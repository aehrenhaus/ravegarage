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
using OpenQA.Selenium.Internal;



namespace Medidata.RBT
{
	/// <summary>
	/// Provides basic implemenations of IPage methods.
	/// </summary>
    public abstract class PageBase : IPage
    {
        #region .ctor and initialization


        public PageBase()
        {
			this.Browser = TestContext.Browser;
			PageFactory.InitElements(Browser, this);
        }


        #endregion

  
        #region IPage

        /// <summary>
		/// See IPage interface
        /// </summary>
		public RemoteWebDriver Browser { get; set; }

        /// <summary>
        /// Whether or not to stay on current page
        /// </summary>
        public bool StayOnPage { get; set; } //by default it is false;

		/// <summary>
		/// See IPage interface
		/// </summary>
        public abstract string URL { get; }

		/// <summary>
		/// See IPage interface
		/// </summary>
        public virtual string BaseURL { get; protected set; }

		/// <summary>
		/// See IPage interface
		/// </summary>
        public TPage As<TPage>() where TPage : class
        {
            var page = this as TPage;
            if (page == null)
            {
                TestContext.CurrentPage = TestContext.POFactory.GetPageByUrl(new Uri(Browser.Url));
                IPage currentpage = TestContext.CurrentPage as TPage as IPage;
                if (currentpage == null)
                {
                    IWebElement fakeEle = TestContext.Browser.CheckURLIsCorrect(b => CheckCurrentPage<TPage>(Browser));

                    if(fakeEle != null)
                        currentpage = TestContext.POFactory.GetPageByUrl(new Uri(Browser.Url)) as TPage as IPage;
                    else
					    throw new Exception("Expect current page to be " + typeof(TPage).Name + ", but it's " + (TestContext.CurrentPage==null?"null":TestContext.CurrentPage.GetType().Name));
                }
                return (TPage)currentpage;
            }
            return page;
        }

        /// <summary>
        /// This is a bit of a hack to use web driver wait to wait a controlled amount for the page to load.
        /// </summary>
        /// <param name="expectedPageUrl">The url of the page we expect to be here</param>
        /// <returns>Returns an empty textbox if the page matches the expected page, a null if the page doesn't</returns>
        private static IWebElement CheckCurrentPage<TPage>(RemoteWebDriver pageBaseBrowser) where TPage : class
        {
            TestContext.CurrentPage = TestContext.POFactory.GetPageByUrl(new Uri(pageBaseBrowser.Url));
            IPage currentpage = TestContext.CurrentPage as TPage as IPage;

            if (currentpage is TPage)
                return new Textbox();
            return null;
        }

		/// <summary>
		/// See IPage interface
		/// </summary>
        public virtual IPage ClickButton(string identifier)
        {
            var element = Browser.ButtonByText(identifier, true, false);
            if (element == null)
                element = Browser.ButtonByID(identifier, true, false);
			if (element == null)
				element = TryGetElementByName(identifier, null, null);
            if (element == null)
                throw new Exception("Can't find button:" + identifier);

            element.Click();

			return GetPageByCurrentUrlIfNoAlert();
        }
		
		public virtual void PressKey(string key)
        {
            if (key == "<tab>" || key == "tab")
                Browser.Keyboard.PressKey("\t");
            else
                Browser.Keyboard.PressKey(key);
        }

        /// <summary>
        /// See IPage interface
        /// </summary>
        public virtual IPage ClickLink(string linkText, string objectType = null, string areaIdentifier = null)
        {
            ISearchContext area = null;
            if (!string.IsNullOrEmpty(areaIdentifier))
            {
                area = Browser.TryFindElementById(areaIdentifier,false);
                if (area == null)
                    area = GetElementByName(areaIdentifier);
            }
            else
            {
                area = Browser;
            }

            var link = area.Link(linkText);
            link.Click();

            return GetPageByCurrentUrlIfNoAlert();
        }

		/// <summary>
		/// See IPage interface
		/// </summary>
		protected IPage GetPageByCurrentUrlIfNoAlert()
		{
			//if a model dialog presents, then Browser.Url will throw error
			//In this case there are usually more step the handle the situaltion, like accept or dismiss the dialog first.

			 var wait = new WebDriverWait(Browser, TimeSpan.FromSeconds(SeleniumConfiguration.Default.WaitElementTimeout));
			 wait.Until(driver1 => ((IJavaScriptExecutor)Browser).ExecuteScript("return document.readyState").Equals("complete"));
			try
			{
				var alert = Browser.GetAlertWindow();
			}
			catch
			{
				var uri = new Uri(Browser.Url);
				return TestContext.POFactory.GetPageByUrl(uri);
				
			}
			return this;
	
		}

        /// <summary>
		/// See IPage interface
        /// </summary>
        public virtual IPage NavigateTo(string identifier)
        {
			var link = Browser.Link(identifier);
			if (link != null)
			{
				link.Click();
				return GetPageByCurrentUrlIfNoAlert();
			}

            throw new Exception("Don't know how to navigate to "+identifier);
        }

