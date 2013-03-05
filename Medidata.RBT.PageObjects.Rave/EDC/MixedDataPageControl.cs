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

namespace Medidata.RBT.PageObjects.Rave
{
    /// <summary>
    /// Control on a mixed data page
    /// </summary>
	public class MixedDataPageControl : ControlBase, IEDCDataPageControl
	{
        public MixedDataPageControl(IPage page)
			: base(page)
		{
			
		}

        /// <summary>
        /// Find a field in a mixed data page control by the fieldName
        /// </summary>
        /// <param name="fieldName">The field to find</param>
        /// <returns>The IWebElement associated with the passed in field text</returns>
		public IEDCFieldControl FindField(string fieldName)
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
            //If it wasn't found as a non-lab field, then look for the field as a lab field
            else
            {
				IEnumerable<IWebElement> els = Page.Browser.FindElements(By.XPath("//table[@id='log']/tbody/tr/td/a[contains(@id,'Content_R')]"));
                area = els.FirstOrDefault(x => x.Text == fieldName);

                if (area != null)
                {
                    ReadOnlyCollection<IWebElement> tds = area.Parent().Children();
                    return new LabFieldControl(Page, area, tds[tds.Count - 1])
                    {
                        FieldName = fieldName
                    };
                }
            }

            //If it exists as neither, it isn't there
            throw new Exception("Can't find field area:" + fieldName);
        }
	}
}
