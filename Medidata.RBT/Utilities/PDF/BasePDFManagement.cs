using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;
using O2S.Components.PDF4NET;
using TechTalk.SpecFlow;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using O2S.Components.PDF4NET.Graphics.Fonts;
using O2S.Components.PDF4NET.Text;
using O2S.Components.PDF4NET.Annotations;
using O2S.Components.PDF4NET.Actions;
using Medidata.RBT.SharedObjects;
using O2S.Components.PDF4NET.PDFFile;
using System.Drawing;
using O2S.Components.PDF4NET.Converters;
using System.Text.RegularExpressions;
using Medidata.RBT.GenericModels;
using System.Collections;
using Medidata.RBT.Utilities.PDF;

namespace Medidata.RBT.Utilities
{
    /// <summary>
    /// Helper class to manage pdf operations, these should NOT be rave-specific.
    /// Other pdf operations should be in BasePDFManagement
    /// </summary>
    public sealed class BasePDFManagement : IVerifyObjectExistence
    {
        private static readonly Lazy<BasePDFManagement> m_Instance = new Lazy<BasePDFManagement>(() => new BasePDFManagement());

        private BasePDFManagement() { }

        public static BasePDFManagement Instance
        {
            get
            {
                return m_Instance.Value;
            }
        }

        public const int POINTS_IN_AN_INCH = 72;
        /// <summary>
        /// Find the x or y distance between two strings
        /// </summary>
        /// <param name="xOrYCoodinates">If the distance you want to find is an "x" distance pass in "x". If "y" distance pass "y"</param>
        /// <param name="stringToFind1">The first string to compare</param>
        /// <param name="stringToFind2">The second string to compare</param>
        /// <param name="page">The page on which to search for the strings</param>
        /// <returns>The distance between the two strings on either the "x" or "y" plane</returns>
        public double DistanceBetweenText(string xOrYCoodinates, string stringToFind1, string stringToFind2, BaseEnhancedPDFPage page)
        {
            BaseEnhancedPDFSearchTextResult searchTextResult1 = FirstEnhancedPDFSearchTextResult(page.BasePage, stringToFind1);
            BaseEnhancedPDFSearchTextResult searchTextResult2 = FirstEnhancedPDFSearchTextResult(page.BasePage, stringToFind2);

            if(xOrYCoodinates.Equals("x", StringComparison.InvariantCultureIgnoreCase))
            {
                double right1Left2 = (searchTextResult1.DisplayBounds.Left + searchTextResult1.DisplayBounds.Width - searchTextResult2.DisplayBounds.Left) / BasePDFManagement.POINTS_IN_AN_INCH;
                double right2Left1 = (searchTextResult2.DisplayBounds.Left + searchTextResult2.DisplayBounds.Width - searchTextResult1.DisplayBounds.Left) / BasePDFManagement.POINTS_IN_AN_INCH;
                return Math.Max(right1Left2, right2Left1);
            }
            else if (xOrYCoodinates.Equals("y", StringComparison.InvariantCultureIgnoreCase))
            {
                double bottom1Top2 = (searchTextResult1.DisplayBounds.Top - searchTextResult1.DisplayBounds.Height - searchTextResult2.DisplayBounds.Top) / BasePDFManagement.POINTS_IN_AN_INCH;
                double bottom2Top1 = (searchTextResult2.DisplayBounds.Top - searchTextResult2.DisplayBounds.Height - searchTextResult1.DisplayBounds.Top) / BasePDFManagement.POINTS_IN_AN_INCH;
                return Math.Max(bottom1Top2, bottom2Top1);
            }
            throw new Exception("Coordinate system incorrectly specified");
        }

