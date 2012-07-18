using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium.Support.PageObjects;
using OpenQA.Selenium;
using OpenQA.Selenium.Remote;
using TechTalk.SpecFlow;
using Medidata.RBT.SeleniumExtension;
using System.Threading;

namespace Medidata.RBT.PageObjects.Rave
{
	public class PDFCreationModel
	{
		public string Name { get; set; }
		public string Profile { get; set; }
		public string Study { get; set; }
		public string Role { get; set; }
		public string SiteGroup { get; set; }
		public string Site { get; set; }
		public string Subject { get; set; }
	}

	public class FileRequestCreateDataRequestPage : RavePageBase
	{

		public FileRequestPage CreateDataPDF(PDFCreationModel args)
		{


			if (!string.IsNullOrEmpty(args.Name))
				Type("Name", args.Name);
			if (!string.IsNullOrEmpty(args.Profile))
				ChooseFromDropdown("_ctl0_Content_FileRequestForm_ConfigProfileID", args.Profile);
			if (!string.IsNullOrEmpty(args.Study))
				ChooseFromDropdown("Study", args.Study);
			if (!string.IsNullOrEmpty(args.Role))
			{
				var dlRole = Browser.FindElementById("Role");
				Thread.Sleep(1000);
				ChooseFromDropdown("Role", args.Role);
			}
			if (!string.IsNullOrEmpty(args.SiteGroup))
				//TODO:
				;
			if (!string.IsNullOrEmpty(args.Site))
			{
				var expandSite = Browser.FindElementById("ISitesSitegroups_SG_1");
				expandSite.Click();


				var div = Browser.TryFindElementById("DSitesSitegroups_SG_1");
				var span = this.WaitForElement(b => div.Spans().FirstOrDefault(x => x.Text == args.Site));
				span.Checkboxes()[0].Click();
			}
			if (!string.IsNullOrEmpty(args.Subject))
			{

				var expandBtn = Browser.FindElementById("Subjects_ShowHideBtn");
				expandBtn.Click();

				var tr = this.WaitForElement(b => b.FindElements(By.XPath("//table[@id='Subjects_FrontEndCBList']/tbody/tr")).FirstOrDefault(x => x.Text == args.Subject));

				tr.Checkboxes()[0].Click();
			}


			ClickLink("Save");
			return new FileRequestPage();
		}
	}
}
