using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium.Support.PageObjects;
using OpenQA.Selenium;
using OpenQA.Selenium.Remote;
using System.Collections.Specialized;

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

		public override string URL
		{
			get
			{
				return "Modules/Reporting/ReportsPage.aspx";
			}
		}
	}
}
