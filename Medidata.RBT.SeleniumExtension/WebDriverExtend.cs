using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;
using OpenQA.Selenium;
using OpenQA.Selenium.Remote;
using System.Collections.ObjectModel;
using TechTalk.SpecFlow;
using OpenQA.Selenium.Internal;
using OpenQA.Selenium.Support.UI;
using Medidata.RBT.ConfigurationHandlers;
using OpenQA.Selenium.Interactions;

namespace Medidata.RBT.SeleniumExtension
{
	public static class WebDriver
	{
		public static long GetPageOffsetX(this RemoteWebDriver driver)
		{
			IJavaScriptExecutor js = driver as IJavaScriptExecutor;
			return (long)js.ExecuteScript("return window.pageXOffset");
		}

		public static long GetPageOffsetY(this RemoteWebDriver driver)
		{
			IJavaScriptExecutor js = driver as IJavaScriptExecutor;
			return (long)js.ExecuteScript("return window.pageYOffset");
		}

		public static void SwitchBrowserWindow(this RemoteWebDriver driver, string windowName)
		{
			driver.WaitForDocumentLoad();
			bool found = false;

			IWebDriver window = null;
            int sleepTime = 100;
            int timeoutInMsec;
			foreach (var handle in driver.WindowHandles)
			{
				window = driver.SwitchTo().Window(handle);

                //sometimes we query window before the title is updated resulting in this step to fail
                //wait to see if the title has updated then proceed
                //timeout in 10 seconds
                timeoutInMsec = 10000;
                while ((string.IsNullOrWhiteSpace(window.Title) || "untitled".Equals(window.Title, StringComparison.InvariantCultureIgnoreCase)) && timeoutInMsec > 0)
                {
                    Thread.Sleep(sleepTime);
                    timeoutInMsec = timeoutInMsec - sleepTime;
                }

				if (window.Title == windowName)
				{
					found = true;
					break;
				}
			}
			if (!found) throw new NoSuchWindowException(string.Format("window {0} not found", windowName));
			while (driver.Url == "about:blank")
				Thread.Sleep(500);

			driver.WaitForDocumentLoad();
		}

		public static void SwitchToSecondBrowserWindow(this RemoteWebDriver driver)
		{
			if (driver.WindowHandles.Count < 2)
				throw new Exception("There isn't a second window");
			var secondWindowHandle = driver.WindowHandles[1];

			IWebDriver window = driver.SwitchTo().Window(secondWindowHandle);

			while (driver.Url == "about:blank")
				Thread.Sleep(500);

		}


		public static void SwitchToMainBrowserWindow(this RemoteWebDriver driver, bool close = false)
		{
			if (close)
				driver.Close();

			var secondWindowHandle = driver.WindowHandles[0];

			IWebDriver window = driver.SwitchTo().Window(secondWindowHandle); ;
		}

		/// <summary>
		/// Get the alert reference inorder to click yes, no etc.
		/// </summary>
		/// <returns></returns>
		public static IAlert GetAlertWindow(this RemoteWebDriver driver)
		{
			IAlert alert = driver.SwitchTo().Alert();
			return alert;
		}

		public static void WaitForDocumentLoad(this RemoteWebDriver driver)
		{
			var wait = new WebDriverWait(driver, TimeSpan.FromSeconds(SeleniumConfiguration.Default.WaitElementTimeout));
			wait.Until(driver1 => ((IJavaScriptExecutor)driver).ExecuteScript("return document.readyState").Equals("complete"));
		}

        public static void WaitForElementToCompleteDisplayOrDisplayWithWarning(this RemoteWebDriver driver, By elementBy, By warningBy)
        {
            var wait = new WebDriverWait(driver, TimeSpan.FromSeconds(SeleniumConfiguration.Default.WaitElementTimeout));
            wait.Until(driver1 => 
                {
                    if (driver.TryFindElementBy(elementBy) != null)
                        return true;

                    //If it is displayed maybe there is a warning, this is expected behavior
                    if (driver.TryFindElementBy(warningBy) != null)
                        return true;

                    return false;
                });
        }

        public static void WaitForPageToBeReady(this RemoteWebDriver driver, double timeoutSeconds = 180)
        {
            WebDriverWait wait = new WebDriverWait(driver, TimeSpan.FromSeconds(timeoutSeconds));
            wait.Until(driver1 => ((IJavaScriptExecutor)driver).ExecuteScript("return window.location.protocol").Equals("http:")
                || ((IJavaScriptExecutor)driver).ExecuteScript("return window.location.protocol").Equals("https:"));
        }

        /// <summary>
        /// Use this method to navigate to next tab
        /// A check should be made in higher level API to verify if multiple tabs exist
        /// </summary>
        /// <param name="driver"></param>
        public static void SwitchToNextTab(this RemoteWebDriver driver)
        {
            new Actions(driver).SendKeys(driver.FindElement(By.TagName("html")), Keys.Control + Keys.Tab).
                Build().Perform();

            new Actions(driver).KeyUp(Keys.Control).Build().Perform();

            driver.SwitchTo().Window(driver.WindowHandles[0]);
        }

        /// <summary>
        /// Use this method to navigate to previous tab
        /// A check should be made in higher level API to verify if multiple tabs exist
        /// </summary>
        /// <param name="driver"></param>
        public static void SwitchToPreviousTab(this RemoteWebDriver driver)
        {
            new Actions(driver).SendKeys(driver.FindElement(By.TagName("html")), Keys.Control + Keys.Shift + Keys.Tab).
                Build().Perform();

            new Actions(driver).KeyUp(Keys.Shift).Build().Perform();
            new Actions(driver).KeyUp(Keys.Control).Build().Perform();

            driver.SwitchTo().Window(driver.WindowHandles[0]);
        }

        /// <summary>
        /// This method uses the web element passsed to right click the context menu followed by an attempt to 
        /// open link in new tab
        /// </summary>
        /// <param name="driver"></param>
        /// <param name="elementToClick"></param>
        public static void OpenLinkInNewTab(this RemoteWebDriver driver, IWebElement elementToClick)
        {
            if (elementToClick.TagName.Equals("a"))
            {
                new Actions(driver).ContextClick(elementToClick).SendKeys(Keys.ArrowDown).
                    SendKeys(Keys.Return).Build().Perform();
            }
            else
                throw new InvalidOperationException("Element should be a link in order to be opened in a new tab");
        }

        /// <summary>
        /// Use this method to switch to the tab window specified by the tab number parameter
        /// </summary>
        /// <param name="driver"></param>
        /// <param name="tabNumber"></param>
        public static void SwitchToTabNumber(this RemoteWebDriver driver, int tabNumber)
        {
            new Actions(driver).SendKeys(driver.FindElement(By.TagName("html")), Keys.Control + GetNumPadKeyString(tabNumber)).
                Build().Perform();

            new Actions(driver).KeyUp(Keys.Control).Build().Perform();

            driver.SwitchTo().Window(driver.WindowHandles[0]);
        }

        private static string GetNumPadKeyString(int tabNumber)
        {
            switch (tabNumber)
            {
                case 0: return Keys.NumberPad0;
                case 1: return Keys.NumberPad1;
                case 2: return Keys.NumberPad2;
                case 3: return Keys.NumberPad3;
                case 4: return Keys.NumberPad4;
                case 5: return Keys.NumberPad5;
                case 6: return Keys.NumberPad6;
                case 7: return Keys.NumberPad7;
                case 8: return Keys.NumberPad8;
                case 9: return Keys.NumberPad9;
                default: throw new ArgumentException("Argument should be between 0 and 9");
            }
        }
	}
}
