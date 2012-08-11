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
		/// Verify all rows given in the feature all exist in a table on page.
		/// Columns in matchTable can be less then the actual columns in html table.
		/// If page support pagination of this table, this step will go through all pages of the table.
		/// If page support highting of the found row, it will be highlighted
		/// When any of the rows found, this method will take a screenshot. 
		/// 
		/// Only when all rows in matchTables have been found will this method succeed, else it will through an Assert exception 
		/// 
		/// </summary>
		/// <param name="tableIdentifier"></param>
		/// <param name="matchTable"></param>
		[StepDefinition(@"I verify rows exist in ""([^""]*)"" table")]
		public void IVerifyRowsExistIn____Table(string tableIdentifier, Table matchTable)
		{
			bool allExist = CurrentPage.As<ICanVerifyExist>().VerifyTableRowsExist(tableIdentifier, matchTable);
			Assert.IsTrue(allExist,String.Format("Not all rows have been found in the table {0}", tableIdentifier));
		}

		/// <summary>
		/// 
		/// </summary>
		/// <param name="identifier"></param>
		[StepDefinition(@"I verify control ""([^""]*)"" exists")]
		public void IVerifyControl____Exist(string identifier)
		{
			bool exist = CurrentPage.As<ICanVerifyExist>().VerifyControlExist(identifier);
			Assert.IsTrue(exist, String.Format("Control does not exist :{0}", identifier));
		}

		/// <summary>
		/// 
		/// </summary>
		/// <param name="text"></param>
		/// <param name="identifier"></param>
		[StepDefinition(@"I verify text ""([^""]*)"" exists in ""([^""]*)""")]
		public void IVerifyText____ExistsIn____(string text, string identifier)
		{
			bool exist = CurrentPage.As<ICanVerifyExist>().VerifyTextExist(identifier,text);
			Assert.IsTrue(exist, String.Format("Text does not exist :{0}", text));
		}

		/// <summary>
		/// 
		/// </summary>
		/// <param name="text"></param>
		[StepDefinition(@"I verify text ""([^""]*)""")]
		public void IVerifyText____ExistsIn____(string text)
		{
			bool exist = CurrentPage.As<ICanVerifyExist>().VerifyTextExist(null, text);
			Assert.IsTrue(exist, String.Format("Text does not exist :{0}", text));
		}
	}
}
