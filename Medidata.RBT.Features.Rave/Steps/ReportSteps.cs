using TechTalk.SpecFlow;
using Medidata.RBT.PageObjects.Rave;
using TechTalk.SpecFlow.Assist;
using System.Collections.Generic;
using Medidata.RBT.PageObjects.Rave.SharedRaveObjects;

namespace Medidata.RBT.Features.Rave
{
	[Binding]
	public class ReportSteps : BrowserStepsBase
	{


        [StepDefinition(@"I verify text")]
        public void IVerifyText(Table table)
        {
            var args = table.CreateSet<QueryAuditReportSearchModel>();
            //TODO finish logic to parse text.  
        }

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
                Project project = TestContext.GetExistingFeatureObjectOrMakeNew(studyName, () => new Project(studyName));
                string envName = "";
                tabRow.TryGetValue(headers[1], out envName);
                newTable.AddRow(project.UniqueName, envName);
            }

            SpecialStringHelper.ReplaceTableColumn(newTable, "Name");
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

	}
}
