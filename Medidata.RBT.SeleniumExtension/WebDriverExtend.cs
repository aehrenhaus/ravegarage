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
	}
}