		/// <summary>
		/// See IPage interface
		/// </summary>
        public virtual IPage Type(string identifier, string text)
        {
			var ele = TryFindElement(identifier);

			ele.EnhanceAs<Textbox>().SetText(text);
            return this;
        }

		/// <summary>
		/// See IPage interface
		/// </summary>
		public virtual IPage ChooseFromDropdown(string identifier, string text, string objectType = null, string areaIdentifier = null)
        {
			var ele = TryFindElement(identifier);

			ele.EnhanceAs<Dropdown>().SelectByText(text);

			return GetPageByCurrentUrlIfNoAlert();
        }

		/// <summary>
		/// See IPage interface
		/// </summary>
		public virtual IPage ChooseFromCheckboxes(string identifier, bool isChecked, string areaIdentifier = null, string listItem = null)
        {

			var element = TryFindElement(identifier, areaIdentifier);


            if (isChecked)
                element.EnhanceAs<Checkbox>().Check();
            else
				element.EnhanceAs<Checkbox>().Uncheck();

			return GetPageByCurrentUrlIfNoAlert();
        }

		/// <summary>
		/// See IPage interface
		/// </summary>
		public IPage ChooseFromCheckboxes(string listIdentifier, string listItem, string identifier, bool isChecked)
		{
			throw new NotImplementedException();
		}

		/// <summary>
		/// See IPage interface
		/// </summary>
        public virtual IPage ChooseFromRadiobuttons(string areaIdentifier, string identifier)
        {
            var element = Browser.RadioButton(identifier, true);
            if (element == null)
                element = GetElementByName(identifier) as RadioButton;

            element.Set();

            return this;
        }

		/// <summary>
		/// See IPage interface
		/// </summary>
        public virtual bool IsThePage()
        {
			//TODO: this does not take the {} template into account, provide fix later
			if (string.IsNullOrEmpty(this.URL))
				return false;

			return Browser.Url.ToLower().Contains(this.URL.ToLower());
        }

        /// <summary>
		/// See IPage interface
        /// </summary>
		public virtual IPage NavigateToSelf(NameValueCollection parameters = null)
        {
            string contextSessionIdstring = Storage.GetScenarioLevelValue<string>("UrlSessionID");
            string url = string.Format("{0}{1}{2}", BaseURL, string.IsNullOrEmpty(contextSessionIdstring) ? string.Empty : contextSessionIdstring + "/", URL);
            string querystring = string.Empty;

			if(parameters != null)
            {
                foreach (string key in parameters.Keys)
                {
                    //allows params within url for MVC routes
                    string keyReplacement = string.Format("{{{0}}}", key);
                    if (url.Contains(keyReplacement))
                        url = url.Replace(keyReplacement, parameters[key]);
                    else
                    {
                        //any querystring params
                        querystring = string.Format("{0}{1}{2}={3}", querystring, string.IsNullOrEmpty(querystring) ? string.Empty : "&", key, parameters[key]);
                    }
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
                Storage.SetScenarioLevelValue("UrlSessionID", sessionIdstring);
            }

            Browser = TestContext.Browser;
            PageFactory.InitElements(Browser, this);

            return this;
        }

		/// <summary>
		/// See IPage interface
		/// </summary>
		public virtual string GetInfomation(string identifier)
		{
			throw new Exception("Don't know how to get text from "+identifier);
		}

		public virtual IWebElement GetElementByName(string identifier, string areaIdentifier = null, string listItemIdentifier = null)
		{
            IWebElement element = Browser.TryFindElementBy(By.XPath("//input[@value='" + identifier + "']"));
            return element;
		}

		//Don't make this virtual , override GetElementByName in base classes
		public IWebElement TryGetElementByName(string identifier, string areaIdentifier = null, string listItemIdentifier = null)
		{
			IWebElement ele = null;
			try
			{
				ele = GetElementByName(identifier, areaIdentifier, listItemIdentifier);
			}
			catch (Exception)
			{
			}
			return ele;
		}

        #endregion

		//Don't make this public. This method is only a lines saver inside PageBase
		private IWebElement TryFindElement(string identifier, string areaIdentifier = null)
		{
			var ele = Browser.TryFindElementById(identifier, false);
			if (ele == null)
				ele = TryGetElementByName(identifier, areaIdentifier);

			if (ele == null)
				ele = Browser.TryFindElementByPartialID(identifier, false);
			if (ele == null)
			{
				ele = Browser.TryFindElementById(identifier, true);

				if (ele == null)
					ele = Browser.TryFindElementByPartialID(identifier, true);
			}
			return ele;
		}

        /// <summary>
        /// See IPage interface
        /// </summary>
		//public virtual bool CanSeeTextInArea(string text, string areaIdentifier)
		//{
		//    throw new Exception("This page does not implement this method");
		//}


        public void SetFocusElement(IWebElement ele)
        {
            this.Browser
                .TryExecuteJavascript("document.getElementById('" + ele.GetAttribute("ID") + "').focus()");
        }

		public IWebElement GetFocusElement()
		{
			return Browser.SwitchTo().ActiveElement();
		}


	}
}
