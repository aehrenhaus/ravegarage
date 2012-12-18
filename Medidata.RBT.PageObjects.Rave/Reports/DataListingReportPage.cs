using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium.Support.PageObjects;
using OpenQA.Selenium;
using OpenQA.Selenium.Remote;
using TechTalk.SpecFlow;
using System.Collections.ObjectModel;
using System.Threading;
using Medidata.RBT.SeleniumExtension;


namespace Medidata.RBT.PageObjects.Rave
{
    public class DataListingReportPage : CrystalReportPageBase, IVerifyRowsExist, ICanPaginate, ICanHighlight
	{
		public override IWebElement GetElementByName(string identifier, string areaIdentifier = null, string listItem = null)
		{
			if (identifier == "Data Source")
				return Browser.TryFindElementByPartialID("ddlSource");
			if (identifier == "Form")
				return Browser.TryFindElementByPartialID("ddlDomain");
            if (identifier == "Result")
				return Browser.TryFindElementByPartialID("dgResult");


			return base.GetElementByName(identifier,areaIdentifier,listItem);
		}


		public override string URL
		{
			get
			{
				return "DataListingsReport.aspx";
			}
		}

        #region ICanVerifyExist

		bool IVerifyRowsExist.VerifyTableRowsExist(string tableIdentifier, Table matchTable)
		{
			SpecialStringHelper.ReplaceTableColumn(matchTable, "Subject");
			return this.VerifyTableRowsExist_Default(tableIdentifier, matchTable);
		}
      
        #endregion ICanVerifyExist

       
        #region ICanPaginate

		public int CurrentPageNumber { get; private set; }

        public bool GoNextPage(string areaIdentifier)
        {
            int pageIndex = 0;
            int count = 0;

            int numberOfRows = 0;
            HtmlTable htmlTable = GetElementByName(areaIdentifier).EnhanceAs<HtmlTable>();
            var trs = htmlTable.FindElements(By.XPath("./tbody/tr"));
            numberOfRows = trs.Count;
            var pageTable = TestContext.Browser.FindElementByXPath(String.Format("/html/body/form/table[3]/tbody/tr/td/table/tbody/tr[{0}]/td", numberOfRows.ToString()));
            var current = pageTable.FindElement(By.XPath(".//span"));
            var pageLinks = pageTable.FindElements(By.XPath(".//a"));

            count = pageLinks.Count;
            
            int currentValue = int.Parse(current.Text);
            int pageLinksValue = int.Parse(pageLinks[pageIndex].Text);

            while (count >= currentValue && pageLinksValue <= currentValue)
            {  
                pageIndex++;
                pageLinksValue = int.Parse(pageLinks[pageIndex].Text);
            }

            if (count > 0 && pageLinksValue > currentValue)
            {
                pageLinks[pageIndex].Click();
            }
            else
            {
                return false;
            }
            return true;
        }

        public bool GoPreviousPage(string areaIdentifier)
        {
            throw new NotImplementedException();
        }

        public bool GoToPage(string areaIdentifier, int page)
        {
            throw new NotImplementedException();
        }

        public bool CanPaginate(string areaIdentifier)
        {
            return true;
        }
        #endregion ICanPaginate

        #region ICanHighlight

        public void Hightlight(string type, IWebElement eleToHighlight)
        {
            if (type == "match tr")
            {
                eleToHighlight.SetStyle("border", " 2px solid red");
            }
        }
        #endregion ICanPaginate


	}
}

