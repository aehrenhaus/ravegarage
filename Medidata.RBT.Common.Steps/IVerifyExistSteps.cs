using System;
using OpenQA.Selenium;
using TechTalk.SpecFlow;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Medidata.RBT.SeleniumExtension;


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
			bool allExist = CurrentPage.As<IVerifyRowsExist>().VerifyTableRowsExist(tableIdentifier, matchTable);
			Assert.IsTrue(allExist,String.Format("Not all rows have been found in the table {0}", tableIdentifier));
		}

        /// <summary>
        /// Save as IVerifyRowsExistIn____Table(string tableIdentifier, Table matchTable)
        /// except this step should be used where the tableIdentifier parameter is meaningless (ex. Crystal Reports page)
        /// </summary>
        /// <param name="matchTable"></param>
        [StepDefinition(@"I verify rows exist in table")]
        public void IVerifyRowsExistInTable(Table matchTable)
        {
            SpecialStringHelper.ReplaceTableColumn(matchTable, "Subject");
            bool result = CurrentPage.As<IVerifyRowsExist>()
                .VerifyTableRowsExist(null, matchTable);
            Assert.IsTrue(result, "Not all rows have been found in the table");
        }


		/// <summary>
		/// 
		/// </summary>
		/// <param name="identifier"></param>
		[StepDefinition(@"I verify control ""([^""]*)"" exists")]
		public void IVerifyControl____Exist(string identifier)
		{
			bool exist = CurrentPage.As<IVerifySomethingExists>().VerifySomethingExist(null,"control",identifier);
			Assert.IsTrue(exist, String.Format("Control does not exist :{0}", identifier));
		}

		/// <summary>
		/// 
		/// </summary>
		/// <param name="text"></param>
		/// <param name="identifier"></param>
		[StepDefinition(@"I verify text ""([^""]*)"" exists in ""([^""]*)""")]
		public void IVerifyText____ExistsIn____(string text, string areaIdentifier)
		{
			bool exist = CurrentPage.As<IVerifySomethingExists>().VerifySomethingExist(areaIdentifier,"text",text);
			Assert.IsTrue(exist, String.Format("Text does not exist :{0}", text));
		}

		/// <summary>
		/// 
		/// </summary>
		/// <param name="text"></param>
		[StepDefinition(@"I verify text ""([^""]*)"" exists")]
		public void IVerifyText____Exists(string text)
		{
			bool exist = CurrentPage.As<IVerifySomethingExists>().VerifySomethingExist(null,"text",text);
			Assert.IsTrue(exist, String.Format("Text does not exist :{0}", text));
		}

		/// <summary>
		/// 
		/// </summary>
		/// <param name="text"></param>
		[StepDefinition(@"I verify text ""([^""]*)"" does not exist")]
		public void IVerifyText____DoesNotExist(string text)
		{
			bool exist = CurrentPage.As<IVerifySomethingExists>().VerifySomethingExist(null,"text",text);
			Assert.IsFalse(exist, String.Format("Text does exist :{0}", text));
		}

		/// <summary>
		/// 
		/// </summary>
		/// <param name="linkText"></param>
		[StepDefinition(@"I verify link ""([^""]*)"" does not exist")]
		public void IVerifyLink____DoesNotExist(string linkText)
		{
			IWebElement link = Browser.TryFindElementByLinkText(linkText);
			Assert.IsNull(link, String.Format("Link does exist :{0}", linkText));
		}

		/// <summary>
		/// 
		/// </summary>
		/// <param name="linkText"></param>
		[StepDefinition(@"I verify link ""([^""]*)"" exists")]
		public void IVerifyLink____Exists(string linkText)
		{
			IWebElement link = Browser.TryFindElementByLinkText(linkText);
			Assert.IsNotNull(link, String.Format("Link does not exist :{0}", linkText));
		}

		[StepDefinition(@"I should see ""([^""]*)"" in ""([^""]*)""")]
		public void IShouldSee____In____(string identifier,string areaIdentifer)
		{
			bool exist = CurrentPage.As<IVerifySomethingExists>().VerifySomethingExist(areaIdentifer, null, identifier);
			Assert.IsFalse(exist, String.Format("Does exist :{0}", identifier));
		}

		[StepDefinition(@"I should see ""([^""]*)""")]
		public void IShouldSee____(string identifier)
		{
			bool exist = CurrentPage.As<IVerifySomethingExists>().VerifySomethingExist(null, null, identifier);
			Assert.IsFalse(exist, String.Format("Does exist :{0}", identifier));
		}
	}
}
