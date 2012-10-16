using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium.Support.PageObjects;
using OpenQA.Selenium;
using OpenQA.Selenium.Remote;
using TechTalk.SpecFlow;
using Medidata.RBT.SeleniumExtension;
using System.Collections.Specialized;
namespace Medidata.RBT.PageObjects.Rave
{
    public class LabPageBase : RavePageBase, ICanPaginate
    {

        public override IPage NavigateTo(string name)
        {
            NameValueCollection poClassMapping = new NameValueCollection();

            poClassMapping["Unit Conversions"] = "UnitConversionsPage";
            poClassMapping["Global Data Dictionaries"] = "GlobalDataDictionariesPage";
            poClassMapping["Global Unit Dictionaries"] = "GlobalUnitDictionariesPage";
            poClassMapping["Global Variables"] = "GlobalVariablesPage";
            poClassMapping["Lab Unit Dictionaries"] = "LabUnitDictionariesPage";


            poClassMapping["Central Labs"] = "CentralLabsPage";
            poClassMapping["Global Labs"] = "LabsPage";


            var leftNavContainer = Browser.FindElementById("TblOuter");
            var link = leftNavContainer.TryFindElementBy(By.LinkText(" " + name));

            if (link == null)
                return base.NavigateTo(name);

            link.Click();
            string className = poClassMapping[name];
            return TestContext.POFactory.GetPage(className);
        }

        /// <summary>
        /// Finds the lab.
        /// </summary>
        /// <param name="labName">Name of the lab.</param>
        /// <param name="labType">Type of Lab</param>
        /// <returns></returns>
        public IWebElement FindLab(string labName, string type)
        {
            int foundOnPage;
            Table dt = new Table("Type", "Name");
            dt.AddRow(type, labName);

            IWebElement pdfTr = this.FindInPaginatedList("", () =>
            {
                HtmlTable table = Browser.TryFindElementByPartialID("LabsGrid").EnhanceAs<HtmlTable>();
                return table.FindMatchRows(dt).FirstOrDefault();
            }, out foundOnPage);

            if (pdfTr == null)
            {
                //add lab
                AddNewLab(labName, type);
                pdfTr = FindLab(labName, type);
            }
            return pdfTr;
        }


        /// <summary>
        /// Select Range for Lab
        /// </summary>
        public void SelectLabRange(IWebElement row)
        {
            EnhancedElement checkButton = row.FindImagebuttons().FirstOrDefault(img => img.GetAttribute("id").EndsWith("_ImgBtnLabRanges"));
            checkButton.Click();
        }
        /// <summary>
        /// Adds the new lab.
        /// </summary>
        /// <param name="labName">Name of the lab.</param>
        /// <param name="type">The type.</param>
         public void AddNewLab(string labName, string type, string rangeType = null)
        {
            TestContext.CurrentPage.ClickLink("Add New Lab");
            
            //table.Dropdown("_ddlLabType").SendKeys(type);
            ChooseFromDropdown("_ddlLabType", type);
            if (!String.IsNullOrEmpty(rangeType)) ChooseFromDropdown("_ddlRangeType", rangeType);
             
            HtmlTable table = Browser.TryFindElementByPartialID("LabsGrid").EnhanceAs<HtmlTable>();
            var currentRow =  table.TextboxById("_txtName").Parent().Parent();
            table.TextboxById("_txtName").SetText(labName);
            table.TextboxById("_txtDescription").SetText(labName);
            
         
            var checkButton = currentRow.ImageBySrc("../../Img/i_ccheck.gif");
            checkButton.Click();
        }


        #region IPaginatedPage

        int pageIndex = 0;
        int count = 0;
        int lastValue = -1;

        public bool GoNextPage(string areaIdentifer)
        {
            var pageTable = Browser.TryFindElementByPartialID("_LabsGrid").TryFindElementBy(By.XPath("./tbody/tr[last()]"));

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
