using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium.Support.PageObjects;
using OpenQA.Selenium;
using OpenQA.Selenium.Remote;

namespace Medidata.UAT.WebDrivers.Rave
{
	public  class PrimaryRecordPage : PageBase
	{

		public SubjectPage FillNameAndSave(string subjectName)
		{//TODO: find the text box fo

			RavePagesHelper.FillDataPoint("Subject Name", subjectName, false);
			IWebElement saveButton = Browser.TryFindElementById("_ctl0_Content_CRFRenderer_footer_SB");

			saveButton.Click();
				
			return new SubjectPage().UseCurrent<SubjectPage>();
		}

	}
}
