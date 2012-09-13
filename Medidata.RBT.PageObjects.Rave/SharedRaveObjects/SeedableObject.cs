using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Medidata.RBT.PageObjects.Rave;

namespace Medidata.RBT.Seeding
{
    ///<summary>
    ///All objects which can seed should implement this class. 
    ///The seedable objects should be marked for seeding when created.
    ///</summary>
    public abstract class SeedableObject
    {
        public Guid? UID { get; set; }
        public string Name { get; set; }
        public string UniqueName { get; set; }
        public string FileLocation { get; set; }
        public string UniqueFileLocation { get; set; }
        public string TID = TemporalID.GetTID(); //This is a unique temporal ID for uniqueness purposes and ease of debugging

        /// <summary>
        /// Seed the seedable object.
        /// All uploads are done logging in with the default user.
        /// Note the user logged in before that seed. At the end of the seed, this user is logged in again and we return to the HomePage.
        /// </summary>
        public virtual void Seed()
        {
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
