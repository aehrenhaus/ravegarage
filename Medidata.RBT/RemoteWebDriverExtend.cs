using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium;
using OpenQA.Selenium.Remote;

namespace Medidata.RBT.PageObjects
{
	public static class RemoteWebDriverExtend
	{
        public static ICollection<IWebElement> FindTextboxes(this ISearchContext driver)
        {
            return driver.FindElements(By.XPath(".//input[@type='text']"));
        }

        public static ICollection<IWebElement> FindCheckboxes(this ISearchContext driver)
        {
            return driver.FindElements(By.XPath(".//input[@type='checkbox']"));
        }

        public static void SetText(this IWebElement driver, string text)
        {
            driver.Clear();
            driver.SendKeys(text);
        }

		public static IWebElement TryFindElementBy(this ISearchContext driver,  By by)
		{
			IWebElement ele = null;
			try
			{
				ele = driver.FindElement(by);
			}
			catch
			{
			}
			return ele;
		}

		public static IWebElement TryFindElementById(this RemoteWebDriver driver, string Id)
		{
			IWebElement ele = null;
			try
			{
				ele = driver.FindElementById(Id);
			}
			catch
			{
			}
			return ele;
		}
		public static IWebElement TryFindElementByName(this RemoteWebDriver driver, string name)
		{
			IWebElement ele = null;
			try
			{
				ele = driver.FindElementByName(name);
			}
			catch
			{
			}
			return ele;
		}
		public static IWebElement TryFindElementByLinkText(this RemoteWebDriver driver, string LinkText)
		{
			IWebElement ele = null;
			try
			{
	
				ele = driver.FindElementByLinkText(LinkText);
			}
			catch
			{
			}
			return ele;
		}
	}
}
