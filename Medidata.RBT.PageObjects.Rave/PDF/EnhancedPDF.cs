using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using O2S.Components.PDF4NET;
using O2S.Components.PDF4NET.PDFFile;
using TechTalk.SpecFlow;
using OpenQA.Selenium;
using Medidata.RBT.SeleniumExtension;
using System.IO;
using System.Text.RegularExpressions;
using Medidata.RBT.Utilities.PDF;
using O2S.Components.PDF4NET.Actions;
using O2S.Components.PDF4NET.Graphics.Fonts;
using O2S.Components.PDF4NET.Text;

namespace Medidata.RBT
{
    /// <summary>
    /// This is additional PDF functionality to give us functionality beyond the PDF4NET PDF.
    /// All properties methods in here should have something to do with Rave-specific functionality
    ///</summary>
    public class EnhancedPDF : BaseEnhancedPDF
    {
        #region Variables
        private List<EnhancedPDFPage> m_Pages;
        #endregion
        #region Constructors
        public EnhancedPDF()
        {
        }
        #endregion

        public static EnhancedPDF ConvertToEnhancedPDF(BaseEnhancedPDF pdf)
        {
            EnhancedPDF convertedPDF = new EnhancedPDF();
            convertedPDF.Name = pdf.Name;
            convertedPDF.FileLocation = pdf.FileLocation;
            convertedPDF.Text = pdf.Text;
            convertedPDF.BaseDocument = pdf.BaseDocument;

            return convertedPDF;
        }

        #region Properties
        public new List<EnhancedPDFPage> Pages
        {
            get
            {
                if (m_Pages == null)
                    m_Pages = base.Pages.ToList().ConvertAll(x => EnhancedPDFPage.ConvertToEnhancedPDFPage(x));

                return m_Pages;
            }
        }

        public string Study
        {
            get
            {
                string studyString = TitleInfo.FirstOrDefault(x => x.StartsWith("study"));
                return studyString.Substring("study ".Length);
            }
        }

        public string Sites
        {
            get
            {
                Match prodMatch = Regex.Match(Pages[0].Text, @"\(Prod:.*\)");
                return prodMatch.Value.Substring("(Prod: ".Length, prodMatch.Length - "(Prod: ".Length - 1);
            }
        }

        public string SubjectInitials
        {
            get
            {
                PDFBookmark subjectBookmark = FirstMatchingBookmarkNodeInBookmarkCollection("Subject ID");

                PDFImportedPage subjectBookmarkTarget = (PDFImportedPage)(((PDFGoToAction)subjectBookmark.Action).Destination.Page);
                string subjectPageText = subjectBookmarkTarget.ExtractText();
                Match prodMatch = Regex.Match(subjectPageText, @"Subject Initials.*?\r\nSubject");
                return prodMatch.Value.Substring("Subject Initials ".Length, prodMatch.Length - "Subject Initials ".Length - "\r\nSubject".Length);
            }
        }
        #endregion
    }
}
