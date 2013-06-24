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
using Medidata.RBT.PageObjects.Rave.EDC;
using Medidata.RBT.SharedObjects;
using System.Text.RegularExpressions;

namespace Medidata.RBT.PageObjects.Rave
{
    public class LabDataPageControl : ControlBase, IControl
	{
		public LabDataPageControl(IPage page)
			: base(page)
		{
		}
        private static readonly Regex s_fieldNameExtractor = new Regex(@"^(?<FIELD>.*?)(<\s*br\s*/*\s*>\s*<\s*table.*?>.*)*$",
            RegexOptions.Singleline | RegexOptions.IgnoreCase);

        /// <summary>
        /// Find the lab field matching the passed in fieldName.
        /// </summary>
        /// <param name="fieldName">The name of the field to find</param>
        /// <returns>The lab field that was found</returns>
        public IEDCFieldControl FindField(string fieldName)
        {
            SearchableTDs searchableTds = GetSearchableTDs(Page, false);
            //If there are still no searchable tds, maybe we need to wait
            if (searchableTds.LabSearchableTDs.Count == 0)
                searchableTds = GetSearchableTDs(Page, true);

            //Then check the lab searchable tds
            IWebElement nameTD = GetTDContainingFieldName(fieldName, searchableTds);

            if (nameTD == null)
                throw new Exception("Can't find field area:" + fieldName);

            //Get content td
            IWebElement elementTR = nameTD.Parent();

            LabFieldControl field = new LabFieldControl(Page, nameTD, elementTR.TryFindElementBy(By.XPath("//following-sibling::tr")))
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
                LabSearchableTDs = new List<IWebElement>(currentPage.Browser.TryFindElementsBy(By.XPath("//tr[@class='evenRow' or @class='oddRow']/td[2]"), wait))
            };
        }

        /// <summary>
        /// Get the TD area containing the name of the field passed in
        /// </summary>
        /// <param name="fieldName">The name of the field to search for</param>
        /// <param name="searchableTDs">All of the possible tds which may contain the field on the page</param>
        /// <returns>The td containing the field with the name passed in and the index of that element in the searchable TDs</returns>
        private IWebElement GetTDContainingFieldName(string fieldName, SearchableTDs searchableTDs)
        {
            string escFieldName = ISearchContextExtend.ReplaceSpecialCharactersWithEscapeCharacters(fieldName);
            foreach (IWebElement searchableTD in searchableTDs.LabSearchableTDs)
            {
                if (escFieldName.Equals(GetEscapedFieldString(searchableTD), StringComparison.InvariantCulture))
                    return searchableTD;
            }

            return null;
        }

        private string GetEscapedFieldString(IWebElement ele)
        {
            string escFieldString = ISearchContextExtend.ReplaceTagsWithEscapedCharacters(MatchFieldString(ele));

            //This should be already caught in the regex (s_fieldNameExtractor) but just 
            //leaving it here for the time being - it should be transient
            escFieldString = escFieldString
                .Split(new string[] { "<" },
                    StringSplitOptions.None)[0]
                .Trim();

            return escFieldString;
        }

        private string MatchFieldString(IWebElement element)
        {
            string html = element.GetInnerHtml();

            Match M = s_fieldNameExtractor.Match(html);
            var field = M.Success
                ? M.Groups["FIELD"].Value
                : html;

            return field;
        }

        public IEDCFieldControl FindUnitDropdown(string fieldText)
        {
            IWebElement el = Page.Browser.FindElements(By.XPath("//span[contains(@id,'Content_R')]")).FirstOrDefault();
            var area = el.FindElementsByText<IWebElement>(fieldText).FirstOrDefault();

            if (area == null)
                throw new Exception("Can't find field area:" + fieldText);
            var tds = area.Parent().Children();
            return new LabFieldControl(Page, area, tds[tds.Count - 3])
            {
                FieldName = fieldText
            };
        }
	}
}
