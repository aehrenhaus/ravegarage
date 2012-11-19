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
	public static partial class ISearchContextExtend
	{
        /// <summary>
        /// This is a bit of a hack to use web driver wait to wait a controlled amount for the page to load.
        /// </summary>
        /// <param name="context">The browser CurrentPage's browser instance</param>
        /// <param name="urlCheckMethod">A method to check that the URL is the correct page</param>
        /// <returns></returns>
        public static IWebElement CheckURLIsCorrect(this ISearchContext context, Func<IWebDriver, IWebElement> urlCheckMethod)
        {
            return waitForElement(context, urlCheckMethod, "Page Mismatch", 20);
        }
	}
}
