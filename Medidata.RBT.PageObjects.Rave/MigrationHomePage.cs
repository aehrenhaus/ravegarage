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
	public class MigrationHomePage : RavePageBase
	{
		protected override IWebElement GetElementByName(string name)
		{
			if (name == "Source CRF")
				return Browser.Dropdown("_ddlSimpleSourceVersionId");
			if (name == "Target CRF")
				return Browser.Dropdown("ddlSimpleTargetVersionId");
			return base.GetElementByName(name);
		}
	}
}
