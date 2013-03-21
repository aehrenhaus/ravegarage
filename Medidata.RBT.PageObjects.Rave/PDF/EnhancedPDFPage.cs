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
using O2S.Components.PDF4NET.Text;
using O2S.Components.PDF4NET.Graphics.Fonts;
using Medidata.RBT.PageObjects.Rave.Audits;
using O2S.Components.PDF4NET.Annotations;
using O2S.Components.PDF4NET.Graphics;
using Medidata.RBT.Helpers;
using Medidata.RBT.PageObjects.Rave.SharedRaveObjects;
using System.Collections.ObjectModel;
using System.Collections.Specialized;
using Medidata.RBT.Utilities;

namespace Medidata.RBT
{
    /// <summary>
    /// Enhances the PDF4Net functionality
    /// This is the correct place for Rave specific pdf functionality
    ///</summary>
    public class EnhancedPDFPage : BaseEnhancedPDFPage, IVerifyAudits
    {
        #region Variables
        private List<PDFAudit> m_Audits;
        private ObservableCollection<string> m_UsersRegex = new ObservableCollection<string>();
        private PDFTextRun m_TimeInAuditBarTextRun;
        private PDFTextRun m_UserInAuditBarTextRun;
        private bool m_AuditUsersChanged = false;
        #endregion
        #region Constructors
        //public EnhancedPDFPage(PDFImportedPage page)
        //    : base(page)
        //{
        //    m_UsersRegex.CollectionChanged += MarkAuditUsersAsChanged;
        //}

        //public EnhancedPDFPage(BaseEnhancedPDFPage page, PDFImportedPage importedPage)
        //    : base(importedPage)
        //{
        //}

        public EnhancedPDFPage()
        {
            m_UsersRegex.CollectionChanged += MarkAuditUsersAsChanged;
        }
        #endregion

        public static EnhancedPDFPage ConvertToEnhancedPDFPage(BaseEnhancedPDFPage pdf)
        {
            EnhancedPDFPage convertedPDFPage = new EnhancedPDFPage();
            convertedPDFPage.BasePage = pdf.BasePage;
            convertedPDFPage.BottomLeftOfPage = pdf.BottomLeftOfPage;
            convertedPDFPage.BottomMargin = pdf.BottomMargin;
            convertedPDFPage.BottomMostGlyph = pdf.BottomMostGlyph;
            convertedPDFPage.BottomRightOfPage = pdf.BottomRightOfPage;
            convertedPDFPage.FontsUsedToFontSize = pdf.FontsUsedToFontSize;
            convertedPDFPage.LeftMargin = pdf.LeftMargin;
            convertedPDFPage.LeftMostGlyph = pdf.LeftMostGlyph;
            convertedPDFPage.RightMargin = pdf.RightMargin;
            convertedPDFPage.RightMostGlyph = pdf.RightMostGlyph;
            convertedPDFPage.Text = pdf.Text;
            convertedPDFPage.TopMargin = pdf.TopMargin;
            convertedPDFPage.TopMostGlyph = pdf.TopMostGlyph;

            return convertedPDFPage;
        }

        /// <summary>
        /// If the audit users have changed this means that we need to reload the audits to look for different audits.
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void MarkAuditUsersAsChanged(object sender, NotifyCollectionChangedEventArgs e)
        {
            m_AuditUsersChanged = true;
        }

        #region Properties
        /// <summary>
        /// Generated on date string version
        /// </summary>
        public string GeneratedOnString
        {
            get
            {
                Match prodMatch = Regex.Match(Text, @"Generated On:.*\r\n");
                return prodMatch.Value.Substring("Generated On: ".Length, prodMatch.Length - "Generated On: ".Length - "\r\n".Length);
            }
        }

        public string TimeFormat {get;set;}
        public ObservableCollection<string> UsersRegex {
            get
            {
                return m_UsersRegex;
            }
            set
            {
                m_UsersRegex = value;
            }
        }

        /// <summary>
        /// This is the words "Time (GMT)" in the audit header it is used to determine the location of the audits.
        /// </summary>
        public PDFTextRun TimeInAuditBarTextRun
        {
            get
            {
                if (m_TimeInAuditBarTextRun == null)
                {
                    PDFSearchTextResultCollection timeInAuditBar = BasePage.SearchText("Time (GMT)");
                    if (timeInAuditBar == null || timeInAuditBar.Count == 0)
                        throw new Exception("There are no audits on the page");
                    PDFTextRunCollection timeInAuditBarTextRun = timeInAuditBar.FirstOrDefault().TextRuns;
                    if (timeInAuditBarTextRun == null || timeInAuditBarTextRun.Count == 0)
                        throw new Exception("There are no audits on the page");

                    m_TimeInAuditBarTextRun = timeInAuditBarTextRun.FirstOrDefault();
                    return m_TimeInAuditBarTextRun;
                }
                else
                {
                    return m_TimeInAuditBarTextRun;
                }
            }
        }

