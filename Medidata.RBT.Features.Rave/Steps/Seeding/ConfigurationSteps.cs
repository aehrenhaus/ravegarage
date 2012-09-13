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
                User user = new User(configuration.User, true);
                Role role = new Role(configuration.Role, true);
                SecurityRole securityRole = new SecurityRole(configuration.SecurityRole);

                Site site = new Site(configuration.Site, true);
                Project project = new Project(configuration.Project);

                CurrentPage = new UserAdministrationPage().NavigateToSelf();
                CurrentPage = CurrentPage.As<UserAdministrationPage>().SearchUser(new UserAdministrationPage.SearchByModel()
                {
                    Login = user.UniqueName
                });
                CurrentPage = CurrentPage.As<UserAdministrationPage>().ClickUser(user.UniqueName);
                CurrentPage.As<UserEditPage>().AssignUserToPermissions(project, role, configuration.Environment, site, securityRole);
            }
        }
	}
}
