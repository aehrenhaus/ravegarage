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
    public class SiteAdministrationEditSitePage : SiteAdministrationDetailsPage
    {
        public override string URL
        {
            get
            {
                return "Modules/SiteAdmin/SiteDetails.aspx?siteid=-1";
            }
        }

        public void CreateSite(string siteName, string siteNumber)
        {
            SiteNameBox.EnhanceAs<Textbox>().SetText(siteName);
            SiteNumberBox.EnhanceAs<Textbox>().SetText(siteNumber);

            ClickLink("Update");
        }
    }
}
