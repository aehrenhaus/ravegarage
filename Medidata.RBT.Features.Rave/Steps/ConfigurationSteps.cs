using System;
using System.Collections.Generic;
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
    public class ConfigurationSteps : BrowserStepsBase, IExcelFileHandler
    {
        public ExcelFileHelper ExcelFile { get; set; }

        [StepDefinition(@"the URL has ""([^""]*)"" installed")]
        public void TheURLHas____Installed()
        {
            bool isCoderEnabled = DbHelper.ExecuteStoredProcedureRetBool("spUrlUsingCoder");
            Assert.IsTrue(isCoderEnabled);
        }

        [StepDefinition(@"the ""([^""]*)"" is downloaded")]
        public void The____IsDownloadedAndOpened(string fileName)
        {
            string path = RBTConfiguration.Default.DownloadPath;
            bool zipped = false;
            string fullPath = null;
            switch (fileName)
            {
                case "Core Configuration Specification Template":                
                    fullPath = path + @"\" + "RaveCoreConfig_eng_Template.zip";
                    zipped = true;
                    break;
            }
            ExcelFile = new ExcelFileHelper(fullPath,zipped);

            Assert.IsNotNull(ExcelFile);
        }

        [StepDefinition(@"I verify ""([^""]*)"" spreadsheet exists")]
        public void IVerify____TabExistsInExcelFile(string name)
        {
            bool spreadSheetExists = name != null && ExcelFile.SpreadSheetExists("ss",name);
            Assert.IsTrue(spreadSheetExists);
        }

        [StepDefinition(@"I verify spreadsheet data")]
        public void IVerifySpreadsheetData(Table table)
        {
            string nameSpace = "ss";
            string spreadSheetName = "Coder Configuration";

            var data = table.CreateSet<ExcelConfigurationModel>();
            string test = ExcelFile.GetExcelValue(nameSpace, spreadSheetName, 1, 1);


        }

        [Then(@"I click the drop-down arrow for field ""Site from Sytem""")]
        public void ThenIClickTheDrop_DownArrowForFieldSiteFromSytem()
        {
            
        }


        [StepDefinition(@"I enter data in ""Coder Configuration"" and save")]
        public void IEnterDataInCoderConfiguration(Table table)
        {
            var page = CurrentPage.As<CoderConfigurationPage>();     

            page.FillData(table.CreateSet<CoderConfigurationModel>());
            page.Save();
        }

        [StepDefinition(@"I click ""([^""]*)""")]
        public void IClick____(string name)
        {
            var page = CurrentPage;
            IPage clickButton = page.ClickButton(name);

        }

}
}
