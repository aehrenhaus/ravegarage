using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using TechTalk.SpecFlow;
using Medidata.RBT.PageObjects;
using Medidata.RBT.PageObjects.Rave;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Medidata.RBT;
using TechTalk.SpecFlow.Assist;

namespace Medidata.RBT.Features.Rave
{
	[Binding]
	public class ReportSteps : BrowserStepsBase
	{


        [Then(@"I verify text")]
        public void ThenIVerifyText(Table table)
        {
            var args = table.CreateSet<QueryAuditReportSearchModel>();
            //TODO finish logic to parse text.  
        }

		/// <summary>
		/// Select report by name on Report page
		/// </summary>
		/// <param name="reportName"></param>
        [StepDefinition(@"I select Report ""([^""]*)""")]
		public void GivenISelectReport____(string reportName)
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
		public void GivenISetReportParameter____WithTable(string name, Table table)
		{
            SpecialStringHelper.ReplaceTableColumn(table, "Name");
			CurrentPage.As<PromptsPage>().SetParameter(name, table);
		}

		/// <summary>
		/// Set textbox or datetime report parameter
		/// </summary>
		/// <param name="name"></param>
		/// <param name="value"></param>
        [StepDefinition(@"I set report parameter ""([^""]*)"" with ""([^""]*)""")]
		public void GivenISetReportParameter____With____(string name, string value)
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
