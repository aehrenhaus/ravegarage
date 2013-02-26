﻿using TechTalk.SpecFlow;
using Medidata.RBT.PageObjects.Rave;
using TechTalk.SpecFlow.Assist;
using Medidata.RBT.PageObjects.Rave.SharedRaveObjects;
using System.Collections.Generic;
using Medidata.RBT.Utilities;
using Microsoft.VisualStudio.TestTools.UnitTesting;

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
        /// Temporary step for testing purposes this is used to load a pdf from a location, but generate pdf should call the load code instead.
        /// </summary>
        /// <param name="pdfLocation">The location of the pdf file on the computer</param>
        [StepDefinition(@"I load PDF at location ""([^""]*)""")]
        public void ILoadPdfAtLocation____(string pdfLocation)
        {
            PDFManagement.LoadDocumentFromLocation(WebTestContext, pdfLocation);
        }

        /// <summary>
        /// Verify that bookmarks don't exist in the bookmark tree
        /// </summary>
        /// <param name="bookmarkText">The text of the bookmarks to verify</param>
        [StepDefinition(@"I verify PDF bookmarks don't exist")]
        public void ThenIVerifyPDFBookmarksDontContain(Table bookmarkText)
        {
            Assert.IsTrue(PDFManagement.VerifyBookmarks(WebTestContext, bookmarkText, false));
        }

        /// <summary>
        /// Verify that bookmarks exist in the bookmark tree
        /// </summary>
        /// <param name="bookmarkText">The text of the bookmarks to verify</param>
        [StepDefinition(@"I verify PDF bookmarks exist")]
        public void IVerifyPDFBookmarksContain(Table bookmarkText)
        {
            Assert.IsTrue(PDFManagement.VerifyBookmarks(WebTestContext, bookmarkText, true));
        }

        /// <summary>
        /// Verify that bookmarks exist in the bookmark tree under a parent bookmark
        /// </summary>
        /// <param name="parentBookmark">The text of the parent bookmark</param>
        /// <param name="bookmarkText">The text of the bookmarks to verify</param>
        [StepDefinition(@"I verify PDF bookmarks exist under bookmark ""([^""]*)""")]
        public void IVerifyPDFBookmarksContainUnderBookmark____(string parentBookmark, Table bookmarkText)
        {
            Assert.IsTrue(PDFManagement.VerifyBookmarks(WebTestContext, bookmarkText, true, parentBookmark));
        }

        /// <summary>
        /// Verify that a link on one page goes to another page
        /// </summary>
        /// <param name="linkText">The text of the link</param>
        /// <param name="linkSourcePageNumber">The page number of the source page</param>
        /// <param name="linkDestinationPageNumber">The page number of the target page</param>
        [StepDefinition(@"I verify link ""(.*)"" on page ""(.*)"" goes to page ""(.*)""")]
        public void ThenIVerifyLinkOnPageGoesToPage(string linkText, int linkSourcePageNumber, int linkDestinationPageNumber)
        {
            Assert.IsTrue(PDFManagement.VerifyLinkGoesToPage(WebTestContext, linkText, linkSourcePageNumber, linkDestinationPageNumber));
        }

        /// <summary>
        /// Verify properties on a pdf level
        /// </summary>
        /// <param name="propertiesToVerify">The properties on the pdf to verify</param>
        [StepDefinition(@"I verify PDF properties")]
        public void IVerifyPDFProperties(Table propertiesToVerify)
        {
            PDFParseModel args = propertiesToVerify.CreateInstance<PDFParseModel>();
            string errorMessage = PDFManagement.VerifyPDFProperties(WebTestContext,
                args.Study,
                args.Locale,
                args.SitesGroupsAndSites,
                args.SubjectInitials,
                args.PageSize);
            Assert.IsNull(errorMessage, errorMessage);
        }

        /// <summary>
        /// Verify properties on a page level
        /// </summary>
        /// <param name="targetPageNumber">The page number of the page to verify properties on</param>
        /// <param name="propertiesToVerify">The properties on the page to verify</param>
        [StepDefinition(@"I verify PDF properties on page ""(.*)""")]
        public void ThenIVerifyFormattingProperties(int targetPageNumber, Table propertiesToVerify)
        {
            PDFFormattingModel args = propertiesToVerify.CreateInstance<PDFFormattingModel>();

            string errorMessage = PDFManagement.VerifyPageProperties(
                WebTestContext,
                targetPageNumber,
                args.Font,
                args.FontSize,
                args.TopMargin,
                args.BottomMargin,
                args.LeftMargin,
                args.RightMargin,
                args.PageNumber
                );
            Assert.IsNull(errorMessage, errorMessage);
        }
	}
}
