using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium.Support.PageObjects;
using OpenQA.Selenium;
using OpenQA.Selenium.Remote;
using TechTalk.SpecFlow;

namespace Medidata.RBT.PageObjects.Rave
{
	public class FileRequestViewPage : RavePageBase
	{
		public void ViewPDF(string pdf)
		{
			var table = Browser.FindElementById("_ctl0_Content_Results");
			Table dt = new Table("Name");
			dt.AddRow(pdf);
			var tr = table.FindMatchTrs(dt).FirstOrDefault();
			//tr.FindImagebuttons()[0].Click();
		
		}
	}
}
