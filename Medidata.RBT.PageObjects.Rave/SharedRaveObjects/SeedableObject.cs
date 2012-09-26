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
    public abstract class SeedableObject : IFeatureObject
    {
        public Guid? UID { get; set; } //A unique identifier for the object
        public string Name { get; set; } //The feature file defined name of the SeedableObject
        public string UniqueName { get; set; } //A unique name of the SeedableObject, usually formed using the name + TID
        public string FileLocation { get; set; } //The location of the original file upload
        public string UniqueFileLocation { get; set; } //A unique location of the duplicate of the seedable object, that has been made unique
        public string TID = TemporalID.GetNewTID(); //This is a unique temporal ID for uniqueness purposes and ease of debugging

        public SeedableObject()
            :base()
        {
        }

        public SeedableObject(string featureName)
        {
            if (UID.HasValue)
                DraftCounter.DecrementCounter();
        }

        /// <summary>
        /// Seed the seedable object.
        /// All uploads are done logging in with the default user.
        /// Note the user logged in before that seed. At the end of the seed, this user is logged in again and we return to the HomePage.
        /// </summary>
        public virtual void Seed()
        {
            if (TestContext.CurrentUser == null)
                LoginPage.LoginUsingDefaultUserFromAnyPage();
            string loggedInUserBeforeSeed = TestContext.CurrentUser;
            NavigateToSeedPage();
            MakeUnique();
            CreateObject();
            if (loggedInUserBeforeSeed != TestContext.CurrentUser)
            {
                TestContext.CurrentPage = new LoginPage().NavigateToSelf();
                TestContext.CurrentPage.As<LoginPage>().Login(loggedInUserBeforeSeed, RaveConfiguration.Default.DefaultUserPassword);
            }
            TestContext.CurrentPage = new HomePage().NavigateToSelf();
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
        public abstract void NavigateToSeedPage();

        /// <summary>
        /// Make the object that you are going to seed unique. This usually involves appending the TID to the name. 
        /// If you are uploading an xml, this is where you would save a unique version of the xml.
        /// Make sure to not overwrite the orginial xml provided. 
        /// </summary>
        public abstract void MakeUnique();

        /// <summary>
        /// Create a unique version of the object, usually by uploading the object.
        /// </summary>
        public abstract void CreateObject();
    }
}
