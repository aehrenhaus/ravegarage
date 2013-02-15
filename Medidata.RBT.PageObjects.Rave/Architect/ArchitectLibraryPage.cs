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
			Browser.WaitForDocumentLoad();
            Context.CurrentPage = new ArchitectPushPage();
            Context.CurrentPage.As<ArchitectPushPage>().PushToSites(env, sites);
			//
			//go back to study
            ClickLink( studyName,null, "Header");
		
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
            Context.CurrentPage = new ArchitectCRFDraftPage();
            return Context.CurrentPage;
        }

		public ArchitectCRFDraftPage CreateDraftFromProject(string draftName, string project, string version)
		{
			ClickLink("Add New Draft");
			ChooseFromRadiobuttons(null, "_ctl0_Content_RadioButtonList1_1");
			ChooseFromDropdown("_ctl0_Content_ProjectDropDown", project, "Project");
			ChooseFromPartialDropdown("_ctl0_Content_VersionDropDown", version, "CRFVersion");
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

            IPage result;
            switch (name)
            {
                case "Publish Checks":
                case "Amendment Manager":
                    result = ClickLink(name);
                    break;
                default:
                    result = base.NavigateTo(name);
                    break;
            }//End switch

            return result;
		}

		public override IWebElement GetElementByName(string identifier, string areaIdentifier = null, string listItem = null)
		{
			if (identifier == "CRF Drafts")
				return Browser.Table("DraftsGrid");

			if (identifier == "CRF Versions")
				return Browser.Table("VersionsGrid");

			return base.GetElementByName(identifier,areaIdentifier,listItem);
		}


		public override string URL
		{
			get
			{
				return "Modules/Architect/LibraryPage.aspx";
			}
		}

        /// <summary>
        /// Select the CRF versin from architect library page from version grid
        /// based on the version name specified
        /// </summary>
        /// <param name="versionName"></param>
        /// <returns></returns>
        public IPage SelectCrfVersion(string versionName)
        {
            IWebElement versionsTable = Browser.TryFindElementBy(By.Id("_ctl0_Content_VersionsGrid"));
            IWebElement versionLink = versionsTable.TryFindElementBy(
                By.XPath(string.Format("//a[contains(@id,'_LinkVersion') and contains(text(),'{0}')]", versionName)));

            versionLink.Click();
            return this.WaitForPageLoads();
        }
    }
}