        /// <summary>
        /// Returns the first BaseEnhancedPDFSearchTextResult where there is only 1 search result.
        /// </summary>
        /// <param name="page">The page to search for the string</param>
        /// <param name="stringToFind">The string to search for</param>
        /// <returns>The first BaseEnhancedPDFSearchTextResult when searching for the string</returns>
        public BaseEnhancedPDFSearchTextResult FirstEnhancedPDFSearchTextResult(PDFImportedPage page, string stringToFind)
        {
            List<BaseEnhancedPDFSearchTextResult> pdfSearchTextResults = page.SearchText(stringToFind).ToList().ConvertAll(x => new BaseEnhancedPDFSearchTextResult(x));
            if (pdfSearchTextResults == null)
                throw new Exception(stringToFind + " is not found on the page");
            if (pdfSearchTextResults.Count > 1)
                throw new Exception(stringToFind + " is found more than once on the page");

            return pdfSearchTextResults.FirstOrDefault();
        }

        /// <summary>
        /// Load a pdf from a file location into memory for manipulation
        /// </summary>
        /// <param name="webTestContext">The current WebTestContext</param>
        /// <param name="fileLocation">The location of the pdf</param>
        public static void LoadDocumentFromLocation(WebTestContext webTestContext, string fileLocation)
        {
            using (FileStream fileIn = new FileStream(fileLocation, FileMode.Open, FileAccess.Read))
            {
                webTestContext.LastLoadedPDF = new RBT.BaseEnhancedPDF(Path.GetFileName(fileIn.Name), fileLocation, fileIn);
            }
        }

        /// <summary>
        /// Verify properties that exist on the pageSize
        /// </summary>
        /// <param name="pdf">The current BaseEnhancedPDF</param>
        /// <param name="pageSize">The expected pageSize</param>
        /// <returns>An error message if something doesn't match the expected value, null if there is no issues</returns>
        public string VerifyPDFProperties(
            RBT.BaseEnhancedPDF pdf,
            string pageSize
            )
        {
            if (pageSize != null && !pdf.BaseDocument.PageSize.Equals((PDFPageSize)Enum.Parse(typeof(PDFPageSize), pageSize, true)))
                return "Page size doesn't match pdf";
            else
                return null;
        }

        /// <summary>
        /// Verify the position or existance of bookmarks in the bookmark tree
        /// </summary>
        /// <param name="webTestContext">The current web test context</param>
        /// <param name="table">The table of bookmarks to verify</param>
        /// <param name="shouldContainBookmarks">Where the bookmark tree should or should not contain the bookmarks</param>
        /// <param name="parentBookmark">The optional parent bookmark. 
        /// If this has a value the bookmarks in the table must exist somewhere as a child, child of a child, etc. 
        /// Basically somewhere in the depth first search underneath the parent bookmark.</param>
        /// <param name="directChild">If true, the bookmark in the table must be a child of the parent bookmark. Cannot be a grandchild or more.</param>
        /// <returns></returns>
        public bool VerifyBookmarks(
            RBT.BaseEnhancedPDF pdf,
            Table table, 
            bool shouldContainBookmarks,
            string parentBookmark = null, 
            bool directChild = false,
            bool inOrder = false)
        {
            for (int i = 0; i < table.RowCount; i++)
            {
                TableRow tr = table.Rows[i];
                string bookmarkText = tr[0];

                if (shouldContainBookmarks && pdf.FirstMatchingBookmarkNodeInBookmarkCollection(
                    bookmarkText, 
                    parentBookmark, 
                    directChild, 
                    inOrder ? i : (int?)null)
                    == null)
                    return false;
                if (!shouldContainBookmarks && pdf.FirstMatchingBookmarkNodeInBookmarkCollection(
                    bookmarkText, 
                    parentBookmark,
                    directChild,
                    inOrder ? i : (int?)null)
                    != null)
                    return false;
            }
            return true;
        }

        public bool VerifyObjectExistence(
            string areaIdentifier, 
            string type, 
            string identifier, 
            bool exactMatch = false, 
            int? amountOfTimes = null, 
            RBT.BaseEnhancedPDF pdf = null,
            bool? bold = null,
            bool shouldExist = true
            )
        {
            if (type.Equals("image", StringComparison.InvariantCultureIgnoreCase))
                return VerifyImageExists(pdf, identifier, areaIdentifier);
            if (type.Equals("text", StringComparison.InvariantCultureIgnoreCase))
                return VerifyPDFText(pdf, identifier, shouldExist, areaIdentifier, bold) == null;

            throw new Exception("Unknown verification type");
        }

