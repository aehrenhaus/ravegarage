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
	public class AMMigrationHomePage : RavePageBase
	{
		public override IWebElement GetElementByName(string identifier, string areaIdentifier = null, string listItem = null)
		{
			if (identifier == "Source CRF")
				return Browser.Dropdown("_ddlSimpleSourceVersionId");
			if (identifier == "Target CRF")
				return Browser.Dropdown("ddlSimpleTargetVersionId");
		
			return base.GetElementByName(identifier, areaIdentifier, listItem);
		}


		public override IPage NavigateTo(string name)
		{
			if (name == "Execute Plan")
			{
				ClickLink("Execute Plan");
				return new AMMigrationExecutePage();
			}
			return base.NavigateTo(name);
		}

		public override string URL
		{
			get
			{
				return "Modules/AmendmentManager/MigrationHome.aspx";
			}
		}
	}
}
