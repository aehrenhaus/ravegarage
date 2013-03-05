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

namespace Medidata.RBT.PageObjects.Rave
{
	public class NonLabDataPageControl:ControlBase, IEDCDataPageControl
	{
        //Matches on {Field Name (possibly wihth special chars)}<br><table>....
        private static readonly Regex s_fieldNameExtractor = new Regex(@"^(?<FIELD>.*?)(<\s*br\s*/*\s*>\s*<\s*table.*?>.*)*$", 
            RegexOptions.Singleline | RegexOptions.IgnoreCase);

		public NonLabDataPageControl(IPage page)
			: base(page)
		{
			
		}


		//-------------STRUCTURE for noe-lab form
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

		//

        private string MatchFieldString(IWebElement element)
        {
            var html = element.FindElement(By.XPath(".//td[@class='crf_preText']")).GetInnerHtml();
            
            Match M = s_fieldNameExtractor.Match(html);
            var field = M.Success 
                ? M.Groups["FIELD"].Value 
                : html;

            return field;
        }
		public IEDCFieldControl FindField(string fieldName)
		{
            var leftSideTds = Page.Browser.TryFindElementsBy(By.XPath("//td[@class='crf_rowLeftSide']"))
                ?? new ReadOnlyCollection<IWebElement>(new List<IWebElement>());
            var area = leftSideTds.FirstOrDefault(x =>
                {
                    var escFieldName = ISearchContextExtend.ReplaceSpecialCharactersWithEscapeCharacters(fieldName);
                    var escFieldString = ISearchContextExtend.ReplaceTagsWithEscapedCharacters(MatchFieldString(x));

                    //This should be already caught in the regex (s_fieldNameExtractor) but just 
                    //leaving it here for the time being - it should be transient
                    escFieldString = escFieldString
                        .Split(new string[] { "<" }, 
                            StringSplitOptions.None)[0]
                        .Trim();
                     
                    return escFieldName == escFieldString;
                });

            if (area == null)
                throw new Exception("Can't find field area:" + fieldName);
            var tds = area.Parent().Children();
            return new NonLabFieldControl(Page, area, tds[tds.Count - 1]);
        }

        public void FindFieldByText(string fieldText)
        {
            var el = Page.Browser.FindElementById("_ctl0_Content_R");
        }
	}
}
