using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using TechTalk.SpecFlow;
using OpenQA.Selenium;
using OpenQA.Selenium.Remote;
using System.Threading;
using System.Collections.Specialized;
using Medidata.RBT.SeleniumExtension;
using Microsoft.VisualStudio.TestTools.UnitTesting;

namespace Medidata.RBT.Common.Steps
{
    [Binding]
    public class IVerifyExistSteps : BrowserStepsBase
    {
		/// <summary>
		/// Verify all rows given in the feature exist in a table on page.
		/// Columns can be less then the actual columns in html table.
		/// </summary>
		/// <param name="tableIdentifier"></param>
		/// <param name="matchTable"></param>
		[StepDefinition(@"I verify row\(s\) exist in ""([^""]*)"" table")]
		public void IShouldVerifyRowSExistIn____table(string tableIdentifier, Table matchTable)
		{
			HtmlTable htmlTable = CurrentPage.GetElementByName(tableIdentifier).EnhanceAs<HtmlTable>();
			//ICanPaginate ppage = CurrentPage.As<ICanPaginate>();
			//ppage.
			var rows = htmlTable.FindMatchRows(matchTable);
			Assert.AreEqual(matchTable.Rows.Count, rows.Count, String.Format("Not all rows have been found in the table {0}", tableIdentifier));
		}

	
	}
}
