using System;
using OpenQA.Selenium;
using TechTalk.SpecFlow;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Medidata.RBT.SeleniumExtension;


namespace Medidata.RBT.Common.Steps
{
    /// <summary>
    /// Steps to verify objects exists
    /// </summary>
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
			SpecialStringHelper.ReplaceTable(matchTable);

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
        /// Verify that text exists a certain amount of times in a certain area
        /// </summary>
        /// <param name="text">The text to verify</param>
        /// <param name="amountOfTimes">The amount of times that text should exist</param>
        /// <param name="areaIdentifier">An identifier for the area the text should exist in</param>
        [StepDefinition(@"I verify text ""(.*)"" exists ""(.*)"" time\(s\) in ""(.*)""")]
        public void ThenIVerifyText____Exists_____TimeSIn____(string text, string amountOfTimes, string areaIdentifier)
        {
            bool exist = CurrentPage.As<IVerifySomethingExists>().VerifySomethingExist(
                areaIdentifier, "text", text, amountOfTimes: Convert.ToInt32(amountOfTimes));
            Assert.IsTrue(exist, String.Format("Text does not exist :{0}", text));
        }

		/// <summary>
		/// Verify text exists at least once in an area
		/// </summary>
        /// <param name="text">The text to verify</param>
        /// <param name="areaIdentifier">An identifier for the area the text should exist in</param>
		[StepDefinition(@"I verify text ""([^""]*)"" exists in ""([^""]*)""")]
		public void IVerifyText____ExistsIn____(string text, string areaIdentifier)
		{
			bool exist = CurrentPage.As<IVerifySomethingExists>().VerifySomethingExist(areaIdentifier,"text",text);
			Assert.IsTrue(exist, String.Format("Text does not exist :{0}", text));
		}

        /// <summary>
        /// Verify text doesn't exist in an area
        /// </summary>
        /// <param name="text">The text to verify</param>
        /// <param name="areaIdentifier">An identifier for the area the text should exist in</param>
        [StepDefinition(@"I verify text ""([^""]*)"" does not exist in ""([^""]*)""")]
        public void IVerifyText____DoesNotExistIn____(string text, string areaIdentifier)
        {
            bool exist = CurrentPage.As<IVerifySomethingExists>().VerifySomethingExist(areaIdentifier, "text", text);
            Assert.IsFalse(exist, String.Format("Text does not exist :{0}", text));
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
        /// Verify field with the passed in name exists
        /// </summary>
        /// <param name="identifier">The field name to verify</param>
        [StepDefinition(@"I verify field ""([^""]*)"" exists")]
		public void IVerifyField____Exists(string identifier)
		{
            Assert.IsTrue(CurrentPage.As<IVerifySomethingExists>().VerifySomethingExist(null, "field", identifier));
		}

        /// <summary>
        /// Verify field with the passed in name and OID exists
        /// </summary>
        /// <param name="identifier">The field name to verify</param>
        /// <param name="identifier">The field OID to verify</param>
        [StepDefinition(@"I verify field ""([^""]*)"" with field OID ""([^""]*)"" exists")]
        public void IVerifyField____Exists(string identifier, string fieldOID)
        {
            Assert.IsTrue(CurrentPage.As<IVerifySomethingExists>().VerifySomethingExist(fieldOID, "field", identifier));
        }

        /// <summary>
        /// Verify field with the passed in name does not exist
        /// </summary>
        /// <param name="identifier">The field name to verify</param>
        [StepDefinition(@"I verify field ""([^""]*)"" does not exist")]
        public void IVerifyField____DoesNotExist(string identifier)
        {
            Assert.IsFalse(CurrentPage.As<IVerifySomethingExists>().VerifySomethingExist(null, "field", identifier));
        }

        /// <summary>
        /// Verify button with the passed in identifier exists
        /// </summary>
        /// <param name="identifier">An identifier for the button (usually the button text)</param>
        [StepDefinition(@"I verify button ""([^""]*)"" exists")]
        public void IVerifyButton____Exists(string identifier)
        {
            Assert.IsTrue(CurrentPage.As<IVerifySomethingExists>().VerifySomethingExist(null, "button", identifier));
        }

        /// <summary>
        /// Verify button with the passed in identifier does not exist
        /// </summary>
        /// <param name="identifier">An identifier for the button (usually the button text)</param>
        [StepDefinition(@"I verify button ""([^""]*)"" does not exist")]
        public void IVerifyButton____DoesNotExist(string identifier)
        {
            Assert.IsFalse(CurrentPage.As<IVerifySomethingExists>().VerifySomethingExist(null, "button", identifier));
        }

        /// <summary>
        /// Verify a link with the text passed in exists
        /// </summary>
        /// <param name="linkText">The link text</param>
        [StepDefinition(@"I verify link ""([^""]*)"" exists")]
        public void IVerifyLink____Exists(string linkText)
        {
            IWebElement link = Browser.TryFindElementByLinkText(linkText);
            Assert.IsNotNull(link, String.Format("Link does not exist :{0}", linkText));
        }

        /// <summary>
        /// Unused step
        /// </summary>
        /// <param name="identifier"></param>
        /// <param name="areaIdentifer"></param>
		[StepDefinition(@"I should see ""([^""]*)"" in ""([^""]*)""")]
		public void IShouldSee____In____(string identifier,string areaIdentifer)
		{
			bool exist = CurrentPage.As<IVerifySomethingExists>().VerifySomethingExist(areaIdentifer, null, identifier);
			Assert.IsTrue(exist, String.Format("Does exist :{0}", identifier));
		}

        /// <summary>
        /// Unused step
        /// </summary>
        /// <param name="identifier"></param>
		[StepDefinition(@"I should see ""([^""]*)""")]
		public void IShouldSee____(string identifier)
		{
			bool exist = CurrentPage.As<IVerifySomethingExists>().VerifySomethingExist(null, null, identifier);
			Assert.IsTrue(exist, String.Format("Does exist :{0}", identifier));
		}

        /// <summary>
        /// To check on a page if a certain button control is not visible
        /// </summary>
        /// <param name="buttonName"></param>
        [StepDefinition(@"I verify button ""([^""]*)"" is not visible")]
        public void IVerifyButton____IsNotVisible(string buttonName)
        {
            bool visible = CurrentPage.As<IVerifySomethingExists>().VerifySomethingExist(null, "button", buttonName);
            Assert.IsFalse(visible, String.Format("Is visible :[{0}] button", buttonName));
        }

        /// <summary>
        /// To check on a page if a certain button control is visible
        /// </summary>
        /// <param name="buttonName"></param>
        [StepDefinition(@"I verify button ""([^""]*)"" is visible")]
        public void IVerifyButton____IsVisible(string buttonName)
        {
            bool visible = CurrentPage.As<IVerifySomethingExists>().VerifySomethingExist(null, "button", buttonName);
            Assert.IsTrue(visible, String.Format("Is not visible :[{0}] button", buttonName));
        }
	}
}
