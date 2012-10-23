using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium.Support.PageObjects;
using OpenQA.Selenium;
using Medidata.RBT.PageObjects.Rave.SharedRaveObjects;
using Medidata.RBT.SeleniumExtension;
using TechTalk.SpecFlow;


namespace Medidata.RBT.PageObjects.Rave.SiteAdministration
{
    public class SiteAdministrationDetailsPage : SiteAdministrationBasePage
    {
        [FindsBy(How = How.Id, Using = "_ctl0_Content_SiteNameBox")]
        public IWebElement SiteNameBox;

        [FindsBy(How = How.Id, Using = "_ctl0_Content_SiteNumberBox")]
        public IWebElement SiteNumberBox;

        public override string URL
        {
            get
            {
                return "Modules/SiteAdmin/SiteDetails.aspx";
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

        /// <summary>
        /// Link the study provided with the site you are on and environment desired
        /// </summary>
        /// <param name="studyName">name of the study to link the site with, this should be the UniqueName, not the feature provided one</param>
        /// <param name="envName">name of the environment type</param>
        public void LinkStudyWithSite(Site site, string studyName, string envName)
        {
            TestContext.CurrentPage.ClickLink("Add Study");
            ChooseFromDropdown("ProjectDDL", studyName);
            if (!string.IsNullOrEmpty(envName))
                ChooseFromDropdown("StudyDDL", envName);
            TestContext.CurrentPage.ClickLink("Add");
            if (site.StudyUIDs == null)
                site.StudyUIDs = new List<Guid>();
            site.StudyUIDs.Add(site.UID.Value);
        }

        /// <summary>
        /// Selects the element in study site.
        /// </summary>
        /// <param name="elementName">Name of the element.</param>
        /// <param name="studyName">Name of the study.</param>
        /// <param name="environment">The environment.</param>
        public void SelectElementInStudySite(string elementName, string studyName, string environment)
        {
            string mapGifId = String.Empty;
            switch (elementName)
            {
                case "Lab Maintenance":
                    mapGifId = "i_lab.gif";
                    break;                     
                default:
                    throw new NotImplementedException("Not implemented yet for :");
            }

            TestContext.CurrentPage.ClickLink("Add Study");
            ChooseFromDropdown("ProjectDDL", studyName);
            ChooseFromDropdown("StudyDDL", environment.ToLower() == "prod" ? "Live: Prod" : String.Concat("Aux: ", environment));
            TestContext.CurrentPage.ClickLink("Add");
            var table = TestContext.CurrentPage.GetElementByName("_WizardTitleBox_AddStudySiteWzrd_StudyGrid").EnhanceAs<HtmlTable>();
            Table matchTable = new Table("Name");
            matchTable.AddRow(String.Format("{0}-{1}", studyName, environment));            
            var rows = table.FindMatchRows(matchTable);
            rows[0].Images().First(x => x.GetAttribute("src").EndsWith(mapGifId)).Click();
        }

        public override IWebElement GetElementByName(string identifier, string areaIdentifier = null, string listItem = null)
        {
            return Browser.Table("_WizardTitleBox_AddStudySiteWzrd_StudyGrid");
        }
    }
}
