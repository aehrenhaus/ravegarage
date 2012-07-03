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
using Medidata.RBT.SeleniumExtension;
using System.Collections.Specialized;


namespace Medidata.RBT
{
    public class PageBase : IPage
    {
        #region .ctor and initialization


        public PageBase()
        {
            InitializeWithCurrentUrl();
        }

        /// <summary>
        /// Open a brower according to configuration
        /// </summary>
        /// <param name="browserName"></param>
        /// <returns></returns>
        public static RemoteWebDriver OpenBrowser(string browserName = null)
        {
            RemoteWebDriver _webdriver = null;

            var driverPath = RBTConfiguration.Default.WebDriverPath;
            if (!Path.IsPathRooted(driverPath))
                driverPath = new DirectoryInfo(Path.Combine(AppDomain.CurrentDomain.BaseDirectory, driverPath)).FullName;

            switch (RBTConfiguration.Default.BrowserName.ToLower())
            {
                case "firefox":
                    FirefoxProfile p = new FirefoxProfile(RBTConfiguration.Default.FirefoxProfilePath, true);
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

        /// <summary>
        /// Represents the actual browser
        /// </summary>
        protected RemoteWebDriver Browser { get; set; }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="url"></param>
        protected void InitializeWithNewUrl(string url)
        {
            //this.URL = url;
            this.Browser = TestContext.Browser;

            Browser.Navigate().GoToUrl(url);
            PageFactory.InitElements(Browser, this);
        }

        /// <summary>
        /// 
        /// </summary>
        protected void InitializeWithCurrentUrl()
        {
            this.Browser = TestContext.Browser;
            //this.URL = Browser.Url;

            PageFactory.InitElements(Browser, this);
        }

        /// <summary>
        /// 
        /// </summary>
        public IPage NavigateToSelf()
        {
            string url = BaseURL + URL;
            string querystring = string.Empty;
            
            foreach (string key in Parameters.Keys)
	        {
                //allows params within url for MVC routes
                string keyReplacement = string.Format("{{{0}}", key);
                if (url.Contains(keyReplacement))
                    url = url.Replace(keyReplacement, Parameters[key]);
                else
                {
                    //any querystring params
                    querystring = string.Format("{0}{1}{2}={3}", querystring, string.IsNullOrEmpty(querystring) ? string.Empty : "&", key, Parameters[key]);
                }
            }
           
            if (!string.IsNullOrEmpty(querystring))
                 url = url + "?" + querystring;

            Browser.Url = url;
            Browser = TestContext.Browser;
            PageFactory.InitElements(Browser, this);

            return this;
        }

        /// <summary>
        /// 
        /// </summary>
        /// <typeparam name="TPage"></typeparam>
        /// <returns></returns>
        public virtual TPage OpenNew<TPage>() where TPage : PageBase
        {
            throw new NotImplementedException("This page object must override OpenNew method first.");
        }

        #endregion

        /// <summary>
        /// For summary of these methods, please see IPage interface
        /// </summary>
        #region IPage

        public virtual string URL { get; protected set; }

        public virtual string BaseURL { get; protected set; }

        public TPage As<TPage>() where TPage : class, IPage
        {
            var page = this as TPage;
            if (page == null)
                throw new Exception("Expect current page to be " + typeof(TPage).Name + ", but it's not.");
            return page;
        }

        public virtual IPage ClickButton(string identifer)
        {
            var element = Browser.TryFindElementBy(By.XPath("//input[@value='" + identifer + "']"));
            if (element == null)
                element = Browser.TryFindElementById(identifer);
            if (element == null)
                element = GetElementByName(identifer);

            if (element == null)
                throw new Exception("Can't find button:" + identifer);
            element.Click();
            return this;
        }

        public virtual IPage ClickLinkInArea(string type, string linkText, string areaIdentifer)
        {
            IWebElement area = Browser.TryFindElementById(areaIdentifer);
            if (area == null)
                area = GetElementByName(areaIdentifer);

            var link = area.Link(linkText);
            link.Click();

            return GetTargetPageObjectByLinkAreaName(type, areaIdentifer);
        }

        public virtual IPage ClickLink(string linkText)
        {
            var link = Browser.Link(linkText);
            link.Click();
            return this;
        }

        public virtual IPage NavigateTo(string identifer)
        {
            throw new Exception("page object does not implment NavigateTo()");
        }


        public virtual IPage Type(string identifer, string text)
        {
            var element = Browser.Textbox(identifer);
            if (element == null)
                element = GetElementByName(identifer).EnhanceAs<Textbox>();
            element.SetText(text);
            return this;
        }

        public virtual IPage ChooseFromDropdown(string identifer, string text)
        {
            var element = Browser.Dropdown(identifer, true);
            if (element == null)
                element = GetElementByName(identifer).EnhanceAs<Dropdown>();

            element.SelectByText(text);
            return this;
        }

        public virtual IPage ChooseFromCheckboxes(string areaIdentifer, string identifer, bool isChecked)
        {

            var element = Browser.Checkbox(identifer, true);
            if (element == null)
                element = GetElementByName(identifer).EnhanceAs<Checkbox>();

            if (isChecked)
                element.Check();
            else
                element.Uncheck();

            return this;
        }

        public virtual IPage ChooseFromRadiobuttons(string areaIdentifer, string identifer)
        {
            var element = Browser.RadioButton(identifer, true);
            if (element == null)
                element = GetElementByName(identifer) as RadioButton;

            element.Set();

            return this;
        }

        public virtual bool IsThePage()
        {
            return true;
        }

        public virtual NameValueCollection Parameters
        {
            get
            {
                NameValueCollection param = new NameValueCollection();
                return param;
            }
        }

        #endregion


        /// <summary>
        /// This method is used by many default implmentation of IPage methods, where a friendly name is used to find a IWebElement
        /// In many case you will only need to orverride this method to provide mappings on your specific page obejct in order for a step to work.
        /// <example>
        /// 
        ///protected override IWebElement GetElementByName(string name)
        ///{
        ///    if (name == "Active Projects")
        ///        return Browser.Table("_ctl0_Content_ProjectGrid");
        ///    if (name == "Inactive Projects")
        ///        return Browser.Table("_ctl0_Content_InactiveProjectGrid");
        ///
        ///    return base.GetElementByName(name);
        ///}
        /// 
        /// </example>
        /// </summary>
        /// <param name="name"></param>
        /// <returns></returns>
        protected virtual IWebElement GetElementByName(string name)
        {
            throw new Exception("This page does not provide information about named page elements");
        }

        /// <summary>
        /// This is only used by default implementaion of ClickLinkInArea()
        /// which tries to find out the target page object of the linkarea.
        /// 
        /// This is useful when a group of links will navigate to same kind of Url's ,just with different parameters.
        /// 
        /// If a group of links will go to different Urls, use IPage.Navigate() method instead.
        /// 
        /// </summary>
        /// <param name="areaName"></param>
        /// <returns></returns>
        //protected virtual IPage GetTargetPageObjectByLinkAreaName(string areaName)
        //{
        //    return GetTargetPageObjectByLinkAreaName(null, areaName);
        //}

        protected virtual IPage GetTargetPageObjectByLinkAreaName(string type, string areaName)
        {
            throw new Exception("This page does not provide information of target page obejct of a link area");
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="text"></param>
        /// <param name="areaIdentifer"></param>
        /// <returns></returns>
        public virtual bool CanSeeTextInArea(string text, string areaIdentifer)
        {
            throw new Exception("This page does not implement this method");
        }

        /// <summary>
        /// Get the alert reference inorder to click yes, no etc.
        /// </summary>
        /// <returns></returns>
        public IAlert GetAlertWindow()
        {
            IAlert alert = Browser.SwitchTo().Alert();
            return alert;
        }
    }
}
