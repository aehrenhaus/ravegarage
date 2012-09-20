using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using TechTalk.SpecFlow;
using Medidata.RBT.PageObjects.Rave.Configuration;
using TechTalk.SpecFlow.Assist;
using Medidata.RBT.PageObjects.Rave.SharedRaveObjects;
using Medidata.RBT.PageObjects.Rave;

namespace Medidata.RBT.Features.Rave
{
    /// <summary>
    /// Steps that configure assignments between uploaded elements
    /// </summary>
	[Binding]
	public class ConfigurationSteps : BrowserStepsBase
	{
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
                User user = TestContext.GetExistingFeatureObjectOrMakeNew(configuration.User, () => new User(configuration.User, true));
                Role role = TestContext.GetExistingFeatureObjectOrMakeNew(configuration.Role, () => new Role(configuration.Role, true));
                SecurityRole securityRole = TestContext.GetExistingFeatureObjectOrMakeNew
                    (configuration.SecurityRole, () => new SecurityRole(configuration.SecurityRole));

                Site site = TestContext.GetExistingFeatureObjectOrMakeNew(configuration.Site, () => new Site(configuration.Site, true));
                Project project = TestContext.GetExistingFeatureObjectOrMakeNew(configuration.Project, () => new Project(configuration.Project));

                bool studyAssignmentExists = user.StudyAssignmentExists(role.UID.Value, project.UID.Value, site.UID.Value);
                bool moduleAssignmentExists = user.ModuleAssignmentExists("All Projects", securityRole.UniqueName);
                if (!studyAssignmentExists && !moduleAssignmentExists)
                {
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
                }
            }
        }
	}
}
