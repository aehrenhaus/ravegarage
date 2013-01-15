using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Medidata.RBT.PageObjects.Rave;
using Medidata.RBT.SharedObjects;
using System.Reflection;
using System.IO;

namespace Medidata.RBT.SharedRaveObjects
{

	///<summary>
    ///All objects which can seed should implement this class. 
    ///The seedable objects should be marked for seeding when created.
    ///</summary>
    public class BaseRaveSeedableObject : ISeedableObject
	{
		public WebTestContext WebTestContext
		{
			get
			{
				return (SpecflowStaticBindings.Current as SpecflowWebTestContext).WebTestContext;
			}
		}

	    public bool SuppressSeeding { get; set; } //Only true when you don't want to seed.

        public string UniqueName { get; set; } 

		protected string FileLocation { get; set; } //The location of the original file upload
		protected string UniqueFileLocation { get; set; } //A unique location of the duplicate of the seedable object, that has been made unique\
        protected bool RedirectAfterSeed { get; set; }
        public string TID = TemporalID.GetNewTID(); //This is a unique temporal ID for uniqueness purposes and ease of debugging

		public BaseRaveSeedableObject()
		{
			//set global suppress seeding option, it can be overwrite later
			SuppressSeeding = (SeedingContext.FeatureSeedingOption ?? SeedingContext.DefaultSeedingOption).SuppressSeeding(GetType());
            RedirectAfterSeed = true;
		}

		public virtual void Seed()
		{
			var type = this.GetType();

			if (SuppressSeeding || !(SeedingContext.FeatureSeedingOption ?? SeedingContext.DefaultSeedingOption).EnableSeeding)
			{
				Console.WriteLine("-> Seeding --> suppressed --> {0} --> {1}", type.Name, UniqueName);
		
				return;
			}

			string originalName = UniqueName;
			if ((SeedingContext.FeatureSeedingOption ?? SeedingContext.DefaultSeedingOption).FromUI(type))
			{
				Console.WriteLine("-> Seeding --> UI --> {0} --> {1}", type.Name, originalName); 
				SeedFromUI();
			}
			else
			{
				Console.WriteLine("-> Seeding --> backend --> {0} --> {1}", type.Name, originalName); 
				SeedFromBackend();
			}
			Console.WriteLine("-> {0} --> {1} --> {2}", type.Name, originalName, UniqueName); 
		}

		#region Protected methods

		protected virtual void SeedFromUI()
		{
			using (new LoginSession(WebTestContext, redirectOnDispose: RedirectAfterSeed))
			{
				MakeUnique();
				NavigateToSeedPage();
				CreateObject();
			}
		}

		protected virtual void SeedFromBackend()
		{
			throw new NotImplementedException();
		}

		/// <summary>
        /// Make a unique file location that sits in the "Temporary" folder for the seedable object
        /// </summary>
        /// <param name="fileLocation">Original file location</param>
        /// <returns>Unique file location that sits in the temporary folder for the object</returns>
        protected string MakeFileLocationUnique(string fileLocation)
        {
            return Path.GetDirectoryName(FileLocation)
                + @"\Temporary\"
                + Path.GetFileNameWithoutExtension(FileLocation)+ Guid.NewGuid() + ".xml";
        }

        /// <summary>
        /// Navigate to the page where seeding occurs.
        /// </summary>
		protected virtual void NavigateToSeedPage()
        {
        }

		/// <summary>
        /// Make the object that you are going to seed unique. This usually involves appending the TID to the name. 
        /// If you are uploading an xml, this is where you would save a unique version of the xml.
        /// Make sure to not overwrite the orginial xml provided. 
        /// </summary>
		protected virtual void MakeUnique()
		{
		}

		/// <summary>
        /// Create a unique version of the object, usually by uploading the object.
        /// </summary>
		protected virtual void CreateObject()
		{
		}

		#endregion
	}
}
