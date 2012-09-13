using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Medidata.RBT.PageObjects.Rave.SharedRaveObjects;
using OpenQA.Selenium.Support.PageObjects;
using OpenQA.Selenium;
using Medidata.RBT.SeleniumExtension;

namespace Medidata.RBT.PageObjects.Rave.SiteAdministration
{
    public class SiteAdministrationNewSitePage : SiteAdministrationSiteDetailsPage
    {
        public override string URL
        {
            get
            {
                return "Modules/SiteAdmin/SiteDetails.aspx?siteid=-1";
            }
        }

        /// <summary>
        /// Create a site with the provided site name and number
        /// </summary>
        /// <param name="siteName">The name of the site to be created</param>
        /// <param name="siteNumber">The number of the site to be created</param>
        public void CreateSite(string siteName, string siteNumber)
        {
            SiteNameBox.EnhanceAs<Textbox>().SetText(siteName);
            SiteNumberBox.EnhanceAs<Textbox>().SetText(siteNumber);

            ClickLink("Update");
        }
    }
}
