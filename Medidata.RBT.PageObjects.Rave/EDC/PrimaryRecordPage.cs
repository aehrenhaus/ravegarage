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
		public PrimaryRecordPage FillDataPoints(IEnumerable<FieldModel> fields)
		{
			foreach (var field in fields)
				FindField(field.Field).EnterData(field.Data);

			return this;
		}


		public IEDCFieldControl FindField(string fieldName)
		{
			return new NonLabDataPageControl(this).FindField(fieldName);
		}
	

		public SubjectPage FillNameAndSave(Table table)
		{
			var dps = table.CreateSet<FieldModel>();
			FillDataPoints(dps);
			IWebElement saveButton = Browser.TryFindElementById("_ctl0_Content_CRFRenderer_footer_SB");

			saveButton.Click();
				
			return new SubjectPage();
		}

	}
}
