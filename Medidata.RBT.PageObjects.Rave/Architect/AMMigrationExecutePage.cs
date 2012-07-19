using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium.Support.PageObjects;
using OpenQA.Selenium;
using OpenQA.Selenium.Remote;
using Medidata.RBT.SeleniumExtension;
namespace Medidata.RBT.PageObjects.Rave
{
	public class AMMigrationExecutePage : RavePageBase
	{
		public AMMigrationExecutePage Migrate()
		{
			ChooseFromRadiobuttons(null, "rblMigrationMode_0");
	
			Browser.WaitForElement("CRFDraftsLabel");
			Browser.Div("pnlSubjects").Link("All").Click();
			Browser.Link("Migrate").Click();
			return this;
		}



		public override string URL
		{
			get
			{
				return "Modules/AmendmentManager/MigrationExecute.aspx";
			}
		}

	}
}
