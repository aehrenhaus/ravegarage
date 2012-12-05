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

using Medidata.RBT.PageObjects.Rave.SiteAdministration;
using Medidata.RBT.PageObjects.Rave.SharedRaveObjects;
using System.Threading;

namespace Medidata.RBT.PageObjects.Rave
{
	/// <summary>
	/// Because HomePage is a all in one page. It also inherits from BaseEDCPage
	/// </summary>
	public class HomePage : BaseEDCPage, IHavePaginationControl, ICanHighlight, IVerifyRowsExist, ICanVerifyInOrder, ITaskSummaryContainer
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
		public HomePage SelectStudy(string studyName, string environment = null)
        {
            Project study = TestContext.GetExistingFeatureObjectOrMakeNew(
                studyName, () => new Project(studyName));


            int foundOnPage;

			var header = Browser.TryFindElementById("_ctl0_PgHeader_TabTable");
			IWebElement studyLink = header.TryFindElementBySelectLinktext(study.UniqueName,true,false);

			if (studyLink == null)
			{
				studyLink = this.FindInPaginatedList("", () =>
					{
						//with some page settings, this may not be the container of studies
						//var studyList = TestContext.Browser.TryFindElementById("_ctl0_Content_ListDisplayNavigation_dgObjects");

						string linkText = study.UniqueName;
						if (!string.IsNullOrWhiteSpace(environment) && environment != "Prod")
							linkText += " (" + environment + ")";
						return TestContext.Browser.TryFindElementBy(By.LinkText(linkText), true, 2);
					}, out foundOnPage);

			}

			if (studyLink == null)
				throw new Exception("Study not found!" + study.UniqueName);

            studyLink.Click();
			Browser.WaitForDocumentLoad();
            return this;
        }

		//
		public SubjectPage CreateSubject(IEnumerable<FieldModel> dps)
		{
			IWebElement addSubjectLink = Browser.TryFindElementByPartialID("lbAddSubject",true);
			addSubjectLink.Click();
			Browser.WaitForDocumentLoad();
			var prp =new PrimaryRecordPage();
            SubjectPage subPage = prp.FillNameAndSave(dps);
			
			return subPage;
		}

		/// <summary>
		/// Same logic as SelectStudy
		/// </summary>
		/// <param name="siteName"></param>
		/// <returns></returns>
		public HomePage SelectSite(string siteName)
		{
            Site site = TestContext.GetExistingFeatureObjectOrMakeNew(
                siteName, () => new Site(siteName));

            //TODO: the pagination does not work on Inna's site where there is no page buttons for sites list
            //fix this later, but comment for now

            //TODO :    Remove the coalescing op when seeding considderation is up to date for all feature files. 
            //          Use site.Name as the text to search for.
            ClickLink(site.UniqueName,null,null);
			Browser.WaitForDocumentLoad();

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
            if (subjectName != null)
            {
                SearchBox.EnhanceAs<Textbox>().SetText(subjectName);
                SearchButton.Click();
                return new SubjectPage();
            }
            throw new Exception("Subject name cannot be null");
        }


		#region IPaginatedPage

		public ICanPaginate GetPaginationControl(string areaIdentifier)
		{
			var pageTable = TestContext.Browser.TryFindElementById("_ctl0_Content_ListDisplayNavigation_TrPagination").Children()[1];
			var pager = new RavePaginationControl_Arrow(this, pageTable);
			return pager;
		}

		#endregion

        public override string URL { get { return "homepage.aspx"; } }

		public override IWebElement GetElementByName(string identifier, string areaIdentifier = null, string listItem = null)
		{
			if (identifier == "study")
				return Browser.TryFindElementByPartialID("_dgObjects") ;

			if (identifier == "Reports")
			{
				var table =  Browser.FindElementByXPath("//td[text()='Reports']/../../../tbody/tr[2]//table");
				return table;
			}

			return base.GetElementByName(identifier,areaIdentifier,listItem);
		}



		#region ICanHighlight

		public void Hightlight(string type, IWebElement eleToHighlight)
		{
			if (type == "match tr")
			{
				eleToHighlight.SetStyle("border", " 2px solid red");
			}
		}

		#endregion


		bool IVerifyRowsExist.VerifyTableRowsExist(string tableIdentifier, Table matchTable)
		{
			return this.VerifyTableRowsExist_Default(tableIdentifier, matchTable);
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

        /// <summary>
        /// Select a form created by Rave Monitor on this page.
        /// </summary>
        /// <param name="formName">The name of the form to select</param>
        /// <returns>A new MonitorSiteSubjectPage</returns>
        public SubjectPage SelectForm(string formName)
        {
            IWebElement formFolderTable = Browser.FindElementById("TblOuter");
            formFolderTable.FindElement(By.LinkText(formName)).Click();
            return new SubjectPage();
        }

        #region ITaskSummaryContainer

        public TaskSummary GetTaskSummary() { return new TaskSummary(this); }

        #endregion


	}
}
