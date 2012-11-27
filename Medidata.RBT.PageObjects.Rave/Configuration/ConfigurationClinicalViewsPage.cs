using System;
using OpenQA.Selenium;

namespace Medidata.RBT.PageObjects.Rave.Configuration
{
    public class ConfigurationClinicalViewsPage : ConfigurationBasePage
    {
        public override string URL
        {
            get
            {
                return "Modules/Configuration/ClinicalViewsPage.aspx";
            }
        }

        /// <summary>
        /// Build Clinical Views for the project
        /// </summary>
        /// <param name="projectName">Project name</param>
        /// <returns></returns>
        public IPage BuildClinicalViews(string projectName)
        {
            ClickLink("Add New");
            ChooseFromDropdown("_ddlProjects", projectName);
            Browser.FindElement(By.XPath("//img[@src = '../../Img/i_ccheck.gif']")).Click();

            return this;
        }
    }
}