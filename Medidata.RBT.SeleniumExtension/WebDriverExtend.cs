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

namespace Medidata.RBT.SeleniumExtension
{
	public static class WebDriver
	{
		public static bool TryExecuteJavascript(this RemoteWebDriver driver, string script)
		{
			try
			{
				driver.ExecuteScript(script);
			
			}
			catch
			{
				return false;
			}

			return true;
		}


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
			foreach (var handle in driver.WindowHandles)
			{
				window = driver.SwitchTo().Window(handle);
				if (window.Title == windowName)
				{
					found = true;
					break;
				}
			}
			if (!found) throw new Exception(string.Format("window {0} not found", windowName));
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
	}
}
