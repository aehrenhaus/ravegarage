using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Medidata.RBT.PageObjects.Rave.SharedRaveObjects;
using OpenQA.Selenium;
using OpenQA.Selenium.Support.PageObjects;
using Medidata.RBT.SeleniumExtension;

namespace Medidata.RBT.PageObjects.Rave.SiteAdministration
{
    public class SiteAdministrationHomePage : SiteAdministrationBasePage, ICanPaginate
    {
        [FindsBy(How = How.Id, Using = "_ctl0_Content_SiteNameBox")]
        IWebElement SiteNameBox;

        [FindsBy(How = How.Id, Using = "_ctl0_Content_FilterButton")]
        IWebElement Search;

        public override string URL
        {
            get
            {
                return "Modules/SiteAdmin/Sites.aspx";
            }
        }

        public override IPage ClickLink(string linkText)
        {
            base.ClickLink(linkText);
            if (linkText == "New Site")
                TestContext.CurrentPage = new SiteAdministrationNewSitePage();

            return TestContext.CurrentPage;
        }

        /// <summary>
        /// Search for a site
        /// </summary>
        /// <param name="siteName">Name of the site to search for</param>
        public void SearchForSite(string siteName)
        {
            SiteNameBox.EnhanceAs<Textbox>().SetText(siteName);
            Search.Click();
            TestContext.CurrentPage = new SiteAdministrationHomePage();
        }

        /// <summary>
        /// Click a site after you've searched for it
        /// </summary>
        /// <param name="siteName">Name of the site to click</param>
        /// <returns>Returns the SiteAdministrationSiteDetailsPage for the clicked site</returns>
        public SiteAdministrationDetailsPage ClickSite(string siteName)
        {
            int foundOnPage;
            IWebElement siteLink = this.FindInPaginatedList("", () =>
            {
                var resultTable = Browser.TryFindElementBy(By.Id("_ctl0_Content_DisplayGrid"));
                var link = resultTable.TryFindElementBy(By.XPath(
                    "tbody/tr[position()>1]/td[position()=1 and contains(text(),'" + siteName + "')]/../td[position()=7]/a"));
                return link;

            }, out foundOnPage);

            if (siteLink == null)
                throw new Exception("User not found in result table: " + siteName);

            siteLink.Click();
            TestContext.CurrentPage = new SiteAdministrationDetailsPage();
            return new SiteAdministrationDetailsPage();
        }

        #region ICanPaginate
        int pageIndex = 1;
        int count = 0;
        int lastValue = -1;

        public bool GoNextPage(string areaIdentifier)
        {
            var pageTable = TestContext.Browser.TryFindElementById("_ctl0_Content_DisplayGrid").TryFindElementBy(By.XPath("./tbody/tr[last()]"));

            var pageLinks = pageTable.FindElements(By.XPath(".//a"));

            count = pageLinks.Count;
            if (pageIndex == count)
                return false;

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
            return true;
        }

        public bool GoPreviousPage(string areaIdentifier)
        {
            throw new NotImplementedException();
        }

        public bool GoToPage(string areaIdentifier, int page)
        {
            throw new NotImplementedException();
        }

        public bool CanPaginate(string areaIdentifier)
        {
            return true;
        }
        #endregion
    }
}
