using System;
using System.Collections.Generic;
using Medidata.RBT.SeleniumExtension;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using TechTalk.SpecFlow;
using System.IO;
using TechTalk.SpecFlow.Assist;

namespace Medidata.RBT.Common.Steps
{
	[Binding]
	public class DownloadAndExcelSteps : BrowserStepsBase
	{
		
		[StepDefinition(@"I click the ""([^""]*)"" button to download")]
		public void IClickThe___ButtonToDownload(string button)
		{
			TestContext.WatchForDownload();
			CurrentPage.ClickButton(button);
			TestContext.WaitForDownloadFinish();
		}




		[StepDefinition(@"I click ""([^""]*)"" to upload ""([^""]*)"" file ""([^""]*)"" and wait until I see ""([^""]*)""")]
		public void IClick____ToUpload____AndWaitUntilISee____(string buttonName, string uploadControlIdentifier, string fileName, string finishSignal)
		{
			var uploadControl = CurrentPage.GetElementByName(uploadControlIdentifier);
			var fileInfo = new FileInfo(Path.Combine(RBTConfiguration.Default.UploadPath, fileName));
			uploadControl.SendKeys(fileInfo.FullName);
			CurrentPage.ClickButton(buttonName);

			Browser.WaitForElement((b) => CurrentPage.GetElementByName(finishSignal), null, 60);
		}

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

						if (expected != actual)
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
