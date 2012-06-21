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
using Medidata.RBT.PageObjects;


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
						FirefoxProfile p = new FirefoxProfile(RBTConfiguration.Default.FirefoxProfilePath,true);
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
			var page = this as TPage;
			if (page == null)
				throw new Exception("Expect current page to be "+typeof(TPage).Name+", but it's not.");
			return page;
		}

		public virtual TPage OpenNew<TPage>() where TPage:PageBase
		{
			throw new NotImplementedException("This page object must override OpenNew method first.");
		}

		protected virtual IWebElement GetElementByName(string name)
		{
			throw new Exception("This page does not provide information about named page elements");
		}

		protected virtual IPage GetTargetPageObjectByLinkAreaName(string areaName)
		{
			throw new Exception("This page does not provide information of target page obejct of a link area");
		}

		public virtual IPage ClickButton(string textOrName)
		{
            var button = Browser.TryFindElementBy(By.XPath("//input[text()='"+textOrName+"']"));
            if (button == null)
                button = GetElementByName(textOrName);

            if (button == null)
                throw new Exception("Can't find button:"+textOrName);
            button.Click();
			return this;
		}

		public virtual IPage ClickLinkInArea(string linkText, string areaName)
		{
			IWebElement area = GetElementByName(areaName);
			ClickLink(linkText);
			return GetTargetPageObjectByLinkAreaName(areaName);
		}

		public virtual IPage ClickLink(string linkText)
		{
			var link = Browser.TryFindElementBy(By.LinkText(linkText));
			if (link == null)
				throw new Exception("Can'f find hyperlink: "+linkText);
			return this;
		}

		public virtual IPage Type(string name, string text)
		{
			GetElementByName(name).SetText(text);
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

        public IWebElement WaitForElement(Func<IWebDriver,IWebElement> getElement,string errorMessage=null, double timeOutSecond =3)
        {

            var wait = new WebDriverWait(Browser, TimeSpan.FromSeconds(timeOutSecond));
            IWebElement ele = null;
			try
			{
				ele = wait.Until(getElement);
			}
			catch
			{
				if (errorMessage == null)
					throw;
				else
					throw new Exception(errorMessage);
			}
            return ele;
        }
	}
}
