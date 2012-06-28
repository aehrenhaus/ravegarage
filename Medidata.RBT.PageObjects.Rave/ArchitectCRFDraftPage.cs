using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium.Support.PageObjects;
using OpenQA.Selenium;
using OpenQA.Selenium.Remote;
using Medidata.RBT.SeleniumExtension;
using TechTalk.SpecFlow;

namespace Medidata.RBT.PageObjects.Rave
{
	public class ArchitectCRFDraftPage : RavePageBase
	{

		protected override IWebElement GetElementByName(string name)
		{

			return base.GetElementByName(name);
		}

		public override IPage NavigateTo(string name)
		{

			if (name == "Edit Checks")
			{
				Browser.TryFindElementById("TblOuter").Link(name).Click();
		
				return new ArchitectChecksPage();
			}

			return base.NavigateTo(name);
		}
	
	}
}
