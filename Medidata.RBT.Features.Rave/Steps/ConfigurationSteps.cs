using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using Medidata.RBT.PageObjects.Rave.Configuration;
using Medidata.RBT.PageObjects.Rave.Configuration.Models;
using TechTalk.SpecFlow;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using TechTalk.SpecFlow.Assist;

namespace Medidata.RBT.Features.Rave.Steps
{
    [Binding]
    public class ConfigurationSteps : BrowserStepsBase
    {
       

        [StepDefinition(@"the URL has ""([^""]*)"" installed")]
        public void TheURLHas____Installed()
        {
            bool isCoderEnabled = DbHelper.ExecuteStoredProcedureRetBool("spUrlUsingCoder");
            Assert.IsTrue(isCoderEnabled);
        }

        [StepDefinition(@"the ""([^""]*)"" spreadsheet is downloaded")]
        public void The____IsDownloaded(string fileName)
        {
            string path = RBTConfiguration.Default.DownloadPath + @"\";
            bool zipped = false;
            string fullPath = null;
            TestContext.SpreadsheetName = fileName;
            switch (fileName)
            {
                case "Core Configuration Specification Template":                
                    fullPath = path + "RaveCoreConfig_eng_Template.zip";
                    zipped = true;
                    break;
                case "Core Configuration Specification":
                    var files = Directory.GetFiles(path, "*.zip").Select(t=>new FileInfo(t)).OrderByDescending(t=>t.LastWriteTime);
                    Assert.IsTrue(files.Any());

                    //take latest downloaded file
                    fullPath = files.First().FullName;
                    zipped = true;
                    break;
                default:
                    throw new NotImplementedException("Steps for this spreadsheet arent implemented yet");
            }
            TestContext.ExcelFile = new ExcelFileHelper(fullPath,zipped);

            Assert.IsNotNull(TestContext.ExcelFile);
        }

        [StepDefinition(@"I verify ""([^""]*)"" tab exists in the spreadsheet")]
        public void IVerify____TabExistsInExcelFile(string name)
        {
            bool spreadSheetExists = name != null && TestContext.ExcelFile.SpreadSheetExists("ss", name);
            Assert.IsTrue(spreadSheetExists);
        }

        [StepDefinition(@"I verify ""([^""]*)"" spreadsheet data")]
        public void IVerify___SpreadsheetData(string name, Table table)
        {
            if (name == "Coder Configuration")
            {
                string nameSpace = "ss";
                string spreadSheetName = "Coder Configuration";

                var data = table.CreateSet<ExcelConfigurationModel>();
                var excelConfigurationModels = data as List<ExcelConfigurationModel> ?? data.ToList();
                for (int i = 0; i < excelConfigurationModels.Count(); i++)
                {
                    string expected = excelConfigurationModels.ElementAt(i).Setting;
                    string actual = TestContext.ExcelFile.GetExcelValue(nameSpace, spreadSheetName, 3, i + 2);
                    Assert.AreEqual(expected.Trim(), actual.Trim());

                    expected = excelConfigurationModels.ElementAt(i).CoderManualQueries;
                    actual = TestContext.ExcelFile.GetExcelValue(nameSpace, spreadSheetName, 2, i + 2);
                    Assert.AreEqual(expected.Trim(), actual.Trim());

                    expected = excelConfigurationModels.ElementAt(i).InstructionsComments;
                    actual = TestContext.ExcelFile.GetExcelValue(nameSpace, spreadSheetName, 4, i + 2);
                    Assert.AreEqual(expected.Trim(), actual.Trim());
                }
            }
        }


        [StepDefinition(@"I verify options for cell ""([^""]*)""")]
        public void IVerifyOptionsForCell____( string cellName, Table table)
        {
          
            string nameSpace = "ss";
            string spreadSheetName = "Coder Configuration";

            var data = table.CreateSet<ExcelConfigurationModel>();
            var excelConfigurationModels = data as List<ExcelConfigurationModel> ?? data.ToList();
            for (int i = 0; i < excelConfigurationModels.Count(); i++)
            {
                bool found = false;
                string expected = excelConfigurationModels.ElementAt(i).Setting;
                for (int j = 1; j < 31; j++)
                {
                    int colNum = j <= 4 ? 5 : 2;

                    string actual = TestContext.ExcelFile.GetExcelValue(nameSpace, spreadSheetName, colNum,j);

                    if (expected.Equals(actual))
                        found = true;
                }
               
               Assert.IsTrue(found);
            }
            
        }




        [StepDefinition(@"I enter data in ""Coder Configuration"" and save")]
        public void IEnterDataInCoderConfiguration(Table table)
        {
            var page = CurrentPage.As<CoderConfigurationPage>();     

            page.FillData(table.CreateSet<CoderConfigurationModel>());
            page.Save();
        }


		//TODO: this method should be deleted, use the common step for clicking a button
        [StepDefinition(@"I click ""([^""]*)""")]
        public void IClick____(string name)
        {
            var page = CurrentPage;
            IPage clickButton = page.ClickButton(name);

        }

}
}