        public PDFTextRun UserInAuditBarTextRun
        {
            get
            {
                if (m_UserInAuditBarTextRun == null)
                {
                    //Next get the user column
                    PDFSearchTextResultCollection auditUserSearchResultsOnPage = BasePage.SearchText("User");
                    List<PDFTextRun> auditUserTextRuns = new List<PDFTextRun>();
                    //Get the word "User" which appears in-line with the Time(GMT) in the auditbar
                    foreach (PDFSearchTextResult auditUserSearchResult in auditUserSearchResultsOnPage)
                        auditUserTextRuns.AddRange(auditUserSearchResult.TextRuns.Where(x => Math.Round(x.DisplayBounds.Top) == Math.Round(TimeInAuditBarTextRun.DisplayBounds.Top)).ToList());

                    if (auditUserTextRuns == null || auditUserTextRuns.Count != 1)
                        throw new Exception("User not in audit bar");

                    m_UserInAuditBarTextRun = auditUserTextRuns.FirstOrDefault();
                    return m_UserInAuditBarTextRun;
                }
                else
                {
                    return m_UserInAuditBarTextRun;
                }
            }
        }

        /// <summary>
        /// All of the audits on a page
        /// </summary>
        public List<PDFAudit> Audits
        {
            get
            {
                if(m_Audits != null && !m_AuditUsersChanged)
                    return m_Audits;

                double leftBoundOfTimeString = TimeInAuditBarTextRun.DisplayBounds.Left;
                List<BaseEnhancedPDFSearchTextResult> timeTextRuns = GetAuditTimeTextRuns(leftBoundOfTimeString);
                List<BaseEnhancedPDFSearchTextResult> userTextRuns = GetAuditUserSearchTextResults(leftBoundOfTimeString);

                //Combine the user with the time to make a list of audits
                List<PDFAudit> audits = new List<PDFAudit>();

                for(int i = 0; i < timeTextRuns.Count; i++)
                {
                    BaseEnhancedPDFSearchTextResult timeTextRun = timeTextRuns[i];
                    BaseEnhancedPDFSearchTextResult nextTimeTextRun = timeTextRuns.Count - 1 != i ? timeTextRuns[i + 1] : null;

                    audits.Add(new PDFAudit()
                    {
                        Time = timeTextRun,
                        User = userTextRuns.FirstOrDefault(x => Math.Round(x.DisplayBounds.Top) == Math.Round(timeTextRun.DisplayBounds.Top)),
                        Message = GetAuditMessage(timeTextRun.DisplayBounds.Top,
                            nextTimeTextRun != null ? nextTimeTextRun.DisplayBounds.Top : BasePage.Height - (BottomLeftOfPage.Top + BottomLeftOfPage.Height), 
                            userTextRuns.FirstOrDefault().DisplayBounds.Left),
                    });
                }

                m_Audits = audits;
                m_AuditUsersChanged = false;
                return m_Audits;
            }
            set 
            {
                m_Audits = value;
            }
        }

        /// <summary>
        /// Folder, should be in the header
        /// </summary>
        public string Folder
        {
            get
            {
                Match prodMatch = Regex.Match(Text, @"Folder:.*\r\n");
                return prodMatch.Value.Substring("Folder: ".Length, prodMatch.Length - "Folder: ".Length - "\r\n".Length);
            }
        }
        #endregion

        #region Methods
        /// <summary>
        /// Get the audit message
        /// </summary>
        /// <param name="currentTimeTextRunTopBound">The top bound of the current audit time row.</param>
        /// <param name="nextTimeTextRunTopBound">The top bound of the next audit time row. If there is no next audit, Use the bottom of the page</param>
        /// <param name="leftBoundOfUserAudits">The left bound of the user audits, the message should be to the left of this</param>
        /// <returns>The audit message in the current audit row</returns>
        private string GetAuditMessage(double currentTimeTextRunTopBound, double nextTimeTextRunTopBound, double leftBoundOfUserAudits)
        {
            StringBuilder messageSB = new StringBuilder();
            
            List<PDFTextRun> allTextRuns = BasePage.ExtractTextRuns().ToList();
            foreach (PDFTextRun textRun in allTextRuns)
                if (Math.Round(textRun.DisplayBounds.Top) >= Math.Round(currentTimeTextRunTopBound) 
                    && Math.Round(textRun.DisplayBounds.Top) < Math.Round(nextTimeTextRunTopBound)
                    && textRun.DisplayBounds.Left < leftBoundOfUserAudits)
                    messageSB.Append(textRun.Text + " ");

            return messageSB.ToString();
        }

