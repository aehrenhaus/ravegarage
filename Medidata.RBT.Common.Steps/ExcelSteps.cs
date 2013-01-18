using System;
using System.Collections.Generic;
using Medidata.RBT.SeleniumExtension;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using TechTalk.SpecFlow;
using System.IO;
using TechTalk.SpecFlow.Assist;
using System.Linq;


namespace Medidata.RBT.Common.Steps
{
    /// <summary>
    /// Steps related to excel file operations.
    /// </summary>
	[Binding]
	public class ExcelSteps : BrowserStepsBase
	{
		/// <summary>
		/// 
		/// </summary>
		/// <param name="name"></param>
		/// <param name="columnName"></param>
		[StepDefinition(@"I verify ""([^""]*)"" spreadsheet has column ""([^""]*)""")]
		public void IVerify___SpreadsheetHasColumn____(string name, string columnName)
		{
			string fileName = WebTestContext.LastDownloadedFile.FullName;
			if (Path.GetExtension(fileName).ToLower() == ".zip")
				fileName = FileHelper.UnZipFile(fileName);
			bool contains = false;

			using (var excel = new ExcelWorkbook(fileName))
			{
				var sheet = excel.OpenTableForEdit(name);
				contains = sheet.ColumnNames.Contains(columnName);
			}

			Assert.IsTrue(contains, string.Format("Spreadsheet {0} does not contain column {1}", name, columnName));
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

		/// <summary>
		/// Verify a spreadsheet file exists in an excel file (using the last downloaded file).
		/// </summary>
		/// <param name="name"></param>
		[StepDefinition(@"I verify ""([^""]*)"" spreadsheet exists")]
		public void IVerify___SpreadsheetExists(string name)
		{
			string fileName = WebTestContext.LastDownloadedFile.FullName;
			if (Path.GetExtension(fileName).ToLower() == ".zip")
				fileName = FileHelper.UnZipFile(fileName);

			using (var excel = new ExcelWorkbook(fileName))
			{
				bool has = excel.HasSheet(name);
				Assert.IsTrue(has, "Spreadsheet does not exist: " + name);
			}
		}
		
		/// <summary>
		/// Verify a spreadsheet file does not exist in an excel file (using the last downloaded file).
		/// </summary>
		/// <param name="name"></param>
		[StepDefinition(@"I verify ""([^""]*)"" spreadsheet does not exist")]
		public void IVerify___SpreadsheetDoesNotExist(string name)
		{
			string fileName = WebTestContext.LastDownloadedFile.FullName;
			if (Path.GetExtension(fileName).ToLower()==".zip")
				fileName = FileHelper.UnZipFile(fileName);

			using (var excel = new ExcelWorkbook(fileName))
			{
				bool has = excel.HasSheet(name);
				Assert.IsFalse(has, "Spreadsheet exists: " + name);
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
			SpecialStringHelper.ReplaceTable(table);

			string fileName = WebTestContext.LastDownloadedFile.FullName;
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

		/// <summary>
		/// Clear the whole spreadsheet (keeps the first line which is considered header) in the last downloaded excel file.
		/// </summary>
		/// <param name="name"></param>
		[StepDefinition(@"I clear ""([^""]*)"" spreadsheet data")]
		public void IClear___SpreadsheetData(string name)
		{
			string fileName = WebTestContext.LastDownloadedFile.FullName;
			if (Path.GetExtension(fileName).ToLower() == ".zip")
			{
				fileName = FileHelper.UnZipFile(fileName);
				WebTestContext.LastDownloadedFile = new FileInfo(fileName);
			}
			WebTestContext.FileToUpload = new FileInfo(fileName);
			using (var excel = new ExcelWorkbook(fileName))
			{
				var sheet = excel.OpenTableForEdit(name);
				sheet.ClearContent();
				excel.Save();
			}
		}

		/// <summary>
		/// Clear the spreadsheet's content from the X line on, in the last downloaded excel file.
		/// </summary>
		/// <param name="name"></param>
		[StepDefinition(@"I clear ""([^""]*)"" spreadsheet data from line (\d+)")]
		public void IClear___SpreadsheetData(string name, int startLine)
		{
			string fileName = WebTestContext.LastDownloadedFile.FullName;
			if (Path.GetExtension(fileName).ToLower() == ".zip")
			{
				fileName = FileHelper.UnZipFile(fileName);
				WebTestContext.LastDownloadedFile = new FileInfo(fileName);
			}
			WebTestContext.FileToUpload = new FileInfo(fileName);
			using (var excel = new ExcelWorkbook(fileName))
			{
				var sheet = excel.OpenTableForEdit(name);
				sheet.ClearContent(startLine);
				excel.Save();
			}
		}

		/// <summary>
		/// Modify the lasted downloaded spreadsheet file
		/// </summary>
		/// <param name="name"></param>
		/// <param name="table"></param>
		[StepDefinition(@"I modify ""([^""]*)"" spreadsheet data")]
		public void IModify___SpreadsheetData(string name, Table table)
		{
			SpecialStringHelper.ReplaceTable(table);

			string fileName = WebTestContext.LastDownloadedFile.FullName;
			if (Path.GetExtension(fileName).ToLower() == ".zip")
			{
				fileName = FileHelper.UnZipFile(fileName);
				WebTestContext.LastDownloadedFile = new FileInfo(fileName);
			}
			WebTestContext.FileToUpload = new FileInfo(fileName); 
			using (var excel = new ExcelWorkbook(fileName))
			{
				var sheet = excel.OpenTableForEdit(name);
				
				foreach (var column in table.Header)
				{
					int rowIndex = 1;
					foreach (var row in table.Rows)
					{
						string newVal = row[column] ?? "";
					
						string current = sheet[rowIndex, column] as string ?? "";
						sheet[rowIndex, column] = newVal;
						
						rowIndex++;
					}
				}
				excel.Save();
			}
		}
	}
}
