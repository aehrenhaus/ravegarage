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
	public class PrimaryRecordPage : BaseEDCPage
	{



		public override IEDCFieldControl FindField(string fieldName)
		{
			return new NonLabDataPageControl(this).FindField(fieldName);
		}


        //TODO: treat primary record page as an extension of regular page, it is very similar, and makes no sense to reinvent methods for it.  
		public SubjectPage FillNameAndSave(IEnumerable<FieldModel> dps) 
		{
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
