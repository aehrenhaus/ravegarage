using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using TechTalk.SpecFlow;
using Medidata.RBT.PageObjects;
using Medidata.RBT.PageObjects.Rave;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Medidata.RBT;

namespace Medidata.RBT.Features.Rave
{
	[Binding]
	public class ReportSteps : BrowserStepsBase
	{


        [StepDefinition(@"I select Report ""([^""]*)""")]
		public void GivenISelectReport____(string reportName)
		{
			CurrentPage = CurrentPage.As<ReportsPage>().SelectReport(reportName);
		}

        [StepDefinition(@"I set report parameter ""([^""]*)"" with table")]
		public void GivenISetReportParameter____WithTable(string name, Table table)
		{
			CurrentPage.As<PromptsPage>().SetParameter(name, table);
		}

        [StepDefinition(@"I set report parameter ""([^""]*)"" with ""([^""]*)""")]
		public void GivenISetReportParameter____With____(string name, string value)
		{
			CurrentPage.As<PromptsPage>().SetParameter(name, value);
		}

	}
}
