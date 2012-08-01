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

        [StepDefinition(@"I select Report ""([^""]*)""")]
		public void GivenISelectReport____(string reportName)
		{
			CurrentPage = CurrentPage.As<ReportsPage>().SelectReport(reportName);
		}

        [StepDefinition(@"I set report parameter ""([^""]*)"" with table")]
		public void GivenISetReportParameter____WithTable(string name, Table table)
		{
            SpecialStringHelper.ReplaceTableColumn(table, "Name");
			CurrentPage.As<PromptsPage>().SetParameter(name, table);
		}

        [StepDefinition(@"I set report parameter ""([^""]*)"" with ""([^""]*)""")]
		public void GivenISetReportParameter____With____(string name, string value)
		{
			value = SpecialStringHelper.Replace(value);
			CurrentPage.As<PromptsPage>().SetParameter(name,value);
		}

		[StepDefinition(@"I search report parameter ""([^""]*)"" with ""([^""]*)""")]
		public void ISearchReportParameter____With_____(string name, string value)
		{
			value = SpecialStringHelper.Replace(value);
			CurrentPage.As<PromptsPage>().SearchInParameter(name, value);
		}

	}
}
