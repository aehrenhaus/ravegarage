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


        [StepDefinition(@"I enter data in ""Coder Configuration"" and save")]
        public void IEnterDataInCoderConfiguration(Table table)
        {
            var page = CurrentPage.As<CoderConfigurationPage>();

            page.FillData(table.CreateSet<CoderConfigurationModel>());
            page.Save();
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
                user.SetLinesPerPage(configuration.LinesPerPage);
                Role role = TestContext.GetExistingFeatureObjectOrMakeNew(configuration.Role, () => new Role(configuration.Role));
                SecurityRole securityRole = TestContext.GetExistingFeatureObjectOrMakeNew
                    (configuration.SecurityRole, () => new SecurityRole(configuration.SecurityRole));

                Site site = TestContext.GetExistingFeatureObjectOrMakeNew(configuration.Site, () => new Site(configuration.Site));
                Project project = TestContext.GetExistingFeatureObjectOrMakeNew(configuration.Project, () => new Project(configuration.Project));

                bool studyAssignmentExists = user.StudyAssignmentExists(role.UniqueName, project.UniqueName, site.UniqueName);
                bool moduleAssignmentExists = user.ModuleAssignmentExists("All Projects", securityRole.UniqueName);
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
