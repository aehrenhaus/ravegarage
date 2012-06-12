using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium.Remote;
using OpenQA.Selenium.Support.PageObjects;
using OpenQA.Selenium.Firefox;
using OpenQA.Selenium.Chrome;
using OpenQA.Selenium.IE;
using System.IO;
using OpenQA.Selenium;
using OpenQA.Selenium.Support.UI;

namespace Medidata.RBT
{
	public class PageBase : IPage
	{
		public PageBase()
		{
			InitializeWithCurrentUrl();
		}

		public static RemoteWebDriver OpenBrowser(string browserName = null)
		{
			RemoteWebDriver _webdriver = null;

			var driverPath = RBTConfiguration.Default.WebDriverPath;
			if (!Path.IsPathRooted(driverPath))
				driverPath = new DirectoryInfo(Path.Combine(AppDomain.CurrentDomain.BaseDirectory, driverPath)).FullName;

			switch (RBTConfiguration.Default.BrowserName.ToLower())
			{
				case "firefox":
						FirefoxProfile p = new FirefoxProfile(RBTConfiguration.Default.FirefoxProfilePath);
						FirefoxBinary bin = new FirefoxBinary(RBTConfiguration.Default.BrowserPath);
						_webdriver = new FirefoxDriver(bin, p);
					break;


				case "chrome":
		
					_webdriver = new ChromeDriver(driverPath);
					break;


				case "ie":
					_webdriver = new InternetExplorerDriver(driverPath);
					break;

			}

			return _webdriver;
		}

		protected RemoteWebDriver Browser { get; set; }

		public string URL { get; protected set; }

		protected void InitializeWithNewUrl(string url)
		{
			this.URL = url;
			this.Browser = TestContext.Browser;

			Browser.Navigate().GoToUrl(url);
			PageFactory.InitElements(Browser, this);
		}

		protected void InitializeWithCurrentUrl()
		{
			this.Browser = TestContext.Browser;
			this.URL = Browser.Url;

			PageFactory.InitElements(Browser, this);
		}


		public TPage As<TPage>() where TPage :class, IPage
		{
			return this as TPage;
		}

		public virtual TPage OpenNew<TPage>() where TPage:PageBase
		{
			throw new NotImplementedException("This page object must override OpenNew method first.");
		}

		protected virtual IWebElement GetElementByName(string name)
		{
			throw new Exception("Must override");
		}

		public virtual IPage Click(string name)
		{
			GetElementByName(name).Click();
			return this;
		}

		public virtual IPage Type(string name, string text)
		{
			GetElementByName(name).SendKeys(text);
			return this;
		}

		public virtual IPage Choose(string name, string text)
		{
			new SelectElement(GetElementByName(name)).SelectByText(text);
			return this;
		}

		public virtual bool IsThePage()
		{
			return true;
		}
	}
}
