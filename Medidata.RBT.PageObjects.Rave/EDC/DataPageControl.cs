using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium.Support.PageObjects;
using OpenQA.Selenium;
using OpenQA.Selenium.Remote;
using Medidata.RBT.SeleniumExtension;
using System.Collections.Specialized;
using System.Collections.ObjectModel;
using System.Text.RegularExpressions;
using Medidata.RBT.PageObjects.Rave.EDC;
using Medidata.RBT.SharedObjects;

namespace Medidata.RBT.PageObjects.Rave
{
    public enum FieldType
    {
        NotFound,
        Landscape,
        Portrait,
        Lab
    }

    /// <summary>
    /// The data page control for non lab forms
    /// </summary>
    public class DataPageControl : ControlBase, IControl
	{
        public DataPageControl(IPage page)
            : base(page)
        {
        }
        private static readonly Regex s_fieldNameExtractor = new Regex(@"^(?<FIELD>.*?)(<\s*br\s*/*\s*>\s*<\s*table.*?>.*)*$",
            RegexOptions.Singleline | RegexOptions.IgnoreCase);

        /// <summary>
        /// Find the field matching the passed in fieldName. 
        /// For the case of landscape log fields, will return the last log line (e.g. if there are 3 log lines, will return the third one)
        /// </summary>
        /// <param name="fieldName">The name of the field to find</param>
        /// <returns>The non-lab field that was found</returns>
        public IEDCFieldControl FindField(string fieldName, int? record = null)
		{
            SearchableTDs searchableTds = GetSearchableTDs(Page, false);
            //If there are still no searchable tds, maybe we need to wait
            if (searchableTds.LandscapeSearchableTDs.Count == 0 && searchableTds.PortraitSearchableTDs.Count == 0 && searchableTds.LabSearchableTDs.Count == 0)
                searchableTds = GetSearchableTDs(Page, true);

            FieldType fieldType = FieldType.NotFound;

            //First, check the portrait searchable tds
            ElementWithIndex nameTD = GetTDContainingFieldName(fieldName, searchableTds, FieldType.Portrait);
            if (nameTD != null)
                fieldType = FieldType.Portrait;

            //Then check the landscape searchable tds
            if (nameTD == null)
            {
                nameTD = GetTDContainingFieldName(fieldName, searchableTds, FieldType.Landscape);
                if (nameTD != null)
                    fieldType = FieldType.Landscape;
            }

            //Then check the lab searchable tds
            if (nameTD == null)
            {
                nameTD = GetTDContainingFieldName(fieldName, searchableTds, FieldType.Lab);
                if (nameTD != null)
                    fieldType = FieldType.Lab;
            }

            if (nameTD == null)
                throw new Exception("Can't find field area:" + fieldName);

            //Get the web element containing the content of the field.
            IWebElement contentElement = GetContentElement(fieldType, nameTD, record);

            BaseEDCFieldControl field = null;
            if (fieldType == FieldType.Lab)
            {
                field = new LabFieldControl(Page, nameTD.Element, contentElement)
                {
                    FieldName = fieldName
                };
            }
            else
            {
                field = new NonLabFieldControl(Page, nameTD.Element, contentElement)
                {
                    FieldName = fieldName
                };
            }
            if (field != null)
                return field;

            throw new Exception("Can't find field area:" + fieldName);
        }

        /// <summary>
        /// Get all of the TDs on a page which may contain the field name.
        /// </summary>
        /// <param name="currentPage">The current page</param>
        /// <param name="wait">
        /// Whether we want to wait for timeout or not when searching for the TDs.
        /// Should not wait the first use and wait the second so that we don't have to wait for both types until the second go around.
        /// If we do not do this, it will wait for both portrait and landscape fields the first time, which usually won't be necessary.
        /// </param>
        /// <returns>All of the TDs on a page which may contain the field name</returns>
        private SearchableTDs GetSearchableTDs(IPage currentPage, bool wait)
        {
            return new SearchableTDs()
            {
                PortraitSearchableTDs = new List<IWebElement>(currentPage.Browser.TryFindElementsBy(By.XPath("//td[@class='crf_rowLeftSide']"), wait)),
                LandscapeSearchableTDs = new List<IWebElement>(currentPage.Browser.TryFindElementsBy(By.XPath("//tr[@class='breaker']/td"), wait)),
                LabSearchableTDs = new List<IWebElement>(currentPage.Browser.TryFindElementsBy(By.XPath("//tr[@class='evenRow' or @class='oddRow' or @class='oddWarning' or @class='evenWarning']/td[2]"), wait)),
            };
        }

