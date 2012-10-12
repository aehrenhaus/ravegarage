using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium.Support.PageObjects;
using OpenQA.Selenium;
using OpenQA.Selenium.Remote;
using Medidata.RBT.SeleniumExtension;
using TechTalk.SpecFlow;


namespace Medidata.RBT.PageObjects.Rave
{
    public class SubjectPage : BaseEDCPage, ICanVerifyInOrder, ICanVerifyExist, ITaskSummaryContainer
	{
        public IWebElement GetTaskSummaryArea(string header)
		{
			var TRs = Browser.FindElementsByXPath("//span[@id='_ctl0_Content_TsBox_CBoxC']/table/tbody/tr[position()>1]");

			var TR = TRs.FirstOrDefault(x => x.Text.Contains(header));

			return TR;
		}

		public SubjectPage ExpandTask(string header)
		{
			var TR = GetTaskSummaryArea(header);

			var expandButton = TR.Images().FirstOrDefault(x => x.GetAttribute("src").EndsWith("arrow_right.gif"));
			expandButton.Click();
			
			//wait for contents to load
			Browser.WaitForElement(driver => Browser.FindElementByXPath("//body[@style='cursor: default;']"));


			return this;
		}

        public override bool CanSeeTextInArea(string text, string areaName)
        {
            //TODO: this is just a simple version of finding text. Implement more useful version later
            var TR = GetTaskSummaryArea(areaName);

            return TR.Text.Contains(text);
        }

		public override IWebElement GetElementByName(string identifier, string areaIdentifier = null, string listItem = null)
		{
            IWebElement element;
            string id = "";

			if (identifier == "Reports")
			{
				var table = Browser.FindElementByXPath("//td[text()='Reports']/../../../tbody/tr[2]//table");
				return table;
			}

            if (identifier == "Add Event")
                id = "_ctl0_Content_SubjectAddEvent_MatrixList";
            else if (identifier == "Add")
                id = "_ctl0_Content_SubjectAddEvent_SaveBtn";
            else if (identifier == "Enable" || identifier == "Disable")
                id = "_ctl0_Content_SubjectAddEvent_LockAddEventSaveBtn";
            else if (identifier == "Set")
                id = "_ctl0_Content__ctl0_RadioButtons_0";
            else if (identifier == "Clear")
                id = "_ctl0_Content__ctl0_RadioButtons_1";
            else
			    return GetTaskSummaryArea(identifier);

            try
            {
                element = base.Browser.FindElementById(id);
            }
            catch
            {
                element = null;
            }

            return element;
		}

		public override IPage ChooseFromCheckboxes(string identifier, bool isChecked, string areaIdentifier = null, string listItem = null)
		{
			if (identifier == "Lock")
				this.ChooseFromCheckboxes("_ctl0_Content__ctl0_CB_Lock_0", true);
			else
			{
				throw new Exception("Unknow checkbox");
			}
			return this;
		}

		public override string GetInfomation(string identifier)
		{
			if (identifier == "crfversion")
				return GetCRFVersion();
			return base.GetInfomation(identifier);
		}

		public string GetCRFVersion()
		{
			var trs = Browser.Table("Table1").Children()[0].Children();
			var tr = trs[trs.Count - 1];
			var text = tr.Text.Trim();
			//CRF Version 1410 - Page Generated: 17 Jul 2012 10:00:25 FLE Daylight Time
			string version = text.Substring(11, text.IndexOf("-") -12).Trim();
			return version;
		}

		public override string URL
		{
			get
			{
				return "Modules/EDC/SubjectPage.aspx";
			}
		}

        public IPage ClickPrimaryRecordLink()
        {
            IWebElement element = CanSeeControl("_ctl0_Content_PrimaryRecordLink");
            if (element != null)
                element.Click();

            return GetPageByCurrentUrlIfNoAlert();
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="identifier"></param>
        /// <returns></returns>
        public override IWebElement CanSeeControl(string identifier)
        {
            if ("Sign and Save".Equals(identifier))
            {
                IWebElement result = Browser.TryFindElementBy(
                    By.XPath("//button[text()='" + identifier + "']"));
                
                return result;
            }

            return base.CanSeeControl(identifier);
        }

		#region ICanVerifyInOrder

		public bool VerifyTableRowsInOrder(string tableIdentifier, Table matchTable)
		{
			throw new NotImplementedException();
		}

		public bool VerifyTableColumnInAphabeticalOrder(string tableIdentifier, string columnName, bool asc)
		{
			throw new NotImplementedException();
		}

		public bool VerifyTableInAphabeticalOrder(string tableIdentifier, bool hasHeader, bool asc)
		{
			return DefaultPOInterfaceImplementation.VerifyTableInAphabeticalOrder_Default(this, tableIdentifier, hasHeader, asc);
		}

		public bool VerifyThingsInOrder(string identifier)
		{
			throw new NotImplementedException();
		}

		#endregion

		#region ICanVerifyExist
		
		public bool VerifyTableRowsExist(string tableIdentifier, Table matchTable)
		{
			throw new NotImplementedException();
		}

		public bool VerifyControlExist(string identifier)
		{
			throw new NotImplementedException();
		}

		bool ICanVerifyExist.VerifyTextExist(string identifier, string text)
		{
            bool result = false;
            if (string.IsNullOrEmpty(identifier))
            {
                //We have to wait for this element in the situation where the text appears after 
                //eSign window phases out.
                Browser.WaitForElement(b => Browser.FindElementByXPath(string.Format(
                    "//*[text()='{0}']",
                    text)));
                result = base.VerifyTextExist(null, text);
            }
            else
            {
                //TODO: this is just a simple version of finding text. Implement more useful version later
                var TR = GetTaskSummaryArea(identifier);

                result = TR.Text.Contains(text);
            }

            return result;
		}

		#endregion


        #region ITaskSummaryContainer
        
        public TaskSummary GetTaskSummary()
        { 
            //var element = Browser.TryFindElementBy(
            //    By.XPath("//span[@id='_ctl0_Content_TsBox_CBoxC']/../../../../.."));
            return new TaskSummary(Browser);
        }
        
        #endregion
    }
}
