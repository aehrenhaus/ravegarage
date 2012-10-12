using System;
using System.Collections.Generic;
using System.Linq;
using TechTalk.SpecFlow;
using Medidata.RBT.PageObjects.Rave;
using Medidata.RBT.SeleniumExtension;

using Microsoft.VisualStudio.TestTools.UnitTesting;
using OpenQA.Selenium;
using System.IO;


namespace Medidata.RBT.Features.Rave
{
	[Binding]
	public class ReportAdminSteps : BrowserStepsBase
	{
		[StepDefinition(@"I create report package ""(.+?)""")]
		public void ICreateReportPackage____(string reportName)
		{
			CurrentPage.ChooseFromCheckboxes(null, true, null, reportName);
			CurrentPage = CurrentPage.ClickButton("Continue");
			CurrentPage = CurrentPage.ClickButton("Create Package");
			TestContext.AcceptAlert();
			Browser.WaitForElement(b => b.ButtonByText("Download Package"),null,20);

			TestContext.WatchForDownload();
			CurrentPage.ClickButton("Download Package");
			FileInfo lastFile =  TestContext.WaitForDownloadFinish();

		
			string tempFolderSharedByOtherScenarios = "c:\\";
			TestContext.Vars["tempFile"] = lastFile.Name;
			lastFile.MoveTo(Path.Combine(tempFolderSharedByOtherScenarios,lastFile.Name));

		}


		[StepDefinition(@"I install report package ""(.+?)""")]
		public void IInstallReportPackage____(string reportName)
		{
			Assert.IsNotNull(TestContext.Vars["tempFile"], "File not exist, should run the create package scenario to download the file.");

			string tempFolderSharedByOtherScenarios = "c:\\";
			FileInfo lastFile = new FileInfo(Path.Combine(tempFolderSharedByOtherScenarios, TestContext.Vars["tempFile"]));

			Assert.IsTrue(lastFile.Exists, "File not exist, should run the create package scenario to download the file.");


			string fileName = FileHelper.UnZipFile(lastFile.FullName);

			var unzipedExcelFile = new FileInfo(fileName);

			//the code name is the xls's file name
			string oid = Path.GetFileNameWithoutExtension(unzipedExcelFile.Name);


			Browser.FindElementById("UploadFile").SendKeys(lastFile.FullName);
			CurrentPage.ClickButton("View Package Contents");
			CurrentPage.ChooseFromCheckboxes(null, true, null, reportName);

			//select ID by OID, delete related table rows, and delete report
			object reportID = DbHelper.ExecuteScalar("select reportID from reports where ReportOID='" + "CODINGHIERARCHY" + "'", System.Data.CommandType.Text);
			DbHelper.ExecuteScalar("delete from ReportFiles where ReportID='" + reportID + "'", System.Data.CommandType.Text);
			DbHelper.ExecuteScalar("delete from ReportParameters where ReportID='" + reportID + "'", System.Data.CommandType.Text);
			DbHelper.ExecuteScalar("delete from Reports where ReportID='" + reportID + "'", System.Data.CommandType.Text);
			CurrentPage = CurrentPage.ClickButton("Next");
			CurrentPage = CurrentPage.ClickButton("Install Eligible Reports");
			TestContext.AcceptAlert();

			unzipedExcelFile.Delete();
			lastFile.Delete();

			Browser.WaitForElement(b=>b.TryFindElementBy(By.XPath("//span[text()='"+"The Report Package has been installed successfully."+"']")));
		}

	}
}