        public bool VerifyObjectExistence(
            string areaIdentifier, 
            string type, 
            List<string> identifiers, 
            bool exactMatch = false, 
            int? amountOfTimes = null, 
            RBT.BaseEnhancedPDF pdf = null, 
            bool? bold = null,
            bool shouldExist = true
            )
        {
            if (type.Equals("text", StringComparison.InvariantCultureIgnoreCase))
                return VerifyPDFText(pdf, identifiers, shouldExist, areaIdentifier) == null;

            throw new Exception("Unknown verification type");
        }

        /// <summary>
        /// Verify that an image exists in a page in the pdf
        /// </summary>
        /// <param name="pdf">The pdf to check</param>
        /// <param name="imageName">The name of the image, should be in the Images folder</param>
        /// <param name="pageName">The name of the page to look in</param>
        /// <returns>True if the image exists on the page, false if it does not</returns>
        private bool VerifyImageExists(RBT.BaseEnhancedPDF pdf, string imageName, string pageName)
        {
            Image imageInImageFolder = null;
            using (FileStream fs = new FileStream(RBTConfiguration.Default.UploadPath + @"\Images\" + imageName, FileMode.Open))
            {
                imageInImageFolder = Image.FromStream(fs);
            }

            bool matchFound = false;

            //extract bitmaps
            Bitmap[] bitmaps = ExtractPageBitmaps(pdf, pageName, 10);

            foreach (Bitmap bitmap in bitmaps)
            {
                Console.WriteLine(string.Format("-> Size --> Actual: {0} --> Expected: {1}", 
                    bitmap.Size, imageInImageFolder.Size));
                if (bitmap.Size != imageInImageFolder.Size) 
                    continue;

                Console.WriteLine(string.Format("-> FrameDimensionsList --> Actual: {0} --> Expected: {1}", 
                    bitmap.FrameDimensionsList.FirstOrDefault(), imageInImageFolder.FrameDimensionsList.FirstOrDefault()));
                if (bitmap.FrameDimensionsList.FirstOrDefault() != imageInImageFolder.FrameDimensionsList.FirstOrDefault())
                    continue;

                Console.WriteLine(string.Format("-> Palette.Flags --> Actual: {0} --> Expected: {1}", 
                    bitmap.Palette.Flags, imageInImageFolder.Palette.Flags));
                if (bitmap.Palette.Flags != imageInImageFolder.Palette.Flags)
                    continue;

                Console.WriteLine(string.Format("-> PixelFormat --> Actual: {0} --> Expected: {1}", 
                    bitmap.PixelFormat, imageInImageFolder.PixelFormat));
                if (bitmap.PixelFormat != imageInImageFolder.PixelFormat) 
                    continue;

                Console.WriteLine(string.Format("-> RawFormat.Guid --> Actual: {0} --> Expected: {1}", 
                    bitmap.RawFormat.Guid, imageInImageFolder.RawFormat.Guid));
                if (bitmap.RawFormat.Guid != imageInImageFolder.RawFormat.Guid)
                    continue;
                
                matchFound = true;
                break;
            }

            return matchFound;
        }

        /// <summary>
        /// Method the extract the bitmaps from specified pdf and a specified page
        /// </summary>
        /// <param name="pdf">pdf object to extract bitmaps from</param>
        /// <param name="pageName">name of the page on the pdf to check for bitmaps</param>
        /// <param name="timeoutSeconds">if retries are required then timeout in seconds should be specified, default is no timeout</param>
        /// <returns></returns>
        public Bitmap[] ExtractPageBitmaps(RBT.BaseEnhancedPDF pdf, string pageName, int timeoutSeconds = 0)
        {
            return ExtractGenericObject<Bitmap[]>(() =>
            {
                BaseEnhancedPDFPage page = GetPageFromFirstMatchingBookmark(pdf, pageName);
                return page.BasePage.ExtractImages();
            }, timeoutSeconds);
        }

        /// <summary>
        /// This generic method can be used to extract ICollections with re-attempts when returned 
        /// collection from extraction logic is null or has count 0
        /// </summary>
        /// <typeparam name="T1">Any type that inherits from ICollection</typeparam>
        /// <param name="extractor">Delegate to method with logic to extractor type T1</param>
        /// <param name="timeoutSeconds">Optional parameter to indicate how much time to try extracting, default is 10 seconds</param>
        /// <returns>returns the extracted type derived from ICollection</returns>
        private T1 ExtractGenericObject<T1>(Func<T1> extractor, int timeoutSeconds = 10) where T1 : ICollection
        {
            T1 result;

            for (result = extractor(); (result == null || result.Count < 1) && timeoutSeconds > 0; timeoutSeconds--)
            {
                System.Threading.Thread.Sleep(1000);
                result = extractor();
            }
            
            return result;
        }

        /// <summary>
        /// True if the bookmark has no child bookmarks, false if it has child bookmarks
        /// </summary>
        /// <param name="pdf">The pdf to search</param>
        /// <param name="bookmarkText">The bookmark to check its child bookmarks</param>
        /// <returns>True if the bookmark has no child bookmarks, false if it has child bookmarks</returns>
        public bool BookmarkHasNoChildren(RBT.BaseEnhancedPDF pdf, string bookmarkText)
        {
            PDFBookmarkCollection pdfBookmarkCollection = pdf.FirstMatchingBookmarkNodeInBookmarkCollection(bookmarkText).Bookmarks;
            return (pdfBookmarkCollection == null || pdfBookmarkCollection.Count == 0);
        }

        /// <summary>
        /// Verify that a link on one page goes to another page
        /// </summary>
        /// <param name="pdf">The pdf to verify the link on</param>
        /// <param name="linkText">The text of the link</param>
        /// <param name="linkSourcePage">The page the link is on</param>
        /// <param name="linkTargetPage">The page the link goes to</param>
        /// <returns>True if it goes to the target page, false if it does not</returns>
        public bool VerifyLinkGoesToPage(RBT.BaseEnhancedPDF pdf, string linkText, string linkSourcePage, string linkTargetPage)
        {
            BaseEnhancedPDFPage sourcePage = GetPageFromFirstMatchingBookmark(pdf, linkSourcePage);

            //Find text matching the passed in text on page source bookmark goes to
            PDFSearchTextResultCollection linksWithTextThatMatchPassedInLinkTextOnSourcePage = sourcePage.BasePage.SearchText(linkText);

            //Find targets of all the links on the source page
            List<PDFLinkAnnotation> linksOnSourcePage = sourcePage.BasePage.Annotations.ToList().ConvertAll(x => (PDFLinkAnnotation)x);

            //See if any of those links go to the linkTargetPage
            BaseEnhancedPDFPage targetPage = GetPageFromFirstMatchingBookmark(pdf, linkTargetPage);

            List<PDFLinkAnnotation> linksWhichGoToTheTargetPage = new List<PDFLinkAnnotation>();
            foreach (PDFLinkAnnotation link in linksOnSourcePage)
                if (targetPage.BasePage.Equals((PDFImportedPage)((PDFGoToAction)link.Action).Destination.Page))
                    linksWhichGoToTheTargetPage.Add(link);

            //See if any of the links that go to the link target page overlap the area of the linkText

            foreach (PDFLinkAnnotation linkOnSourcePage in linksWhichGoToTheTargetPage)
                foreach (PDFSearchTextResult linkTextMatch in linksWithTextThatMatchPassedInLinkTextOnSourcePage)
                    foreach(PDFTextRun pdfTextRun in linkTextMatch.TextRuns)
                        if (AreasOverlap(linkOnSourcePage.PDFRectangle, pdfTextRun.PDFBounds))
                            return true;

            return false;
        }

        /// <summary>
        /// Gets the page matching the first bookmark after a depth-first search of the bookmark tree
        /// </summary>
        /// <param name="pdf">The pdf to search</param>
        /// <param name="bookmarkText">The text of the bookmark in the tree</param>
        /// <returns>The page where the bookmark goes to</returns>
        public BaseEnhancedPDFPage GetPageFromFirstMatchingBookmark(RBT.BaseEnhancedPDF pdf, string bookmarkText)
        {
            PDFBookmark bookmarkMatchingText = pdf.FirstMatchingBookmarkNodeInBookmarkCollection(bookmarkText);
            return new BaseEnhancedPDFPage(((PDFImportedPage)((PDFGoToAction)bookmarkMatchingText.Action).Destination.Page));
        }

        /// <summary>
        /// True if the two rectangles overlap, false if they do not
        /// </summary>
        /// <param name="pdfRectangle1">The first rectangle</param>
        /// <param name="pdfRectangle2">The second rectangle</param>
        /// <returns>True if the two rectangles overlap, false if they do not</returns>
        public bool AreasOverlap(PDFRectangle pdfRectangle1, PDFRectangle pdfRectangle2)
        {
            //Losing precision here in the conversion from double to int be careful!
            DoubleRectangle doubleRectangle1 = new DoubleRectangle(
                pdfRectangle1.LLX,
                pdfRectangle1.LLY,
                pdfRectangle1.Width,
                pdfRectangle1.Height);
            DoubleRectangle doubleRectangle2 = new DoubleRectangle(
                pdfRectangle2.LLX,
                pdfRectangle2.LLY,
                pdfRectangle2.Width,
                pdfRectangle2.Height);
            return Medidata.RBT.Helpers.MathHelper.TwoDoubleRectanglesOverlap(doubleRectangle1, doubleRectangle2);
        }

        /// <summary>
        /// True if the two rectangles overlap, false if they do not
        /// </summary>
        /// <param name="pdfRectangle1">The first rectangle</param>
        /// <param name="pdfRectangle2">The second rectangle</param>
        /// <returns>True if the two rectangles overlap, false if they do not</returns>
        public bool AreasOverlap(DisplayRectangle pdfRectangle1, DisplayRectangle pdfRectangle2)
        {
            //Losing precision here in the conversion from double to int be careful!
            DoubleRectangle doubleRectangle1 = new DoubleRectangle(
                pdfRectangle1.Left,
                pdfRectangle1.Top - pdfRectangle1.Height,
                pdfRectangle1.Width,
                pdfRectangle1.Height);
            DoubleRectangle doubleRectangle2 = new DoubleRectangle(
                pdfRectangle2.Left,
                pdfRectangle2.Top - pdfRectangle1.Height,
                pdfRectangle2.Width,
                pdfRectangle2.Height);
            return Medidata.RBT.Helpers.MathHelper.TwoDoubleRectanglesOverlap(doubleRectangle1, doubleRectangle2);
        }

        /// <summary>
        /// True if the two rectangles overlap, false if they do not
        /// </summary>
        /// <param name="systemRectangle">The first rectangle</param>
        /// <param name="pdfRectangle">The second rectangle</param>
        /// <returns>True if the two rectangles overlap, false if they do not</returns>
        public bool AreasOverlap(System.Drawing.Rectangle systemRectangle, PDFRectangle pdfRectangle)
        {
            //Losing precision here in the conversion from double to int be careful!
            DoubleRectangle linkRectangle = new DoubleRectangle(
                systemRectangle.X,
                systemRectangle.Y,
                systemRectangle.Width,
                systemRectangle.Height);
            DoubleRectangle textRectangle = new DoubleRectangle(
                pdfRectangle.LLX,
                pdfRectangle.LLY,
                pdfRectangle.Width,
                pdfRectangle.Height);
            return Medidata.RBT.Helpers.MathHelper.TwoDoubleRectanglesOverlap(linkRectangle, textRectangle);
        }

        /// <summary>
        /// Verify that a list of strings exist in the pdf text.
        /// </summary>
        /// <param name="pdf">The current pdf</param>
        /// <param name="stringsToSearchFor">The strings to search the pdf text for</param>
        /// <param name="shouldExist">True if the text should exist in the pdf, false if it should not</param>
        /// <param name="pageName">Use when you want to search a specific page, not the entire PDF</param>
        /// <returns>An error message if the any of the strings are not on the page and they should be.
        /// An error message, if the any of the strings are on the page and they should not be.
        /// Null if there are no error messages.</returns>
        private string VerifyPDFText(
            BaseEnhancedPDF pdf, 
            List<string> stringsToSearchFor,
            bool shouldExist, 
            string pageName = null)
        {
            Assert.IsFalse(String.IsNullOrEmpty(pdf.Text));
            string noWhitespacePDFtext = Regex.Replace(pdf.Text, @"\s", "");

            string ret = null;
            foreach (string stringToVerifyGDM in stringsToSearchFor)
            {
                string stringToVerify = Regex.Replace(stringToVerifyGDM, @"\s", "");
                ret = VerifyPDFText(pdf, stringToVerify, shouldExist, pageName);
                if (ret != null)
                    return ret;
            }
            
            return null;
        }

        /// <summary>
        /// Verify that text exists on a page with any passed in style information
        /// </summary>
        /// <param name="pdf">The pdf to use for searching</param>
        /// <param name="text">The text to search for</param>
        /// <param name="shouldExist">True if the text should exist. False if the text should not exist.</param>
        /// <param name="pageName">The name of the page to search for the text on</param>
        /// <param name="bold">The text searched for is bold</param>
        /// <returns>An error message if the text is not on the page. Null if there are no error messages.</returns>
        private string VerifyPDFText(
            RBT.BaseEnhancedPDF pdf,
            string text,
            bool shouldExist,
            string pageName = null,
            bool? bold = null
            )
        {
            PDFSearchTextResultCollection pdfSearchTextResultCollection = null;
            if(pageName != null)
            {
                BaseEnhancedPDFPage page = GetPageFromFirstMatchingBookmark(pdf, pageName);
                pdfSearchTextResultCollection = page.BasePage.SearchText(text);
            }
            if (shouldExist)
            {
                if ((pageName != null && (pdfSearchTextResultCollection == null || pdfSearchTextResultCollection.Count == 0))
                    || (pageName == null && !pdf.Text.Contains(text))
                    )
                    return String.Format("Text {0} not found in pdf and it should be.", text);
            }
            else
            {
                if ((pageName != null && (pdfSearchTextResultCollection != null || pdfSearchTextResultCollection.Count > 0))
                    || (pageName == null && pdf.Text.Contains(text))
                    )
                    return String.Format("Text {0} found in pdf and it should not be.", text);
            }

            if(bold.HasValue)
                return VerifyBoldText(pdfSearchTextResultCollection, text, pageName, bold);

            return null;
        }

        /// <summary>
        /// Verify that font on a page is correctly bold.
        /// </summary>
        /// <param name="pdfSearchTextResultCollection">The pdfSearchTextResultCollection to search through</param>
        /// <param name="text">The text to verify that it is bold</param>
        /// <param name="pageName">The name of the page the text exists on</param>
        /// <param name="bold">True if the text should be bold, false if it should not be.</param>
        /// <returns>An error message if the text is not on the page. Null if there are no error messages.</returns>
        private string VerifyBoldText(
            PDFSearchTextResultCollection pdfSearchTextResultCollection,
            string text,
            string pageName = null, 
            bool? bold = null)
        {
            if (pageName == null)
                return null; //TODO: Add in support for verifying bold text on an entire PDF has not been added yet.

            PDFTextRun ptr = pdfSearchTextResultCollection.FirstOrDefault().TextRuns.FirstOrDefault();

            if ((bold.Value && !ptr.FontName.EndsWith("bold", true, System.Globalization.CultureInfo.InvariantCulture))
                || (!bold.Value && ptr.FontName.EndsWith("bold", true, System.Globalization.CultureInfo.InvariantCulture))
            )
                return String.Format("Text {0} is not bold when it should be bold, or is bold when it should not be", text);

            return null;
        }

        /// <summary>
        /// Verify properties on a pdf page
        /// </summary>
        /// <param name="pdf">The pdf to verify where the page exists</param>
        /// <param name="pageName">The name of the page to verify (gets the page linked by the first bookmark after a depth-first search of a bookmark tree)</param>
        /// <param name="font">Check if a font exists on a page (Must be used in conjuction with fontSize)</param>
        /// <param name="fontSize">Check if a font size exists on a page (Must be used in conjuction with font)</param>
        /// <param name="topMargin">The size of the top margin of the page</param>
        /// <param name="bottomMargin">The size of the bottom margin of the page</param>
        /// <param name="leftMargin">The size of the left margin of the page</param>
        /// <param name="rightMargin">The size of the right margin of the page</param>
        /// <returns>An error message corresponding to the issue with the pdf, or null if there are no errors</returns>
        public string VerifyPageProperties(
            RBT.BaseEnhancedPDF pdf,
            string pageName,
            string font,
            int? fontSize,
            double? topMargin,
            double? bottomMargin,
            double? leftMargin,
            double? rightMargin
            )
        {
            BaseEnhancedPDFPage page = GetPageFromFirstMatchingBookmark(pdf, pageName);

            if (!String.IsNullOrEmpty(font) && fontSize != null && pdf.FontsUsedToFontSize.FirstOrDefault(x => x.Key == font && x.Value == fontSize)
                                .Equals(default(KeyValuePair<PDFFont, double>)))
                return "No font on page matches specified font";
            if (topMargin != null && page.TopMargin != topMargin)
                return "Top margin does not match page top margin";
            if (bottomMargin != null && page.BottomMargin != bottomMargin)
                return "Bottom margin does not match page bottom margin";
            if (leftMargin != null && page.LeftMargin != leftMargin)
                return "Left margin does not match page left margin";
            if (rightMargin != null && page.RightMargin != rightMargin)
                return "Right margin does not match page right margin";

            return null;
        }

        /// <summary>
        /// Get the text from a pdf or pdf page
        /// </summary>
        /// <param name="pdf">The pdf to get the text from</param>
        /// <param name="pageName">The page to get the text from</param>
        /// <returns>The text on the pdf or pdf page if pageName was not null</returns>
        public string GetPDFText(RBT.BaseEnhancedPDF pdf, string pageName = null)
        {
            if (!String.IsNullOrEmpty(pageName))
                return GetPageFromFirstMatchingBookmark(pdf, pageName).Text;

            return pdf.Text;
        }

        /// <summary>
        /// Verify if text exists in a certain area of a page (useful to check the footer)
        /// </summary>
        /// <param name="page">The page to verify</param>
        /// <param name="textToSearchFor">The text to search for</param>
        /// <param name="pdfSearchArea">The area of the page to search</param>
        /// <returns></returns>
        public bool TextExistsInArea(BaseEnhancedPDFPage page, string textToSearchFor, PdfSearchArea pdfSearchArea)
        {
			bool textResultOverlaps = false;
            PDFSearchTextResultCollection matchingTextOnPage = page.BasePage.SearchText(textToSearchFor);
			//NOTE : The above code will assign null to matchingTextOnPage if page.BasePage.SearchText(<input>) yields no results.
			//That will cause an null reference exception - we want to return false.
			if (matchingTextOnPage != null)
				return textResultOverlaps;

            Rectangle? pageArea = null;
			switch (pdfSearchArea)
			{
				case PdfSearchArea.BottomRight:
					pageArea = page.BottomRightOfPage;
					break;
				case PdfSearchArea.BottomLeft:
					pageArea = page.BottomLeftOfPage;
					break;
			}

			if (!pageArea.HasValue)
				return textResultOverlaps;

			foreach (PDFSearchTextResult pdfSearchTextResult in matchingTextOnPage)
			{
				foreach (PDFTextRun textMatch in pdfSearchTextResult.TextRuns)
				{
					if (textResultOverlaps = BasePDFManagement.Instance.AreasOverlap(pageArea.Value, textMatch.PDFBounds))
						break;
				}

				if (textResultOverlaps)
					break;
			}

            return textResultOverlaps;
        }
    }
}
