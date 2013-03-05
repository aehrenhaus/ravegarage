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
    public class BaseEnhancedPDFSearchTextResult
    {
        private double? m_TopMostTextRun;
        private double? m_LeftMostTextRun;
        private double? m_RightMostTextRun;
        private double? m_BottomMostTextRun;
        private DisplayRectangle m_DisplayBounds;
        private string m_Text;

        public BaseEnhancedPDFSearchTextResult(PDFSearchTextResult pdfSearchTextResult)
        {
            BasePDFSearchTextResult = pdfSearchTextResult;
        }

        public PDFSearchTextResult BasePDFSearchTextResult { get; set; }

        public DisplayRectangle DisplayBounds
        {
            get
            {
                if(m_DisplayBounds == null)
                {
                    foreach (PDFTextRun textRun in BasePDFSearchTextResult.TextRuns)
                    {
                        TopMostTextRun = textRun.DisplayBounds.Top;
                        LeftMostTextRun = textRun.DisplayBounds.Left;
                        RightMostTextRun = textRun.DisplayBounds.Left + textRun.DisplayBounds.Width;
                        BottomMostTextRun = textRun.DisplayBounds.Top - textRun.DisplayBounds.Height;
                    }
                    m_DisplayBounds = new DisplayRectangle(LeftMostTextRun.Value,
                        TopMostTextRun.Value, 
                        RightMostTextRun.Value - LeftMostTextRun.Value,
                        TopMostTextRun.Value - BottomMostTextRun.Value);
                }
                return m_DisplayBounds;
            }
        }

        public double? TopMostTextRun
        {
            get
            {
                return m_TopMostTextRun;
            }
            set
            {
                if (m_TopMostTextRun == null || value < m_TopMostTextRun)
                    m_TopMostTextRun = value;
            }
        }

        public double? LeftMostTextRun
        {
            get
            {
                return m_LeftMostTextRun;
            }
            set
            {
                if (m_LeftMostTextRun == null || value < m_LeftMostTextRun)
                    m_LeftMostTextRun = value;
            }
        }

        public double? RightMostTextRun
        {
            get
            {
                return m_RightMostTextRun;
            }
            set
            {
                if (m_RightMostTextRun == null || value > m_RightMostTextRun)
                    m_RightMostTextRun = value;
            }
        }

        public double? BottomMostTextRun
        {
            get
            {
                return m_BottomMostTextRun;
            }
            set
            {
                if (m_BottomMostTextRun == null || value > m_BottomMostTextRun)
                    m_BottomMostTextRun = value;
            }
        }

        public string Text
        {
            get
            {
                if(m_Text == null)
                {
                    StringBuilder sb = new StringBuilder();
                    foreach (PDFTextRun pdfTextRun in BasePDFSearchTextResult.TextRuns)
                        sb.Append(pdfTextRun.Text);
                    m_Text = sb.ToString();
                }
                return m_Text;
            }
        }
    }
}
