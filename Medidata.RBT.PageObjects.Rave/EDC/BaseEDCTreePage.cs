using System;
using System.Collections.Generic;
using OpenQA.Selenium;
using TechTalk.SpecFlow;
using Medidata.RBT.SeleniumExtension;
using Medidata.RBT.PageObjects.Rave.SharedRaveObjects;


namespace Medidata.RBT.PageObjects.Rave
{
	public abstract class BaseEDCPage : RavePageBase, IVerifySomethingExists
	{
		public virtual IEDCFieldControl FindField(string fieldName)
		{
			throw new NotImplementedException();
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
			IWebElement subLink = Browser.FindElementById("_ctl0_PgHeader_TabTextHyperlink3");
			subLink.Click();

			IWebElement formFolderTable = Browser.TryFindElementById("_ctl0_LeftNav_EDCTaskList_TblTaskItems", true);
			var folderLink = formFolderTable.TryFindElementBy(By.PartialLinkText(folderName));
				
			if(folderLink==null)
				throw new Exception("Folder not found:"+folderName);
			folderLink.Click();
			return this;
		}

        /// <summary>
        /// Select a form
        /// </summary>
        /// <param name="formName">The form to select</param>
        /// <returns>The current CRFPage</returns>
		public CRFPage SelectForm(string formName)
		{
			IWebElement formFolderTable = Browser.TryFindElementById("_ctl0_LeftNav_EDCTaskList_TblTaskItems", true);
			formFolderTable.FindElement(By.LinkText(formName)).Click();
            TestContext.CurrentPage = new CRFPage();
            return TestContext.CurrentPage.As<CRFPage>();
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



		bool IVerifySomethingExists.VerifySomethingExist(string areaIdentifier, string type, string identifier)
		{
            if (areaIdentifier == null)
            {
                if (Browser.FindElementByTagName("body").Text.Contains(identifier))
                    return true;
                else
                    return false;
            }

			IWebElement result = null;
			switch (identifier)
			{
				case "Sign and Save":
					result = Browser.TryFindElementBy(
						By.XPath("//button[text()='" + identifier + "']"));
					break;
				//Add additional cases here
				default:
					result = GetElementByName(identifier);
					break;
			}

            return result != null;

			throw new NotImplementedException();
		}

		public IPage ClickAuditOnFormLevel()
        {
            IWebElement element = Browser.TryFindElementById("_ctl0_Content_CRFRenderer_header_SG_DataStatusHyperlink");
            if (element != null)
                element.Click();

            return GetPageByCurrentUrlIfNoAlert();

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
