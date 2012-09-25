using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium.Support.PageObjects;
using OpenQA.Selenium;
using Medidata.RBT.PageObjects.Rave.SharedRaveObjects;

namespace Medidata.RBT.PageObjects.Rave.SiteAdministration
{
    public class SiteAdministrationSiteDetailsPage : SiteAdministrationBasePage
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
        /// Link the study provided with the site you are on.
        /// </summary>
        /// <param name="studyName">Name of the study to link the site with, this should be the UniqueName, not the feature provided one</param>
        public void LinkStudyWithSite(Site site, string studyName)
        {
            TestContext.CurrentPage.ClickLink("Add Study");
            ChooseFromDropdown("ProjectDDL", studyName);
            TestContext.CurrentPage.ClickLink("Add");
            if (site.StudyUIDs == null)
                site.StudyUIDs = new List<Guid>();
            site.StudyUIDs.Add(site.UID.Value);
        }

        /// <summary>
        /// Link the study provided with the site you are on and environment desired
        /// </summary>
        /// <param name="studyName">name of the study to link the site with, this should be the UniqueName, not the feature provided one</param>
        /// <param name="envName">name of the environment type</param>
        public void LinkStudyWithSite(string studyName, string envName)
        {
            TestContext.CurrentPage.ClickLink("Add Study");
            ChooseFromDropdown("ProjectDDL", studyName);
            ChooseFromDropdown("StudyDDL", envName);
            TestContext.CurrentPage.ClickLink("Add");
        }
    }
}
