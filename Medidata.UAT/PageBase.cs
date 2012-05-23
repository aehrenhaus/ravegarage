using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium.Remote;
using OpenQA.Selenium.Support.PageObjects;
using OpenQA.Selenium.Firefox;

namespace Medidata.UAT
{
	public class PageBase
	{

		public static RemoteWebDriver OpenBrowser(string browserName = null)
		{
			RemoteWebDriver _webdriver = null;
			
			switch (UATConfiguration.Default.BrowserName.ToLower())
			{
				case "firefox":
					if (!string.IsNullOrEmpty(UATConfiguration.Default.BrowserLocation))
					{
						FirefoxProfile p = new FirefoxProfile();
						FirefoxBinary bin = new FirefoxBinary(UATConfiguration.Default.BrowserLocation);
						_webdriver = new FirefoxDriver(bin, p);
					}
					else
						_webdriver = new FirefoxDriver();

					break;
				//case "chrome":
				//    _webdriver = WebDriver.Chrome;
				//    break;
				//case "internet explorer":
				//    _webdriver = WebDriver.IE;
				//    break;
				//case "headless":
				//    _webdriver = WebDriver.Headless;
				//    break;
			}

			return _webdriver;
		}

		protected RemoteWebDriver Browser { get; set; }

		public string URL { get; protected set; }

		public static TPage GotoUrl<TPage>(RemoteWebDriver browser, string url) where TPage:PageBase,new ()
		{
			TPage page = new TPage()
			{
				URL = url,
				Browser = browser
			};

			browser.Navigate().GoToUrl(url);

			PageFactory.InitElements(browser, page);
			return page;
		}


	
		public static TPage FromCurrentUrl<TPage>(RemoteWebDriver browser) where TPage : PageBase, new()
		{
			TPage page = new TPage()
			{
				URL = browser.Url,
				Browser = browser
			};

			PageFactory.InitElements(browser, page);
			return page;
		}

		public TPage As<TPage>() where TPage : PageBase
		{
			return this as TPage;
		}

		public PageBase()
		{
		}
	}
}
