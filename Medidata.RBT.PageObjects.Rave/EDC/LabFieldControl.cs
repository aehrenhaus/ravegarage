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
		}


		private EnhancedElement MainTR;
		private EnhancedElement QueriesTR;

        private Checkbox HardLockCheckBox
        {
            get
            {
                var checkBox = MainTR.Parent().Checkboxes(".//td/table/tbody/tr/td/input", "HardLockBox");
                return (checkBox != null) ? checkBox.FirstOrDefault() : null;
            }
        }

        public override AuditsPage ClickAudit()
        {
            var auditButton = MainTR.TryFindElementByPartialID("DataStatusHyperlink");
            auditButton.Click();
            return new AuditsPage();
        }

 
		/// <summary>
		///  see base method
		/// </summary>
		/// <returns></returns>
        protected override IWebElement GetFieldControlContainer()
        {
            return MainTR.Parent();
        }


		public IWebElement FindQuery(QuerySearchModel filter)
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

		public void AnswerQuery(QuerySearchModel filter)
		{
			string answer = filter.Answer;
			filter.Answer = null;
			FindQuery(filter).Textboxes()[0].SetText(answer);
		}

		public void CloseQuery(QuerySearchModel filter)
		{
			FindQuery(filter).Dropdowns()[0].SelectByText("Close Query");
		}

		public void CancelQuery(QuerySearchModel filter)
		{
			FindQuery(filter).Checkboxes()[0].Check();
		}      

		public void Check(string checkName)
		{
			if (checkName == "Freeze")
			{
				MainTR.Checkbox("EntryLockBox").Check();
			}

			if (checkName == "Hard Lock")
			{
                if (HardLockCheckBox != null) HardLockCheckBox.Click();
			}
		}


        public bool HasData(string text)
        {
            throw new NotImplementedException();
        }

        public bool VerifyCheck(string checkName, string status)
        {
            if (checkName == "Hard Lock")
            {
                if (HardLockCheckBox != null) return ((HardLockCheckBox.Selected && status == "On") ||
                                                    (!HardLockCheckBox.Selected && status == "Off"));
            }           
            return false;
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
            if (verificationType.Equals("Unit") && GetFieldControlContainer().FindElements(By.TagName("select")).Count > 0 && text.Trim().Equals(""))
                return true; 

            var el = MainTR.Parent().FindElements(By.XPath("./td"))[elementIndex];
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
