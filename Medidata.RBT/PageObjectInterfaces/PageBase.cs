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
using System.Threading;



namespace Medidata.RBT
{
	/// <summary>
	/// Provides basic implemenations of IPage methods.
	/// </summary>
    public abstract class PageBase : IPage
    {
		/// <summary>
		/// WARNING:
		/// TODO:
		/// 
		/// This constructor uses static member of SpecflowStaticBindings class to get the WebTestContext object,
		/// this breaks the separation of web test and specflow test.
		/// 
		/// I add this constructor just for convenience.
		/// Ideally , every PO classes should accept a WebTestContext object in the constructor
		/// </summary>
		public PageBase()
			: this((SpecflowStaticBindings.Current as SpecflowWebTestContext).WebTestContext)
		{
		}


        #region .ctor and initialization


		public PageBase(WebTestContext context)
        {
			//TODO: this line should be removed too when the parameterless constructor (demon contract) get removed.
			if (context == null)
				return;

			this.Context = context;
			PageFactory.InitElements(Browser, this);
			
        }


        #endregion

  
        #region IPage

		/// <summary>
		/// See IPage interface
		/// </summary>
		public WebTestContext Context { get; set; }

        /// <summary>
		/// See IPage interface
        /// </summary>
		public RemoteWebDriver Browser { get { return Context.Browser; } }

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
				Context.CurrentPage = Context.POFactory.GetPageByUrl(new Uri(Browser.Url));
				IPage currentpage = Context.CurrentPage as TPage as IPage;
				if (currentpage == null)
				{
					IWebElement fakeEle = Context.Browser.CheckURLIsCorrect(b => CheckCurrentPage<TPage>(Browser));

					if (fakeEle != null)
						currentpage = Context.POFactory.GetPageByUrl(new Uri(Browser.Url)) as TPage as IPage;
					else
						throw new Exception("Expect current page to be " + typeof(TPage).Name + ", but it's " + (Context.CurrentPage == null ? "null" : Context.CurrentPage.GetType().Name));
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
		private IWebElement CheckCurrentPage<TPage>(RemoteWebDriver pageBaseBrowser) where TPage : class
		{
			this.Context.CurrentPage = Context.POFactory.GetPageByUrl(new Uri(pageBaseBrowser.Url));
			IPage currentpage = Context.CurrentPage as TPage as IPage;

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

			return Context.WaitForPage();
        }
		
        /// <summary>
        /// Will try to press a key in two attempts.
        /// It has been observed that Selenium throws an ambiguous "a is null" exception on occasions
        /// that may be caused by a timeout.
        /// </summary>
        /// <param name="key"></param>
		public virtual void PressKey(string key)
        {
            InvalidOperationException ex = null;
            if (PressKeyWrapper(key) != null)
            {
                //Since this is and attempt to fix an 
                //intermittent issue, lets wait before attempting again
                Thread.Sleep(1000);
                if (null != (ex = PressKeyWrapper(key)))
                    throw new Exception(
                        string.Format("There was a problem pressing the key [{0}] on the second attempt", key),
                        ex);
            }
        }
        private InvalidOperationException PressKeyWrapper(string key)
        {
            InvalidOperationException result = null;
            try
            {
                if (key == "<tab>" || key == "tab")
                    Browser.Keyboard.PressKey("\t");
                else
                    Browser.Keyboard.PressKey(key);
            }
            catch (InvalidOperationException ioe) { result = ioe; }
           
            return result;
        }
		
		///// <summary>
		///// See IPage interface
		///// </summary>
		//protected IPage GetPageByCurrentUrlIfNoAlert()
		//{
		//    try
		//    {
		//        //if alert presents , return current page object
		//        var alert = Browser.SwitchTo().Alert();
		//    }
		//    catch
		//    {
		//        //if no alert window, wait and return the new page
		//        Browser.WaitForDocumentLoad();
		//        var uri = new Uri(Browser.Url);

		//        return WebTestContext.POFactory.GetPageByUrl(uri);

		//    }
		//    return this;
	
	
		//}
        /// <summary>
        /// See IPage interface
        /// </summary>
		public virtual IPage ClickLink(string linkText, string objectType = null, string areaIdentifier = null, bool partial = false)
        {
			ISearchContext context = string.IsNullOrEmpty(areaIdentifier) ? Browser as ISearchContext : this.GetElementByName(areaIdentifier, null);

			IWebElement link = partial ? context.TryFindElementBy(By.PartialLinkText(linkText)) : context.TryFindElementBy(By.LinkText(linkText));
			link.Click();
 
            return Context.WaitForPage();
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
				return Context.WaitForPage();
			}

            throw new Exception("Don't know how to navigate to "+identifier);
        }

