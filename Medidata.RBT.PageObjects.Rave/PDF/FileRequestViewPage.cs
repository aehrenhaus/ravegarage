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

namespace Medidata.RBT.PageObjects.Rave
{
	public class FileRequestViewPage : RavePageBase
	{
		public void ViewPDF(string pdfName)
		{
			var table = Browser.Table("_ctl0_Content_Results");
			Table dt = new Table("Name");
            dt.AddRow(pdfName);
			var tr = table.FindMatchRows(dt).FirstOrDefault();
			tr.FindImagebuttons()[0].Click();
            List<String> extractedFilePaths = UnzipAllDownloads();

            StringBuilder sb = new StringBuilder();

            foreach (string filePath in extractedFilePaths)
                if(filePath.ToLower().EndsWith(".pdf"))
                    sb.Append(new PDF(pdfName, filePath).Text);

            TestContext.ScenarioText = sb.ToString();
		}
	}
}
