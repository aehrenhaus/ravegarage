using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Medidata.RBT;
using TechTalk.SpecFlow;
using Medidata.RBT.SeleniumExtension;
using OpenQA.Selenium;
using System.Collections.ObjectModel;
using System.IO;
using System.Xml;
using Medidata.RBT.PageObjects.Rave.UserAdministrator;
using Medidata.RBT.SharedObjects;
using Medidata.RBT.SharedRaveObjects;

namespace Medidata.RBT.PageObjects.Rave.SharedRaveObjects
{
    /// <summary>
    ///This is a rave specific User. It is seedable. 
    ///These sit in Uploads/Users.
    ///</summary>
    public class RangeType : BaseRaveSeedableObject
    {
        /// <summary>
        /// The uploaded user constructor. This uploads users using the user uploader.
        /// It will also activate the created user.
        /// You may call this constuctor with "SUPER USER 'N'" where "N" is an integer.
        /// This will upload a unique version of the source controlled "SUPERUSER.xml" and tie it to that name.
        /// </summary>
        /// <param name="userUploadName">The feature defined name of the user</param>
        /// <param name="seed">Bool determining whether you want to seed the object if it is not in the FeatureObjects dictionary</param>
        public RangeType(string rangeName)
        {
            UniqueName = rangeName;
        }

        /// <summary>
        /// Navigate to the user upload page.
        /// </summary>
		protected override void NavigateToSeedPage()
        {
            LoginPage.LoginToHomePageIfNotAlready();
            new RangeTypesPage().NavigateToSelf();
        }

        /// <summary>
        /// Upload the unique version of the User. Mark it for deletion after scenario completion.
        /// </summary>
		protected override void CreateObject()
        {
            TestContext.CurrentPage.As<RangeTypesPage>().AddRangeType(UniqueName);
        }

        /// <summary>
        /// Load the xml to upload. Replace the user name with a unique version of it with a TID at the end.
        /// </summary>
		protected override void MakeUnique()
        {
            UniqueName = UniqueName + TID;
        }
    }
}