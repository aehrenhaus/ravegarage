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
			this.Browser = TestContext.Browser;
			PageFactory.InitElements(Browser, this);
        }

        /// <summary>
        /// Represents the actual browser
        /// </summary>
        protected RemoteWebDriver Browser { get; set; }


  
        #endregion

        /// <summary>
        /// For summary of these methods, please see IPage interface
        /// </summary>
        #region IPage

		public virtual string URL { get { throw new Exception("Must override URL property"); } }

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


			return TestContext.POFactory.GetPageByUrl(new Uri(Browser.Url));
        }

        public virtual IPage ClickLink(string linkText)
        {
            var link = Browser.Link(linkText);
            link.Click();
			return TestContext.POFactory.GetPageByUrl(new Uri(Browser.Url)); ;
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
			//TODO: this does not take the {} template into account, provide fix later
			if (string.IsNullOrEmpty(this.URL))
				return false;

			return Browser.Url.Contains(this.URL);
        }

        /// <summary>
        /// 
        /// </summary>
        public IPage NavigateToSelf()
        {
            string contextSessionIdstring = TestContext.GetContextValue<string>("UrlSessionID");
            string url = string.Format("{0}{1}{2}", BaseURL, string.IsNullOrEmpty(contextSessionIdstring) ? string.Empty : contextSessionIdstring + "/", URL);
            string querystring = string.Empty;

            foreach (string key in Parameters.Keys)
            {
                //allows params within url for MVC routes
                string keyReplacement = string.Format("{{{0}}}", key);
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
            string modifiedUrl = Browser.Url;
            if (modifiedUrl.Contains("S(") && string.IsNullOrEmpty(contextSessionIdstring))
            {
                int sessionidstart = modifiedUrl.IndexOf("(S(");
                string sessionIdstring = modifiedUrl.Substring(sessionidstart, (modifiedUrl.IndexOf("/", sessionidstart) - sessionidstart));
                TestContext.SetContextValue("UrlSessionID", sessionIdstring);
            }

            Browser = TestContext.Browser;
            PageFactory.InitElements(Browser, this);

            return this;
        }

		/// <summary>
		/// Get some critical text from the page
		/// </summary>
		/// <param name="identifer"></param>
		public virtual string GetInfomation(string identifer)
		{
			throw new Exception("Don't know how to get text from "+identifer);
		}

        #endregion


		private NameValueCollection param = new NameValueCollection();
		public virtual NameValueCollection Parameters
		{
			get { return param; }
		}


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

		//protected virtual IPage GetTargetPageObjectByLinkAreaName(string type, string areaName)
		//{
		//    if (string.IsNullOrEmpty(type))
		//        return this;
		//    throw new Exception(string.Format("This page does not provide information of target page obejct of a link area(type={0}, area={1}",type,areaName));
      
		//}

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


		public IWebElement WaitForElement(Func<IWebDriver, IWebElement> getElement, string errorMessage = null, double timeOutSecond = 0)
		{
			if (timeOutSecond == 0)
				timeOutSecond = RBTConfiguration.Default.ElementWaitTimeout;
			return Browser.WaitForElement( getElement, errorMessage, timeOutSecond);
		}

		public IWebElement WaitForElement(By by, string errorMessage = null, double timeOutSecond = 0)
		{
			if (timeOutSecond == 0)
				timeOutSecond = RBTConfiguration.Default.ElementWaitTimeout;
			return Browser.WaitForElement( browser => browser.FindElement(by), errorMessage, timeOutSecond);
		}


		public IWebElement WaitForElement(string partialID, Func<IWebElement, bool> predicate = null, string errorMessage = null, double timeOutSecond = 0)
		{
			if (timeOutSecond == 0)
				timeOutSecond = RBTConfiguration.Default.ElementWaitTimeout;
	
			return Browser.WaitForElement(partialID,predicate, errorMessage, timeOutSecond);
		}
   
	}
}
