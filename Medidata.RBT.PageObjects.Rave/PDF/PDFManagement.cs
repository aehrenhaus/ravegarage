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
using O2S.Components.PDF4NET.Converters;
using System.Drawing;
using Medidata.RBT.PageObjects.Rave.Audits;
using Medidata.RBT.PageObjects.Rave.SharedRaveObjects;
using System.Text.RegularExpressions;

namespace Medidata.RBT.Utilities
{
    /// <summary>
    /// Helper class to manage pdf operations, these should be rave-specific.
    /// Other pdf operations should be in BasePDFManagement
    /// </summary>
    public static class PDFManagement
    {
        /// <summary>
        /// Verify properties on the pdf
        /// </summary>
        /// <param name="pdf">The pdf to verify</param>
        /// <param name="study">The name of the study in the pdf (these can be seen in a pdf by clicking File->Properties)</param>
        /// <param name="locale">The locale (either english/non-english)</param>
        /// <param name="sites">The sites, located on the cover page of the pdf</param>
        /// <param name="pageSize">The default page size for the pdf</param>
        /// <returns>An error message corresponding to the issue with the pdf, or null if there are no errors</returns>
        public static string VerifyPDFProperties(
            RBT.EnhancedPDF pdf,
            string study,
            string locale,
            List<string> sites,
            string pageSize
            )
        {
            if (study != null && !pdf.Study.Equals(study, StringComparison.InvariantCulture))
                return "Study doesn't match pdf";
            if (locale != null && !pdf.Locale.ToString().Equals(locale, StringComparison.InvariantCulture))
                return "Locale doesn't match pdf";
            if (sites != null)
            {
                foreach (string site in sites)
                    if (!pdf.Sites.ToString().Contains(site))
                        return "Sites groups and sites don't match pdf";
            }
            string baseRet = BasePDFManagement.VerifyPDFProperties(pdf, pageSize);
            if (!String.IsNullOrEmpty(baseRet))
                return baseRet;
            else
                return null;
        }

        /// <summary>
        /// Verify the CRF version on the page
        /// </summary>
        /// <param name="page">The page to verify</param>
        /// <param name="crfVersion">The expected CRFVersion</param>
        /// <returns>True if it is matches the expected version and exists in the bottom left of the page, false if not</returns>
        public static bool VerifyCRFVersion(BaseEnhancedPDFPage page, string crfVersion)
        {
            return TextExistsInArea(page, crfVersion, "BottomLeft");
        }

        /// <summary>
        /// Verify the page number on the page
        /// </summary>
        /// <param name="page">The page to verify</param>
        /// <param name="crfVersion">The expected page number</param>
        /// <returns>True if it is matches the expected page number and exists in the bottom right of the page, false if not</returns>
        public static bool VerifyPageNumber(BaseEnhancedPDFPage page, string pageNumber)
        {
            return TextExistsInArea(page, pageNumber, "BottomRight");
        }

        /// <summary>
        /// Verify if text exists in a certain area of a page (useful to check the footer)
        /// </summary>
        /// <param name="page">The page to verify</param>
        /// <param name="textToSearchFor">The text to search for</param>
        /// <param name="areaToSearch">The area of the page to search</param>
        /// <returns></returns>
        public static bool TextExistsInArea(BaseEnhancedPDFPage page, string textToSearchFor, string areaToSearch)
        {
            PDFSearchTextResultCollection matchingTextOnPage = page.BasePage.SearchText(textToSearchFor);
            bool textResultOverlaps = false;

            Rectangle? pageArea = null;
            if (areaToSearch.Equals("BottomRight"))
                pageArea = page.BottomRightOfPage;
            if (areaToSearch.Equals("BottomLeft"))
                pageArea = page.BottomLeftOfPage;

            foreach (PDFSearchTextResult pdfSearchTextResult in matchingTextOnPage)
            {
                foreach (PDFTextRun textMatch in pdfSearchTextResult.TextRuns)
                {
                    if (BasePDFManagement.AreasOverlap(pageArea.Value, textMatch.PDFBounds))
                    {
                        textResultOverlaps = true;
                        break;
                    }
                }
            }

            return textResultOverlaps;
        }
        /// <summary>
        /// Get the first page object that matches the passed in bookmark text. 
        /// Does a depth-first search on the bookmark tree to accomplish that.
        /// </summary>
        /// <param name="pdf">The pdf to look through</param>
        /// <param name="bookmarkText">The text of the bookmark</param>
        /// <returns>The page linked to by the bookmark</returns>
        public static EnhancedPDFPage GetPageFromFirstMatchingBookmark(RBT.EnhancedPDF pdf, string bookmarkText)
        {
            PDFBookmark bookmarkMatchingText = pdf.FirstMatchingBookmarkNodeInBookmarkCollection(bookmarkText);
            return pdf.Pages.FirstOrDefault(x => x.BasePage == ((PDFImportedPage)((PDFGoToAction)bookmarkMatchingText.Action).Destination.Page));
        }

