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
using Medidata.RBT.PageObjects.Rave.SiteAdministration;
using Medidata.RBT.SharedRaveObjects;

namespace Medidata.RBT.PageObjects.Rave.SharedRaveObjects
{
    /// <summary>
    ///This is a rave specific Site. It is seedable.
    ///These are not uploaded, and are created entirely through the UI.
    ///</summary>
    public class Site : SeedableObject
    {
        public UploadedDraft Draft { get; set; }
        public string Number { get; set; }
        public List<Guid> StudyUIDs { get; set; }

        /// <summary>
        /// The Site constructor
        /// </summary>
        /// <param name="siteName">The feature defined name of the Site</param>
        /// <param name="seed">Bool determining whether you want to seed the object if it is not in the FeatureObjects dictionary</param>
        public Site(string siteName, bool seed = false)
            :base(siteName)
        {
            if (!UID.HasValue)
            {
                UID = Guid.NewGuid();
                Name = siteName;
                Number = Guid.NewGuid().ToString();

                if (seed)
                    Seed();
            }
        }

        /// <summary>
        /// Create a unique name for the site by appending a TID.
        /// </summary>
        public override void MakeUnique()
        {
            UniqueName = Name + TID;
        }

        /// <summary>
        /// Navigate to the "New Site" page
        /// </summary>
        public override void NavigateToSeedPage()
        {
            LoginPage.LoginToHomePageIfNotAlready();
            TestContext.CurrentPage.As<HomePage>().ClickLink("Site Administration");
            TestContext.CurrentPage.As<SiteAdministrationHomePage>().ClickLink("New Site");
        }

        /// <summary>
        /// Create a site and add it to the FeatureObjects site dictionary.
        /// </summary>
        public override void CreateObject()
        {
            TestContext.CurrentPage.As<SiteAdministrationDetailsPage>().CreateSite(UniqueName, Number);
        }
    }
}
