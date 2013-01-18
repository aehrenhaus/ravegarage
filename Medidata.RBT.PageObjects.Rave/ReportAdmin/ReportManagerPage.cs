using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium.Support.PageObjects;
using OpenQA.Selenium;
using OpenQA.Selenium.Remote;
using System.Collections.Specialized;
using Medidata.RBT.SeleniumExtension;
using System.Collections.ObjectModel;
using TechTalk.SpecFlow;

namespace Medidata.RBT.PageObjects.Rave
{
	public class ReportManagerPage : RavePageBase, ICanPaginate
    {
        public override string URL
        {
            get
            {
                return "Modules/ReportAdmin/ReportManager.aspx";
            }
        }

        public ReportManagerPage Activate(string reportName, string reportDescription)
        {
            int foundOnPage;
            Table dt = new Table("Name", "Description");
            dt.AddRow(reportName, reportDescription);

            IWebElement reportTr = this.FindInPaginatedList("", () =>
            {
                HtmlTable table = Browser.TryFindElementByPartialID("_ctl0_Content_MainGrid").EnhanceAs<HtmlTable>();
                return table.FindMatchRows(dt).FirstOrDefault();
            }, out foundOnPage);

            IWebElement checkImage = reportTr.TryFindElementByPartialID("_Image3");

            //if check image does not exist then make changes to activate the report
            if (checkImage != null && !checkImage.GetAttribute("src").Contains("i_check.gif"))
            {
                IWebElement editControl = reportTr.TryFindElementByPartialID("_Image1");
                editControl.Click();

                //check the activate checkbox for the report
                Checkbox activateCheckbox = Browser.TryFindElementById("_ctl0_Content_CheckBoxActive", true).EnhanceAs<Checkbox>();
                activateCheckbox.Check();

                //save the settings
                IWebElement saveLink = Browser.TryFindElementById("_ctl0_Content_LinkbuttonReportSave");
                saveLink.Click();

                Context.CurrentPage = new ReportManagerPage().NavigateToSelf();
            }

            return this;
        }

        #region ICanPaginate

        int pageIndex = 1;
        int count = 0;
        int lastValue = -1;

        public int CurrentPageNumber
        {
            get { return pageIndex; }
        }

        public bool GoNextPage(string areaIdentifier)
        {
            HtmlTable table = Browser.TryFindElementByPartialID("_ctl0_Content_MainGrid").EnhanceAs<HtmlTable>();
            IWebElement pageTable = table.TryFindElementBy(By.XPath(".//tr[@align='left']"));
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
                string linkText = pageLinks[pageIndex].Text;
                pageLinks[pageIndex].Click();
                //Adding necessary check so that we make sure that new page is loaded properly
                IWebElement clickedSpanElem = Browser.TryFindElementBy(By.XPath(".//span[text()='" + linkText + "']"), true, 20);
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
