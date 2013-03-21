using System;
using System.Collections.Generic;
using OpenQA.Selenium;
using TechTalk.SpecFlow;
using Medidata.RBT.SeleniumExtension;
using Medidata.RBT.PageObjects.Rave.SharedRaveObjects;
using System.Linq;

namespace Medidata.RBT.PageObjects.Rave
{
	public abstract class BaseEDCPage : RavePageBase, IVerifySomethingExists
	{
		public virtual IEDCFieldControl FindField(string fieldName)
		{
			throw new NotImplementedException();
		}


		public IWebElement GetTaskSummaryArea(string header)
		{
			var TRs = Browser.FindElementsByXPath("//span[@id='_ctl0_Content_TsBox_CBoxC']/table/tbody/tr[position()>1]");

			var TR = TRs.FirstOrDefault(x => x.Text.Contains(header));

			return TR;
		}

		public BaseEDCPage ClickModify()
		{
			IWebElement editButton = Browser.TryFindElementByPartialID("header_SG_PencilButton");
			if (editButton == null)
				throw new Exception("Can not find the modify button");
			editButton.Click();
			return this;
		}



		public BaseEDCPage FillDataPoints(IEnumerable<FieldModel> fields)
		{
			foreach (var field in fields)
				FindField(field.Field).EnterData(field.Data, EnumHelper.GetEnumByDescription<ControlType>(field.ControlType), field.AdditionalData);

			return this;
		}

		public BaseEDCPage CancelForm()
		{
			IWebElement btn = Browser.TryFindElementByPartialID("footer_CB");
			if (btn == null)
				throw new Exception("Can not find the Cancel button");
			btn.Click();
			return this;
		}

        /// <summary>
        /// Save a form selected form
        /// </summary>
        /// <returns>This page</returns>
		public BaseEDCPage SaveForm()
		{
			IWebElement btn = Browser.TryFindElementByPartialID("footer_SB");
			if (btn == null)
				throw new Exception("Can not find the Save button");
			btn.Click();
			return this;
		}

		public BaseEDCPage SelectFolder(string folderName)
		{
			//navigate to subject first, incase it is alreay in a folder.
			IWebElement subLink = Browser.TryFindElementById("_ctl0_PgHeader_TabTextHyperlink3");
			subLink.Click();

			IWebElement formFolderTable = Browser.TryFindElementById("_ctl0_LeftNav_EDCTaskList_TblTaskItems", true);
			var folderLink = formFolderTable.TryFindElementBy(By.PartialLinkText(folderName));
				
			if(folderLink==null)
				throw new Exception("Folder not found:"+folderName);
			folderLink.Click();
			return this.WaitForPageLoads().As<BaseEDCPage>();
		}

        /// <summary>
        /// Select a form
        /// </summary>
        /// <param name="formName">The form to select</param>
        /// <returns>The current CRFPage</returns>
		public virtual RavePageBase SelectForm(string formName)
		{
			IWebElement formFolderTable = Browser.TryFindElementById("_ctl0_LeftNav_EDCTaskList_TblTaskItems", true);
			formFolderTable.TryFindElementBy(By.LinkText(formName)).Click();
            return this.WaitForPageLoads().As<RavePageBase>();
		}


		public void SignForm(string username, string password)
		{
			Browser.TextboxById("TwoPart").SetText(username);
			Browser.TextboxById("SignatureBox").SetText(password);
			this.ClickButton("Sign and Save");//ValidateSignAndSave
		}

        public BaseEDCPage ClickCheckBoxOnForm(string checkboxName)
        {
            string partialID = GetCheckboxPartialIdFromCheckName(checkboxName);
			IWebElement chkBox = Browser.TryFindElementByPartialID("_ctl0_Content_R_header_SG_" + partialID);

            if (chkBox == null)
                throw new Exception("Cannot find the checkbox named: " + checkboxName);

            chkBox.Click();
            return this;
        }

		#region IVerifySomethingExists

        public bool VerifySomethingExist(string areaIdentifier, string type, string identifier, bool exactMatch = false, int? amountOfTimes = null, BaseEnhancedPDF pdf = null, bool? bold = null)
		{        
            if (areaIdentifier == null)
            {
                var element = Browser.TryFindElementBy(b =>
                {
                    var body = Browser.FindElementByTagName("body");
                    IWebElement bodyResult = null;
                    if (exactMatch)
                    {
                        bodyResult = Browser.TryFindElementBy(
                            By.XPath(string.Format("//*[text()='{0}']", identifier)), 
                            isWait: false); //Don't wait here - let the caller do the waiting
                    }
                    else if (!exactMatch && body.Text.Contains(identifier))
                        bodyResult = body;
                    else if (!exactMatch && body.Text.Contains(identifier))
                        bodyResult = body;

                    return bodyResult;
                }, 
                isWait: true, 
                timeOutSecond: 20); //We need to wait somewhat longer in some situations
                    
                if(element != null)
                {
                    return true;
                }
            }

            IWebElement result = null;
            if (!string.IsNullOrEmpty(type) && type.Equals("text"))
            {
                if (Browser.FindElementByTagName("body").Text.Contains(identifier))
                    return true;
            }

            switch (identifier)
            {
                case "Sign and Save":
                    result = Browser.TryFindElementBy(
                        By.XPath("//button[text()='" + identifier + "']"));
                    break;
                //Add additional cases here
                default:
                    result = TryGetElementByName(identifier);
                    break;
            }

            return result != null;
		}

        public bool VerifySomethingExist(string areaIdentifier, string type, List<string> identifiers, bool exactMatch, int? amountOfTimes, RBT.BaseEnhancedPDF pdf, bool? bold)
        {
            foreach (string identifier in identifiers)
                if (VerifySomethingExist(areaIdentifier, type, identifier, exactMatch, amountOfTimes, pdf, bold) == false)
                    return false;

            return true;
        }

		public override IWebElement GetElementByName(string identifier, string areaIdentifier = null, string listItem = null)
		{
			if ((new string[] { 
				"Requiring Signature",
				"NonConformant Data",
				"Requiring Coding",
				"",
				"Open Queries",
				"Answered Queries",
				"Sticky Notes",
				"Requiring Review",
				"",
				"",
				"",
				"",
				"Cancel Queries",
			}).Contains(identifier))
			{
				return GetTaskSummaryArea(identifier);
			}
			return base.GetElementByName(identifier, areaIdentifier, listItem);
		}

		public IPage ClickAuditOnFormLevel()
        {
            IWebElement element = Browser.TryFindElementByPartialID("_header_SG_DataStatusHyperlink");
            if (element != null)
                element.Click();

            return WaitForPageLoads();

        }
        #endregion

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
