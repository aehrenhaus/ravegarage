using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Medidata.RBT.Features;
using TechTalk.SpecFlow;
using Medidata.RBT.PageObjects;
using Medidata.RBT.PageObjects.Rave;
using System.IO;
using Microsoft.Practices.EnterpriseLibrary.Data;
using System.Data;
using System.Collections.Specialized;
using Microsoft.VisualStudio.TestTools.UnitTesting;

namespace Medidata.RBT.Features.Rave
{

	[Binding]
	public class PDFSteps : BrowserStepsBase
	{

		[StepDefinition(@"I create Data PDF")]
		public void ICreateDataPDF(Table table)
		{
			CurrentPage.As<FileRequestPage>().CreateDataPDF(table);
		}

		[StepDefinition(@"I generate Data PDF ""([^""]*)""")]
		public void IGenerateDataPDF(string pdfName)
		{
			ScenarioContext.Current.Pending();
		}

		[StepDefinition(@"I wait for PDF ""([^""]*)"" to complete")]
		public void GivenIWaitForPDF____ToComplete(string pdfName)
		{
			ScenarioContext.Current.Pending();
		}


		[StepDefinition(@"I View Data PDF ""([^""]*)""")]
		public void WhenIViewDataPDF____(string pdfName)
		{
			ScenarioContext.Current.Pending();
		}

		[StepDefinition(@"I should see ""Query Data"" in Audits")]
		public void ThenIShouldSeeQueryDataInAudits()
		{
			ScenarioContext.Current.Pending();
		}


	}
}
