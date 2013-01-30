﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using O2S.Components.PDF4NET;
using O2S.Components.PDF4NET.PDFFile;
using TechTalk.SpecFlow;
using OpenQA.Selenium;
using Medidata.RBT.SeleniumExtension;

namespace Medidata.RBT
{
    /// <summary>
    ///This is a shared PDF object, it represents the system level functionality of the pdf.
    ///</summary>
    public class PDF
    {
        public string FileLocation { get; set; }
        public string Name { get; set; }

        private string m_Text;
        public string Text
        {
            get
            {
                if (m_Text == null)
                {
                    PDFDocument pdfDoc = new PDFDocument(FileLocation);

                    StringBuilder sb = new StringBuilder();
                    for (int i = 0; i < pdfDoc.Pages.Count; i++)
                    {
                        PDFImportedPage ip = pdfDoc.Pages[i] as PDFImportedPage;

                        string tempText = ip.ExtractText();
                        sb.AppendLine(tempText);
                    }

                    foreach (PDFBookmark bookmark in pdfDoc.Bookmarks)
                        DepthFirstGetTextInBookmarkTree(sb, bookmark);

                    string text = sb.ToString();

                    pdfDoc.Dispose();
                    m_Text = text;
                    return m_Text;
                }
                else
                    return m_Text;
            }
        }

        private StringBuilder DepthFirstGetTextInBookmarkTree(StringBuilder sb, PDFBookmark bookmark)
        {
            sb.AppendLine(bookmark.Title); //Either this, or replace it in the FF, (e.g. Pre Filled\r\nValues
            foreach(PDFBookmark bookmarkChild in bookmark.Bookmarks)
                DepthFirstGetTextInBookmarkTree(sb, bookmarkChild);
            return sb;
        }

        public PDF()
        {
        }

        public PDF(string name)
        {
            Name = name;
        }

        public PDF(string name, string fileLocation)
        {
            Name = name;
            FileLocation = fileLocation;
        }
    }
}
