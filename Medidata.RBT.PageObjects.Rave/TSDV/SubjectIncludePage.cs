using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium.Support.PageObjects;
using OpenQA.Selenium;
using OpenQA.Selenium.Remote;
using Medidata.RBT.SeleniumExtension;
using TechTalk.SpecFlow;

namespace Medidata.RBT.PageObjects.Rave
{
    public class SubjectIncludePage : SubjectManagementPageBase,IHavePaginationControl
	{

        public override string URL
        {
            get
            {
                return "Modules/Reporting/TSDV/SubjectInclude.aspx";
            }
        }

        public IPage IncludeSubjects(int num)
        {

			int selectedCount = 0;

	        while(selectedCount!=num)
			{
				IWebElement table = Browser.TryFindElementById("SubjectIncludeDiv");
				var checks = table.Checkboxes();
				int countToCheckThisTime = Math.Min(checks.Count - 1, num - selectedCount);
				for(int i =1;i<=countToCheckThisTime;i++)
					checks[i].Check();
				this.ClickLink("Include Subjects");
				Browser.GetAlertWindow().Accept();
				selectedCount += countToCheckThisTime;

				Browser.WaitForDocumentLoad();
			}

 
			
            return this;
        }

		public ICanPaginate GetPaginationControl(string areaIdentifier)
		{
			var pageTable = Context.Browser.TryFindElementById("_ctl0_Content_TblPage").Children()[1];
			var pager = new RavePaginationControl_CurrentPageNotLink(this, pageTable);
			return pager;
		}
	}
}
