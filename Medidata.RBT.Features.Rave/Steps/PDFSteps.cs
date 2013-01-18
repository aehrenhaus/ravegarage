using TechTalk.SpecFlow;
using Medidata.RBT.PageObjects.Rave;
using TechTalk.SpecFlow.Assist;
using Medidata.RBT.PageObjects.Rave.SharedRaveObjects;
using System.Collections.Generic;

namespace Medidata.RBT.Features.Rave
{
    /// <summary>
    /// Steps pertaining to PDFs 
    /// </summary>
	[Binding]
	public class PDFSteps : BrowserStepsBase
	{
        /// <summary>
        /// Create a data PDF with the passed in information
        /// </summary>
        /// <param name="table">The configuration for the data PDF</param>
        [StepDefinition(@"I create Data PDF")]
        public void ICreateDataPDF(Table table)
        {
            PDFCreationModel args = table.CreateInstance<PDFCreationModel>();
            args.Name = SpecialStringHelper.Replace(args.Name);
            CurrentPage = CurrentPage.As<FileRequestPage>().CreateDataPDF(args);
        }

        /// <summary>
        /// Create a blank PDF with the passed in information
        /// </summary>
        /// <param name="table">The configuration for the blank PDF</param>
        [StepDefinition(@"I create Blank PDF")]
        public void ICreateBlankPDF(Table table)
        {
            PDFCreationModel args = table.CreateInstance<PDFCreationModel>();
            args.Name = SpecialStringHelper.Replace(args.Name);
            CurrentPage = CurrentPage.As<FileRequestPage>().CreateBlankPDF(args);
        }

        /// <summary>
        /// Generate a blank or data pdf
        /// </summary>
        /// <param name="pdfName">The name of the PDF to generate</param>
        [StepDefinition(@"I generate Blank PDF ""([^""]*)""")]
		[StepDefinition(@"I generate Data PDF ""([^""]*)""")]
		public void IGeneratePDF(string pdfName)
		{
            CurrentPage = CurrentPage.As<FileRequestPage>().Generate(pdfName);
		}

        /// <summary>
        /// Wait for the generated PDF to complete
        /// </summary>
        /// <param name="pdfName">The name of the PDF to wait for</param>
		[StepDefinition(@"I wait for PDF ""([^""]*)"" to complete")]
		public void IWaitForPDF____ToComplete(string pdfName)
		{
			CurrentPage.As<FileRequestPage>().WaitForPDFComplete(SpecialStringHelper.Replace(pdfName));
		}

        /// <summary>
        /// View the pdf
        /// </summary>
        /// <param name="pdfName">Name of the PDF to view</param>
		[StepDefinition(@"I View Data PDF ""([^""]*)""")]
        [StepDefinition(@"I View Blank PDF ""([^""]*)""")]
        [StepDefinition(@"I View PDF ""([^""]*)""")]
		public void IViewDataPDF____(string pdfName)
		{
			CurrentPage.As<FileRequestPage>().ViewPDF(SpecialStringHelper.Replace(pdfName));
		}

        /// <summary>
        /// Step definition to create the specified pdf configuration if it doesn't exist
        /// </summary>
        /// <param name="table"></param>
        [StepDefinition(@"following PDF Configuration Profile Settings exist")]
        public void FollowingPDFConfigurationProfileSettingsExist(Table table)
        {
            IEnumerable<PdfProfileModel> pdfProfileList = table.CreateSet<PdfProfileModel>();

            foreach (PdfProfileModel ppModel in pdfProfileList)
            {
                SeedingContext.GetExistingFeatureObjectOrMakeNew(ppModel.ProfileName, () => new PdfProfile(ppModel.ProfileName));
            }
        }

        /// <summary>
        /// Step definition to edit pdf file requrest
        /// </summary>
        [StepDefinition(@"I click edit datapdf ""([^""]*)""")]
        public void IClickEditDatapdfDataPDF____(string pdfName)
        {
            pdfName = SpecialStringHelper.Replace(pdfName);
            CurrentPage = CurrentPage.As<FileRequestPage>().EditPdf(pdfName);
        }

        /// <summary>
        /// Step definition to expand Display multiple log lines per page
        /// </summary>
        [StepDefinition(@"I expand Display multiple log lines per page")]
        public void IExpandDisplayMultipleLogLinesPerPage()
        {
            CurrentPage.As<FileRequestPage>().ExpandDisplayMultipleLogLines();
        }
	}
}
