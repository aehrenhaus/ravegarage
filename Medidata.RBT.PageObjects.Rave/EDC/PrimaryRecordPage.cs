using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium.Support.PageObjects;
using OpenQA.Selenium;
using OpenQA.Selenium.Remote;
using TechTalk.SpecFlow;
using Medidata.RBT.SeleniumExtension;
using TechTalk.SpecFlow.Assist;

namespace Medidata.RBT.PageObjects.Rave
{
	public class PrimaryRecordPage : RavePageBase
	{

		public SubjectPage FillNameAndSave(Table table)
		{
			throw new NotImplementedException();
			//RavePagesHelper.FillDataPoints(table.CreateSet<FieldModel>());
      
			IWebElement saveButton = Browser.TryFindElementById("_ctl0_Content_CRFRenderer_footer_SB");

			saveButton.Click();
				
			return new SubjectPage();
		}

	}
}
