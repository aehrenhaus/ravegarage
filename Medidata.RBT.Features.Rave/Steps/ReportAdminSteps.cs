﻿using System;
using System.Collections.Generic;
using System.Linq;
using Medidata.RBT.ConfigurationHandlers;
using TechTalk.SpecFlow;
using TechTalk.SpecFlow.Assist;
using Medidata.RBT.PageObjects.Rave;
using Medidata.RBT.SeleniumExtension;

using Microsoft.VisualStudio.TestTools.UnitTesting;
using OpenQA.Selenium;
using System.IO;

namespace Medidata.RBT.Features.Rave
{
    /// <summary>
    /// Steps pertaining to the report administrator
    /// </summary>
	[Binding]
	public class ReportAdminSteps : BrowserStepsBase
	{
        /// <summary>
        /// Create a report package with the passed in name
        /// </summary>
        /// <param name="reportName">The name of the report package</param>
		[StepDefinition(@"I create report package ""(.+?)""")]
		public void ICreateReportPackage____(string reportName)
		{
			CurrentPage.ChooseFromCheckboxes(null, true, null, reportName);
			CurrentPage = CurrentPage.ClickButton("Continue");
			CurrentPage = CurrentPage.ClickButton("Create Package");

			Browser.GetAlertWindow().Accept();
			CurrentPage = WebTestContext.POFactory.GetPageByUrl(new Uri(Browser.Url));

			Browser.ButtonByText("Download Package");

			using (var fileWatcher = WebTestContext.WatchForDownload())
			{
				CurrentPage.ClickButton("Download Package");
			}

			string tempFolderSharedByOtherScenarios = "c:\\";
			WebTestContext.Storage["tempFile"] = WebTestContext.LastDownloadedFile.Name;
			WebTestContext.LastDownloadedFile.MoveTo(Path.Combine(tempFolderSharedByOtherScenarios, WebTestContext.LastDownloadedFile.Name));
		}

        /// <summary>
        /// Install report packed with the passed in name
        /// </summary>
        /// <param name="reportName">Name of the report package to install</param>
		[StepDefinition(@"I install report package ""(.+?)""")]
		public void IInstallReportPackage____(string reportName)
		{
			Assert.IsNotNull(WebTestContext.Storage["tempFile"], "File not exist, should run the create package scenario to download the file.");

			string tempFolderSharedByOtherScenarios = "c:\\";
			FileInfo lastFile = new FileInfo(Path.Combine(tempFolderSharedByOtherScenarios, WebTestContext.Storage["tempFile"] as string));

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

			Browser.GetAlertWindow().Accept();
			CurrentPage = WebTestContext.POFactory.GetPageByUrl(new Uri(Browser.Url));

			unzipedExcelFile.Delete();
			lastFile.Delete();

			Browser.TryFindElementBy(By.XPath("//span[text()='"+"The Report Package has been installed successfully."+"']"));
		}

        /// <summary>
        /// Check if report matrix assigments exist, create them if they don't
        /// </summary>
        /// <param name="table"></param>
        [StepDefinition(@"the following Reports Matrix assignments exist")]
        public void TheFollowingReportsMatrixAssignmentsExist(Table table)
        {
            IEnumerable<ReportMatrixAssignmentModel> reportMatrixAssignments = table.CreateSet<ReportMatrixAssignmentModel>();
            WebTestContext.CurrentPage = new ReportMatrixPage().NavigateToSelf();

            CurrentPage.As<ReportMatrixPage>().AssignReportMatrices(reportMatrixAssignments.ToList());

            WebTestContext.CurrentPage = new HomePage().NavigateToSelf();
        }

        /// <summary>
        /// Install script utility script into window
        /// </summary>
        /// <param name="table"></param>
        [StepDefinition(@"I install script utility script ""(.*)""")]
        public void GivenIInstallScriptUtilityScript(string scriptfile)
        {
            scriptfile = RBTConfiguration.Default.UploadPath + @"\Reports\" + scriptfile;
            WebTestContext.Browser.FindElementByName("_ctl0:Content:_ctl7").SendKeys(scriptfile);
            CurrentPage.ClickButton("Upload");
        }

        /// <summary>
        /// Select subject to copy from list
        /// </summary>
        /// <param name="table"></param>
        [StepDefinition(@"I select ""(.*)"" to copy")]
        public void GivenISelectToCopy(string subject)
        {
            subject=SpecialStringHelper.Replace(subject);
            IWebElement selectedSubject = Browser.TryFindElementByOptionText(subject, true);
            selectedSubject.Click();
        }

        /// <summary>
        /// checkbox selector
        /// </summary>
        /// <param name="table"></param>
        [StepDefinition(@"I select ""(.*)"" checkbox")]
        public void GivenISelectCheckbox(string checkbox)
        {
            this.CurrentPage.ChooseFromCheckboxes(checkbox, true);
        }



	}
}
