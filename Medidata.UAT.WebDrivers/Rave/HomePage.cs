using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Medidata.UAT.WebDrivers;
using OpenQA.Selenium.Support.PageObjects;
using OpenQA.Selenium;

namespace Medidata.UAT.WebDrivers.Rave
{
	public  class HomePage : PageBase
	{
		[FindsBy(How = How.Id, Using = "_ctl0_Content_ListDisplayNavigation_txtSearch")]
		IWebElement SearchBox;

		[FindsBy(How = How.Id, Using = "_ctl0_Content_ListDisplayNavigation_ibSearch")]
		IWebElement SearchButton;

		/// <summary>
		/// First suppose it is study table view. If the table exist, then find study inside
		/// If table does not exists, then it could be unique study and hence already in tab header, try to find study link there
		/// If not found in tab header,  then failed
		/// </summary>
		/// <param name="studyName"></param>
		/// <returns></returns>
		public HomePage SelectStudy(string studyName)
		{
			IWebElement studyTable = Browser.TryFindElementById("_ctl0_Content_ListDisplayNavigation_dgObjects");

			if (studyTable != null)
			{
				IWebElement tableLink = studyTable.FindElement(By.XPath("//a[text()='" + studyName + "']"));
				tableLink.Click();
			}
			else
			{
				IWebElement tabLink = Browser.FindElement(By.XPath("//a[@id='_ctl0_PgHeader_TabTextHyperlink1', text()='" + studyName + "']"));
				if (tabLink == null)
					throw new Exception("Can't find study to open");
			}
			return this;
		}

		//
		public SubjectPage CreateSubject(string subjectName)
		{
			IWebElement addSubjectLink = Browser.FindElementById("_ctl0_Content_ListDisplayNavigation_lbAddSubject");
			addSubjectLink.Click();
			var prp =new PrimaryRecordPage().UseCurrent<PrimaryRecordPage>();
			SubjectPage subPage = prp.FillNameAndSave(subjectName);
			
			return subPage;
		}

		/// <summary>
		/// Same logic as SelectStudy
		/// </summary>
		/// <param name="siteName"></param>
		/// <returns></returns>
		public HomePage SelectSite(string siteName)
		{

			//TODO :find out the ID
			IWebElement studyTable = Browser.TryFindElementById("siteTableControlID");

			if (studyTable != null)
			{
				IWebElement tableLink = studyTable.FindElement(By.XPath("//a[text()='" + siteName + "']"));
				tableLink.Click();
			}
			else
			{
				string xpath = "//a[@id='_ctl0_PgHeader_TabTextHyperlink2' and text()='" + siteName + "']";
				IWebElement tabLink = Browser.TryFindElementBy(By.XPath(xpath));
				if (tabLink == null)
					throw new Exception("Can't find site to open");
			}
			return this;
		}

		/// <summary>
		/// Fill search box and click search
		/// </summary>
		/// <param name="textToSearch"></param>
		/// <returns></returns>
		public HomePage Search(string textToSearch)
		{
			SearchBox.SendKeys(textToSearch);
			SearchButton.Click();
			return this;
		}

	}
}