		/// <summary>
		/// See IPage interface
		/// </summary>
        public virtual IPage Type(string identifier, string text)
        {
			var ele = FindElementDelayedWait(identifier,null);

			ele.EnhanceAs<Textbox>().SetText(text);
            return this;
        }

		/// <summary>
		/// See IPage interface
		/// </summary>
		public virtual IPage ChooseFromDropdown(string identifier, string text, string objectType = null, string areaIdentifier = null)
        {
			var ele = FindElementDelayedWait(identifier,areaIdentifier);

			ele.EnhanceAs<Dropdown>().SelectByText(text);

			return Context.WaitForPage();
        }

        /// <summary>
        /// See IPage interface
        /// </summary>
        public virtual IPage ChooseFromPartialDropdown(string identifier, string text, string objectType = null, string areaIdentifier = null)
        {
            var ele = FindElementDelayedWait(identifier,areaIdentifier);

            ele.EnhanceAs<Dropdown>().SelectByPartialText(text);

            return Context.WaitForPage();
        }

		/// <summary>
		/// See IPage interface
		/// </summary>
		public virtual IPage ChooseFromCheckboxes(string identifier, bool isChecked, string areaIdentifier = null, string listItem = null)
        {

			var element = FindElementDelayedWait(identifier, areaIdentifier);


            if (isChecked)
                element.EnhanceAs<Checkbox>().Check();
            else
				element.EnhanceAs<Checkbox>().Uncheck();

			return Context.WaitForPage();
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
			var element = FindElementDelayedWait(identifier, areaIdentifier);
            element.EnhanceAs<RadioButton>().Set();

            return this;
        }

		/// <summary>
		/// See IPage interface
		/// </summary>
        public virtual bool IsThePage()
        {
			if (string.IsNullOrEmpty(this.URL))
				return false;
			var uri = new Uri(Browser.Url);
			string stripSessionUrl = uri.Scheme + "://" + uri.Host+string.Join("",uri.Segments.Where(x=>!x.StartsWith("(S(")).ToArray()).ToLower();
			//uri = new Uri(stripSessionUrl);

			if (!stripSessionUrl.StartsWith(BaseURL.ToLower()))
				return false;

			string path = stripSessionUrl.Replace(BaseURL.ToLower(), "");


			bool isThePage = string.Equals(this.URL, path, StringComparison.InvariantCultureIgnoreCase) 
                || string.Equals(this.URL, path + uri.Query, StringComparison.InvariantCultureIgnoreCase);
			return isThePage;
        }

        /// <summary>
		/// See IPage interface
        /// </summary>
		public virtual IPage NavigateToSelf(NameValueCollection parameters = null)
        {
			string contextSessionIdstring = Context.Storage["UrlSessionID"] as string;
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
            Browser.WaitForPageToBeReady();
            
            string modifiedUrl = Browser.Url;
            if (modifiedUrl.Contains("S(") && string.IsNullOrEmpty(contextSessionIdstring))
            {
                int sessionidstart = modifiedUrl.IndexOf("(S(");
                string sessionIdstring = modifiedUrl.Substring(sessionidstart, (modifiedUrl.IndexOf("/", sessionidstart) - sessionidstart));
				Context.Storage["UrlSessionID"] = sessionIdstring;
            }

            
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
			throw new Exception(string.Format("This page ({0}) does not provide information about element: {1}", this.GetType().Name, identifier));
		
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
		private IWebElement FindElementDelayedWait(string identifier, string areaIdentifier)
		{
			ISearchContext context = string.IsNullOrEmpty(areaIdentifier) ? Browser as ISearchContext : this.GetElementByName(null, areaIdentifier, null);

			var ele = context.TryFindElementById(identifier, false);
			if (ele == null)
				ele = TryGetElementByName(identifier, areaIdentifier);

			if (ele == null)
				ele = context.TryFindElementByPartialID(identifier, false);
			if (ele == null)
			{
				ele = context.TryFindElementById(identifier, true);

				if (ele == null)
					ele = context.TryFindElementByPartialID(identifier, true);
			}
			return ele;
		}


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
