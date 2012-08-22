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
using ICSharpCode.SharpZipLib.Zip;


namespace Medidata.RBT
{
	/// <summary>
	/// Provides basic implemenations of IPage methods.
	/// </summary>
    public class PageBase : IPage
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
		/// See IPage interface
		/// </summary>
		public virtual string URL { get { throw new Exception("Must override URL property"); } }

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
                var currentpage = TestContext.CurrentPage as TPage;
                if (currentpage == null)
                {
                    throw new Exception("Expect current page to be " + typeof(TPage).Name + ", but it's not.");
                }
                return currentpage;
            }
            return page;
        }

		/// <summary>
		/// See IPage interface
		/// </summary>
        public virtual IPage ClickButton(string identifier)
        {
            var element = Browser.TryFindElementBy(By.XPath("//button[text()='" + identifier + "']"));
            if (element == null)
				element = Browser.TryFindElementBy(By.XPath("//input[@value='" + identifier + "']"));
            if (element == null)
                element = Browser.TryFindElementById(identifier);
            if (element == null)
                element = GetElementByName(identifier);

            if (element == null)
                throw new Exception("Can't find button:" + identifier);
            element.Click();

			var uri = new Uri(Browser.Url);
			return TestContext.POFactory.GetPageByUrl(uri); ;
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
        public virtual IPage ClickLinkInArea(string type, string linkText, string areaIdentifier)
        {
			
            IWebElement area = Browser.TryFindElementById(areaIdentifier);
            if (area == null)
                area = GetElementByName(areaIdentifier);

            var link = area.Link(linkText);
            link.Click();

			return GetPageByCurrentUrlIfNoAlert();
        }

		/// <summary>
		/// See IPage interface
		/// </summary>
        public virtual IPage ClickLink(string linkText)
        {
            var link = Browser.Link(linkText);
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
				
			try
			{
				var alert = this.GetAlertWindow();
			}
			catch
			{
				var uri = new Uri(Browser.Url);
				return TestContext.POFactory.GetPageByUrl(uri);
				
			}
			return this;
	
		}


        /// <summary>
        /// Clicks the link that is created as a span with an onclick event.  
        /// </summary>
        /// <param name="linkText">The link text.</param>
        /// <returns></returns>
        public virtual IPage ClickSpanLink(string linkText)
        {

            var item = Browser.TryFindElementByLinkText(linkText);
            if (item != null) 
				item.Click();
            else 
				throw new Exception("Can't find link by text:" + linkText);

			return GetPageByCurrentUrlIfNoAlert();
        }

        /// <summary>
		/// See IPage interface
        /// </summary>
        public virtual IPage NavigateTo(string identifier)
        {
            throw new Exception("Don't know how to navigate to "+identifier);
        }

		/// <summary>
		/// See IPage interface
		/// </summary>
        public virtual IPage Type(string identifier, string text)
        {
            var element = Browser.Textbox(identifier);
            if (element == null)
                element = GetElementByName(identifier).EnhanceAs<Textbox>();
            element.SetText(text);
            return this;
        }

		/// <summary>
		/// See IPage interface
		/// </summary>
        public virtual IPage ChooseFromDropdown(string identifier, string text)
        {
            var element = Browser.Dropdown(identifier, true);
            if (element == null)
                element = GetElementByName(identifier).EnhanceAs<Dropdown>();

            element.SelectByText(text);

			return GetPageByCurrentUrlIfNoAlert();
        }

		/// <summary>
		/// See IPage interface
		/// </summary>
        public virtual IPage ChooseFromCheckboxes(string areaIdentifier, string identifier, bool isChecked)
        {

            var element = Browser.Checkbox(identifier, true);
            if (element == null)
                element = GetElementByName(identifier).EnhanceAs<Checkbox>();

            if (isChecked)
                element.Check();
            else
                element.Uncheck();

			return GetPageByCurrentUrlIfNoAlert();
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
        public virtual void DeleteObjectOnPage(RemoveableObject removeableObject)
        {
            throw new NotImplementedException();
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
            string contextSessionIdstring = TestContext.GetContextValue<string>("UrlSessionID");
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
                TestContext.SetContextValue("UrlSessionID", sessionIdstring);
            }

            Browser = TestContext.Browser;
            PageFactory.InitElements(Browser, this);

            return this;
        }

		/// <summary>
		/// See IPage interface
		/// </summary>
		public virtual bool CanSeeTextInArea(string text, string areaIdentifier)
		{
			throw new Exception("This page does not implement this method");
		}

		/// <summary>
		/// See IPage interface
		/// </summary>
		public virtual string GetInfomation(string identifier)
		{
			throw new Exception("Don't know how to get text from "+identifier);
		}

        #endregion
        


        /// <summary>
        /// This method is used by many default implmentation of IPage methods, where a friendly name is used to find a IWebElement
        /// In many case you will only need to orverride this method to provide mappings on your specific page object in order for a step to work.
        /// <example>
        /// 
        ///public override IWebElement GetElementByName(string name)
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
        public virtual IWebElement GetElementByName(string name)
        {
			throw new Exception("This page does not provide information about named element:" + name);
        }

        public virtual IWebElement CanSeeControl(string identifier)
        {
            IWebElement element = Browser.TryFindElementBy(By.XPath("//input[@value='" + identifier + "']"));
            if (element == null)
                element = Browser.TryFindElementById(identifier);
            if (element == null)
                element = GetElementByName(identifier);

            return element;
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

        public void SelectLink(string linkText)
        {
            var link = Browser.Link(linkText);
            link.Click();
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

        public void FocusOnElementById(string id)
        {
            this.Browser
                .TryExecuteJavascript("document.getElementById('" + id + "').focus()");
        }

        public long GetPageOffsetX()
        {
            IJavaScriptExecutor js = Browser as IJavaScriptExecutor;
            return (long)js.ExecuteScript("return window.pageXOffset");
        }

        public long GetPageOffsetY()
        {
            IJavaScriptExecutor js = Browser as IJavaScriptExecutor;
            return (long)js.ExecuteScript("return window.pageYOffset");
        }

        public IWebElement GetCurrentFocusedElement()
        {
            return Browser.SwitchTo().ActiveElement();
        }

        /// <summary>
        /// See IPage interface
        /// </summary>
        public List<String> UnzipAllDownloads()
        {
            List<String> extractedFilePaths = new List<string>();
            List<String> zipFilePaths = Directory.GetFiles(TestContext.DownloadPath, "*.zip").ToList();
            foreach (String zipFilePath in zipFilePaths)
                extractedFilePaths.AddRange(UnZipAndExtract(zipFilePath));

            return extractedFilePaths;
        }

        //Unzips a zip file in the download path returns a list of the extracted files' paths.
        private List<String> UnZipAndExtract(string zipFilePath)
        {
            List<String> extractedFilePaths = new List<string>();

            using (FileStream fileStreamIn = new FileStream(zipFilePath, FileMode.Open))
            {
                using (ZipInputStream zipInputStream = new ZipInputStream(fileStreamIn))
                {
                    ZipEntry currentEntry = zipInputStream.GetNextEntry();

                    String fullZipToPath = TestContext.DownloadPath + currentEntry.Name.Replace("/", "\\");
                    
                    string directoryName = Path.GetDirectoryName(fullZipToPath);
                    if (directoryName.Length > 0)
                        Directory.CreateDirectory(directoryName);

                    using (FileStream fileStreamOut = new FileStream(fullZipToPath, FileMode.Create, FileAccess.Write))
                    {
                        int size;
                        byte[] buffer = new byte[4096];
                        do
                        {
                            size = zipInputStream.Read(buffer, 0, buffer.Length);
                            fileStreamOut.Write(buffer, 0, size);
                        } while (size > 0);
                    }
                    extractedFilePaths.Add(fullZipToPath);
                }
            }
            
            return extractedFilePaths;
        }
    }
}
