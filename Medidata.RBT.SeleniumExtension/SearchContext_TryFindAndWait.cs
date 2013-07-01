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

        private static ReadOnlyCollection<IWebElement> waitForElements(
            ISearchContext context,
            Func<IWebDriver, ReadOnlyCollection<IWebElement>> getElement,
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
            ReadOnlyCollection<IWebElement> eles = null;


            eles = wait.Until(getElement);

            return eles;
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

        /// <summary>
        /// Show attempt to show an area on the page. That is closed via a show/hide button.
        /// </summary>
        /// <param name="context">The search context</param>
        /// <param name="areaToDisplayID">The id of the area you want to display</param>
        /// <param name="showHideButtonID">The id of the button that controls the display of that area</param>
        /// <param name="isWait">Should you wait for the area to display</param>
        /// <param name="timeOutSecond"></param>
        /// <returns>Expanded area</returns>
        public static IWebElement TryShowArea(
            this ISearchContext context, 
            string areaToDisplayID, 
            string showHideButtonID, 
            bool? isWait = null, 
            int? timeOutSecond = null)
        {
            IWebElement areaToDisplay;
            IWebElement ele = null;

            isWait = isWait ?? SeleniumConfiguration.Default.WaitByDefault;
            try
            {
                if (isWait.Value)
                    ele = waitForElement(context, b =>
                        {
                            areaToDisplay = context.TryFindElementById(areaToDisplayID, false);
                            if (areaToDisplay.Displayed)
                                return areaToDisplay;
                            else
                            {
                                context.TryFindElementById(showHideButtonID, false).Click();

                                areaToDisplay = context.TryFindElementById(areaToDisplayID, false);
                                if (areaToDisplay.Displayed)
                                    return areaToDisplay;
                                else 
                                    return null;
                            }
                        }, null, timeOutSecond);
                else
                {
                    areaToDisplay = context.TryFindElementById(areaToDisplayID);
                    if (!areaToDisplay.Displayed)
                    {
                        context.TryFindElementById(showHideButtonID).Click();
                        return context.TryFindElementById(areaToDisplayID);
                    }
                    return areaToDisplay;
                }
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

        /// <summary>
        /// Try and find elements
        /// </summary>
        /// <param name="context">The context where the search takes place</param>
        /// <param name="by">What elements we are looking for</param>
        /// <param name="isWait">Should we wait when searching</param>
        /// <param name="timeOutSecond">How long should we wait when searching</param>
        /// <returns>All of the elements matching the parameters</returns>
        public static ReadOnlyCollection<IWebElement> TryFindElementsBy(this ISearchContext context, By by, bool? isWait = null, int? timeOutSecond = null)
        {
            ReadOnlyCollection<IWebElement> eles = null;

            isWait = isWait ?? SeleniumConfiguration.Default.WaitByDefault;

            try
            {
                if (isWait.Value)
                    eles = waitForElements(context, drv => {
                        ReadOnlyCollection<IWebElement> elementsOnPage = context.FindElements(by);
                        return elementsOnPage.Count > 0 ? elementsOnPage : null;
                    }, null, timeOutSecond);
                else
                    eles = context.FindElements(by);
            }
            catch
            {
            }
            return (ReadOnlyCollection<IWebElement>)eles;
        }

        /// <summary>
        /// Works like TryFindElementsBy, but only return elements with text in them
        /// </summary>
        /// <param name="context">The context where the search takes place</param>
        /// <param name="by">What elements we are looking for</param>
        /// <param name="timeOutSecond">How long should we wait when searching</param>
        /// <returns>All of the elements matching the parameters that contain some text</returns>
        public static ReadOnlyCollection<IWebElement> TryFindElementsWithTextBy(this ISearchContext context, By by, int? timeOutSecond = null)
        {
            ReadOnlyCollection<IWebElement> eles = null;
            timeOutSecond = timeOutSecond ?? SeleniumConfiguration.Default.WaitElementTimeout;

            try
            {
                eles = waitForElements(context, drv =>
                {
                    ReadOnlyCollection<IWebElement> elementsOnPage = new ReadOnlyCollection<IWebElement>(context.FindElements(by).Where(x => !String.IsNullOrEmpty(x.Text.Trim())).ToList());
                    return elementsOnPage.Count() > 0 ? elementsOnPage : null;
                }, null, timeOutSecond: (int?)Math.Round(timeOutSecond.Value * 1.2)); 
                //Multiply by 1.2 to increase the wait time by 20% to avoid intermittent issues finding EDC fields
            }
            catch
            {
            }
            return (ReadOnlyCollection<IWebElement>)eles;
        }


		public static IWebElement TryFindElementByLinkText(this RemoteWebDriver context, string LinkText, bool? isWait = null, int? timeOutSecond = null)
		{
			IWebElement ele = null;

			isWait = isWait ?? SeleniumConfiguration.Default.WaitByDefault;

			try
			{
				if (isWait.Value)
					ele = waitForElement(context, drv =>
					{
						return context.FindElementByLinkText(LinkText);
						
					}, null, timeOutSecond);
				else
					ele = context.FindElementByLinkText(LinkText);

				
			}
			catch

			{
                if (isWait.Value)
                {
                    try
                    {
                        ele = waitForElement(context, drv =>
                        {
                            return context.TryFindElementBySpanLinktext(LinkText);

                        }, null, timeOutSecond);
                    }
                    catch (TimeoutException) { }  
                }
                else
                    ele = context.TryFindElementBySpanLinktext(LinkText);   
			}
			return ele;
		}

		public static IWebElement TryFindElementBySpanLinktext(this ISearchContext context, string linkText, bool isWait = false)
        {
            return context.Spans().FirstOrDefault(x => x.Text.Trim() == linkText);
        }


        public static IWebElement TryFindElementByOptionText(this ISearchContext context, string linkText, bool partial, bool? isWait = null)
        {
            return partial ? context.Options().FirstOrDefault(x => x.Text.Trim().Contains(linkText)) 
                : context.Options().FirstOrDefault(x => x.Text.Trim().Equals(linkText));
        }

	}
}