        private List<BaseEnhancedPDFSearchTextResult> GetAuditTimeTextRuns(double leftBoundOfTimeString)
        {
            string timeRegex = RegexHelper.GetRegexFromDateTimeFormat(TimeFormat);

            //Get all of the matching time strings
            MatchCollection allTimeStringsOnThePageInTimeFormat = Regex.Matches(Text, timeRegex);
            List<BaseEnhancedPDFSearchTextResult> timeTextRuns = new List<BaseEnhancedPDFSearchTextResult>();
            foreach (Match differentTimeString in allTimeStringsOnThePageInTimeFormat)
                foreach (PDFSearchTextResult timeString in BasePage.SearchText(differentTimeString.Value))
                {
                    BaseEnhancedPDFSearchTextResult timeStringEnhanced = new BaseEnhancedPDFSearchTextResult(timeString);
                    if (timeTextRuns.FirstOrDefault(x => BasePDFManagement.Instance.AreasOverlap(x.DisplayBounds, timeStringEnhanced.DisplayBounds)) == null)
                        timeTextRuns.Add(timeStringEnhanced);
                }

            //We now have all of the text runs of time, so we can compare their location with the header and figure out their order
            //First, eliminate ones to the left of the left bound of the time cell in the header, because they appear somewhere else on the page
            timeTextRuns.RemoveAll(x => x.DisplayBounds.Left < leftBoundOfTimeString);

            //Then, sort them by how high up they are in the page, this gives us the order.
            timeTextRuns.OrderBy(x => x.DisplayBounds.Top);

            return timeTextRuns;
        }

        private List<BaseEnhancedPDFSearchTextResult> GetAuditUserSearchTextResults(double leftBoundOfTimeString)
        {
            List<BaseEnhancedPDFSearchTextResult> userSearchTextResults = new List<BaseEnhancedPDFSearchTextResult>();
            foreach (string userRegex in UsersRegex)
            {
                MatchCollection allUserStringsOnThePageInUserFormat = Regex.Matches(Text.Replace("\r\n", ""), userRegex);
                HashSet<string> uniqueUserRegex = RemoveDuplicates(allUserStringsOnThePageInUserFormat);

                foreach (string differentUserString in uniqueUserRegex)
                    foreach (PDFSearchTextResult userString in BasePage.SearchText(differentUserString))
                        userSearchTextResults.Add(new BaseEnhancedPDFSearchTextResult(userString));
            }

            //Eliminate ones to the left of the left bound of the user cell in the header and ones to the right of left bound of "Time(GMT)",
            //because they appear somewhere else on the page
            userSearchTextResults.RemoveAll(x => x.DisplayBounds.Left < UserInAuditBarTextRun.DisplayBounds.Left
                && (x.DisplayBounds.Left + x.DisplayBounds.Width) > leftBoundOfTimeString);

            //Then, sort them by how high up they are in the page, this gives us the order.
            userSearchTextResults.OrderBy(x => x.DisplayBounds.Top);

            return userSearchTextResults;
        }

        private static HashSet<string> RemoveDuplicates(MatchCollection matchCollection)
        {
            Match[] matchArray = new Match[matchCollection.Count];
            matchCollection.CopyTo(matchArray, 0);
            HashSet<string> uniqueUserRegex = new HashSet<string>();
            foreach (Match match in matchCollection)
                uniqueUserRegex.Add(match.Value);

            return uniqueUserRegex;
        }

        public bool AuditExist(string message, string userRegex, string timeFormat, int? position = null)
        {
            if(UsersRegex == null || UsersRegex.Count == 0 || String.IsNullOrEmpty(TimeFormat))
                throw new Exception("Please set users and time format before checking that audits exist");

            List<PDFAudit> auditsToTest = null;
            List<PDFAudit> validAudits = new List<PDFAudit>();

            if (position.HasValue)
                auditsToTest = new List<PDFAudit>() { Audits[position.Value] };
            else
                auditsToTest = Audits;

            foreach (PDFAudit audit in auditsToTest)
            {
                if (!String.IsNullOrEmpty(message) && (audit.Message == null || audit.Message.Trim() != message))
                    return false;
                if (!String.IsNullOrEmpty(userRegex) && (audit.User == null || Regex.Match(audit.User.Text, userRegex).Success == false))
                    return false;
                if (!String.IsNullOrEmpty(timeFormat) && (audit.Time == null || Convert.ToDateTime(audit.Time.Text).ToString(timeFormat) != audit.Time.Text))
                    return false;

                validAudits.Add(audit);
            }

            return validAudits.Count > 0;
        }
        #endregion
    }
}
