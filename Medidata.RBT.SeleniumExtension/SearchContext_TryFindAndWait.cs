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
using System.Text.RegularExpressions;

namespace Medidata.RBT.SeleniumExtension
{
	public  static partial class ISearchContextExtend
	{
		public static IWebElement TryFindElementByPartialID(this ISearchContext context, string partialID, bool? isWait = null, int? timeOutSecond = null)
		{
			var ele = context.TryFindElementBy(By.XPath(".//*[contains(@id,'" + partialID + "')]"),isWait,timeOutSecond);
			return ele;
		}

		public static IWebElement TryFindElementByXPath(this ISearchContext context, string xpath, bool? isWait = null , int? timeOutSecond = null)
		{
			return context.TryFindElementBy(By.XPath(xpath), isWait, timeOutSecond);
		}


        private static IWebElement waitForElement(
            ISearchContext context, 
            Func<IWebDriver, IWebElement> getElement, 
            string errorMessage = null, 
            int? timeOutSecond = null)
        {
			RemoteWebDriver driver;
			
            if (context is IWrapsDriver)
                driver = ((IWrapsDriver)context).WrappedDriver as RemoteWebDriver;
            else
                driver = ((RemoteWebDriver)context);

			
            timeOutSecond = timeOutSecond ?? SeleniumConfiguration.Default.WaitElementTimeout;
            var wait = new WebDriverWait(driver, TimeSpan.FromSeconds(timeOutSecond.Value));
            IWebElement ele = null;

	
			ele = wait.Until(getElement);

            return ele;
        }

		public static IWebElement TryFindElementBy(this ISearchContext context, Func<IWebDriver, IWebElement> getElement, bool? isWait = null, int? timeOutSecond = null)
		{
			IWebElement ele = null;

			isWait = isWait ?? SeleniumConfiguration.Default.WaitByDefault;
			try
			{
				if (isWait.Value)
					ele = waitForElement(context, getElement, null, timeOutSecond);
				else
					ele = waitForElement(context, getElement, null, 0);
			}
			catch
			{
			}
			return ele;
		}

		public static IWebElement TryFindElementBy(this ISearchContext context, By by, bool? isWait = null, int? timeOutSecond = null)
        {
            IWebElement ele = null;

			isWait = isWait ?? SeleniumConfiguration.Default.WaitByDefault;
			try
			{
				if (isWait.Value)
					ele = waitForElement(context, b => context.FindElement(by), null, timeOutSecond);
                else
                    ele = context.FindElement(by);
            }
            catch
            {
            }
			return ele;
		}

		public static IWebElement TryFindElementById(this ISearchContext context, string Id, bool? isWait = null, int? timeOutSecond = null)
		{
			IWebElement ele = null;

			isWait = isWait ?? SeleniumConfiguration.Default.WaitByDefault;
			try
			{
				if (isWait.Value)
					ele = waitForElement(context, b => context.FindElement(By.Id(Id)), null, timeOutSecond);
				else
					ele = context.FindElement(By.Id(Id));
			}
			catch
			{
			}
			return ele;
		}


		public static IWebElement TryFindElementByName(this RemoteWebDriver context, string name)
		{
			IWebElement ele = null;
			try
			{
				ele = context.FindElementByName(name);
			}
			catch
			{
			}
			return ele;
		}

		public static IWebElement TryFindElementByLinkText(this RemoteWebDriver context, string LinkText)
		{
			IWebElement ele = null;
			try
			{
				ele = context.FindElementByLinkText(LinkText);
			}
			catch

			{
                ele = context.TryFindElementBySpanLinktext(LinkText);
			}
			return ele;
		}

		public static IWebElement TryFindElementBySpanLinktext(this ISearchContext context, string linkText)
        {
            IWebElement ele = null;
            try
            {
                ele = context.Spans().FirstOrDefault(x => x.Text.Trim() == linkText);
            }
            catch
            {

            }
            return ele;
        }

        public static IWebElement TryFindElementBySelectPartialLinktext(this RemoteWebDriver context, string linkText)
        {
            IWebElement ele = null;
            try
            {
                ele = context.Options().FirstOrDefault(x => x.Text.Trim().Contains(linkText));
            }
            catch
            {

            }
            return ele;
        }

        public static IWebElement TryFindElementBySelectLinktext(this RemoteWebDriver context, string linkText)
        {
            IWebElement ele = null;
            try
            {
                ele = context.Options().FirstOrDefault(x => x.Text.Trim() == linkText);
            }
            catch
            {

            }
            return ele;
        }

	}
}
