using TechTalk.SpecFlow;
using Medidata.RBT.PageObjects.Rave;
using TechTalk.SpecFlow.Assist;
using Medidata.RBT.PageObjects.Rave.SharedRaveObjects;
using System.Collections.Generic;
using Medidata.RBT.Utilities;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using System;
using System.Linq;
using System.Text.RegularExpressions;
using Medidata.RBT.PageObjects.Rave.PDF;
using Medidata.RBT.PageObjects.Rave.TableModels;
using Medidata.RBT.PageObjects.Rave.TableModels.PDF;
using Medidata.RBT.GenericModels;

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
            args.Subjects = SpecialStringHelper.Replace(args.Subjects);
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
        /// View the pdf. 
        /// The filename for a data pdf is the name of the subject with ".pdf".
        /// The filename for a blank pdf is the matrix used with ".pdf"
        /// </summary>
        /// <param name="pdfName">Name of the PDF to view</param>
        /// <param name="requestName">The pdf request to view</param>
        [StepDefinition(@"I view data PDF ""([^""]*)"" from request ""([^""]*)""")]
        [StepDefinition(@"I view blank PDF ""([^""]*)"" from request ""([^""]*)""")]
		public void IViewPDF____FromRequest____(string pdfName, string requestName)
		{
            CurrentPage.As<FileRequestPage>().ViewPDF(WebTestContext, SpecialStringHelper.Replace(pdfName), SpecialStringHelper.Replace(requestName));
		}

        /// <summary>
        /// Step definition to create the specified pdf configuration if it doesn't exist
        /// </summary>
        /// <param name="table">The PDF configuration profiles to create</param>
        [StepDefinition(@"following PDF Configuration Profile Settings exist")]
        public void FollowingPDFConfigurationProfileSettingsExist(Table table)
        {
            IEnumerable<PdfProfileModel> pdfProfileList = table.CreateSet<PdfProfileModel>();

            foreach (PdfProfileModel ppModel in pdfProfileList)
                SeedingContext.GetExistingFeatureObjectOrMakeNew(ppModel.ProfileName, () => new PdfProfile(ppModel.ProfileName));
        }

        /// <summary>
        /// Additional PDF configuration profile properties that cannot be uploaded.
        /// This should be essentially only images. Please use the PDF profile upload for everything that can be controlled through there
        /// </summary>
        /// <param name="table">The pdf configuration profile properties to update</param>
        [StepDefinition(@"PDF configuration profile has properties")]
        public void PDFConfigurationProfileHasProperties(Table table)
        {
            List<PdfProfileModel> pdfProfiles = table.CreateSet<PdfProfileModel>().ToList();
            foreach (PdfProfileModel pdfProfile in pdfProfiles)
            {
                string pdfProfileUniqueName = SeedingContext.GetExistingFeatureObjectOrMakeNew<PdfProfile>(pdfProfile.ProfileName,
                    () => { throw new Exception("PDF profile is not seeded"); }).UniqueName;

                CurrentPage = new PDFConfigProfilesPage().NavigateToSelf();
                CurrentPage.As<PDFConfigProfilesPage>().EditPdfProfile(pdfProfileUniqueName);
                CurrentPage.As<PDFConfigPage>().EditDocumentProperties(pdfProfile.CoverPageLogo, pdfProfile.HeaderImage);
            }
        }

        /// <summary>
        /// Step definition to edit pdf file requrest
        /// </summary>
        /// <param name="pdfName">Click edit on a datapdf</param>
        [StepDefinition(@"I click edit datapdf ""([^""]*)""")]
        public void IClickEditDatapdf____(string pdfName)
        {
            pdfName = SpecialStringHelper.Replace(pdfName);
            CurrentPage = CurrentPage.As<FileRequestPage>().EditPdf(pdfName);
        }

        /// <summary>
        /// Step for testing purposes. 
        /// This is used to load a pdf from a location, but generate pdf will call this load code in a normal FF.
        /// Only use if you want to load a pdf that you have already and skip the seeding steps while working, remove uses of this before check in. 
        /// </summary>
        /// <param name="pdfLocation">The location of the pdf file on the computer</param>
        [StepDefinition(@"I load PDF at location ""([^""]*)""")]
        public void ILoadPdfAtLocation____(string pdfLocation)
        {
            BasePDFManagement.LoadDocumentFromLocation(WebTestContext, pdfLocation);
        }

        /// <summary>
        /// Step definition to check if a the text stored in the scenario text contains all the listed symbols. Succeeds if it does.
        /// </summary>
        /// <param name="table">The list of characters to look for</param>
        [StepDefinition(@"I verify the PDF text contains")]
        public void IVerifyThePDFTextContains(Table table)
        {
            Assert.IsTrue(BasePDFManagement.Instance.VerifySomethingExist(null, "text", table.CreateSet<GenericDataModel<string>>().ToList().ConvertAll<string>(x => x.Data), pdf: WebTestContext.LastLoadedPDF));
        }

        /// <summary>
        /// Step definition to check if a the text stored in the scenario text contains all the listed symbols. Succeeds if it does.
        /// </summary>
        /// <param name="table">The list of characters to look for</param>
        [StepDefinition(@"I verify the PDF text does not contain")]
        public void IVerifyThePDFTextDoesNotContain(Table table)
        {
            Assert.IsFalse(BasePDFManagement.Instance.VerifySomethingExist(null, "text", table.CreateSet<GenericDataModel<string>>().ToList().ConvertAll<string>(x => x.Data), pdf:WebTestContext.LastLoadedPDF));
        }
        

        /// <summary>
        /// Check the image exists on a given pdf page
        /// </summary>
        /// <param name="imageName">The image to look for</param>
        /// <param name="pageName">The name of the page to search, found through depth first search of the bookmarks</param>
        [StepDefinition(@"I verify image ""(.*)"" exits on PDF page ""(.*)""")]
        public void ThenIVerifyImage____ExitsOnPDFPage____(string imageName, string pageName)
        {
            Assert.IsTrue(
                BasePDFManagement.Instance.VerifySomethingExist(SpecialStringHelper.Replace(pageName), "image", imageName, pdf: WebTestContext.LastLoadedPDF), 
                String.Format("Image {0} not on page {1}.", imageName, pageName));
        }

        /// <summary>
        /// Verify that bookmarks don't exist in the bookmark tree
        /// </summary>
        /// <param name="bookmarkText">The text of the bookmarks to verify</param>
        [StepDefinition(@"I verify PDF bookmarks don't exist")]
        public void ThenIVerifyPDFBookmarksDontContain(Table bookmarkText)
        {
            Assert.IsTrue(BasePDFManagement.Instance.VerifyBookmarks(WebTestContext.LastLoadedPDF, SpecialStringHelper.ReplaceTableColumn(bookmarkText, "Bookmark Text"), false));
        }

        /// <summary>
        /// Verify that bookmarks exist in the bookmark tree
        /// </summary>
        /// <param name="bookmarkText">The text of the bookmarks to verify</param>
        [StepDefinition(@"I verify PDF bookmarks exist")]
        public void IVerifyPDFBookmarksExist(Table bookmarkText)
        {
            Assert.IsTrue(BasePDFManagement.Instance.VerifyBookmarks(WebTestContext.LastLoadedPDF, SpecialStringHelper.ReplaceTableColumn(bookmarkText, "Bookmark Text"), true));
        }

        /// <summary>
        /// Verify that bookmarks exist in the bookmark tree under a parent bookmark.
        /// This will search the children of a bookmark, and the children of those children (basically a depth-first search under a parent node)
        /// </summary>
        /// <param name="parentBookmark">The text of the parent bookmark</param>
        /// <param name="bookmarkText">The text of the bookmarks to verify</param>
        [StepDefinition(@"I verify PDF bookmarks exist somewhere under parent bookmark ""([^""]*)""")]
        public void IVerifyPDFBookmarksExistSomewhereUnderParentBookmark____(string parentBookmark, Table bookmarkText)
        {
            Assert.IsTrue(BasePDFManagement.Instance.VerifyBookmarks(WebTestContext.LastLoadedPDF, SpecialStringHelper.ReplaceTableColumn(bookmarkText, "Bookmark Text"), true, parentBookmark));
        }

        /// <summary>
        /// Verify that bookmarks exist in the bookmark tree under a parent bookmark.
        /// This verifies that the the bookmark is a child of the parent bookmark.
        /// </summary>
        /// <param name="parentBookmark">The text of the parent bookmark</param>
        /// <param name="bookmarkText">The text of the bookmarks to verify</param>
        [StepDefinition(@"I verify PDF bookmarks exist directly under parent bookmark ""([^""]*)""")]
        public void IVerifyPDFBookmarksExistDirectlyUnderParentBookmark____(string parentBookmark, Table bookmarkText)
        {
            Assert.IsTrue(
                BasePDFManagement.Instance.VerifyBookmarks(
                WebTestContext.LastLoadedPDF, 
                SpecialStringHelper.ReplaceTableColumn(bookmarkText, "Bookmark Text"), 
                true, 
                SpecialStringHelper.Replace(parentBookmark),
                true)
                );
        }

        /// <summary>
        /// Verify that bookmarks exist in the bookmark tree under a parent bookmark.
        /// This verifies that the the bookmark is a child of the parent bookmark.
        /// </summary>
        /// <param name="parentBookmark">The text of the parent bookmark</param>
        /// <param name="bookmarkText">The text of the bookmarks to verify</param>
        [StepDefinition(@"I verify PDF bookmarks exist directly under parent bookmark ""([^""]*)"" in the following order")]
        public void IVerifyPDFBookmarksExistDirectlyUnderParentBookmark____InTheFollowingOrder(string parentBookmark, Table bookmarkText)
        {
            Assert.IsTrue(
                BasePDFManagement.Instance.VerifyBookmarks(
                WebTestContext.LastLoadedPDF,
                SpecialStringHelper.ReplaceTableColumn(bookmarkText, "Bookmark Text"),
                true,
                SpecialStringHelper.Replace(parentBookmark),
                true,
                true)
                );
        }

        /// <summary>
        /// Verify that bookmarks don't exist in the bookmark tree under a given bookmark.
        /// </summary>
        /// <param name="bookmarkName">The name of the bookmark to check for children bookmarks</param>
        [StepDefinition(@"I verify PDF bookmarks don't exist under bookmark ""([^""]*)""")]
        public void ThenIVerifyPDFBookmarksDonTExistUnderBookmark____(string bookmarkName)
        {
            Assert.IsTrue(
                BasePDFManagement.Instance.BookmarkHasNoChildren(WebTestContext.LastLoadedPDF, SpecialStringHelper.Replace(bookmarkName))
                );
        }

        /// <summary>
        /// Verify that a link on one page goes to another page
        /// </summary>
        /// <param name="linkText">The text of the link</param>
        /// <param name="linkSourcePage">The page number of the source page</param>
        /// <param name="linkDestinationPage">The page number of the target page</param>
        [StepDefinition(@"I verify link ""(.*)"" on page ""(.*)"" goes to page ""(.*)""")]
        public void ThenIVerifyLink____OnPage____GoesToPage____(string linkText, string linkSourcePage, string linkDestinationPage)
        {
            Assert.IsTrue(BasePDFManagement.Instance.VerifyLinkGoesToPage(WebTestContext.LastLoadedPDF, linkText, linkSourcePage, linkDestinationPage));
        }

        /// <summary>
        /// Verify properties on a pdf level
        /// </summary>
        /// <param name="propertiesToVerify">The properties on the pdf to verify</param>
        [StepDefinition(@"I verify PDF properties")]
        public void IVerifyPDFProperties(Table propertiesToVerify)
        {
            PDFParseModel args = propertiesToVerify.CreateInstance<PDFParseModel>();
            List<string> sites = args.Sites != null ? args.Sites.Split(',').ToList() : new List<string>();
            for(int i = 0; i < sites.Count; i ++)
                sites[i] = SeedingContext.GetExistingFeatureObjectOrMakeNew<Site>(sites[i], () => { throw new Exception("Site is not seeded"); }).UniqueName;


            string errorMessage = PDFManagement.Instance.VerifyPDFProperties(EnhancedPDF.ConvertToEnhancedPDF(WebTestContext.LastLoadedPDF),
                args.Study != null ? SeedingContext.GetExistingFeatureObjectOrMakeNew<Project>(args.Study, null).UniqueName : null,
                args.Locale,
                args.Sites != null ? sites : null,
                args.PageSize);
            Assert.IsNull(errorMessage, errorMessage);
        }

        /// <summary>
        /// Verify properties on a page level
        /// </summary>
        /// <param name="pageName">The page number of the page to verify properties on</param>
        /// <param name="propertiesToVerify">The properties on the page to verify</param>
        [StepDefinition(@"I verify PDF properties on page ""(.*)""")]
        public void ThenIVerifyPDFPropertiesOnPage____(string pageName, Table propertiesToVerify)
        {
            PDFPageParseModel args = propertiesToVerify.CreateInstance<PDFPageParseModel>();

            string errorMessage = PDFManagement.Instance.VerifyPageProperties(
                EnhancedPDF.ConvertToEnhancedPDF(WebTestContext.LastLoadedPDF),
                pageName,
                args.Font,
                args.FontSize,
                args.TopMargin,
                args.BottomMargin,
                args.LeftMargin,
                args.RightMargin,
                args.PageNumber,
                args.GeneratedOn,
                args.Folder,
                args.CRFVersion != null ? SeedingContext.GetExistingFeatureObjectOrMakeNew<CrfVersion>(args.CRFVersion, null).UniqueName : null
                );
            Assert.IsNull(errorMessage, errorMessage);
        }

        /// <summary>
        /// Verify that the text exists with the provided style infomation. 
        /// If no style information is provided, will just verify the text.
        /// </summary>
        /// <param name="pageName">The name of the page the text exists on</param>
        /// <param name="textToVerify">The text and style infomation to verify</param>
        [StepDefinition(@"I verify PDF text on page ""(.*)""")]
        public void ThenIVerifyPDFTextOnPage____(string pageName, Table textToVerify)
        {
            List<PDFTextAndTextStyleModel> stringsToCheck = (List<PDFTextAndTextStyleModel>)textToVerify.CreateSet<PDFTextAndTextStyleModel>();

            foreach (PDFTextAndTextStyleModel stringToCheck in stringsToCheck)
            {
                Assert.IsTrue(BasePDFManagement.Instance.VerifySomethingExist(
                    SpecialStringHelper.Replace(pageName),
                    "text",
                    stringToCheck.Text,
                    pdf: WebTestContext.LastLoadedPDF,
                    bold: stringToCheck.Bold));
            }
        }

        /// <summary>
        /// Verify audit exists on a page
        /// </summary>
        /// <param name="pageName">The page to verify audits on, does depth first search of bookmarks to find correct page</param>
        /// <param name="auditsTable">The table of audits to verify, works the same as the edc audits table</param>
        [StepDefinition(@"I verify PDF Audits exist on page ""(.*)""")]
        public void IVerifyAuditsExistOnPage____(string pageName, Table auditsTable)
        {
            List<AuditModel> audits = (List<AuditModel>)auditsTable.CreateSet<AuditModel>();
            int position = 0;
            EnhancedPDFPage page = PDFManagement.Instance.GetPageFromFirstMatchingBookmark(EnhancedPDF.ConvertToEnhancedPDF(WebTestContext.LastLoadedPDF), pageName);
            foreach (AuditModel audit in audits)
            {
                Assert.IsTrue(PDFManagement.Instance.VerifyAuditExists(
                    page,
                    audit.AuditType,
                    audit.QueryMessage.Split(',').ToList(),
                    audit.Time,
                    audit.User,
                    position), string.Format("Audit {0} does not exist", audit.AuditType));
                position++;
            }
        }

        /// <summary>
        /// Verify the distance between two strings on a PDF page is greater than some value.
        /// </summary>
        /// <param name="xOrYCoodinates">If the distance we are checking is "x" distance, pass in "x". If "y" distance, pass in "y"</param>
        /// <param name="stringToFind1">The first string to find on the page, must be unique to the page</param>
        /// <param name="stringToFind2">The second string to find on the page, must be unique to the page</param>
        /// <param name="pageName">he page to verify audits on, does depth first search of bookmarks to find correct page</param>
        /// <param name="amount">The amount that the distance must be greater than</param>
        [StepDefinition(@"I verify the ""(.*)"" distance between ""(.*)"" and ""(.*)"" on PDF page ""(.*)"" is greater than ""(.*)""")]
        public void ThenIVerifyThe____DistanceBetween____And____OnForm____IsGreaterThan____(string xOrYCoodinates, string stringToFind1, string stringToFind2, string pageName, double amount)
        {
            Assert.IsTrue(BasePDFManagement.Instance.DistanceBetweenText(xOrYCoodinates, stringToFind1, stringToFind2, BasePDFManagement.Instance.GetPageFromFirstMatchingBookmark(WebTestContext.LastLoadedPDF, pageName)) > amount);
        }
	}
}