        /// <summary>
        /// Get the TD area containing the name of the field passed in
        /// </summary>
        /// <param name="fieldName">The name of the field to search for</param>
        /// <param name="searchableTDs">All of the possible tds which may contain the field on the page</param>
        /// <param name="fieldType">Whether we want to treat the form as a landscape or a portrait form</param>
        /// <returns>The td containing the field with the name passed in and the index of that element in the searchable TDs</returns>
        private ElementWithIndex GetTDContainingFieldName(string fieldName, SearchableTDs searchableTDs, FieldType fieldType)
        {
            string escFieldName = ISearchContextExtend.ReplaceSpecialCharactersWithEscapeCharacters(fieldName);
            List<IWebElement> tdsToSearch = null;
            switch (fieldType)
            {
                case FieldType.Portrait:
                    tdsToSearch = searchableTDs.PortraitSearchableTDs;
                    break;
                case FieldType.Landscape:
                    tdsToSearch = searchableTDs.LandscapeSearchableTDs;
                    break;
                case FieldType.Lab:
                    tdsToSearch = searchableTDs.LabSearchableTDs;
                    break;
            }

            for (int i = 0; i < tdsToSearch.Count; i++)
            {
                IWebElement searchableTD = tdsToSearch[i];
                if (escFieldName.Equals(GetEscapedFieldString(searchableTD, fieldType), StringComparison.InvariantCulture))
                    return new ElementWithIndex()
                    {
                        Index = i,
                        Element = searchableTD
                    };
            }

            return null;
        }

        private string GetEscapedFieldString(IWebElement ele, FieldType fieldType)
        {
            string escFieldString = ISearchContextExtend.ReplaceTagsWithEscapedCharacters(MatchFieldString(ele, fieldType));

            //This should be already caught in the regex (s_fieldNameExtractor) but just 
            //leaving it here for the time being - it should be transient
            escFieldString = escFieldString
                .Split(new string[] { "<" },
                    StringSplitOptions.None)[0]
                .Trim();

            return escFieldString;
        }

        private string MatchFieldString(IWebElement element, FieldType fieldType)
        {
            string html = null;
            switch (fieldType)
            {
                case FieldType.Portrait:
                    html = element.FindElement(By.XPath(".//td[@class='crf_preText']")).GetInnerHtml();
                    break;
                case FieldType.Landscape:
                    html = element.FindElement(By.XPath(".//a")).GetInnerHtml();
                    break;
                case FieldType.Lab:
                    html = element.GetInnerHtml();
                    break;
            }

            Match M = s_fieldNameExtractor.Match(html);
            var field = M.Success
                ? M.Groups["FIELD"].Value
                : html;

            return field;
        }

        /// <summary>
        /// Get the field content of a landscape field
        /// </summary>
        /// <param name="nameTD">The table cell containing the field name</param>
        /// <param name="record">The record if the form is a log from, null if it is not</param>
        /// <returns>The TD containing the content of the landscape field</returns>
        private IWebElement GetLandscapeContentElement(ElementWithIndex nameTD, int? record)
        {
            IWebElement tableRow = null;
            ReadOnlyCollection<IWebElement> tableRows = nameTD.Element.TryFindElementsBy(By.XPath(@"./../../tr"));
            if (record.HasValue)
            {
                foreach (IWebElement possibleTableRow in tableRows)
                {
                    IWebElement recordNumberTD = possibleTableRow.TryFindElementBy(By.XPath("td[1]"));
                    if (recordNumberTD != null && recordNumberTD.Text.Equals(record.Value.ToString()))
                    {
                        tableRow = possibleTableRow;
                        break;
                    }
                }
            }
            else
            {
                //Get the last log row
                //Subtract by two because array is zero-indexed and the last row is "Add a new Log Line" row
                tableRow = tableRows[tableRows.Count - 2];
            }

            return tableRow.TryFindElementBy(By.XPath("td[" + (nameTD.Index + 1) + "]")); //Need to add 1 to translate 0 index to 1 index
        }

        /// <summary>
        /// Get the field content of a any field field
        /// </summary>
        /// <param name="fieldType">The type of the field</param>
        /// <param name="nameTD">The table cell containing the field name</param>
        /// <param name="record">The record if the form is a log from, null if it is not</param>
        /// <returns>The TD containing the content of the landscape field</returns>
        private IWebElement GetContentElement(FieldType fieldType, ElementWithIndex nameTD, int? record)
        {
            IWebElement contentElement = null;
            switch (fieldType)
            {
                case FieldType.Portrait:
                    ReadOnlyCollection<IWebElement> tds = nameTD.Element.Parent().Children();
                    contentElement = tds[tds.Count - 1];
                    break;
                case FieldType.Landscape:
                    contentElement = GetLandscapeContentElement(nameTD, record);
                    break;
                case FieldType.Lab:
                    IWebElement elementTR = nameTD.Element.Parent();
                    contentElement = elementTR.TryFindElementBy(By.XPath("following-sibling::tr"));
                    break;
            }

            return contentElement;
        }
	}
}
