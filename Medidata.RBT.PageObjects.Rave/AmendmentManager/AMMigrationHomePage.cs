using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium.Support.PageObjects;
using OpenQA.Selenium;
using OpenQA.Selenium.Remote;
using Medidata.RBT.SeleniumExtension;
using Medidata.RBT.PageObjects.Rave.SharedRaveObjects;
namespace Medidata.RBT.PageObjects.Rave.AmendmentManager
{
    public class AMMigrationHomePage : AMMigrationBasePage
	{
		public override IWebElement GetElementByName(string identifier, string areaIdentifier = null, string listItem = null)
		{
			if (identifier == "Source CRF")
				return Browser.DropdownById("_ddlSimpleSourceVersionId");
			if (identifier == "Target CRF")
				return Browser.DropdownById("ddlSimpleTargetVersionId");
		
			return base.GetElementByName(identifier, areaIdentifier, listItem);
		}


        public override IPage NavigateTo(string name)
        {
            if (name == "Execute Plan")
                return ClickLink("Execute Plan");

            return base.NavigateTo(name);
        }


        /// <summary>
        /// Select the source crf
        /// </summary>
        /// <param name="sourceCRFName">The feature defined source crf name</param>
        public void SelectSourceCRF(string sourceCRFName)
        {
            string uniqueSourceCRFName = ((CrfVersion)TestContext.SeedableObjects[sourceCRFName]).UniqueName;
            Dropdown sourceDropdown = Browser.FindElementById("_ctl0_Content_MigrationStepStart1_ddlSimpleSourceVersionId").EnhanceAs<Dropdown>();
            sourceDropdown.SelectByPartialText(uniqueSourceCRFName);
        }

        /// <summary>
        /// Select the target crf
        /// </summary>
        /// <param name="sourceCRFName">The feature defined target crf name</param>
        public void SelectTargetCRF(string targetCRFName)
        {
			string uniqueTargetCRFName = ((CrfVersion)TestContext.SeedableObjects[targetCRFName]).UniqueName;
            Dropdown sourceDropdown = Browser.FindElementById("_ctl0_Content_MigrationStepStart1_ddlSimpleTargetVersionId").EnhanceAs<Dropdown>();
            sourceDropdown.SelectByPartialText(uniqueTargetCRFName);
        }

        /// <summary>
        /// Navigate to a study
        /// </summary>
        /// <param name="studyName">Feature defined study name</param>
        public void NavigateToStudy(string studyName)
        {
            TestContext.CurrentPage = new ArchitectPage().NavigateToSelf();
            Project project = TestContext.GetExistingFeatureObjectOrMakeNew(studyName, () => new Project(studyName));
            TestContext.CurrentPage.As<ArchitectPage>().ClickProject(project.UniqueName);
            TestContext.CurrentPage.As<ArchitectLibraryPage>().NavigateTo("Amendment Manager");
        }

		public override string URL
		{
			get
			{
				return "Modules/AmendmentManager/MigrationHome.aspx";
			}
		}
	}
}
