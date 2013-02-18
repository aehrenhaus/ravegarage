using System;
using System.Collections.Generic;
using System.Linq;
using TechTalk.SpecFlow;
using Medidata.RBT.PageObjects.Rave;
using TechTalk.SpecFlow.Assist;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Medidata.RBT.SharedRaveObjects;
using Medidata.RBT.PageObjects.Rave.SharedRaveObjects;
using System.Text.RegularExpressions;

namespace Medidata.RBT.Features.Rave
{
    /// <summary>
    /// Steps pertaining to all of rave
    /// </summary>
	[Binding]
	public class RaveSteps : BrowserStepsBase
	{
		public const string TripReports = "TripReports";
        /// <summary>
        /// Step definition to check if a the text stored in the scenario text contains the listed symbols. Fails if it does.
        /// </summary>
        /// <param name="table">The list of characters to look for</param>
        /// <returns></returns>
        [StepDefinition(@"the text should not contain ""<Symbol>""")]
        public void TheTextShouldNotContainSymbol(Table table)
		{
			string str = WebTestContext.Storage[RaveSteps.TripReports] as string;
			Assert.IsFalse(String.IsNullOrEmpty(str));

			if (CreateSymbolsTable(table).Any(s => str.Contains(s)))
                Assert.Fail();
        }

        /// <summary>
        /// Step definition to check if a the text stored in the scenario text contains all the listed symbols. Succeeds if it does.
        /// </summary>
        /// <param name="table">The list of characters to look for</param>
        /// <returns></returns>
        [StepDefinition(@"the text should contain ""<Symbol>""")]
        public void TheTextShouldContainSymbol(Table table)
        {
			string str = WebTestContext.Storage[RaveSteps.TripReports] as string;
			Assert.IsFalse(String.IsNullOrEmpty(str));
            string noWhitespacePDFtext = Regex.Replace(str, @"\s", "");

            if (CreateSymbolsTable(table).Any(s => !noWhitespacePDFtext.Contains(Regex.Replace(s, @"\s", ""))))
                Assert.Fail();
        }

        /// <summary>
        /// Create the symbols table using the passed in table from the feature file
        /// </summary>
        /// <param name="table">Table from the feature file</param>
        /// <returns>All the strings in the symbol table</returns>
        private List<String> CreateSymbolsTable(Table table)
        {
            List<String> symbols = new List<string>();

            foreach (TableRow tableRow in table.Rows)
            {
                string value = tableRow["Symbol"];
                symbols.Add(value);
            }

            return symbols;
        }

        /// <summary>
        /// This step copies the query string field value pair from the Url to be used later
        /// </summary>
        /// <param name="table"></param>
        [StepDefinition(@"I copy the following fields from query string in current url")]
        public void ICopyTheFollowingFieldsFromQueryStringInUrl(Table table)
        {
            IEnumerable<GenericDataModel<string>> queryNames = table.CreateSet<GenericDataModel<string>>();

            foreach (GenericDataModel<string> queryName in queryNames)
                CurrentPage.As<RavePageBase>().StoreQueryString(queryName.Data);
        }

        /// <summary>
        /// This step changes the current url with specified page and uses the fields specified in the table
        /// to retrieve the stored values corresponding to those field followed by append them to the existing 
        /// query string of the Url.
        /// </summary>
        /// <param name="page"></param>
        /// <param name="table"></param>
        [StepDefinition(@"I replace current page with ""([^""]*)"" and append following copied fields to query string")]
        public void IReplaceCurrentPageWithAndAppendFollowingCopiedFieldsToQueryString(string page, Table table)
        {
            IEnumerable<GenericDataModel<string>> queryNames = table.CreateSet<GenericDataModel<string>>();
            List<string> qNames = queryNames.Select((p) => p.Data).ToList();
            CurrentPage.As<RavePageBase>().ModifyUrl(page, qNames);
        }
	}
}
