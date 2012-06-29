using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium;
using OpenQA.Selenium.Remote;
using System.Collections.ObjectModel;
using TechTalk.SpecFlow;
using OpenQA.Selenium.Internal;
using OpenQA.Selenium.Support.UI;

namespace Medidata.RBT.SeleniumExtension
{
	public static class WebDriverExtend
	{

		public static void TryExecuteJavascript(this RemoteWebDriver driver, string script)
		{
			try
			{
				driver.ExecuteScript(script);
			}
			catch
			{
			}
		}


		private static IWebElement waitForElement( IWebDriver driver, Func<IWebDriver, IWebElement> getElement, string errorMessage = null, double timeOutSecond = 3)
		{

			var wait = new WebDriverWait(driver, TimeSpan.FromSeconds(timeOutSecond));
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
		public static IWebElement WaitForElement(this IWebDriver driver, Func<IWebDriver, IWebElement> getElement, string errorMessage = null, double timeOutSecond = 3)
		{


			return waitForElement(driver, getElement, errorMessage, timeOutSecond);
		}

		public static IWebElement WaitForElement(this IWebDriver driver, By by, string errorMessage = null, double timeOutSecond = 3)
		{
			return waitForElement(driver, browser => browser.FindElement(by), errorMessage, timeOutSecond);
		}


		public static IWebElement WaitForElement(this IWebDriver driver, string partialID, Func<IWebElement, bool> predicate=null, string errorMessage = null, double timeOutSecond = 3)
		{
			Func<IWebDriver, IWebElement> func =browser => browser.FindElements(By.XPath(".//*[contains(@id,'" + partialID + "')]")).FirstOrDefault((predicate==null)?(c=>true):predicate);
		
			return waitForElement(driver, func, errorMessage, timeOutSecond);
		}



	}
}
