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

		public ArchitectCRFDraftPage CreateDraftFromProject(string draftName, string project, string version)
		{
			ChooseFromRadiobuttons(null, "_ctl0_Content_RadioButtonList1_1");
			ChooseFromDropdown("_ctl0_Content_ProjectDropDown", project);
			ChooseFromDropdown("_ctl0_Content_VersionDropDown", version);
			Type("_ctl0_Content_DraftText", draftName);
			ClickButton("_ctl0_Content_CreateButton");

			return new ArchitectCRFDraftPage();
		}

		public override IPage NavigateTo(string name)
		{
			var leftNavContainer = Browser.FindElementById("TblOuter");
		

			if (name == "Amendment Manager")
			{
				var link = leftNavContainer.Link("Amendment Manager");
				link.Click();
				return new MigrationHomePage();
			}
			return base.NavigateTo(name);
		}
	}
}
