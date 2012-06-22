using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Medidata.RBT.PageObjects;
using OpenQA.Selenium.Support.PageObjects;
using OpenQA.Selenium;

using System.Collections.Specialized;
using TechTalk.SpecFlow;

namespace Medidata.RBT.PageObjects.Rave
{
	public  class RavePageBase : PageBase
	{
		public override IPage NavigateTo(string name)
		{
			if (name == "Home")
			{
				Browser.FindElementById("_ctl0_PgHeader_TabHyperlink0").Click();
				return new HomePage();
			}

			throw new Exception("Don't know how to navigate to "+name);
		}
	}
}
