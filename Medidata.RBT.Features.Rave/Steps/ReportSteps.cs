using TechTalk.SpecFlow;
using Medidata.RBT.PageObjects.Rave;
using TechTalk.SpecFlow.Assist;
using System.Collections.Generic;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using System;
using Medidata.RBT.PageObjects.Rave.SeedableObjects;

namespace Medidata.RBT.Features.Rave
{
    /// <summary>
    /// Steps pertaining to reports
    /// </summary>
	[Binding]
	public class ReportSteps : BrowserStepsBase
	{
		/// <summary>
		/// Select report by name on Report page
		/// </summary>
		/// <param name="reportName"></param>
        [StepDefinition(@"I select Report ""([^""]*)""")]
		public void ISelectReport____(string reportName)
		{
			CurrentPage = CurrentPage.As<ReportsPage>().SelectReport(reportName);
		}

		/// <summary>
		/// Set report parameter.
		/// Table can contain 1 or more columns
		/// </summary>
		/// <param name="name"></param>
		/// <param name="table"></param>
        [StepDefinition(@"I set report parameter ""([^""]*)"" with table")]
		public void ISetReportParameter____WithTable(string name, Table table)
		{
            string[] headers = new string[table.Header.Count];
            table.Header.CopyTo(headers, 0);
            Table newTable = new Table(headers);
           
            foreach (TableRow tabRow in table.Rows)
            {
                string studyName = "";
                tabRow.TryGetValue(headers[0], out studyName);
                Project project = SeedingContext.GetExistingFeatureObjectOrMakeNew(studyName, () => new Project(studyName));
                string envName = "";
                tabRow.TryGetValue(headers[1], out envName);
                newTable.AddRow(project.UniqueName, envName);
            }

			SpecialStringHelper.ReplaceTable(newTable);
            CurrentPage.As<PromptsPage>().SetParameter(name, newTable);
		}

		/// <summary>
		/// Set textbox or datetime report parameter
		/// </summary>
		/// <param name="name"></param>
		/// <param name="value"></param>
        [StepDefinition(@"I set report parameter ""([^""]*)"" with ""([^""]*)""")]
		public void ISetReportParameter____With____(string name, string value)
		{
			value = SpecialStringHelper.Replace(value);
			CurrentPage.As<PromptsPage>().SetParameter(name,value);
		}

		/// <summary>
		/// Search from the table report parameter
		/// </summary>
		/// <param name="name"></param>
		/// <param name="value"></param>
		[StepDefinition(@"I search report parameter ""([^""]*)"" with ""([^""]*)""")]
		public void ISearchReportParameter____With_____(string name, string value)
		{
			value = SpecialStringHelper.Replace(value);
			CurrentPage.As<PromptsPage>().SearchInParameter(name, value);
		}

		/// <summary>
		/// 
		/// </summary>
		/// <param name="table"></param>
		[StepDefinition(@"I verify the following URL addresses in the address bar when I click ""Help"" link")]
		public void IVerifyTheFollowingURLAddressesInTheAddressBarWhenIClickHelpLink(Table table)
		{
			var reports = table.CreateSet<ReportListModel>();
			CurrentPage.As<ReportsPage>().VerifyHelpLinks(reports);
		}

		/// <summary>
		/// 
		/// </summary>
		/// <param name="table"></param>
		[StepDefinition(@"I verify the following URL addresses in the address bar when I click ""View Report Help"" link in Prompts page")]
		public void IVerifyTheFollowingURLAddressesInTheAddressBarWhenIClickViewReportHelpLinkInPromptsPage(Table table)
		{
			var reports = table.CreateSet<ReportListModel>();
			CurrentPage.As<ReportsPage>().VerifyHelpLinksInPromptsPage(reports);
		}

        /// <summary>
        /// Verifies that no duplicate records exist
        /// </summary>
        [StepDefinition(@"I verify duplicate records are not displayed")]
        public void IVerifyDuplicateRecordsAreNotDisplayed()
        {
            bool result = CurrentPage.As<CrystalReportPage>().VerifyDuplicateRecordsAreNotDisplayed();
            Assert.IsTrue(result);
        }
	}
}
