using System;
using System.Collections.Generic;
using Medidata.RBT.SeleniumExtension;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using TechTalk.SpecFlow;
using System.IO;
using TechTalk.SpecFlow.Assist;

namespace Medidata.RBT.Common.Steps
{
    /// <summary>
    /// Steps pertaining to downloading and verifying excel data
    /// </summary>
	[Binding]
	public class DownloadAndExcelSteps : BrowserStepsBase
	{
        /// <summary>
        /// Click a button to download a file
        /// </summary>
        /// <param name="button">The value of the button to download (the text in the button)</param>
		[StepDefinition(@"I click the ""([^""]*)"" button to download")]
		public void IClickThe___ButtonToDownload(string button)
		{
			TestContext.WatchForDownload();
			CurrentPage.ClickButton(button);
			TestContext.WaitForDownloadFinish();
		}

        /// <summary>
        /// Click a button to upload a specific type of file and wait until some text is present to verify completion.
        /// </summary>
        /// <param name="buttonName">The value of the button to click to upload</param>
        /// <param name="uploadControlIdentifier">Type of object to upload</param>
        /// <param name="fileName">Name of the file to upload</param>
        /// <param name="finishSignal">The text that verifies upload completion</param>
		[StepDefinition(@"I click ""([^""]*)"" to upload ""([^""]*)"" file ""([^""]*)"" and wait until I see ""([^""]*)""")]
		public void IClick____ToUpload____AndWaitUntilISee____(string buttonName, string uploadControlIdentifier, string fileName, string finishSignal)
		{
			var uploadControl = CurrentPage.GetElementByName(uploadControlIdentifier);
			var fileInfo = new FileInfo(Path.Combine(RBTConfiguration.Default.UploadPath, fileName));
			uploadControl.SendKeys(fileInfo.FullName);
			CurrentPage.ClickButton(buttonName);

			Browser.TryFindElementBy((b) => CurrentPage.GetElementByName(finishSignal),true, 60);
		}


		[StepDefinition(@"I verify ""([^""]*)"" spreadsheet exists")]
		public void IVerify___SpreadsheetExists(string name)
		{
			string fileName = TestContext.LastDownloadFile.FullName;
			if (Path.GetExtension(fileName).ToLower() == ".zip")
				fileName = FileHelper.UnZipFile(fileName);

			using (var excel = new ExcelWorkbook(fileName))
			{
				bool has = excel.HasSheet(name);
				Assert.IsTrue(has, "Not exsits:" + name);
			}
		}

		[StepDefinition(@"I verify ""([^""]*)"" spreadsheet does not exist")]
		public void IVerify___SpreadsheetDoesNotExist(string name)
		{
			string fileName = TestContext.LastDownloadFile.FullName;
			if (Path.GetExtension(fileName).ToLower()==".zip")
				fileName = FileHelper.UnZipFile(fileName);

			using (var excel = new ExcelWorkbook(fileName))
			{
				bool has = excel.HasSheet(name);
				Assert.IsFalse(has, "Exsits:" + name);
			}
		}

        /// <summary>
        /// Verify data from a downloaded spreadsheet
        /// </summary>
        /// <param name="name">The name of the downloaded spreadsheet</param>
        /// <param name="table">The data to verify</param>
		[StepDefinition(@"I verify ""([^""]*)"" spreadsheet data")]
		public void IVerify___SpreadsheetData(string name, Table table)
		{
			string fileName = TestContext.LastDownloadFile.FullName;
			if (Path.GetExtension(fileName).ToLower()==".zip")
				fileName = FileHelper.UnZipFile(fileName);

			using (var excel = new ExcelWorkbook(fileName))
			{
				var sheet = excel.OpenTableForEdit(name);

				foreach (var column in table.Header)
				{
					int rowIndex = 1;
					foreach (var row in table.Rows)
					{
						string expected = row[column]??"";
						string actual = sheet[rowIndex, column] as string??"";

						if (actual != null && expected.Trim()!=actual.Trim())
							throw new Exception(string.Format(
								"Sheet data does not match, (Row {0},Column {1})\r\nExpected:\"{2}\", actual:\"{3}\"",
								rowIndex,
								column,
								expected,
								actual
								));

						rowIndex++;
					}
				}
			}
		}
	}
}
