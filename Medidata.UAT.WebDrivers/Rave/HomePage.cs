using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Medidata.UAT.WebDrivers;
using OpenQA.Selenium.Support.PageObjects;
using OpenQA.Selenium;

namespace Medidata.UAT.WebDrivers.Rave
{
	public  class HomePage : PageBase
	{
		[FindsBy(How = How.Id, Using = "_ctl0_Content_ListDisplayNavigation_txtSearch")]
		IWebElement SearchBox;

		[FindsBy(How = How.Id, Using = "_ctl0_Content_ListDisplayNavigation_ibSearch")]
		IWebElement SearchButton;


		public void EnterSearch(string searchText)
		{
			SearchBox.SendKeys(searchText);
		}


		public void ClickSearch()
		{
			SearchButton.Click();

		}


		public bool CanSeeResult(string seeText)
		{
			return true;
		}
	}
}
