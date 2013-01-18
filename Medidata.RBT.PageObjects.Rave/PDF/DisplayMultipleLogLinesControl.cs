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
    /// <summary>
    /// This object is for Multiple log line display control on pdf generator
    /// </summary>
    class DisplayMultipleLogLinesControl : ControlBase, ICanPaginate
    {

        public DisplayMultipleLogLinesControl(IPage page)
            : base(page)
        {
        }

        /// <summary>
        /// Verifies if the form with specified form name is in the display log lines control table
        /// </summary>
        /// <param name="formName"></param>
        /// <param name="isChecked"></param>
        /// <returns></returns>
        public bool VerifyFormExist(string formName, bool? isChecked = null)
        {
            bool exist = false;

            var displayTr = FindTrForForm(formName);

            if (displayTr != null)
            {
                exist = true;
                if (isChecked.HasValue)
                {
                    var tdCheckbox = displayTr.TryFindElementByPartialID("CombineLogLinesFrms_FrontEndCBList").EnhanceAs<Checkbox>();
                    exist = tdCheckbox.Selected.Equals(isChecked.Value);
                }
             }

            return exist;
        }

        /// <summary>
        /// Gives the checkbox element associated with the form name  for the display log lines control table
        /// </summary>
        /// <param name="formName"></param>
        /// <returns></returns>
        public IWebElement FindCheckboxForLogFrom(string formName)
        {
            IWebElement checkboxElem = null;

            var displayTr = FindTrForForm(formName);

            if (displayTr != null)
            {
                checkboxElem = displayTr.TryFindElementByPartialID("CombineLogLinesFrms_FrontEndCBList");
                    
            }

            return checkboxElem;
        }

        /// <summary>
        /// Finds the tr element associated with the form name
        /// </summary>
        /// <param name="formName"></param>
        /// <returns></returns>
        private IWebElement FindTrForForm(string formName)
        {
            int foundOnPage;
            Table dt = new Table("");
            dt.AddRow(formName);

            IWebElement displayTr = this.FindInPaginatedList("", () =>
            {
                HtmlTable table = Page.Browser.TryFindElementByPartialID("CombineLogLinesFrms_FrontEndCBList").EnhanceAs<HtmlTable>();
                return table.FindMatchRows(dt).FirstOrDefault();
            }, out foundOnPage);

            return displayTr;
        }

        #region IPaginatedPage

        //TODO: clean these vars, they are uesd in GoNextPage()
        int pageIndex = 1;
        int count = 0;
        int lastValue = -1;
		public int CurrentPageNumber { get; private set; }
        public bool GoNextPage(string areaIdentifer)
        {
            var elem = Page.Browser.TryFindElementById("CombineLogLinesFrms_Links");
            ReadOnlyCollection<EnhancedElement> pageLinks = elem.FindElementsByPartialId("CombineLogLinesFrms_PageLink");

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
