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
    /// All properties methods in here should have nothing to do with Rave-specific functionality
    ///</summary>
    public class BaseEnhancedPDF
    {
        #region Variables
        private string m_Text;
        private List<BaseEnhancedPDFPage> m_Pages;
        #endregion
        #region Properties
        /// <summary>
        /// This is what you call to access the normal PDF4NET functionality
        /// </summary>
        public PDFDocument BaseDocument { get; set; }
        public string FileLocation { get; set; }
        public string Name { get; set; }
        public List<string> TitleInfo
        {
            get
            {
                return BaseDocument.DocumentInformation.Title.Split(new string[] { ", " }, StringSplitOptions.None).ToList();
            }
        }

        public List<BaseEnhancedPDFPage> Pages
        {
            get
            {
                if (m_Pages == null)
                    m_Pages = BaseDocument.Pages.ToList().ConvertAll(x => new BaseEnhancedPDFPage((PDFImportedPage)x));

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

        public Dictionary<string, double> FontsUsedToFontSize
        {
            get
            {
                Dictionary<string, double> ret = new Dictionary<string,double>();
                foreach (BaseEnhancedPDFPage page in Pages)
                    ret.Intersect(page.FontsUsedToFontSize);

                return ret;
            }
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
                    foreach (BaseEnhancedPDFPage page in Pages)
                        allPageText.Append(page.Text);

                    m_Text = allPageText.ToString();
                    return m_Text;
                }
                else
                    return m_Text;
            }
            set
            {
                m_Text = value;
            }
        }
        #endregion
        #region Methods
        /// <summary>
        /// Find the first matching bookmark node in the bookmarks tree.
        /// If parentBookmarkText is not null find the first bookmark with the textToFind under the bookmark that matches the parent bookmark.
        /// </summary>
        /// <param name="textToFind">The bookmark text to find</param>
        /// <param name="parentBookmarkText">The text of the parent bookmark</param>
        /// <param name="directChild">If true, the bookmark in the table must be a child of the parent bookmark. Cannot be a grandchild or more.</param>
        /// <param name="positionUnderParentBookmarkExpected">If not null, will only call the boomark a match if it is in the correct position under the parent bookmark.
        /// For example, if i is 1, the bookmark must be the second bookmark under the parent (it is zero indexed).</param>
        /// <returns>The first matching bookmark after a depth first search</returns>
        public PDFBookmark FirstMatchingBookmarkNodeInBookmarkCollection(string textToFind,
            string parentBookmarkText = null,
            bool directChild = false,
            int? positionUnderParentBookmarkExpected = null)
        {
            //Get the parent bookmark
            PDFBookmark parentBookmark = null;
            if (parentBookmarkText != null && !directChild)
                parentBookmark = FirstMatchingBookmarkNodeInBookmarkCollection(parentBookmarkText);

            PDFBookmark retBookmark = null;

            if (parentBookmark != null && !directChild)
                retBookmark = FirstMatchingBookmarkNodeInBookmark(textToFind, parentBookmark);
            else
            {
                for (int i = 0; i < BaseDocument.Bookmarks.Count; i++)
                {
                    PDFBookmark bookmark = BaseDocument.Bookmarks[i];
                    if (retBookmark != null)
                        break;

                    retBookmark = FirstMatchingBookmarkNodeInBookmark(textToFind, bookmark, directChild ? parentBookmarkText : null);
                }
            }
            return retBookmark;
        }

        /// <summary>
        /// Find the first matching bookmark node in a bookmark, but check if this the bookmark we are looking for first
        /// If parentBookmarkText is not null find the first bookmark with the textToFind under the bookmark that matches the parent bookmark.
        /// </summary>
        /// <param name="textToFind">The bookmark text</param>
        /// <param name="bookmark">The current bookmark</param>
        /// <param name="parentBookmarkText">The text of the parent bookmark which this bookmark should have, if null. Parent bookmark doesn't matter</param>
        /// <param name="positionUnderParentBookmark">The position under the parent bookmark that this bookmark should have. 
        /// For instance, if this should be the second bookmark under the parent bookmark, this value should be 1</param>
        /// <returns>The first matching bookmark after a depth first search</returns>
        public PDFBookmark FirstMatchingBookmarkNodeInBookmark(string textToFind, PDFBookmark bookmark, string parentBookmarkText = null, int? positionUnderParentBookmark = null)
        {
            if (parentBookmarkText != null
                && bookmark.Parent != null
                && bookmark.Parent.Title.Equals(parentBookmarkText)
                && bookmark.Title.Equals(textToFind, StringComparison.InvariantCultureIgnoreCase))
            {
                if (!positionUnderParentBookmark.HasValue)
                    return bookmark;
                else if (bookmark.Parent.Bookmarks[positionUnderParentBookmark.Value] == bookmark)
                    return bookmark;
            }
            else if (bookmark.Title.Equals(textToFind, StringComparison.InvariantCultureIgnoreCase))
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
        #endregion
        #region Constructors
        public BaseEnhancedPDF()
        {
        }

        public BaseEnhancedPDF(string name)
        {
            Name = name;
        }

        public BaseEnhancedPDF(string name, string fileLocation, FileStream fs)
        {
            BaseDocument = new PDFDocument(fs);
            Name = name;
            FileLocation = fileLocation;
            m_Text = Text;
        }
        #endregion
    }
}
