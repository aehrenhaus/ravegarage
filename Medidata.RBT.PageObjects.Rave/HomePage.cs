using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Medidata.RBT.PageObjects;
using OpenQA.Selenium.Support.PageObjects;
using OpenQA.Selenium;

using System.Collections.Specialized;
using TechTalk.SpecFlow;
using Medidata.RBT.SeleniumExtension;

namespace Medidata.RBT.PageObjects.Rave
{
	public  class HomePage : RavePageBase
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
			SearchBox.EnhanceAs<Textbox>().SetText(textToSearch);
			SearchButton.Click();
			return this;
		}

        public SubjectPage SelectSubject(string subjectName)
        {
			try
			{

				IWebElement subjectLink = RavePagesHelper.FindLinkInPaginatedList(subjectName);
				
				if (subjectLink == null)
					throw new Exception("Can't find sujbect: " + subjectName);
				else
					subjectLink.Click();
			}
			catch(Exception err)
			{
				throw new Exception(string.Format ("Failed to find subject [{0}], reason:{1}",subjectName,err.Message),err);
			}
            return new SubjectPage();
        }


		public override IPage NavigateTo(string name)
		{

			NameValueCollection poClassMapping = new NameValueCollection();
			poClassMapping["Architect"] = "ArchitectPage";
			poClassMapping["User Administration"] = "UserAdministrationPage";
            poClassMapping["DDE"] = "DDEPage";
            poClassMapping["Reporter"] = "ReportsPage";
			poClassMapping["Query Management"] = "DCFQueriesPage";
			poClassMapping["PDF Generator"] = "FileRequestPage";
			

			//TODO: other mappings

			var leftNavContainer = Browser.FindElementById("TblOuter");
			var link = leftNavContainer.TryFindElementBy(By.LinkText(name));

			if (link == null)
				return base.NavigateTo(name);

			link.Click();
			string className = poClassMapping[name];
			return RavePageObjectFactory.GetPage(className);
		}
	}
}
