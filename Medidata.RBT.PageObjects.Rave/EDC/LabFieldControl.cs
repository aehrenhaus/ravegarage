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

namespace Medidata.RBT.PageObjects.Rave
{
    public class LabFieldControl : BaseEDCFieldControl
	{
		public LabFieldControl(IPage page, IWebElement MainTR, IWebElement QueriesTR)
			: base(page)
		{
			this.MainTR = MainTR.EnhanceAs < EnhancedElement>();
			this.QueriesTR = QueriesTR.EnhanceAs<EnhancedElement>();
			this.FieldControlContainer = MainTR.Parent();
		}

		/// <summary>
		/// This is the TD that has class 'crf_rowLeftSide'
		/// </summary>
		private EnhancedElement MainTR;
		private EnhancedElement QueriesTR;

        public string FieldName { get; set; }

		public override IWebElement FindQuery(QuerySearchModel filter)
		{
		
			//each table is a query
			var queryTables = QueriesTR.FindElements(By.XPath("./td[2]/table"));
			IWebElement queryTable = null;

			foreach (var tmpQueryTable in queryTables)
			{
				if (filter.QueryMessage != null && tmpQueryTable.Text.LastIndexOf(filter.QueryMessage) == -1)
					continue;

				var hasDropdown = tmpQueryTable.Dropdowns().Count == 1;
				var hasCancelCheck = tmpQueryTable.Checkboxes().Count == 1;
				var hasReplyTextbox = tmpQueryTable.Textboxes().Count == 1;


				if (filter.Closed != null)
				{
					bool actualClosed = !hasDropdown && !hasCancelCheck && !hasReplyTextbox;
					if (filter.Closed == true && !actualClosed)
						continue;
					if (filter.Closed == false && actualClosed)
						continue;
				}


				if (filter.Response != null)
				{
					bool actualRequireResponse = hasReplyTextbox;
					if (filter.Response == true && !actualRequireResponse)
						continue;
					if (filter.Response == false && actualRequireResponse)
						continue;
				}

				//having the dropdown means requires manual close
				if (filter.ManualClose != null)
				{
					bool actualRequireClose = hasDropdown;
					if (filter.ManualClose == true && !actualRequireClose)
						continue;
					if (filter.ManualClose == false && actualRequireClose)
						continue;
				}

				var answerTD = tmpQueryTable.TryFindElementBy(By.XPath("./tbody/tr[2]/td[2]"));

				if (filter.Answered != null)
				{
					if (filter.Answered == true && answerTD.Text.Trim() == "")
						continue;

					if (filter.Answered == false)
						if (answerTD != null && answerTD.Text.Trim() != "")
							continue;
				}


				if (filter.Answer != null)
				{
					if (!(answerTD != null && answerTD.Text.Trim() == filter.Answer))
						continue;
				}

				queryTable = tmpQueryTable;
			}
			return queryTable;
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
            IWebElement logTable = FieldControlContainer.Parent().Parent().Parent().Parent().FindElement(By.Id("log"));
            List<IWebElement> trs = logTable.FindElements(By.XPath("tbody/tr")).ToList();
            List<IWebElement> topRowTds = trs.FirstOrDefault().FindElements(By.XPath("td")).ToList();
            int tableCellColumn;
            for (tableCellColumn = 0; tableCellColumn < topRowTds.Count(); tableCellColumn++)
                if (topRowTds[tableCellColumn].Text == FieldControlContainer.Text)
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
            return VerifyData(MainTR, field.Data, "Data") &&
                VerifyData(MainTR, field.Unit, "Unit") &&
                VerifyData(MainTR, field.RangeStatus, "RangeStatus") &&
                VerifyData(MainTR, field.StatusIcon, "StatusIcon") &&
                VerifyData(MainTR, field.Range, "Range");
        }

        private bool VerifyData(EnhancedElement MainTR, string text, string verificationType)
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
                    return VerifyRangeStatus(MainTR, text);
                case "StatusIcon":
                    return VerifyStatus(MainTR, text);
                default:
                    elementIndex = 0;
                    break;
            }
			
            // unique condition when Unit select dropdown is visible and throws off the data verification.
			if (verificationType.Equals("Unit") && FieldControlContainer.FindElements(By.TagName("select")).Count > 0 && text.Trim().Equals(""))
                return true;

			var el = FieldControlContainer.FindElements(By.XPath("./td"))[elementIndex];
            return (el.Text.Trim().Equals(text.Trim()));
        }

        private bool VerifyRangeStatus(EnhancedElement MainTR, string statusText)
        {
            if (statusText.Equals(""))
                return !(MainTR.Parent().FindElements(By.XPath("./td"))[4].GetInnerHtml().Contains("/Img/") &&(MainTR.Parent().FindElements(By.XPath("./td"))[4].GetInnerHtml().Contains(".gif"))) ;
            return MainTR.Parent().FindElements(By.XPath("./td"))[4].GetInnerHtml().Contains(StatusIconPathLookup(statusText));
        }

        private bool VerifyStatus(EnhancedElement MainTR, string statusText)
        {  
            return MainTR.Parent().FindElements(By.XPath("./td"))[7].GetInnerHtml().Contains(StatusIconPathLookup(statusText));
        }

    }
}
