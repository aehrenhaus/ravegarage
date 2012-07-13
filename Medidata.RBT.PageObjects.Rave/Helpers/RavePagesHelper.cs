using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium;
using OpenQA.Selenium.Support.UI;
using Medidata.RBT.SeleniumExtension;

namespace Medidata.RBT.PageObjects.Rave
{
	/// <summary>
	/// This class can get really ugly
	/// </summary>
	class RavePagesHelper
	{
	


	
		//TODO: this just find subject in list, later maybe extract the pagin logic to a seperate method
        public static IWebElement FindLinkInPaginatedList(string linkText)
        {
            IWebElement ele = null;
            int pageIndex = 1;
            int count = 0;
            int lastValue = -1;
            do
            {
                ele = TestContext.Browser.TryFindElementByLinkText(linkText);
                if (ele != null)
                    break;
                var pageTable = TestContext.Browser.FindElementById("_ctl0_Content_ListDisplayNavigation_DlPagination");
                var pageLinks = pageTable.FindElements(By.XPath(".//a"));

                count = pageLinks.Count;
                if (pageIndex == count)
                    break;

                while (!pageLinks[pageIndex].Text.Equals("...") && int.Parse(pageLinks[pageIndex].Text) <= lastValue && pageIndex <= count)
                {
                    pageIndex++;
                }

                if (pageLinks[pageIndex].Text.Equals("..."))
                {
                    lastValue = int.Parse(pageLinks[pageIndex - 1].Text);
                    pageLinks[pageIndex].Click();
                    pageIndex = 1;
                }
                else
                {
                    pageLinks[pageIndex].Click();
                    pageIndex++;
                }
            } while (true);

            return ele;
        }

	}
}
