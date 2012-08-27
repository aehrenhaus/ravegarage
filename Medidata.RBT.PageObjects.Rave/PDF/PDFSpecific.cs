using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Medidata.RBT;
using TechTalk.SpecFlow;
using Medidata.RBT.SeleniumExtension;
using OpenQA.Selenium;
using System.Collections.ObjectModel;

namespace Medidata.RBT.PageObjects.Rave.PDF
{
    public class PDFSpecific : Medidata.RBT.PDF
    {
        public PDFSpecific(string name)
        {
            Name = name;
        }

        public override void DeleteSelf()
        {
            //Call PDF Delete the file from the DB
            PDFFilesControl pdfFilesControl = new PDFFilesControl(new FileRequestPage());
            pdfFilesControl.DeletePDF(Name);

            //Delete the File Request
            PDFFileRequestsControl pdfFileRequestsControl = new PDFFileRequestsControl(new FileRequestPage());
            pdfFileRequestsControl.DeletePDF(Name);
        }
    }
}
