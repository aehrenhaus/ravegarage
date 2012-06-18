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
	public  class PrimaryRecordPage : PageBase
	{

		public SubjectPage FillNameAndSave(Table table)
		{
			foreach (var row in table.Rows)
			{
				string val  = row["Value"];
				RavePagesHelper.FillDataPoint(row["Field"], val, false);
			}
      
			IWebElement saveButton = Browser.TryFindElementById("_ctl0_Content_CRFRenderer_footer_SB");

			saveButton.Click();
				
			return new SubjectPage();
		}

	}
}
