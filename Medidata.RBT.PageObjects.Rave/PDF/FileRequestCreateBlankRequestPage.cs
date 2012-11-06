using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium.Support.PageObjects;
using OpenQA.Selenium;
using OpenQA.Selenium.Remote;
using TechTalk.SpecFlow;
using Medidata.RBT.SeleniumExtension;
using System.Threading;

namespace Medidata.RBT.PageObjects.Rave
{
    public class FileRequestCreateBlankRequestPage : FileRequestCreateRequestPageBase
	{
        /// <summary>
        /// Create a new blank PDF file request
        /// </summary>
        /// <param name="args">The pdfCreationModel dictates what on the page gets set. For instace, Name dictates the data PDF's name</param>
        /// <returns>A new FileRequestPage</returns>
        public FileRequestPage CreateBlankPDF(PDFCreationModel args)
        {
            base.CreatePDF(args);

            if (!string.IsNullOrEmpty(args.CRFVersion))
            {
                ChooseFromDropdown("CRFVersion", args.CRFVersion);
            }

            ClickLink("Save");
            return new FileRequestPage();
        }

        public override string URL
        {
            get { return "Modules/PDF/FileRequest.aspx?Type=Blank"; }
        }
	}
}
