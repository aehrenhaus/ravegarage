using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium.Support.PageObjects;
using OpenQA.Selenium;
using OpenQA.Selenium.Remote;
using Medidata.RBT.SeleniumExtension;
using System.Collections.Specialized;
using OpenQA.Selenium.Support.UI;
using TechTalk.SpecFlow;
using System.Collections.ObjectModel;

namespace Medidata.RBT.PageObjects.Rave
{
    public class PDFFilesControl : ControlBase, ICanPaginate
    {
        public PDFFilesControl(IPage page)
            : base(page)
        {
        }

        public void DeletePDF(string name)
        {
            int foundOnPage;
            Table dt = new Table("Name");
            dt.AddRow(name);

            IWebElement pdfTr = this.FindInPaginatedList("", () =>
            {
                HtmlTable table = TestContext.Browser.WaitForElement("_ctl0_Content_Results").EnhanceAs<HtmlTable>();
                return table.FindMatchRows(dt).FirstOrDefault();
            }, out foundOnPage);

            EnhancedElement deleteButton = pdfTr.FindImagebuttons().FirstOrDefault(x => x.GetAttribute("id").EndsWith("Delete"));

            deleteButton.Click();
            ((FileRequestPage)Page).GetAlertWindow().Accept();
        }

        #region IPaginatedPage

        //TODO: clean these vars, they are uesd in GoNextPage()
        int pageIndex = 1;
        int count = 0;
        int lastValue = -1;

        public bool GoNextPage(string areaIdentifer)
        {
            HtmlTable table = TestContext.Browser.WaitForElement("_ctl0_Content_Results").EnhanceAs<HtmlTable>();
            IWebElement pageTable = table.FindElement(By.XPath(".//tr[@align='center']"));
            ReadOnlyCollection<IWebElement> pageLinks = pageTable.FindElements(By.XPath(".//a|.//span"));

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

        public bool GoPreviousPage(string areaIdentifer)
        {
            throw new NotImplementedException();
        }

        public bool GoToPage(string areaIdentifer, int page)
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
