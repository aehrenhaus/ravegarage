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
using Medidata.RBT.SeleniumExtension;


namespace Medidata.RBT.Features.Rave.Steps
{
    /// <summary>
    /// Steps pertaining to configuration
    /// </summary>
    [Binding]
    public class ConfigurationSteps : BrowserStepsBase
    {
        /// <summary>
        /// Check if the URL has coder enabled
        /// </summary>
        [StepDefinition(@"the URL has ""([^""]*)"" installed")]
        public void TheURLHas____Installed()
        {
            bool isCoderEnabled = DbHelper.ExecuteStoredProcedureRetBool("spUrlUsingCoder");
            Assert.IsTrue(isCoderEnabled);
        }

        /// <summary>
        /// Enter the passed in data into coder configuration
        /// </summary>
        /// <param name="table">The data to enter into coder configuration</param>
        [StepDefinition(@"I enter data in ""Coder Configuration"" and save")]
        public void IEnterDataInCoderConfiguration(Table table)
        {
            var page = CurrentPage.As<CoderConfigurationPage>();

            page.FillData(table.CreateSet<CoderConfigurationModel>());
            page.Save();
        }

        /// <summary>
        /// Check that the passed in configuration settings exist
        /// </summary>
        /// <param name="table">The settings to check</param>
		[StepDefinition(@"following Configuration Settings Exist")]
		public void FollowingConfigurationSettingsExist(Table table)
		{
			var page = new WorkflowConfigPage().NavigateToSelf().ClickLink("Other Settings").As<ConfigurationSettingsPage>();
			bool bOk = page.VerifyRowWithValuesExists(table.CreateSet<ConfigurationSettingsModel>());
			Assert.IsTrue(bOk);
			CurrentPage = new HomePage().NavigateToSelf();
		}

        /// <summary>
        /// Set the amount of lines displayed per page for a specified user
        /// </summary>
        /// <param name="linesPerPage">The number of lines to display</param>
        /// <param name="userName">The user to edit the line display for</param>
		[StepDefinition(@"I set lines per page to (.*) for User ""(.*)""")]
		public void ISetLinesPerPageTo____ForUser____(int linesPerPage, string userName)
		{
			User user = TestContext.GetExistingFeatureObjectOrMakeNew(userName, () =>new User(userName));
			user.SetLinesPerPage(linesPerPage);
		}

        /// <summary>
        /// Assign the user to various project assignments
        /// </summary>
        /// <param name="table">Privileges to assign a user to and the user to assign those privileges to</param>
        [StepDefinition(@"following Project assignments exist")]
        public void FollowingProjectAssignmentsExist(Table table)
        {
			using (new LoginSession())
			{

				List<ConfigurationCreationModel> configurations = table.CreateSet<ConfigurationCreationModel>().ToList();
				foreach (ConfigurationCreationModel configuration in configurations)
				{
					User user = TestContext.GetExistingFeatureObjectOrMakeNew(configuration.User, () => new User(configuration.User));

					Role role = TestContext.GetExistingFeatureObjectOrMakeNew(configuration.Role, () => new Role(configuration.Role));
					SecurityRole securityRole = TestContext.GetExistingFeatureObjectOrMakeNew
						(configuration.SecurityRole, () => new SecurityRole(configuration.SecurityRole));

					Site site = TestContext.GetExistingFeatureObjectOrMakeNew(configuration.Site, () => new Site(configuration.Site));
					Project project = TestContext.GetExistingFeatureObjectOrMakeNew(configuration.Project,
					                                                                () => new Project(configuration.Project));

					bool studyAssignmentExists = user.StudyAssignmentExists(role.UniqueName, project.UniqueName, site.UniqueName,configuration.Environment);
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

                        //assign globallibrary role
                        if (!String.IsNullOrEmpty(configuration.GlobalLibraryRole))
                        {
                            CurrentPage.As<UserEditPage>().AssignUserToGlobalLibraryRole();
                        }
					}
				}
			}

			Browser.WaitForDocumentLoad();
        }

        /// <summary>
        /// Assign the user to a security role
        /// </summary>
        /// <param name="userFeature">The user to assign the role to</param>
        /// <param name="securityRoleFeature">The security role to assign to the user</param>
        [StepDefinition(@"I assign user ""([^""]*)"" to security role ""([^""]*)""")]
        public void FollowingProjectAssignmentsExist(string userFeature, string securityRoleFeature)
        {
            
            using (new LoginSession())
            {
                User user = TestContext.GetExistingFeatureObjectOrMakeNew(userFeature, () => new User(userFeature));
                SecurityRole securityRole = TestContext.GetExistingFeatureObjectOrMakeNew
                            (securityRoleFeature, () => new SecurityRole(securityRoleFeature));
                if (!user.ModuleAssignmentExists("All Projects", securityRole.UniqueName))
                {
                    CurrentPage = new UserAdministrationPage().NavigateToSelf();
                    CurrentPage = CurrentPage.As<UserAdministrationPage>().SearchUser(new UserAdministrationPage.SearchByModel()
                    {
                        Login = user.UniqueName
                    });
                    CurrentPage = CurrentPage.As<UserAdministrationPage>().ClickUser(user.UniqueName);
                    CurrentPage.As<UserEditPage>().AssignUserToSecurityRole(user, securityRole);
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
 
        /// <summary>
        /// Build Clinical Views for passed in project
        /// </summary>
        /// <param name="projectName">The name of the project</param>
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
