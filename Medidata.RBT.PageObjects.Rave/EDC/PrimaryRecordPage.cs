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
	public class PrimaryRecordPage : CRFPage
	{
		public new PrimaryRecordPage FillDataPoints(IEnumerable<FieldModel> fields)
		{
			foreach (var field in fields)
				FindField(field.Field).EnterData(field.Data, EnumHelper.GetEnumByDescription<ControlType>(field.ControlType));

			return this;
		}


		public IEDCFieldControl FindField(string fieldName)
		{
			return new NonLabDataPageControl(this).FindField(fieldName);
		}

        public new CRFPage SaveForm()
        {
            IWebElement btn = Browser.WaitForElement("_ctl0_Content_CRFRenderer_footer_SB");
            if (btn == null)
                throw new Exception("Can not find the Save button");
            btn.Click();
            return this;
        }
        //TODO: treat primary record page as an extension of regular page, it is very similar, and makes no sense to reinvent methods for it.  
		public SubjectPage FillNameAndSave(Table table)
		{
			var dps = table.CreateSet<FieldModel>();
			FillDataPoints(dps);
            SaveForm();
				
			return new SubjectPage();
		}

		public override string URL
		{
			get
			{
				return "Modules/EDC/PrimaryRecordPage.aspx";
			}
		}

	}
}
