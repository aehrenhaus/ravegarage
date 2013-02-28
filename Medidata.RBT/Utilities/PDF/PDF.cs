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
    ///This is a shared PDF object, it represents the system level functionality of the pdf.
    ///</summary>
    public class PDF : PDFDocument
    {
        #region Variables
        private string m_Text;
        private List<RBTPage> m_Pages;
        #endregion

        public string FileLocation { get; set; }
        public string Name { get; set; }
        public List<string> TitleInfo
        {
            get
            {
                return DocumentInformation.Title.Split(new string[] { ", " }, StringSplitOptions.None).ToList();
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

        public new List<RBTPage> Pages
        {
            get
            {
                if (m_Pages == null)
                    m_Pages = base.Pages.ToList().ConvertAll(x => new RBTPage((PDFImportedPage)x));

                return m_Pages;
            }
        }

        public PDFLocale Locale
        {
            get
            {
                if (ContainsNonASCIICharacter)
                {
                    return PDFLocale.NonEnglish;
                }
                else
                {
                    return PDFLocale.English;
                }
            }
        }

        public string SitesGroupsAndSites
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

        public Dictionary<string, double> FontsUsedToFontSize
        {
            get
            {
                Dictionary<string, double> ret = new Dictionary<string,double>();
                foreach (RBTPage page in Pages)
                    ret.Intersect(page.FontsUsedToFontSize);

                return ret;
            }
        }

        /// <summary>
        /// Find the first matching bookmark node in the bookmarks tree.
        /// If parentBookmarkText is not null find the first bookmark with the textToFind under the bookmark that matches the parent bookmark.
        /// </summary>
        /// <param name="textToFind"></param>
        /// <param name="parentBookmarkText"></param>
        /// <returns></returns>
        public PDFBookmark FirstMatchingBookmarkNodeInBookmarkCollection(string textToFind, string parentBookmarkText = null)
        {
            //Get the parent bookmark
            PDFBookmark parentBookmark = null;
            if (parentBookmarkText != null)
                parentBookmark = FirstMatchingBookmarkNodeInBookmarkCollection(parentBookmarkText);

            PDFBookmark retBookmark = null;

            if (parentBookmark != null)
                retBookmark = FirstMatchingBookmarkNodeInBookmark(textToFind, parentBookmark);
            else
            {
                foreach (PDFBookmark bookmark in Bookmarks)
                {
                    if (retBookmark != null)
                        break;
                    retBookmark = FirstMatchingBookmarkNodeInBookmark(textToFind, bookmark);
                }
            }
            return retBookmark;
        }

        public PDFBookmark FirstMatchingBookmarkNodeInBookmark(string textToFind, PDFBookmark bookmark)
        {
            if (bookmark.Title.Equals(textToFind, StringComparison.InvariantCultureIgnoreCase))
                return bookmark;
            else
            {
                foreach (PDFBookmark bookmarkChild in bookmark.Bookmarks)
                {
                    bookmark = FirstMatchingBookmarkNodeInBookmark(textToFind, bookmarkChild);
                    if (bookmark != null)
                        return bookmark;
                }
            }

            return null;
        }

        public bool ContainsNonASCIICharacter
        {
            get
            {
                return Regex.IsMatch(Text, @"[^\x00-\x80]+");
            }
        }

        public string Text
        {
            get
            {
                if (m_Text == null)
                {
                    StringBuilder allPageText = new StringBuilder();
                    foreach (RBTPage page in Pages)
                        allPageText.Append(page.Text);

                    m_Text = allPageText.ToString();
                    return m_Text;
                }
                else
                    return m_Text;
            }
        }

        public PDF()
        {
        }

        public PDF(string name)
        {
            Name = name;
        }

        public PDF(string name, string fileLocation, FileStream fs)
            : base(fs)
        {
            Name = name;
            FileLocation = fileLocation;
            m_Text = Text;
        }
    }
}
