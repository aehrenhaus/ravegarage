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
    /// <summary>
    /// All of the searchable TDs on a page, separated into portrait or landscape. 
    /// This will work for both standard and log fields. 
    /// You do not need to separate those out.
    /// </summary>
    internal class SearchableTDs
    {
        public List<IWebElement> PortraitSearchableTDs { get; set; }
        public List<IWebElement> LandscapeSearchableTDs { get; set; }
    }

    /// <summary>
    /// The data page control for non lab forms
    /// </summary>
	public class NonLabDataPageControl: ControlBase, IEDCDataPageControl
	{
        public NonLabDataPageControl(IPage page)
            : base(page)
        {
        }
		//-------------STRUCTURE for non-lab form
		//span id="_ctl0_Content_R"
		//    table 1 summary
		//    table 2 
		//        tr 1 class=breaker herader
		//        tr 2+
		//            td
		//                table class=evenWarning width=100%
		//                    tr
		//                        td 1 class="crf_rowLeftSide
		//                            tab;e
		//                                tr
		//                                    td crf_preText
		//                                        Message and <br> table
		//                        td 3 class=crf_rowRightSide
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
            if (searchableTds.LandscapeSearchableTDs.Count == 0 && searchableTds.PortraitSearchableTDs.Count == 0)
                searchableTds = GetSearchableTDs(Page, true);

            //First, check the portrait searchable tds
            bool portraitField = false;
            ElementWithIndex area = GetTDContainingFieldName(fieldName, searchableTds, false);
            if (area != null)
                portraitField = true;

            //Then check the landscape searchable tds
            if (area == null)
                area = GetTDContainingFieldName(fieldName, searchableTds, true);

            if (area == null)
                throw new Exception("Can't find field area:" + fieldName);

            //Get content td
            IWebElement contentTD = null;
            //It is a portrait field
            if (portraitField)
            {
                ReadOnlyCollection<IWebElement> tds = area.Element.Parent().Children();
                contentTD = tds[tds.Count - 1];
            }
            //It is a landscape field
            else
            {
                IWebElement tableRow = null;
                ReadOnlyCollection<IWebElement> tableRows = area.Element.TryFindElementsBy(By.XPath(@"./../../tr"));
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

                contentTD = tableRow.TryFindElementBy(By.XPath("td[" + (area.Index + 1) + "]")); //Need to add 1 to translate 0 index to 1 index
            }

            NonLabFieldControl field = new NonLabFieldControl(Page, area.Element, contentTD)
            {
                FieldName = fieldName
            };
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
                LandscapeSearchableTDs = new List<IWebElement>(currentPage.Browser.TryFindElementsBy(By.XPath("//tr[@class='breaker']/td"), wait))
            };
        }

        /// <summary>
        /// Get the TD area containing the name of the field passed in
        /// </summary>
        /// <param name="fieldName">The name of the field to search for</param>
        /// <param name="searchableTDs">All of the possible tds which may contain the field on the page</param>
        /// <param name="isLandscapeForm">Whether we want to treat the form as a landscape or a portrait form</param>
        /// <returns>The td containing the field with the name passed in and the index of that element in the searchable TDs</returns>
        private ElementWithIndex GetTDContainingFieldName(string fieldName, SearchableTDs searchableTDs, bool isLandscapeForm)
        {
            string escFieldName = ISearchContextExtend.ReplaceSpecialCharactersWithEscapeCharacters(fieldName);
            List<IWebElement> tdsToSearch = isLandscapeForm ? searchableTDs.LandscapeSearchableTDs : searchableTDs.PortraitSearchableTDs;
            for (int i = 0; i < tdsToSearch.Count; i++)
            {
                IWebElement searchableTD = tdsToSearch[i];
                if (escFieldName.Equals(GetEscapedFieldString(searchableTD, isLandscapeForm), StringComparison.InvariantCulture))
                    return new ElementWithIndex()
                    {
                        Index = i,
                        Element = searchableTD
                    };
            }

            return null;
        }

        private string GetEscapedFieldString(IWebElement ele, bool isLandscapeForm)
        {
            string escFieldString = ISearchContextExtend.ReplaceTagsWithEscapedCharacters(MatchFieldString(ele, isLandscapeForm));

            //This should be already caught in the regex (s_fieldNameExtractor) but just 
            //leaving it here for the time being - it should be transient
            escFieldString = escFieldString
                .Split(new string[] { "<" },
                    StringSplitOptions.None)[0]
                .Trim();

            return escFieldString;
        }

        private string MatchFieldString(IWebElement element, bool isLandscape)
        {
            string html = null;
            if (!isLandscape)
                html = element.FindElement(By.XPath(".//td[@class='crf_preText']")).GetInnerHtml();
            else
                html = element.FindElement(By.XPath(".//a")).GetInnerHtml();

            Match M = s_fieldNameExtractor.Match(html);
            var field = M.Success
                ? M.Groups["FIELD"].Value
                : html;

            return field;
        }
	}
}
