using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium;
using Medidata.RBT.SeleniumExtension;

namespace Medidata.RBT.PageObjects.Rave
{
	public class BaseEDCTreePage : RavePageBase
	{
		public BaseEDCTreePage SelectFolder(string folderName)
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
