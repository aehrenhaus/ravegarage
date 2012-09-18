using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using TechTalk.SpecFlow;
using Medidata.RBT.PageObjects.Rave.SharedRaveObjects;
using Medidata.RBT.PageObjects.Rave;
using Medidata.RBT.PageObjects.Rave.Configuration;
using TechTalk.SpecFlow.Assist;

namespace Medidata.RBT.Features.Rave
{
	[Binding]
	public class RoleSteps : BrowserStepsBase
	{
		[StepDefinition(@"Role ""([^""]*)"" has Action ""([^""]*)""")]
		public void Role____HasAction____(string roleName, string actionNames)
		{

		}

        /// <summary>
        /// Create a role if none already exists
        /// </summary>
        /// <param name="roleName">The name that the role is referred to as in the feature file</param>
        [StepDefinition(@"role ""([^""]*)"" exists")]
        public void Role____Exists(string roleName)
        {
            new Role(roleName, true);
        }

        /// <summary>
        /// Set entry restrictions for the role
        /// </summary>
        /// <param name="roleName">The name that the role is referred to as in the feature file</param>
        /// <param name="table">The location of the entry restriction</param>
        [StepDefinition(@"Entry Restricted is set for role ""([^""]*)"" in")]
        public void EntryRestrictedIsSetForRole____In(string roleName, Table table)
        {
            List<ConfigurationCreationModel> configurations = table.CreateSet<ConfigurationCreationModel>().ToList();
            foreach(ConfigurationCreationModel config in configurations)
            {
                TestContext.CurrentPage = new ArchitectPage().NavigateToSelf();

                TestContext.CurrentPage.As<ArchitectPage>().ClickProject(new Project(config.Project).UniqueName);
                TestContext.CurrentPage.As<ArchitectLibraryPage>().ClickDraft(new Draft(config.Draft).Name);
                TestContext.CurrentPage.As<ArchitectCRFDraftPage>().ClickLink("Restrictions");
                TestContext.CurrentPage.As<ArchitectRestrictionsPage>().SetEntryRestriction(config.Form, config.Field, new Role(roleName).UniqueName);
            }
        }
	}
}
