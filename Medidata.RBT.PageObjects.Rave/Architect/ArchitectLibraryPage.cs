using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium.Support.PageObjects;
using OpenQA.Selenium;
using OpenQA.Selenium.Remote;
using Medidata.RBT.SeleniumExtension;
using Medidata.RBT.PageObjects.Rave.AmendmentManager;
namespace Medidata.RBT.PageObjects.Rave
{
	public class ArchitectLibraryPage : ArchitectBasePage
	{
		public IPage PushVersion(string version, string env, string sites)
		{
			string studyName = StudyName;

            IWebElement versionsTable = Browser.TryFindElementBy(By.Id("_ctl0_Content_VersionsGrid"));
            IWebElement row = versionsTable.FindElement(By.XPath("tbody/tr/td/a[contains(text(),'" + version + "')]/../.."));
            IWebElement push = row.FindElement(By.XPath("td/a[text() = 'Push']"));
			push.Click();

            TestContext.CurrentPage = new ArchitectPushPage();
            TestContext.CurrentPage.As<ArchitectPushPage>().PushToSites(env, sites);
			//
			//go back to study
            ClickLinkInArea(null, studyName, "Header");
		
			return this;
		}

		public string StudyName
		{
			get
			{
				return Browser.LinkByID("TabTextHyperlink2").Text;
			}
		}

        /// <summary>
        /// Click a draft
        /// </summary>
        /// <param name="draftName">Unique name of the draft to click</param>
        /// <returns>The ArchitectCRFDraftPage for that draft</returns>
        public IPage ClickDraft(string draftName)
        {
            base.ClickLink(draftName);
            TestContext.CurrentPage = new ArchitectCRFDraftPage();
            return TestContext.CurrentPage;
        }

		public ArchitectCRFDraftPage CreateDraftFromProject(string draftName, string project, string version)
		{
			ClickLink("Add New Draft");
			ChooseFromRadiobuttons(null, "_ctl0_Content_RadioButtonList1_1");
			ChooseFromDropdown("_ctl0_Content_ProjectDropDown", project);
			ChooseFromDropdown("_ctl0_Content_VersionDropDown", version);
			Type("_ctl0_Content_DraftText", draftName);
			ClickButton("Create Draft");

			return new ArchitectCRFDraftPage();
		}

        public ArchitectCRFDraftPage SelectDraft(string draftName)
		{
			ClickLink(draftName);
			return new ArchitectCRFDraftPage();
		}
        
		public override IPage NavigateTo(string name)
		{
            IWebElement leftNavContainer = Browser.TryFindElementBy(By.Id("TblOuter"));
		
			if (name == "Amendment Manager")
			{
                return ClickLink("Amendment Manager");
                //var link = leftNavContainer.Link("Amendment Manager");
                //link.Click();
                //return new AMMigrationHomePage();
			}
			return base.NavigateTo(name);
		}

		public override IWebElement GetElementByName(string identifier, string areaIdentifier = null, string listItem = null)
		{
			if (identifier == "CRF Drafts")
				return Browser.Table("DraftsGrid");

			if (identifier == "CRF Versions")
				return Browser.Table("VersionsGrid");

			return base.GetElementByName(identifier,areaIdentifier,listItem);
		}

		//public override IPage ClickLinkInArea(string type, string linkText, string areaIdentifier)
		//{
		//    if (areaIdentifier == "CRFDrafts")
		//    {
		//        Browser.Link(linkText).Click();
		//        return new ArchitectCRFDraftPage();
		//    }

		//    return base.ClickLinkInArea(type, linkText, areaIdentifier);
		//}

		public override string URL
		{
			get
			{
				return "Modules/Architect/LibraryPage.aspx";
			}
		}
	}
}
