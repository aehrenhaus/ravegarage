using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Medidata.RBT.SeleniumExtension;
using OpenQA.Selenium;
using System.Collections.ObjectModel;

namespace Medidata.RBT.PageObjects.Rave.PDF
{
    /// <summary>
    /// PDFConfigProfilesPage object to manage Rave pdf configuration
    /// related functionality
    /// </summary>
    class PDFConfigProfilesPage : RavePageBase, ICanPaginate
    {
        /// <summary>
        /// url for pdf config profiles page
        /// </summary>
        public override string URL
        {
            get
            {
                return "Modules/Configuration/PDFConfigProfiles.aspx";
            }
        }

        #region IPaginatedPage

        //TODO: clean these vars, they are uesd in GoNextPage()
        int pageIndex = 1;
        int count = 0;
        int lastValue = -1;
		public int CurrentPageNumber { get; private set; }
        public bool GoNextPage(string areaIdentifer)
        {
            HtmlTable table = Browser.TryFindElementByPartialID("_ctl0_Content_Results").EnhanceAs<HtmlTable>();
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

        /// <summary>
        /// Adds the new pdf profile with named passed to profileName parameter
        /// </summary>
        /// <param name="profileName"></param>
        public void CreateNewPdfProfile(string profileName)
        {
            this.ClickLink("Add New");

            Textbox profileNameBox = Browser.TryFindElementById("_ctl0_Content_NewProfileDescription").
                EnhanceAs<Textbox>();
            profileNameBox.SetText(profileName);

            this.ClickLink("Save");
        }
    }
}
