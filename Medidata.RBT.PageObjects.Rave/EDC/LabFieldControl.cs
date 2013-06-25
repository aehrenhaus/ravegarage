using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium.Support.PageObjects;
using OpenQA.Selenium;
using OpenQA.Selenium.Remote;
using Medidata.RBT.SeleniumExtension;
using System.Collections.Specialized;
using OpenQA.Selenium.Support.UI;
using Medidata.RBT.PageObjects.Rave.TableModels;

namespace Medidata.RBT.PageObjects.Rave
{
    public class LabFieldControl : BaseEDCFieldControl
	{
        public override IEnumerable<IWebElement> ResponseTables
        {
            get
            {
                return QueryArea.FindElements(By.XPath("./td[2]/table"));
            }
        }

		public LabFieldControl(IPage page, IWebElement mainTD, string fieldName)
			: base(page)
		{
            IWebElement mainTR = mainTD.Parent();
			NameElement = mainTD.EnhanceAs<EnhancedElement>();
            FieldDataSpecific = mainTR.EnhanceAs<EnhancedElement>();
            QueryArea = mainTR.TryFindElementBy(By.XPath("following-sibling::tr")).EnhanceAs<EnhancedElement>();
            FieldDataGeneric = mainTR.EnhanceAs<EnhancedElement>();
            FieldName = fieldName;
		}

        /// <summary>
        /// Find if the element has data entered
        /// </summary>
        /// <param name="text">Text of the element to find</param>
        /// <returns>True if the td element has data entered</returns>
        public override bool HasDataEntered(string text)
        {
            IWebElement ele = GetTDElement(text);
            if (ele == null)
                return false;
            else
                return true;
        }

        /// <summary>
        /// Get the td element associated with the text passed in
        /// </summary>
        /// <param name="text">Text of the element to find</param>
        /// <returns>The td element associated with the text passed in</returns>
        private IWebElement GetTDElement(string text)
        {
            IWebElement logTable = FieldDataSpecific.Parent().Parent().Parent().Parent().FindElement(By.Id("log"));
            List<IWebElement> trs = logTable.FindElements(By.XPath("tbody/tr")).ToList();
            List<IWebElement> topRowTds = trs.FirstOrDefault().FindElements(By.XPath("td")).ToList();
            int tableCellColumn;
            for (tableCellColumn = 0; tableCellColumn < topRowTds.Count(); tableCellColumn++)
                if (topRowTds[tableCellColumn].Text == FieldDataSpecific.Text)
                    break;

            foreach (IWebElement tr in trs)
            {
                List<IWebElement> currentRowTds = tr.FindElements(By.XPath("td")).ToList();
                if (currentRowTds[tableCellColumn].Text == text)
                    return currentRowTds[tableCellColumn];
            }

            return null;
        }

        /// <summary>
        /// Check if the field is inactive for lab field control
        /// </summary>
        /// <param name="text">The text of the field to check</param>
        /// <returns>True if inactive, false if active</returns>
        public override bool IsInactive(string text)
        {
            IWebElement strikeoutElement = GetTDElement(text).TryFindElementBy(By.XPath("//s"));
            return !(strikeoutElement == null);
        }

        internal bool VerifyData(LabRangeModel field)
        {
            return VerifyData(NameElement, field.Data, "Data") &&
                VerifyData(NameElement, field.Unit, "Unit") &&
                VerifyData(NameElement, field.RangeStatus, "RangeStatus") &&
                VerifyData(NameElement, field.StatusIcon, "StatusIcon") &&
                VerifyData(NameElement, field.Range, "Range");
        }

        private bool VerifyData(EnhancedElement MainTD, string text, string verificationType)
        {
            int elementIndex;
            switch (verificationType)
            {
                case "Data":
                    elementIndex = 3;
                    break;
                case "Unit":
                    elementIndex = 5;
                    break;
                case "Range":
                    elementIndex = 6;
                    break;
                case "RangeStatus":
                    return VerifyRangeStatus(MainTD, text);
                case "StatusIcon":
                    return VerifyStatus(MainTD, text);
                default:
                    elementIndex = 0;
                    break;
            }
			
            // unique condition when Unit select dropdown is visible and throws off the data verification.
			if (verificationType.Equals("Unit") && FieldDataSpecific.FindElements(By.TagName("select")).Count > 0 && text.Trim().Equals(""))
                return true;

			var el = FieldDataSpecific.FindElements(By.XPath("./td"))[elementIndex];
            return (el.Text.Trim().Equals(text.Trim()));
        }

        private bool VerifyRangeStatus(EnhancedElement MainTD, string statusText)
        {
            if (statusText.Equals(""))
                return !(FieldDataSpecific.FindElements(By.XPath("./td"))[4].GetInnerHtml().Contains("/Img/") && (FieldDataSpecific.FindElements(By.XPath("./td"))[4].GetInnerHtml().Contains(".gif")));
            return FieldDataSpecific.FindElements(By.XPath("./td"))[4].GetInnerHtml().Contains(StatusIconPathLookup(statusText));
        }

        private bool VerifyStatus(EnhancedElement MainTD, string statusText)
        {
            return FieldDataSpecific.FindElements(By.XPath("./td"))[7].GetInnerHtml().Contains(StatusIconPathLookup(statusText));
        }

    }
}