        /// <summary>
        /// Verify audits on a page
        /// </summary>
        /// <param name="page">The page to verify</param>
        /// <param name="auditType">The type of audit</param>
        /// <param name="queryMessage">The message in the audit</param>
        /// <param name="timeFormat">The time format of the audit</param>
        /// <param name="user">The user who made the audit</param>
        /// <param name="position">The position of the audit in the list of audits</param>
        /// <returns></returns>
        public static bool VerifyAuditExists(EnhancedPDFPage page, string auditType, string queryMessage, string timeFormat, string user, int? position)
        {
            string name = user.Split('(').FirstOrDefault().TrimEnd(' ');
            string userLoginNonUnique = user.Split('-')[1].Trim().TrimEnd(')');
            string uniqueName = SeedingContext.GetExistingFeatureObjectOrMakeNew<User>(userLoginNonUnique, null).UniqueName;
            string userRegex = name + @"  \([0-9]* -" + uniqueName + @"\)";

            if (!page.UsersRegex.Contains(userRegex))
                page.UsersRegex.Add(userRegex);
            page.TimeFormat = timeFormat;
            return page.AuditExist(AuditManagement.GetAuditMessage(auditType, queryMessage), userRegex, timeFormat, position);
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
        /// <param name="pageNumber">The number of the bottom right of the page</param>
        /// <param name="generatedOn">When the page was generated on (this information is in the header)</param>
        /// <param name="folder">The folder the form exists in (this information is in the header)</param>
        /// <param name="crfVersion">The crf version (this information is in the footer)</param>
        /// <returns>An error message corresponding to the issue with the pdf, or null if there are no errors</returns>
        public static string VerifyPageProperties(
            RBT.EnhancedPDF pdf,
            string pageName,
            string font,
            int? fontSize,
            double? topMargin,
            double? bottomMargin,
            double? leftMargin,
            double? rightMargin,
            string pageNumber,
            string generatedOn,
            string folder,
            string crfVersion
            )
        {
            EnhancedPDFPage page = GetPageFromFirstMatchingBookmark(pdf, pageName);

            string baseRet = BasePDFManagement.VerifyPageProperties(pdf, pageName, font, fontSize, topMargin, bottomMargin, leftMargin, rightMargin);
            if (!String.IsNullOrEmpty(baseRet))
                return baseRet;
            
            if (!String.IsNullOrEmpty(pageNumber) && !PDFManagement.VerifyPageNumber(page, pageNumber))
                return "Page number does not exist on the page in the page number area.";
            if (generatedOn != null && DateTime.Parse(page.GeneratedOnString).ToString(generatedOn) != page.GeneratedOnString)
                return "Generated on does not exist or does not match format";
            if (folder != null && folder != page.Folder)
                return "Folder does not exist or does not match passed in folder name";
            if (crfVersion != null && !PDFManagement.VerifyCRFVersion(page, crfVersion))
                return "CRF Version does not match page CRF Version";

            return null;
        }
    }
}
