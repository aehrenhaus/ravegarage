using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium.Support.PageObjects;
using OpenQA.Selenium;
using OpenQA.Selenium.Remote;
using TechTalk.SpecFlow;
using Medidata.RBT.SeleniumExtension;
using System.IO;
using System.Collections.ObjectModel;

namespace Medidata.RBT.PageObjects.Rave
{
	public class FileRequestViewPage : RavePageBase
	{
        /// <summary>
        /// Open the generated pdf and load its text into ScenarioText.
        /// </summary>
        /// <param name="pdf">The name of the pdf of be viewed</param>
        /// <returns></returns>
        public void ViewPDF(WebTestContext webTestContext, string pdfName)
		{
			var table = Browser.Table("_ctl0_Content_Results");
			Table dt = new Table("Name");
            dt.AddRow(pdfName);
            ReadOnlyCollection<IWebElement> matchingRows = table.FindMatchRows(dt);
            if (matchingRows == null || matchingRows.Count == 0)
            {
                dt = new Table("LName");
                dt.AddRow(pdfName);
                matchingRows = table.FindMatchRows(dt);
            }
            var tr = matchingRows.FirstOrDefault();
			tr.FindImagebuttons()[0].Click();
            List<String> extractedFilePaths = Misc.UnzipAllDownloads();

            foreach (string filePath in extractedFilePaths)
                if (filePath.ToLower().EndsWith(".pdf"))
                {
                    using (FileStream fs = new FileStream(filePath, FileMode.Open, FileAccess.Read))
                    {
                        webTestContext.LastLoadedPDF = new Medidata.RBT.PDF(pdfName, filePath, fs);
                    }
                }
		}

        public override string URL
        {
            get { return "Modules/PDF/FileRequests.aspx?MyPDF=True"; }
        }
	}
}
