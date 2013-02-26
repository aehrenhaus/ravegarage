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

namespace Medidata.RBT.Utilities
{
    public static class PDFManagement
    {
        public static void LoadDocumentFromLocation(WebTestContext webTestContext, string fileLocation)
        {
            using (FileStream fileIn = new FileStream(fileLocation, FileMode.Open, FileAccess.Read))
            {
                webTestContext.LastLoadedPDF = new RBT.PDF("tempPDF", fileLocation);
            }
        }

        public static string VerifyPDFProperties(
            WebTestContext webTestContext,
            string study,
            string locale,
            string sitesGroupsAndSites,
            string subjectInitials,
            string pageSize
            )
        {
            RBT.PDF pdf = webTestContext.LastLoadedPDF;
            if (!pdf.Study.Equals(study, StringComparison.InvariantCulture))
                return "Study doesn't match pdf";
            if (!pdf.Locale.ToString().Equals(locale, StringComparison.InvariantCulture))
                return "Locale doesn't match pdf";
            if (!pdf.SitesGroupsAndSites.ToString().Equals(sitesGroupsAndSites, StringComparison.InvariantCulture))
                return "Sites groups and sites don't match pdf";
            if (!pdf.SubjectInitials.ToString().Equals(subjectInitials, StringComparison.InvariantCulture))
                return "Subject initials don't match pdf";
            if (pageSize != null && !pdf.PageSize.Equals((PDFPageSize)Enum.Parse(typeof(PDFPageSize), pageSize, true)))
                return "Page size doesn't match pdf";
            else
                return null;
        }

        public static bool VerifyBookmarks(WebTestContext webTestContext, Table table, bool shouldContainBookmarks, string parentBookmark = null)
        {
            for (int i = 0; i < table.RowCount; i++)
            {
                TableRow tr = table.Rows[i];
                string bookmarkText = tr[0];

                if (shouldContainBookmarks && webTestContext.LastLoadedPDF.FirstMatchingBookmarkNodeInBookmarkCollection(bookmarkText, parentBookmark) == null)
                    return false;
                if (!shouldContainBookmarks && webTestContext.LastLoadedPDF.FirstMatchingBookmarkNodeInBookmarkCollection(bookmarkText, parentBookmark) != null)
                    return false;
            }
            return true;
        }

        public static bool VerifyLinkGoesToPage(WebTestContext webTestContext, string linkText, int linkSourcePageNumber, int linkTargetPageNumber)
        {
            RBT.PDF pdf = webTestContext.LastLoadedPDF;
            RBTPage sourcePage = pdf.Pages[linkSourcePageNumber - 1];

            //Find text matching the passed in text on page source bookmark goes to
            PDFSearchTextResultCollection linksWithTextThatMatchPassedInLinkTextOnSourcePage = sourcePage.BasePage.SearchText(linkText);

            //Find targets of all the links on the source page
            List<PDFLinkAnnotation> linksOnSourcePage = sourcePage.BasePage.Annotations.ToList().ConvertAll(x => (PDFLinkAnnotation)x);

            //See if any of those links go to the linkTargetPage
            RBTPage targetPage = pdf.Pages[linkTargetPageNumber - 1];

            List<PDFLinkAnnotation> linksWhichGoToTheTargetPage = new List<PDFLinkAnnotation>();
            foreach (PDFLinkAnnotation link in linksOnSourcePage)
                if (targetPage.Equals(((PDFGoToAction)link.Action).Destination.Page))
                    linksWhichGoToTheTargetPage.Add(link);

            //See if any of the links that go to the link target page overlap the area of the linkText

            foreach (PDFLinkAnnotation linkOnSourcePage in linksWhichGoToTheTargetPage)
                foreach (PDFSearchTextResult linkTextMatch in linksWithTextThatMatchPassedInLinkTextOnSourcePage)
                    foreach(PDFTextRun pdfTextRun in linkTextMatch.TextRuns)
                        if (AreasIntersect(linkOnSourcePage.PDFRectangle, pdfTextRun.PDFBounds))
                            return true;

            return false;
        }

        private static bool AreasIntersect(PDFRectangle pdfRectangle1, PDFRectangle pdfRectangle2)
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
            return Medidata.RBT.Helpers.MathHelper.TwoDoubleRectanglesIntersect(doubleRectangle1, doubleRectangle2);
        }

        private static bool AreasIntersect(System.Drawing.Rectangle systemRectangle, PDFRectangle pdfRectangle)
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
            return Medidata.RBT.Helpers.MathHelper.TwoDoubleRectanglesIntersect(linkRectangle, textRectangle);
        }

        public static string VerifyPageProperties(
            WebTestContext webTestContext,
            int targetPageNumber,
            string font,
            int fontSize,
            double topMargin,
            double bottomMargin,
            double leftMargin,
            double rightMargin,
            string pageNumber
            )
        {
            RBT.PDF pdf = webTestContext.LastLoadedPDF;
            int pageIndex = targetPageNumber - 1;
            RBTPage page = pdf.Pages[pageIndex];

            if (pdf.FontsUsedToFontSize.FirstOrDefault(x => x.Key == font && x.Value == fontSize)
                                .Equals(default(KeyValuePair<PDFFont, double>)))
                return "No font on page matches specified font";
            if (page.TopMargin != topMargin)
                return "Top margin does not match page top margin";
            if (page.BottomMargin != bottomMargin)
                return "Bottom margin does not match page bottom margin";
            if (page.LeftMargin != leftMargin)
                return "Left margin does not match page left margin";
            if (page.RightMargin != rightMargin)
                return "Right margin does not match page right margin";
            if (!VerifyPageNumber(page, pageNumber))
                return "Page number does not exist on the page in the page number area.";

            return null;
        }

        public static bool VerifyPageNumber(RBTPage page, string pageNumber)
        {
            PDFSearchTextResultCollection matchingTextOnPage = page.BasePage.SearchText(pageNumber);
            bool textResultOverlaps = false;
            foreach (PDFSearchTextResult pdfSearchTextResult in matchingTextOnPage)
            {
                foreach (PDFTextRun textMatch in pdfSearchTextResult.TextRuns)
                {
                    if (AreasIntersect(page.PageNumberArea, textMatch.PDFBounds))
                    {
                        textResultOverlaps = true;
                        break;
                    }
                }
            }

            return textResultOverlaps;
        }
    }
}
