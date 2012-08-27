using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Medidata.RBT.Features;
using TechTalk.SpecFlow;
using Medidata.RBT.PageObjects;
using Medidata.RBT.PageObjects.Rave;
using Medidata.RBT.PageObjects.Rave.PDF;
using System.IO;

using System.Data;
using System.Collections.Specialized;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using TechTalk.SpecFlow.Assist;
using System.Threading;

namespace Medidata.RBT.Features.Rave
{

	[Binding]
	public class PDFSteps : BrowserStepsBase
	{
        [StepDefinition(@"I create Data PDF")]
        public void ICreateDataPDF(Table table)
        {
            PDFCreationModel args = table.CreateInstance<PDFCreationModel>();
            args.Name = SpecialStringHelper.Replace(args.Name);
            CurrentPage = CurrentPage.As<FileRequestPage>().CreateDataPDF(args);
        }

        [StepDefinition(@"I create Blank PDF")]
        public void ICreateBlankPDF(Table table)
        {
            PDFCreationModel args = table.CreateInstance<PDFCreationModel>();
            args.Name = SpecialStringHelper.Replace(args.Name);
            CurrentPage = CurrentPage.As<FileRequestPage>().CreateBlankPDF(args);
        }

        [StepDefinition(@"I generate Blank PDF ""([^""]*)""")]
		[StepDefinition(@"I generate Data PDF ""([^""]*)""")]
		public void IGeneratePDF(string pdfName)
		{
            PDFSpecific pdf = new PDFSpecific(SpecialStringHelper.Replace(pdfName));
            CurrentPage = CurrentPage.As<FileRequestPage>().Generate(pdf);
            pdf.MarkForDeletion();
		}

		[StepDefinition(@"I wait for PDF ""([^""]*)"" to complete")]
		public void GivenIWaitForPDF____ToComplete(string pdfName)
		{
			CurrentPage.As<FileRequestPage>().WaitForPDFComplete(SpecialStringHelper.Replace(pdfName));
		}

		[StepDefinition(@"I View Data PDF ""([^""]*)""")]
        [StepDefinition(@"I View Blank PDF ""([^""]*)""")]
        [StepDefinition(@"I View PDF ""([^""]*)""")]
		public void WhenIViewDataPDF____(string pdfName)
		{
			CurrentPage.As<FileRequestPage>().ViewPDF(SpecialStringHelper.Replace(pdfName));
		}

		[StepDefinition(@"I should see ""Query Data"" in Audits")]
		public void ThenIShouldSeeQueryDataInAudits()
		{
			ScenarioContext.Current.Pending();
		}
	}
}
