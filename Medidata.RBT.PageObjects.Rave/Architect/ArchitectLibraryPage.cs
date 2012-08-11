using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium.Support.PageObjects;
using OpenQA.Selenium;
using OpenQA.Selenium.Remote;
using Medidata.RBT.SeleniumExtension;
namespace Medidata.RBT.PageObjects.Rave
{
	public class ArchitectLibraryPage : ArchitectBasePage
	{
		public IPage PushVersion(string version, string env, string sites)
		{
			string studyName = StudyName;

			var link = GetElementByName("CRF Versions").Link(version);
			var push = link.Parent().Parent().Link("Push");
			push.Click();

			var  pushPage = new ArchitectPushPage();
		
			pushPage.PushToSites(env,sites);
			//
			//go back to study
			ClickLinkInArea(null, studyName, "Header");
		
			return this;
		}

		public string StudyName
		{
			get
			{
				return Browser.LinkByPartialID("TabTextHyperlink2").Text;
			}
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

		public override IPage NavigateTo(string name)
		{
			var leftNavContainer = Browser.FindElementById("TblOuter");
		

			if (name == "Amendment Manager")
			{
				var link = leftNavContainer.Link("Amendment Manager");
				link.Click();
				return new AMMigrationHomePage();
			}
			return base.NavigateTo(name);
		}

		public override IWebElement GetElementByName(string name)
		{
			if (name == "CRF Drafts")
				return Browser.Table("DraftsGrid");

			if (name == "CRF Versions")
				return Browser.Table("VersionsGrid");

			return base.GetElementByName(name);
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
