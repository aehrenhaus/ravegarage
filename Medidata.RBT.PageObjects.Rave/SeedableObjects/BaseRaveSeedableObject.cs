using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Medidata.RBT.PageObjects.Rave;
using Medidata.RBT.SharedObjects;
using System.Reflection;
using System.IO;

namespace Medidata.RBT.PageObjects.Rave.SeedableObjects
{

	///<summary>
    ///All objects which can seed should implement this class. 
    ///The seedable objects should be marked for seeding when created.
    ///</summary>
    public abstract class BaseRaveSeedableObject : ISeedableObject
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
        public string UniqueFileLocation { get; set; } //A unique location of the duplicate of the seedable object, that has been made unique\
        
        public string TID = TemporalID.GetNewTID(); //This is a unique temporal ID for uniqueness purposes and ease of debugging

		public BaseRaveSeedableObject()
		{
		}

		public virtual void Seed()
		{
            Type type = this.GetType();
            Console.WriteLine("-> Seeding --> {0} --> {1}", type.Name, UniqueName);
		}

		#region Protected methods
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
		#endregion
	}
}
