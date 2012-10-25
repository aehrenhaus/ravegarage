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
    public abstract class BaseRaveSeedableObject : ISeedableObject
	{
	    public bool SuppressSeeding { get; set; } //Only true when you don't want to seed.

        public Guid? UID { get; set; } //A unique identifier for the object
        public string Name { get; set; } //The feature file defined name of the SeedableObject
        private string m_UniqueName;
        public string UniqueName //A unique name of the SeedableObject, usually formed using the name + TID
        {
            get
            {
                if (RBTConfiguration.Default.EnableSeeding)
                    return m_UniqueName;
                else
                    return Name;
            }
            set { m_UniqueName = value; }
        }
		protected string FileLocation { get; set; } //The location of the original file upload
		protected string UniqueFileLocation { get; set; } //A unique location of the duplicate of the seedable object, that has been made unique
        protected string TID = TemporalID.GetNewTID(); //This is a unique temporal ID for uniqueness purposes and ease of debugging

	
		public virtual void Seed()
		{
			if (SuppressSeeding || !RBTConfiguration.Default.EnableSeeding)
				return;

			if (SeedDecision.FromUI(this.GetType()))
				SeedFromUI();
			else
				SeedFromBackend();
		}

		#region Protected methods

		protected virtual void SeedFromUI()
		{
			if (SuppressSeeding || !RBTConfiguration.Default.EnableSeeding)
				return;

			string previousUser = TestContext.CurrentUser;
			string previousPassword = TestContext.CurrentUserPassword;

			//login as default user to homepage if not already
			LoginPage.LoginToHomePageIfNotAlready();

			MakeUnique();
			NavigateToSeedPage();
			CreateObject();

			//login as previous user, to home page
			LoginPage.LoginToHomePageIfNotAlready(previousUser, previousPassword);


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
                + Path.GetFileName(FileLocation).Substring(0, Path.GetFileName(FileLocation).LastIndexOf(".xml")) + UID + ".xml";
        }

        /// <summary>
        /// Navigate to the page where seeding occurs.
        /// </summary>
		protected abstract void NavigateToSeedPage();

        /// <summary>
        /// Make the object that you are going to seed unique. This usually involves appending the TID to the name. 
        /// If you are uploading an xml, this is where you would save a unique version of the xml.
        /// Make sure to not overwrite the orginial xml provided. 
        /// </summary>
		protected abstract void MakeUnique();

        /// <summary>
        /// Create a unique version of the object, usually by uploading the object.
        /// </summary>
		protected abstract void CreateObject();

		#endregion
	}
}
