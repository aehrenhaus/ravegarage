﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Medidata.RBT;
using TechTalk.SpecFlow;
using Medidata.RBT.SeleniumExtension;
using OpenQA.Selenium;
using System.Collections.ObjectModel;
using Medidata.RBT.SharedObjects;

namespace Medidata.RBT.PageObjects.Rave.SharedRaveObjects
{
    /// <summary>
    ///This is a rave specific PDF object, it represents the rave level functionality of the pdf, such as the ability to be deleted.
    ///</summary>
    public class PDFSpecific : Medidata.RBT.PDF, IRemoveableObject
    {
        public PDFSpecific(string name)
        {
            Name = name;
            Factory.ScenarioObjectsForDeletion.Add(this);
        }

        /// <summary>
        /// Delete this pdfSpecific object. Clearing the file request, and deleting the actual file.
        /// </summary>
        /// <returns></returns>
        public void DeleteSelf()
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
