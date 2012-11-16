using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium.Support.PageObjects;
using OpenQA.Selenium;
using OpenQA.Selenium.Remote;
using System.Collections.Specialized;
using Medidata.RBT.SeleniumExtension;
using TechTalk.SpecFlow;
using Microsoft.VisualStudio.TestTools.UnitTesting;


namespace Medidata.RBT.PageObjects.Rave
{
    public class ReportsPage : RavePageBase
	{
		public ReportsPage(){
			
		}

        public PromptsPage SelectReport(string reportName)
        {
			var reportTable = Browser.FindElementById("MyReportGrid");
			var reportLinks = reportTable.FindElements(By.XPath("./tbody/tr[position()>1]/td[position()=2]/a"));

			var link = reportLinks.FirstOrDefault(x => x.Text == reportName);
			if (link == null)
				throw new Exception("Report not found:"+reportName);
			link.Click();

			NameValueCollection mappingPO = new NameValueCollection();
			mappingPO["Targeted SDV Subject Management"] = "SubjectOverridePage";

			string poName = mappingPO[reportName];
			if (poName == null)
				poName = "CrystalReportPage";
			return new PromptsPage(poName);         
        }

		public override IWebElement GetElementByName(string identifier, string areaIdentifier = null, string listItem = null)
		{
			if (identifier == "Report Type")
				return Browser.TryFindElementByPartialID( "ddlReportTypes");
			return base.GetElementByName(identifier, areaIdentifier, listItem);
		}

		

			
		public void VerifyHelpLinks(IEnumerable<ReportListModel> reports)
		{
			HtmlTable t = Browser.Table("MyReportGrid");
			//first make sure all reports in the list exist;
			foreach (var report in reports)
			{
				Table query = new Table("Name");
				query.AddRow(new string[] { report.Name });
				var rows = t.FindMatchRows(query);
				if (rows.Count == 0)
				{
					throw new Exception("Can't find report "+report.Name);
				}
			}
			
			foreach (var report in reports)
			{
				Table query = new Table("Name");
				query.AddRow(new string[]{report.Name});
				var rows = t.FindMatchRows(query);
				var link = rows[0].FindElement(By.LinkText("Help"));
				link.Click();

				Browser.SwitchToSecondBrowserWindow();
				TestContext.CurrentPage = TestContext.POFactory.GetPageByUrl(new Uri(Browser.Url));

				Assert.AreEqual(Browser.Url, report.URLAddress,"Url is different than expected");

				Browser.SwitchToMainBrowserWindow(true);
				TestContext.CurrentPage = TestContext.POFactory.GetPageByUrl(new Uri(Browser.Url));
			}
		}

		public void VerifyHelpLinksInPromptsPage(IEnumerable<ReportListModel> reports)
		{
			HtmlTable t = Browser.Table("MyReportGrid");
			//first make sure all reports in the list exist;
			foreach (var report in reports)
			{
				Table query = new Table("Name");
				query.AddRow(new string[] { report.Name });
				var rows = t.FindMatchRows(query);
				if (rows.Count == 0)
				{
					throw new Exception("Can't find report "+report.Name);
				}
			}
			
			foreach (var report in reports)
			{
				Table query = new Table("Name");
				query.AddRow(new string[]{report.Name});
				var rows = t.FindMatchRows(query);
				var link = rows[0].FindElement(By.LinkText(report.Name));
				link.Click();
				this.ClickLink("View Report Help");

				Browser.SwitchToSecondBrowserWindow();
				TestContext.CurrentPage = TestContext.POFactory.GetPageByUrl(new Uri(Browser.Url));

				Assert.AreEqual(Browser.Url, report.URLAddress,"Url is different than expected");

				Browser.SwitchToMainBrowserWindow(true);
				TestContext.CurrentPage = TestContext.POFactory.GetPageByUrl(new Uri(Browser.Url));

				this.GoBack();

				//refresh the Selenium object , because page changed
				t = Browser.Table("MyReportGrid");
			}
		}

		public override string URL
		{
			get
			{
				return "Modules/Reporting/ReportsPage.aspx";
			}
		}
	}
}
