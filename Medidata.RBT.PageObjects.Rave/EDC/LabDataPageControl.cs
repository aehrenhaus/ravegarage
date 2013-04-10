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

namespace Medidata.RBT.PageObjects.Rave
{
	public class LabDataPageControl:ControlBase, IEDCDataPageControl
	{
		public LabDataPageControl(IPage page)
			: base(page)
		{
			//set Element here
		}

		//-----------STRUCTURE Lab form:
		//span id="_ctl0_Content_R"
		//table 1 lab dropdown
		//table 2
		//   tr class="evenRow" width="100%
		//        td 2 Label
		//        td 4 
		//            table
		//                td 1 
		//                    input

		//        td 5 Range status
		//        td 6 Unit
		//        td 7 Range
		//        td 8
		//            table (pen and other action controls)
		//	tr(next to the above)
		//		td2
		//			table
		//				tr1
		//					td 2 Query message<br>....,cancel box
		//				tr2
		//					td2 answer <br> dropdown answer textbox
		//			table(other query)
        public IEDCFieldControl FindField(string fieldName, int? record = null)
		{
            fieldName = ISearchContextExtend.ReplaceSpecialCharactersWithEscapeCharacters(fieldName);
            //First, look for the field as a non-lab field
            IEnumerable<IWebElement> leftSideTds = Page.Browser.FindElements(By.XPath("//td[@class='crf_rowLeftSide']"));
            IWebElement area = leftSideTds.FirstOrDefault(x =>
            {
                return ISearchContextExtend.ReplaceTagsWithEscapedCharacters(x.FindElement(By.XPath(".//td[@class='crf_preText']")).GetInnerHtml())
                       .Split(new string[] { "<" }, StringSplitOptions.None)[0].Trim() == fieldName;
            });

            if (area == null) //bringing back original code to locate area, if the the area is not found.
            {
                area = leftSideTds.FirstOrDefault(x =>
                {
                    return x.FindElement(By.XPath(".//td[@class='crf_preText']")).GetInnerHtml()
                        .Split(new string[] { "\r\n", "<" }, StringSplitOptions.None)[0].Trim() == fieldName;
                });
            }
            if (area != null)
            {
                ReadOnlyCollection<IWebElement> tds = area.Parent().Children();
                return new NonLabFieldControl(Page, area, tds[tds.Count - 1])
                {
                    FieldName = fieldName
                };
            }
            else
            {
                IWebElement el = Page.Browser.FindElements(By.XPath("//span[contains(@id,'Content_R')]")).FirstOrDefault();
                area = el.FindElementsByText<IWebElement>(fieldName).FirstOrDefault();

                var fieldTRs = area.FindElements(By.XPath("./../../tr"));

                int i;
                for (i = 0; i < fieldTRs.Count; i++)
                {
                    if (ISearchContextExtend.ReplaceTagsWithEscapedCharacters(fieldTRs[i].Children()[1].GetInnerHtml())
                            .Split(new string[] { "<" }, StringSplitOptions.None)[0].Trim() == fieldName)
                        break;
                }

                IWebElement fieldTR = fieldTRs[i];
                IWebElement fieldTRQueries = fieldTRs[i + 1];

                return new LabFieldControl(Page, fieldTR.Children()[1], fieldTRQueries)
                {
                    FieldName = fieldName
                };
            }
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
