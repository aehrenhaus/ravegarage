﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium.Support.PageObjects;
using OpenQA.Selenium;
using OpenQA.Selenium.Remote;
using TechTalk.SpecFlow;
using Medidata.RBT.SeleniumExtension;
using System.Collections.Specialized;
using Medidata.RBT.PageObjects.Rave.SeedableObjects;
using Medidata.RBT.SharedObjects;

namespace Medidata.RBT.PageObjects.Rave
{
    public abstract class LabPageBase : RavePageBase, ICanPaginate
    {
		private static readonly NameValueCollection PO_CLASS_MAPPING = new NameValueCollection() { 
			{ "Unit Conversions", "UnitConversionsPage" },
			{ "Global Data Dictionaries", "GlobalDataDictionariesPage" },
			{ "Global Unit Dictionaries", "GlobalUnitDictionariesPage" },
			{ "Global Variables", "GlobalVariablesPage" },
			{ "Lab Unit Dictionaries", "LabUnitDictionariesPage" },
			{ "Central Labs", "CentralLabsPage" },
			{ "Global Labs", "LabsPage" }};


        public override IPage NavigateTo(string name)
        {
			var elements = Browser.TryFindElementsBy(By.XPath("//*[@id='TblOuter']//a"));
			var link = elements.FirstOrDefault(element => element.Text.Equals(" " + name));

            if (link == null)
                return base.NavigateTo(name);

            link.Click();
			string className = PO_CLASS_MAPPING[name];
            return Context.POFactory.GetPage(className);
        }

        /// <summary>
        /// Finds the lab.
        /// </summary>
        /// <param name="labName">Name of the lab.</param>
        /// <param name="labType">Type of Lab</param>
        /// <returns></returns>
        public IWebElement FindLab(string labName, string type)
        {
            KeyValuePair<string, ISeedableObject> kvpSeedable = SeedingContext.SeedableObjects.FirstOrDefault(x => x.Key == labName);
            if (kvpSeedable.Value != null)
                labName = kvpSeedable.Value.UniqueName;

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
        public virtual void SelectLabRange(IWebElement row)
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
            Context.CurrentPage.ClickLink("Add New Lab");

            //table.Dropdown("_ddlLabType").SendKeys(type);
            ChooseFromDropdown("_ddlLabType", type);
            if (!String.IsNullOrEmpty(rangeType)) ChooseFromDropdown("_ddlRangeType", SeedingContext.GetExistingFeatureObjectOrMakeNew<RangeType>(rangeType, () => new RangeType(rangeType)).UniqueName);

            HtmlTable table = Browser.TryFindElementByPartialID("LabsGrid").EnhanceAs<HtmlTable>();
            var currentRow = table.TextboxById("_txtName").Parent().Parent();
            table.TextboxById("_txtName").SetText(labName);
            table.TextboxById("_txtDescription").SetText(labName);


            var checkButton = currentRow.ImageBySrc("../../Img/i_ccheck.gif");
            checkButton.Click();
        }


        #region IPaginatedPage

        int pageIndex = 0;
        int count = 0;
        int lastValue = -1;
        public virtual int CurrentPageNumber { get; set; }

        public virtual bool GoNextPage(string areaIdentifer)
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

        public virtual bool GoPreviousPage(string areaIdentifer)
        {
            throw new NotImplementedException();
        }

        public virtual bool GoToPage(string areaIdentifer, int page)
        {
            throw new NotImplementedException();
        }

        public virtual bool CanPaginate(string areaIdentifier)
        {
            return true;
        }
        #endregion
    }
}
