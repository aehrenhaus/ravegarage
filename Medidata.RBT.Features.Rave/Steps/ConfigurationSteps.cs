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
using Medidata.RBT.PageObjects.Rave;
using Medidata.RBT.PageObjects.Rave.SharedRaveObjects;

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
                    var files = Directory.GetFiles(path, "*.zip").Select(t => new FileInfo(t)).OrderByDescending(t => t.LastWriteTime);
                    Assert.IsTrue(files.Any());

                    //take latest downloaded file
                    fullPath = files.First().FullName;
                    zipped = true;
                    break;
                default:
                    throw new NotImplementedException("Steps for this spreadsheet arent implemented yet");
            }
            TestContext.ExcelFile = new ExcelFileHelper(fullPath, zipped);

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
        public void IVerifyOptionsForCell____(string cellName, Table table)
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

                    string actual = TestContext.ExcelFile.GetExcelValue(nameSpace, spreadSheetName, colNum, j);

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

        /// <summary>
        /// Assign the user to various project assignments
        /// </summary>
        /// <param name="table">Privileges to assign a user to and the user to assign those privileges to</param>
        [StepDefinition(@"following Project assignments exist")]
        public void FollowingProjectAssignmentsExist(Table table)
        {
            List<ConfigurationCreationModel> configurations = table.CreateSet<ConfigurationCreationModel>().ToList();
            foreach (ConfigurationCreationModel configuration in configurations)
            {
                User user = TestContext.GetExistingFeatureObjectOrMakeNew(configuration.User, () => new User(configuration.User));
                Role role = TestContext.GetExistingFeatureObjectOrMakeNew(configuration.Role, () => new Role(configuration.Role));
                SecurityRole securityRole = TestContext.GetExistingFeatureObjectOrMakeNew
                    (configuration.SecurityRole, () => new SecurityRole(configuration.SecurityRole));

                Site site = TestContext.GetExistingFeatureObjectOrMakeNew(configuration.Site, () => new Site(configuration.Site, true));
                Project project = TestContext.GetExistingFeatureObjectOrMakeNew(configuration.Project, () => new Project(configuration.Project));

                bool studyAssignmentExists = user.StudyAssignmentExists(role.UID.Value, project.UID.Value, site.UID.Value);
                bool moduleAssignmentExists = user.ModuleAssignmentExists("All Projects", securityRole.Name);
                if (!studyAssignmentExists || !moduleAssignmentExists)
                {
                    string loggedInUserBeforeAssignments = TestContext.CurrentUser;
                    LoginPage.LoginToHomePageIfNotAlready();

                    CurrentPage = new UserAdministrationPage().NavigateToSelf();
                    CurrentPage = CurrentPage.As<UserAdministrationPage>().SearchUser(new UserAdministrationPage.SearchByModel()
                    {
                        Login = user.UniqueName
                    });
                    CurrentPage = CurrentPage.As<UserAdministrationPage>().ClickUser(user.UniqueName);
                    if (!moduleAssignmentExists)
                        CurrentPage.As<UserEditPage>().AssignUserToSecurityRole(user, securityRole);
                    if (!studyAssignmentExists)
                        CurrentPage.As<UserEditPage>().AssignUserToPermissions(user, project, role, configuration.Environment, site);

                    LoginPage page = new LoginPage();
                    page.NavigateToSelf();
                    CurrentPage = page.Login(loggedInUserBeforeAssignments, RaveConfiguration.Default.DefaultUserPassword);

                    CurrentPage = new UserAdministrationPage().NavigateToSelf();
                }
            }
        }

        /// <summary>
        /// Make review groups active
        /// </summary>
        /// <param name="numbers">The numbers of the review groups to make active</param>
        [StepDefinition(@"review group number ""<Numbers>"" is active")]
        public void ReviewGroupNumber____IsActive(Table numbers)
        {
            string loggedInUserBeforeAssignments = TestContext.CurrentUser;
            LoginPage.LoginToHomePageIfNotAlready();

            CurrentPage = new WorkflowConfigPage().NavigateToSelf();

            List<int> reviewGroupsToDeactivate = new List<int>();

            foreach (TableRow tableRow in numbers.Rows)
            {
                string stringNumber = tableRow["Numbers"];
                int parsedNumber;
                Int32.TryParse(stringNumber, out parsedNumber);
                reviewGroupsToDeactivate.Add(parsedNumber);
                CurrentPage.As<WorkflowConfigPage>().SetReviewGroup(parsedNumber, true);
            }

            LoginPage page = new LoginPage();
            page.NavigateToSelf();
            CurrentPage = page.Login(loggedInUserBeforeAssignments, RaveConfiguration.Default.DefaultUserPassword);
            CurrentPage = new WorkflowConfigPage().NavigateToSelf();
        }
 
        [StepDefinition(@"Clinical Views exist for project ""([^""]*)""")]
        public void ClinicalViewsExistForProject____(string projectName)
        {
            Project project = TestContext.GetExistingFeatureObjectOrMakeNew(projectName, () => new Project(projectName));
            TestContext.CurrentPage = new ConfigurationClinicalViewsPage().NavigateToSelf();
            bool hasClinicalViews = CurrentPage.Browser.FindElementByTagName("body").Text.Contains(project.UniqueName);
            if (!hasClinicalViews)
            {
                TestContext.CurrentPage.As<ConfigurationClinicalViewsPage>().BuildClinicalViews(project.UniqueName);
            }
        }
   }
}
