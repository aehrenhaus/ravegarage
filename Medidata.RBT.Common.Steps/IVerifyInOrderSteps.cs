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
    public class IVerifyInOrderSteps : BrowserStepsBase
    {
		/// <summary>
		/// In the order of the given match table (1-* columns)
		/// </summary>
		/// <param name="tableIdentifier"></param>
		/// <param name="matchTable"></param>
		[StepDefinition(@"I verify rows are in this order in table ""([^""]*)""")]
		public void IVerifyRowsAreInThisOrderInTable(string tableIdentifier, Table matchTable)
		{
			bool inorder = CurrentPage.As<ICanVerifyInOrder>().VerifyTableRowsInOrder(tableIdentifier, matchTable);
			Assert.IsTrue(inorder, String.Format("Not in the given order in the table {0}", tableIdentifier));
		}

		/// <summary>
		///  1 column is in descendent alphabetical order 
		/// </summary>
		/// <param name="columnHeader"></param>
		/// <param name="tableIdentifier"></param>
		[StepDefinition(@"I verify column ""([^""]*)"" in table ""([^""]*)"" is in alphabetical order")]
		public void IVerifyColumn____InTable____IsInAlphabeticalOrder(string columnHeader, string tableIdentifier)
		{
			bool inorder = CurrentPage.As<ICanVerifyInOrder>().VerifyTableColumnInAphabeticalOrder(tableIdentifier, columnHeader, true);
			Assert.IsTrue(inorder, String.Format("Column {0} in table {1} is not in alphabetical order", columnHeader, tableIdentifier));

		}

		[StepDefinition(@"I verify column ""([^""]*)"" in table ""([^""]*)"" is in descendent alphabetical order")]
		public void IVerifyColumn____InTable____IsInDescendentAlphabeticalOrder(string columnHeader, string tableIdentifier)
		{
			bool inorder = CurrentPage.As<ICanVerifyInOrder>().VerifyTableColumnInAphabeticalOrder(tableIdentifier, columnHeader, false);
			Assert.IsTrue(inorder, String.Format("Column {0} in table {1} is not in descendent alphabetical order", columnHeader, tableIdentifier));

		}


		/// <summary>
		/// 
		/// </summary>
		/// <param name="tableIdentifier"></param>
		/// <param name="descendent"></param>
		[StepDefinition(@"I verify table ""([^""]*)"" is in alphabetical order")]
		public void IVerifyTable____IsInAlphabeticalOrder(string tableIdentifier)
		{

			bool inorder = CurrentPage.As<ICanVerifyInOrder>().VerifyTableInAphabeticalOrder(tableIdentifier, false, true);
			Assert.IsTrue(inorder, String.Format("Table {0} is not in alphabetical order",  tableIdentifier));
		
		}

		[StepDefinition(@"I verify table ""([^""]*)"" is in descendent alphabetical order")]
		public void IVerifyTable____IsInDescendentAlphabeticalOrder(string tableIdentifier)
		{
			bool inorder = CurrentPage.As<ICanVerifyInOrder>().VerifyTableInAphabeticalOrder(tableIdentifier, false, false);
			Assert.IsTrue(inorder, String.Format("Table {0} is not in descendent alphabetical order", tableIdentifier));
		
		}


		/// <summary>
		/// Things in order, the meaning of this method will depend on concrete page.
		/// </summary>
		/// <param name="identifier"></param>
		[StepDefinition(@"I verify ""([^""]*)"" are in order")]
		public void IVerify____AreInOrder(string identifier)
		{
			bool inorder = CurrentPage.As<ICanVerifyInOrder>().VerifyThingsInOrder(identifier);
			Assert.IsTrue(inorder, String.Format("{0} is not in order", identifier));
		}
	}
}
