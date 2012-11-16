using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium.Support.PageObjects;
using OpenQA.Selenium;
using Medidata.RBT.PageObjects.Rave.SharedRaveObjects;
using Medidata.RBT.SeleniumExtension;
using TechTalk.SpecFlow;
using System.Text.RegularExpressions;
using OpenQA.Selenium.Support.UI;


namespace Medidata.RBT.PageObjects.Rave
{
    public class LabRangesPage : LabPageBase, ICanPaginate
    {
        public override string URL
        {
            get
            {
                return "Modules/LabAdmin/LabRangesPage.aspx";
            }
        }

        /// <summary>
        /// Adds the new analyte version.
        /// </summary>
        public void AddNewVersion(string analyteName)
        {
            this.FindLabRange(analyteName).TryFindElementByPartialID("_ImgBtnNewVer").Click();
        }


        /// <summary>
        /// Adds the new lab range.
        /// </summary>
        public void AddNewRange(string rangeName)
        {
            TestContext.CurrentPage.ClickLink("Add New Range");
        }

        /// <summary>
        /// Adds the new analyte range.
        /// </summary>
        /// <param name="model">The model.</param>
        public void AddNewAnalyteRange(AnalyteRangeModel model)
        {
            ModifyRangeAndUpdate(model);
        }


        /// <summary>
        /// Select Range for Lab
        /// </summary>
        public void SelectLabRange(IWebElement row)
        {
            var checkButton = row.ImageBySrc("../../Img/i_cdrill.gif");
            checkButton.Click();
        }

        private void ModifyRangeAndUpdate(AnalyteRangeModel model)
        {
            this.ChooseFromDynamicSearchListText("slLabAnalyte_TxtBx", model.Analyte);
            this.ChooseFromDateTime("ldcFromDate", model.FromDate);
            this.ChooseFromDateTime("ldcToDate", model.ToDate);
            this.ChooseAge("Textbox1", "DropdownlistUnit1", model.FromAge);
            this.ChooseAge("Textbox2", "DropdownlistUnit2", model.ToAge);
            this.ChooseFromDropdown("Dropdownlist4", model.Sex);
            this.Type("_txtLowRange", model.LowValue);
            this.Type("_txtHighRange", model.HighValue);
            this.ChooseFromDropdown("_ddlLabUnits", model.Units);
            this.ChooseFromDropdown("_ddlDataDictionary", model.Dictionary == String.Empty ? "..." : model.Dictionary);
            this.Type("_txtRangeComments", model.Comments);
            Browser.LinkByPartialText("Update").Click();
        }

        /// <summary>
        /// Choose From DynamicSearchList
        /// </summary>
        /// <param name="identifier">The identifier.</param>
        /// <param name="text">The text.</param>
        /// <returns></returns>
        public IPage ChooseFromDynamicSearchListText(string identifier, string text)
        {
            Textbox element = Browser.TryFindElementByPartialID(identifier).EnhanceAs<Textbox>();
            element.SetText(text);
            var option = Browser.TryFindElementBy(b => b.FindElementsByPartialId("PickListBox").FirstOrDefault(elm => elm.Text == text));
            Browser.FindElement(By.XPath("*//div[@class = 'SearchList_PickListBoxItem_Hover']")).Click();
          
            //SearchList_PickListBoxItem_Hover

         //   element.Parent().Textbox("DropButton").Click();
            return GetPageByCurrentUrlIfNoAlert();
        }


        /// <summary>
        /// Chooses the age.
        /// </summary>
        /// <param name="identifierText">The identifier text.</param>
        /// <param name="identifierDDL">The identifier DDL.</param>
        /// <param name="text">The text.</param>
        /// <returns></returns>
        public IPage ChooseAge(string identifierText, string identifierDDL, string text)
        {
            string[] dateParts = Regex.Split(text, @"\W+");
            this.Type(identifierText, dateParts[0]);
            this.ChooseFromDropdown(identifierDDL, dateParts[1]);
            return GetPageByCurrentUrlIfNoAlert();
        }

        /// <summary>
        /// Choose From DatTime
        /// </summary>
        /// <param name="identifier">The identifier.</param>
        /// <param name="text">The text.</param>
        /// <returns></returns>
        public IPage ChooseFromDateTime(string identifier, string text)
        {
            string dateTimeTableName = String.Format("_{0}_Table1", identifier);
            HtmlTable table = Browser.TryFindElementByPartialID(dateTimeTableName).EnhanceAs<HtmlTable>();
            
            var textboxes = table.Textboxes();
            var dropdowns = table.FindElements(By.TagName("select")).ToList();

            string[] dateParts = Regex.Split(text, @"\W+");
            if (dateParts.Length != 3)
            {
                throw new Exception("wrong datetime format");
            }
            //assign 3 parts of the date format
            textboxes[0].SetText(dateParts[0]);
            dropdowns[0].EnhanceAs<Dropdown>().SelectByText(dateParts[1]);
            textboxes[1].SetText(dateParts[2]);
            
            // element.SetText(text);
            return GetPageByCurrentUrlIfNoAlert();
        }


        /// <summary>
        /// Finds the lab range.
        /// </summary>
        /// <param name="labRangeName">Name of the lab range.</param>
        /// <returns></returns>
        public IWebElement FindLabRange(string analyteRangeName)
        {
            int foundOnPage;
            Table dt = new Table("Analyte");
            dt.AddRow(analyteRangeName);

            IWebElement pdfTr = this.FindInPaginatedList("", () =>
            {
                HtmlTable table = Browser.TryFindElementByPartialID("_LabRangesGrid").EnhanceAs<HtmlTable>();
                return table.FindMatchRows(dt).FirstOrDefault();
            }, out foundOnPage);

            return pdfTr;
        }


        #region IPaginatedPage

        int pageIndex = 0;
        int count = 0;
        int lastValue = -1;
		public int CurrentPageNumber { get; private set; }
        public bool GoNextPage(string areaIdentifer)
        {
            var pageTable = Browser.TryFindElementByPartialID("_LabRangesGrid").TryFindElementBy(By.XPath("./tbody/tr[last()]"));

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
