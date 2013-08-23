using System;
using System.Collections.Generic;
using System.Linq;
using TechTalk.SpecFlow;
using Medidata.RBT.PageObjects.Rave;
using TechTalk.SpecFlow.Assist;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Medidata.RBT.PageObjects.Rave.SeedableObjects;
using System.Text.RegularExpressions;
using Medidata.RBT.Utilities;
using Medidata.RBT.GenericModels;

namespace Medidata.RBT.Features.Rave
{
    /// <summary>
    /// Steps pertaining to all of rave
    /// </summary>
	[Binding]
	public class RaveSteps : BrowserStepsBase
	{
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
