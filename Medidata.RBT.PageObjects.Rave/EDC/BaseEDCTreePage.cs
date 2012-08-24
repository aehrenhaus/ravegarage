using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium;
using Medidata.RBT.SeleniumExtension;

namespace Medidata.RBT.PageObjects.Rave
{
	public  class BaseEDCPage : RavePageBase
	{
		public virtual IEDCFieldControl FindField(string fieldName)
		{
			throw new NotImplementedException();
		}


		public BaseEDCPage ClickModify()
		{
			IWebElement editButton = Browser.WaitForElement("header_SG_PencilButton");
			if (editButton == null)
				throw new Exception("Can not find the modify button");
			editButton.Click();
			return this;
		}



		public BaseEDCPage FillDataPoints(IEnumerable<FieldModel> fields)
		{
			foreach (var field in fields)
				FindField(field.Field).EnterData(field.Data, EnumHelper.GetEnumByDescription<ControlType>(field.ControlType));

			return this;
		}

		public BaseEDCPage CancelForm()
		{
			IWebElement btn = Browser.WaitForElement("footer_CB");
			if (btn == null)
				throw new Exception("Can not find the Cancel button");
			btn.Click();
			return this;
		}

		public BaseEDCPage SaveForm()
		{
			IWebElement btn = Browser.WaitForElement("footer_SB");
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

			IWebElement formFolderTable = Browser.FindElementById("_ctl0_LeftNav_EDCTaskList_TblTaskItems");
			var folderLink = formFolderTable.TryFindElementBy(By.PartialLinkText(folderName));
				
			if(folderLink==null)
				throw new Exception("Folder not found:"+folderName);
			folderLink.Click();
			return this;
		}

		public CRFPage SelectForm(string formName)
		{
			IWebElement formFolderTable = Browser.FindElementById("_ctl0_LeftNav_EDCTaskList_TblTaskItems");
			formFolderTable.FindElement(By.LinkText(formName)).Click();
			return new CRFPage();
		}


		public void SignForm(string username, string password)
		{
			Browser.Textbox("TwoPart").SetText(username);
			Browser.Textbox("SignatureBox").SetText(password);
			this.ClickButton("Sign and Save");//ValidateSignAndSave
		}
	}
}
