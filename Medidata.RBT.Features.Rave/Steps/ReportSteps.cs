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
        [When(@"I run Report ""([^""]*)"" on Study ""([^""]*)""")]
        public void WhenIRunReportTargetedSDVSubjectManagementOnStudyMediflex(string reportName, Table reportParameters)
        {
           CurrentPage = CurrentPage.As<ReportsPage>().SelectReport(reportName);
        }
	}
}
