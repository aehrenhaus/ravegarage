using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium.Support.PageObjects;
using OpenQA.Selenium;
using OpenQA.Selenium.Remote;
using Medidata.RBT.SeleniumExtension;
using Medidata.RBT.PageObjects.Rave.SeedableObjects;
namespace Medidata.RBT.PageObjects.Rave.AmendmentManager
{
    public class AMMigrationObjectMappingPage : AMMigrationBasePage
	{
        /// <summary>
        /// Set object mappings in amendment manager
        /// </summary>
        /// <param name="migrationModels">Migrate from source to target</param>
        public void SetMapping(List<MigrationModel> migrationModels)
        {
            foreach(MigrationModel migrationModel in migrationModels)
            {
                IWebElement source = Browser.TryFindElementByXPath(".//span[text() = '" + migrationModel.Source + "']");
                IWebElement sourceTargetRow = source.Parent().Parent();
                Dropdown targetDropdown = sourceTargetRow.FindElement(By.XPath("td/select")).EnhanceAs<Dropdown>();
                targetDropdown.SelectByText(migrationModel.Target);
            }
        }

        /// <summary>
        /// Click on the edit next to a parent mapping
        /// </summary>
        /// <param name="mappingToEdit">The parent mapping to edit</param>
        public void EditMapping(string mappingToEdit)
        {
            IWebElement source = Browser.FindElementByXPath(".//span[text() = '" + mappingToEdit + "']");
            IWebElement sourceTargetRow = source.Parent().Parent();
            sourceTargetRow.FindElement(By.XPath("td/input")).Click();
        }

        /// <summary>
        /// Set up a child mapping
        /// </summary>
        /// <param name="migrationModels">Migrate from source to target</param>
        public void SetChildMapping(List<MigrationModel> migrationModels)
        {
            foreach (MigrationModel migrationModel in migrationModels)
            {
                IWebElement childrenTable = Browser.TryFindElementById("_ctl0_Content_MigrationStepManagePlan1_MigrationPlanMaps_ChildrenMapping_dgObjects");
                IWebElement source = childrenTable.FindElement(By.XPath("tbody/tr/td/span[text() = '" + migrationModel.Source + "']"));
                IWebElement sourceTargetRow = source.Parent().Parent();
                Dropdown targetDropdown = sourceTargetRow.FindElement(By.XPath("td/select")).EnhanceAs<Dropdown>();
                targetDropdown.SelectByText(migrationModel.Target);
            }
        }

		public override string URL
		{
			get
			{
                return "Modules/AmendmentManager/MigrationObjectMapping.aspx";
			}
		}
	}
}
