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
using Medidata.RBT.ConfigurationHandlers;

namespace Medidata.RBT.PageObjects.Rave
{
	public class FileRequestViewPage : RavePageBase
	{
        /// <summary>
        /// Open the generated pdf and load its text into ScenarioText.
        /// </summary>
        /// <param name="webTestContext">The current web test context</param>
        /// <param name="pdf">The name of the pdf of be viewed</param>
        /// <param name="requestName">The name of the request which generated the pdf</param>
        public void ViewPDF(WebTestContext webTestContext, SpecflowWebTestContext specflowContext, string pdfName, string requestName)
		{
            webTestContext.LastLoadedPDF = null;
			var table = Browser.Table("_ctl0_Content_Results");
			Table dt = new Table("Name");
            dt.AddRow(requestName);
            ReadOnlyCollection<IWebElement> matchingRows = table.FindMatchRows(dt);
            if (matchingRows == null || matchingRows.Count == 0)
            {
                dt = new Table("LName");
                dt.AddRow(requestName);
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
                        if (Path.GetFileName(filePath).Equals(pdfName, StringComparison.InvariantCulture))
                        {
                            webTestContext.LastLoadedPDF = new Medidata.RBT.BaseEnhancedPDF(pdfName, filePath, fs);
                            string pdfCopyPath = Path.Combine(RBTConfiguration.Default.TestResultPath, specflowContext.CurrentScenarioName + "_" + pdfName);

                            File.Copy(filePath, pdfCopyPath);
                        }
                    }
                }
		}

        public override string URL
        {
            get { return "Modules/PDF/FileRequests.aspx?MyPDF=True"; }
        }
	}
}
