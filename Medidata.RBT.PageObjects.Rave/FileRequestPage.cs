using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium.Support.PageObjects;
using OpenQA.Selenium;
using OpenQA.Selenium.Remote;
using TechTalk.SpecFlow;
using Medidata.RBT.SeleniumExtension;
namespace Medidata.RBT.PageObjects.Rave
{
	public class FileRequestPage : RavePageBase
	{
		public FileRequestPage CreateDataPDF(Table table)
		{
			ClickLink("Create Data Request");
			var page = new FileRequestCreateDataRequestPage();
			return page.CreateDataPDF(table) ;
		}

		public FileRequestPage Generate(string pdf)
		{
			var table = Browser.Table("_ctl0_Content_Results");
			Table dt = new Table("Name");
			dt.AddRow(pdf);
			var tr = table.FindMatchRows(dt).FirstOrDefault();
			ChooseFromCheckboxes(null, "Live Status Update",true);

			var genButton  = tr.FindImagebuttons().FirstOrDefault(x => x.GetAttribute("id").EndsWith("imgGenerateNow"));
			genButton.Click();
			GetAlertWindow().Accept();

			return this;
		}

		public FileRequestPage WaitForPDFComplete(string pdf)
		{
			var table = Browser.Table("_ctl0_Content_Results");
			Table dt = new Table("Name");
			dt.AddRow(pdf);
			var tr = table.FindMatchRows(dt).FirstOrDefault();

			int waitTime = 60;
			Browser.WaitForElement(b =>
				tr.Spans().FirstOrDefault(x => x.GetAttribute("id").EndsWith("StatusValue") && x.Text == "Completed"),
				"Did not complete in time("+waitTime+"s)", waitTime
				);

			return this;
		}

		public void ViewPDF(string pdf)
		{
			ClickLink("My PDF Files");
			var page = new FileRequestViewPage();
			 page.ViewPDF(pdf);


		}

		protected override IWebElement GetElementByName(string name)
		{
			if (name == "Live Status Update")
				return Browser.FindElementById("LiveStatusUpdate");
			return base.GetElementByName(name);
		}

		
	}
}
