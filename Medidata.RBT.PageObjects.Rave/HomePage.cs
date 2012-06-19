using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Medidata.RBT.PageObjects;
using OpenQA.Selenium.Support.PageObjects;
using OpenQA.Selenium;

using System.Collections.Specialized;
using TechTalk.SpecFlow;

namespace Medidata.RBT.PageObjects.Rave
{
	public  class HomePage : PageBase, INavigationPage
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
			IWebElement studyLink = Browser.FindElementByLinkText(studyName);
			studyLink.Click();
			//IWebElement studyTable = Browser.TryFindElementById("_ctl0_Content_ListDisplayNavigation_dgObjects");

			//if (studyTable != null)
			//{
			//    IWebElement tableLink = studyTable.FindElement(By.XPath("//a[text()='" + studyName + "']"));
			//    tableLink.Click();
			//}
			//else
			//{
			//    IWebElement tabLink = Browser.FindElement(By.XPath("//a[@id='_ctl0_PgHeader_TabTextHyperlink1', text()='" + studyName + "']"));
			//    if (tabLink == null)
			//        throw new Exception("Can't find study to open");
			//}
			return this;
		}

		//
		public SubjectPage CreateSubject(Table table)
		{
			IWebElement addSubjectLink = Browser.FindElementById("_ctl0_Content_ListDisplayNavigation_lbAddSubject");
			addSubjectLink.Click();
			var prp =new PrimaryRecordPage();
            SubjectPage subPage = prp.FillNameAndSave(table);
			
			return subPage;
		}

		/// <summary>
		/// Same logic as SelectStudy
		/// </summary>
		/// <param name="siteName"></param>
		/// <returns></returns>
		public HomePage SelectSite(string siteName)
		{
			IWebElement siteLink  = Browser.FindElementByLinkText(siteName);
			siteLink.Click();
			return this;
		}

		/// <summary>
		/// Fill search box and click search
		/// </summary>
		/// <param name="textToSearch"></param>
		/// <returns></returns>
		public HomePage Search(string textToSearch)
		{
			SearchBox.SetText(textToSearch);
			SearchButton.Click();
			return this;
		}

        public SubjectPage SelectSubject(string subjectName)
        {
			int pageIndex = 1;
			IWebElement subjectLink = null;
			int count = 0;
			do
			{
				subjectLink = Browser.TryFindElementByLinkText(subjectName);
				if (subjectLink != null)
					break;
				var pageTable = Browser.FindElementById("_ctl0_Content_ListDisplayNavigation_DlPagination");
				var pageLinks = pageTable.FindElements(By.XPath(".//a"));
				count = pageLinks.Count;
				if (pageIndex == count)
					break;

				pageLinks[pageIndex].Click();
				pageIndex++;
			} while (true);

			if (subjectLink == null)
				throw new Exception("Can't find sujbect: " + subjectName);
			else
				subjectLink.Click();
            return new SubjectPage();
        }


		public IPage NavigateTo(string name)
		{

			NameValueCollection poClassMapping = new NameValueCollection();
			poClassMapping["Architect"] = "Architect";
			poClassMapping["User Administration"] = "UserAdministration";
			//TODO: other mappings

			var leftNavContainer = Browser.FindElementById("TblOuter");
			var link = leftNavContainer.TryFindElementBy(By.LinkText(name));
			link.Click();
			string className = poClassMapping[name];
			return RavePageFactory.GetPage(className);
		}
	}
}
