using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium;

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
			formFolderTable.FindElement(By.PartialLinkText(folderName)).Click();
			return this;
		}

		public CRFPage SelectForm(string formName)
		{
			IWebElement formFolderTable = Browser.FindElementById("_ctl0_LeftNav_EDCTaskList_TblTaskItems");
			formFolderTable.FindElement(By.PartialLinkText(formName)).Click();
			return new CRFPage();
		}
	}
}
