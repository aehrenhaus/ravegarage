using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium.Support.PageObjects;
using OpenQA.Selenium;
using OpenQA.Selenium.Remote;
using TechTalk.SpecFlow;
using System.Collections.ObjectModel;
using System.Threading;
using Medidata.RBT.SeleniumExtension;


namespace Medidata.RBT.PageObjects.Rave
{
    public class DataListingReportPage : RavePageBase
	{
		public override IWebElement GetElementByName(string name)
		{
			if (name == "Data Source")
				return Browser.WaitForElement("ddlSource");
			if (name == "Form")
				return Browser.WaitForElement("ddlDomain");
            if (name == "Result")
                return Browser.WaitForElement("dgResult");


			return base.GetElementByName(name);
		}


		public override string URL
		{
			get
			{
				return "DataListingsReport.aspx";
			}
		}
    }
}

