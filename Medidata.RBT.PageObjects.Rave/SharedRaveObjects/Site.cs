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
    public class Site : BaseRaveSeedableObject
    {
        public UploadedDraft Draft { get; set; }
        public string Number { get; set; }
        public string Group { get; set; }
		public List<StudySite> StudySites { get; set; }

        /// <summary>
        /// The Site constructor
        /// </summary>
        /// <param name="siteName">The feature defined name of the Site</param>
        /// <param name="siteGroup">Name of site group</param>
		public Site(string siteName, string siteGroup = "", string siteNumber = null)
        {
	        UniqueName = siteName;
			Number = siteNumber?? Guid.NewGuid().ToString();
	        Group = siteGroup;
			StudySites = new List<StudySite>();
        }

	    /// <summary>
        /// Create a unique name for the site by appending a TID.
        /// </summary>
		protected override void MakeUnique()
        {
            UniqueName = UniqueName + TID;
        }

        /// <summary>
        /// Navigate to the "New Site" page
        /// </summary>
		protected override void NavigateToSeedPage()
        {
            WebTestContext.CurrentPage.As<HomePage>().ClickLink("Site Administration");
            WebTestContext.CurrentPage.As<SiteAdministrationHomePage>().ClickLink("New Site");
        }

        /// <summary>
        /// Create a site and add it to the FeatureObjects site dictionary.
        /// </summary>
		protected override void CreateObject()
        {
            WebTestContext.CurrentPage.As<SiteAdministrationDetailsPage>().CreateSite(UniqueName, Number, Group);
        }
    }
}
