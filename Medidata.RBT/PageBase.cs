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

namespace Medidata.RBT
{
	public class PageBase
	{
		public PageBase()
		{
			InitializeWithCurrentUrl();
		}

		public static RemoteWebDriver OpenBrowser(string browserName = null)
		{
			RemoteWebDriver _webdriver = null;
			
			switch (RBTConfiguration.Default.BrowserName.ToLower())
			{
				case "firefox":
						FirefoxProfile p = new FirefoxProfile(RBTConfiguration.Default.FirefoxProfilePath);
						FirefoxBinary bin = new FirefoxBinary(RBTConfiguration.Default.BrowserPath);
						_webdriver = new FirefoxDriver(bin, p);
					break;


				case "chrome":
					var chromeDriverPath = RBTConfiguration.Default.ChromeDriverPath;
					if (!Path.IsPathRooted(chromeDriverPath))
						chromeDriverPath = Path.Combine(AppDomain.CurrentDomain.BaseDirectory, chromeDriverPath);
					_webdriver = new ChromeDriver(chromeDriverPath);
					break;


				case "ie":
					InternetExplorerOptions o = new InternetExplorerOptions();
					o.IntroduceInstabilityByIgnoringProtectedModeSettings = true;
					_webdriver = new InternetExplorerDriver(o);
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


		public TPage As<TPage>() where TPage : PageBase
		{
			return this as TPage;
		}

		public virtual TPage OpenNew<TPage>() where TPage:PageBase
		{
			throw new NotImplementedException("This page object must override OpenNew method first.");
		}

	}
}
