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

namespace Medidata.RBT
{
    /// <summary>
    ///This extends the functionality of PDFImportedPage to do extra things.
    ///I can't directly inherit from it because there are no public constructors.
    ///So it becomes sort of a hybrid, if you want functionality from the PDFImportedPage call the BasePage property.
    ///If you want the new functionality call the properties here.
    ///</summary>
    public class RBTPage
    {
        #region Variables
        private double? m_TopMostGlyph;
        private double? m_LeftMostGlyph;
        private double? m_RightMostGlyph;
        private double? m_BottomMostGlyph;
        private StringBuilder m_Text = new StringBuilder();
        private Dictionary<string, double> m_FontsUsedToFontSize;
        private const int POINTS_IN_AN_INCH = 72;
        #endregion

        public RBTPage(PDFImportedPage page)
        {
            this.BasePage = page;
            SetExtraInformation();
        }

        private void SetExtraInformation()
        {
            foreach (PDFTextRun pdfTextRun in BasePage.ExtractTextRuns())
            {
                SetText(pdfTextRun);
                FontsUsedToFontSize = PopulateFontsUsedToFontSizeDictionary(FontsUsedToFontSize, pdfTextRun);
                SetMargins(pdfTextRun);
            }
        }

        private void SetText(PDFTextRun pdfTextRun)
        {
            m_Text = m_Text.Append(pdfTextRun.Text);
        }

        private void SetMargins(PDFTextRun pdfTextRun)
        {
            PDFRectangle pdfRectangle = pdfTextRun.PDFBounds;

            TopMostGlyph = pdfRectangle.LLY + pdfRectangle.Height;
            LeftMostGlyph = pdfRectangle.LLX;

            double? bottomMostGlyphOld = BottomMostGlyph;
            BottomMostGlyph = pdfRectangle.LLY;
            if (!bottomMostGlyphOld.HasValue || (bottomMostGlyphOld.Value != BottomMostGlyph))
            {
                //Some loss of precision here
                PageNumberArea
                    = new System.Drawing.Rectangle(0,
                        Convert.ToInt32(BottomMostGlyph.Value),
                        Convert.ToInt32(BasePage.Width),
                        Convert.ToInt32(pdfTextRun.FontSize));
            }
            RightMostGlyph = pdfRectangle.LLX + pdfRectangle.Width;
        }

        public override bool Equals(object obj)
        {
            if (obj.GetType() != typeof(PDFImportedPage))
                return base.Equals(obj);
            else
            {
                PDFImportedPage page = (PDFImportedPage)obj;
                if (
                    page != this.BasePage
                    )
                    return false;
                else
                    return true;
            }
        }

        public override int GetHashCode()
        {
            return base.GetHashCode();
        }

        public PDFImportedPage BasePage { get; set; }

        public double? TopMostGlyph
        {
            get
            {
                return m_TopMostGlyph;
            }
            set
            {
                if (m_TopMostGlyph == null || value > m_TopMostGlyph)
                    m_TopMostGlyph = value;
            }
        }

        public double? LeftMostGlyph
        {
            get
            {
                return m_LeftMostGlyph;
            }
            set
            {
                if (m_LeftMostGlyph == null || value < m_LeftMostGlyph)
                    m_LeftMostGlyph = value;
            }
        }

        public double? RightMostGlyph
        {
            get
            {
                return m_RightMostGlyph;
            }
            set
            {
                if (m_RightMostGlyph == null || value > m_RightMostGlyph)
                    m_RightMostGlyph = value;
            }
        }

        public double? BottomMostGlyph
        {
            get
            {
                return m_BottomMostGlyph;
            }
            set
            {
                if (m_BottomMostGlyph == null || value < m_BottomMostGlyph)
                    m_BottomMostGlyph = value;
            }
        }

        /// <summary>
        /// Round to the nearest .5 inch because our method for the margins on a page is imprecise.
        /// We use the difference between the position of the glyph on the edge of the page and the edge of the page
        /// </summary>
        public double TopMargin
        {
            get
            {
                return Math.Round(((this.BasePage.Height - TopMostGlyph.Value) / POINTS_IN_AN_INCH) * 2, MidpointRounding.AwayFromZero) / 2;
            }
        }

        /// <summary>
        /// Round to the nearest .5 inch because our method for the margins on a page is imprecise.
        /// We use the difference between the position of the glyph on the edge of the page and the edge of the page
        /// </summary>
        public double LeftMargin
        {
            get
            {
                return Math.Round((LeftMostGlyph.Value / POINTS_IN_AN_INCH) * 2, MidpointRounding.AwayFromZero) / 2;
            }
        }

        /// <summary>
        /// Round to the nearest .5 inch because our method for the margins on a page is imprecise.
        /// We use the difference between the position of the glyph on the edge of the page and the edge of the page
        /// </summary>
        public double RightMargin
        {
            get
            {
                return Math.Round(((this.BasePage.Width - RightMostGlyph.Value) / POINTS_IN_AN_INCH) * 2, MidpointRounding.AwayFromZero) / 2;
            }
        }

        /// <summary>
        /// Round to the nearest .5 inch because our method for the margins on a page is imprecise.
        /// We use the difference between the position of the glyph on the edge of the page and the edge of the page
        /// </summary>
        public double BottomMargin
        {
            get
            {
                return Math.Round(((BottomMostGlyph.Value) / POINTS_IN_AN_INCH) * 2, MidpointRounding.AwayFromZero) / 2;
            }
        }

        public System.Drawing.Rectangle PageNumberArea { get; set; }
        public string Text
        {
            get
            {
                return m_Text.ToString();
            }
        }
        public Dictionary<string, double> FontsUsedToFontSize
        {
            get
            {
                if (m_FontsUsedToFontSize == null)
                    FontsUsedToFontSize = new Dictionary<string, double>();
                return m_FontsUsedToFontSize;
            }
            set
            {
                m_FontsUsedToFontSize = value;
            }
        }

        /// <summary>
        /// Add the textRun's fontName/font size to the list of all the fonts/font sizes
        /// </summary>
        /// <param name="fontsUsedToFontSize">The existing list of fontsUsedToFontSize</param>
        /// <param name="pdfTextRun">The current pdfTextRun</param>
        /// <returns>The complete list of fonts and font sizes used on the page</returns>
        private static Dictionary<string, double> PopulateFontsUsedToFontSizeDictionary(Dictionary<string, double> fontsUsedToFontSize, PDFTextRun pdfTextRun)
        {
            if(!fontsUsedToFontSize.Contains(new KeyValuePair<string, double>(pdfTextRun.FontName, pdfTextRun.FontSize)))
                fontsUsedToFontSize.Add(pdfTextRun.FontName, pdfTextRun.FontSize);

            return fontsUsedToFontSize;
        }
    }
}
