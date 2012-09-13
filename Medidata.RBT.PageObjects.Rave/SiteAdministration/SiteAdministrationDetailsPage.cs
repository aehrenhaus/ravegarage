﻿using System;
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
        public void LinkStudyWithSite(string studyName)
        {
            TestContext.CurrentPage.ClickLink("Add Study");
            ChooseFromDropdown("ProjectDDL", studyName);
            TestContext.CurrentPage.ClickLink("Add");
        }
    }
}
