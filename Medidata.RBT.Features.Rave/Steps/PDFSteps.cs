using TechTalk.SpecFlow;
using Medidata.RBT.PageObjects.Rave;
using TechTalk.SpecFlow.Assist;
using Medidata.RBT.PageObjects.Rave.SharedRaveObjects;
using System.Collections.Generic;

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
            CurrentPage = CurrentPage.As<FileRequestPage>().Generate(pdfName);
		}

		[StepDefinition(@"I wait for PDF ""([^""]*)"" to complete")]
		public void IWaitForPDF____ToComplete(string pdfName)
		{
			CurrentPage.As<FileRequestPage>().WaitForPDFComplete(SpecialStringHelper.Replace(pdfName));
		}

		[StepDefinition(@"I View Data PDF ""([^""]*)""")]
        [StepDefinition(@"I View Blank PDF ""([^""]*)""")]
        [StepDefinition(@"I View PDF ""([^""]*)""")]
		public void IViewDataPDF____(string pdfName)
		{
			CurrentPage.As<FileRequestPage>().ViewPDF(SpecialStringHelper.Replace(pdfName));
		}

		[StepDefinition(@"I should see ""Query Data"" in Audits")]
		public void IShouldSeeQueryDataInAudits()
		{
			ScenarioContext.Current.Pending();
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
                TestContext.GetExistingFeatureObjectOrMakeNew(ppModel.ProfileName, () => new PdfProfile(ppModel.ProfileName));
            }
        }



	}
}
