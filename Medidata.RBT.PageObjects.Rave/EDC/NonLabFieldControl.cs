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
	public class NonLabFieldControl : BaseEDCFieldControl
	{
        /// <summary>
        /// Create a NonLabFieldControl which will contain the information about any non-lab field
        /// </summary>
        /// <param name="page">The current page</param>
        /// <param name="LeftSideOrTopTD">The TD containing the field name</param>
        /// <param name="RightSideOrBottomTD">The TD containing the field data</param>
		public NonLabFieldControl(IPage page, IWebElement LeftSideOrTopTD, IWebElement RightSideOrBottomTD)
			: base(page)
		{
			this.FieldInformationTD = LeftSideOrTopTD.EnhanceAs<EnhancedElement>();
			this.FieldDataTD = RightSideOrBottomTD.EnhanceAs<EnhancedElement>();
            this.FieldControlContainer = RightSideOrBottomTD.GetAttribute("style").Contains("padding-left:4px;") ?
                RightSideOrBottomTD : RightSideOrBottomTD.TryFindElementBy(By.XPath(".//td[@style='padding-left:4px;']"), false);

			FieldName = "";
		}

		private EnhancedElement FieldInformationTD;
		private EnhancedElement FieldDataTD;

		public string FieldName { get; set; }
	
		#region IEDCFieldControl

		public override AuditsPage ClickAudit(bool isRecord = false)
		{
            IWebElement auditButton = null;
            if(isRecord)
                auditButton = FieldDataTD.Parent().TryFindElementByPartialID("DataStatusHyperlink");
            else
                auditButton = FieldDataTD.TryFindElementByPartialID("DataStatusHyperlink");
			auditButton.Click();
			return new AuditsPage();
		}
        
        /// <summary>
        /// Checks the checkbox specified by the checkbox name
        /// </summary>
        /// <param name="checkName"></param>
        public override void Check(string checkName)
        {
            string partialID = GetCheckboxPartialIdFromCheckName(checkName);

            if (partialID.Length > 0)
            {     
                Checkbox checkbox = FieldDataTD.CheckboxByID(partialID);
                checkbox.Check();
            }
        }

        /// <summary>
        /// Unchecks the checkbox specified by the checkbox name
        /// </summary>
        /// <param name="checkName"></param>
        public override void Uncheck(string checkName)
        {
            string partialID = GetCheckboxPartialIdFromCheckName(checkName);

            if (partialID.Length > 0)
            {
                Checkbox checkbox = FieldDataTD.CheckboxByID(partialID);
                checkbox.Uncheck();
            }
        }

        /// <summary>
        /// Returns in verification checkbox is enabled or disabled
        /// </summary>
        /// <returns></returns>
        public override bool IsVerificationRequired()
        {
            return (FieldDataTD.CheckboxByID("VerifyBox") as Checkbox).Enabled;
        }

        /// <summary>
        /// Returns if review checkbox is enabled or disabled
        /// </summary>
        /// <returns>True if review checkbox is there, False if it is not there.</returns>
        public override bool IsReviewRequired()
        {
            return FieldDataTD.CheckboxByID("ReviewGroupBox").EnhanceAs<Checkbox>().Enabled;
        }

        /// <summary>
        /// Check if the field is inactive for non lab field control
        /// </summary>
        /// <param name="text">Not necessary for NonLabFieldControl, but must be there for LabFieldControl</param>
        /// <returns>True if inactive, false if active</returns>
        public override bool IsInactive(string text = "")
        {
            IWebElement strikeoutElement = FieldDataTD.TryFindElementBy(By.XPath("//s"));
            return !(strikeoutElement == null);
        }

        /// <summary>
        /// Check the review checkbox next to the field
        /// </summary>
        public override void CheckReview()
        {
            FieldDataTD.CheckboxByID("ReviewGroupBox").EnhanceAs<Checkbox>().Check();
        }

		public override IWebElement FindQuery(QuerySearchModel filter)
		{

			var queryTables = FieldInformationTD.FindElements(
					By.XPath(".//td[@class='crf_preText']/table"));
			
			IWebElement queryTable = null;
			foreach (var tmpQueryTable in queryTables)
			{
                //If the filter has a specific QueryMessage, 
                //the existence of that message becomes a required condition
				if (filter.QueryMessage != null
                    && !tmpQueryTable.Text.Contains(filter.QueryMessage))
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

		public override void AnswerQuery(QuerySearchModel filter)
		{
			string answer = filter.Answer;
			filter.Answer = null;
			FindQuery(filter).Textboxes()[0].SetText(answer);
		}

		public override void CloseQuery(QuerySearchModel filter)
		{
			FindQuery(filter).Dropdowns()[0].SelectByText("Close Query");
		}


		public override void CancelQuery(QuerySearchModel filter)
		{
			FindQuery(filter).Checkboxes()[0].Check();
		}

        public override void PlaceSticky(string responder, string text)
        {
            IWebElement markingButton = FieldDataTD.TryFindElementByPartialID("MarkingButton");
            markingButton.Click();

            RefreshControl();
            FieldInformationTD.TryFindElementsBy(By.XPath(".//select"))[0].EnhanceAs<Dropdown>().SelectByText("Place Sticky");
            RefreshControl();
            FieldInformationTD.TryFindElementsBy(By.XPath(".//select"))[1].EnhanceAs<Dropdown>().SelectByText(responder);
            RefreshControl();
            FieldInformationTD.TryFindElementBy(By.XPath(".//textarea")).EnhanceAs<Textbox>().SetText(text);
        }

        /// <summary>
        /// Add a Protocol Deviation
        /// </summary>
        /// <param name="pdClass">Protocol Deviation class</param>
        /// <param name="pdCode">Protocol Deviation code</param>
        /// <param name="text">Protocol Deviation text</param>
        public override void AddProtocolDeviation(string pdClass, string pdCode, string text)
        {
            if (FieldDataTD.Class != string.Empty)
            {
                IWebElement markingButton = FieldDataTD.TryFindElementByPartialID("MarkingButton");
                markingButton.Click();
                Page.Browser.TryFindElementsBy(By.XPath(".//select"))[0].EnhanceAs<Dropdown>().SelectByText("Protocol Deviation");
                Page.Browser.TryFindElementBy(By.XPath(".//textarea")).EnhanceAs<Textbox>().SetText(text);
                Page.Browser.TryFindElementsBy(By.XPath(".//select"))[1].EnhanceAs<Dropdown>().SelectByText(pdCode);
                Page.Browser.TryFindElementsBy(By.XPath(".//select"))[2].EnhanceAs<Dropdown>().SelectByText(pdClass);
             }
            else
            {
                IWebElement markingLoglineButton = FieldDataTD.Ancestor("tbody").Children()[1].TryFindElementByPartialID("MarkingButton");
                markingLoglineButton.Click();
                Page.Browser.TryFindElementsBy(By.XPath(".//select"))[1].EnhanceAs<Dropdown>().SelectByText("Protocol Deviation");
                Page.Browser.TryFindElementBy(By.XPath(".//textarea")).EnhanceAs<Textbox>().SetText(text);
                Page.Browser.TryFindElementsBy(By.XPath(".//select"))[2].EnhanceAs<Dropdown>().SelectByText(pdCode);
                Page.Browser.TryFindElementsBy(By.XPath(".//select"))[3].EnhanceAs<Dropdown>().SelectByText(pdClass);
            }
        }

        /// <summary>
        /// Refresh the control on a page after a change has been made to invalidate it.
        /// </summary>
        public override void RefreshControl()
        {
            NonLabFieldControl nonLabFieldControl = (NonLabFieldControl)Page.As<CRFPage>().FindField(FieldName + "\br\br");
            FieldInformationTD = nonLabFieldControl.FieldInformationTD;
            FieldDataTD = nonLabFieldControl.FieldDataTD;
        }
		#endregion

        public bool VerifyData(LabRangeModel field)
        {
            throw new NotImplementedException();
        }

        #region helper memebers
        /// <summary>
        /// returns the partial id for checkbox based on checkbox name
        /// </summary>
        /// <param name="checkName"></param>
        /// <returns></returns>
        private string GetCheckboxPartialIdFromCheckName(string checkName)
        {
            string partialID = "";

            if (checkName == "Freeze")
            {
                partialID = "EntryLockBox";
            }
            else if (checkName == "Hard Lock")
            {
                partialID = "HardLockBox";
            }
            else if (checkName == "Verify")
            {
                partialID = "VerifyBox";
            }

            return partialID;
        }
        #endregion
    }
}
