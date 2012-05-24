using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium;

namespace Medidata.UAT.WebDrivers.Rave
{
	public class BaseEDCTreePage :PageBase
	{
		public BaseEDCTreePage SelectFolder(string folderName)
		{
			IWebElement formFolderTable = Browser.FindElementById("_ctl0_LeftNav_EDCTaskList_TblTaskItems");
			formFolderTable.FindElement(By.PartialLinkText(folderName)).Click();
			return this;
		}

		public CRFPage SelectForm(string formName)
		{
			IWebElement formFolderTable = Browser.FindElementById("_ctl0_LeftNav_EDCTaskList_TblTaskItems");
			formFolderTable.FindElement(By.PartialLinkText(formName)).Click();
			return new CRFPage().UseCurrent<CRFPage>();
		}
	}
}
