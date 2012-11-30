﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using TechTalk.SpecFlow;
using Medidata.RBT.PageObjects.Rave.SharedRaveObjects;
using Medidata.RBT.PageObjects.Rave;
using Medidata.RBT.PageObjects.Rave.Configuration;
using TechTalk.SpecFlow.Assist;
using Microsoft.VisualStudio.TestTools.UnitTesting;

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
        /// 
        /// </summary>
        /// <param name="roleName">name of the role</param>
        /// <param name="actionName">name of the action</param>
        /// <param name="actionGroupName">name of the action group</param>
        /// <param name="status">status one of "Checked" and "Unchecked"</param>
        [StepDefinition(@"Role ""([^""]*)"" has Action ""([^""]*)"" in ActionGroup ""([^""]*)"" with Status ""([^""]*)""")]
		public void Role____HasAction____InActionGroup____WithStatus____(string roleName, string actionName, string actionGroupName, string status)
		{
            CurrentPage = new WorkflowConfigPage().NavigateToSelf();
            Role role = TestContext.GetExistingFeatureObjectOrMakeNew(roleName, () => new Role(roleName));
            CurrentPage.As<WorkflowConfigPage>().ClickActionsLinkForGivenRole(role.UniqueName);
            CurrentPage.As<RoleActionsConfigPage>().ChooseFromDropdown("DisplayGroupDDL", actionGroupName);
            bool expected = status.Equals("Checked");
            bool actual = CurrentPage.As<RoleActionsConfigPage>().ClickEditFromRoleActionGridAndCheckState(actionName);
            Assert.IsTrue(actual == expected, String.Format("Action {0} is not set as expected {1}.", actual, expected));
		}

        /// <summary>
        /// Create a role if none already exists
        /// </summary>
        /// <param name="roleName">The name that the role is referred to as in the feature file</param>
        [StepDefinition(@"role ""([^""]*)"" exists")]
        public void Role____Exists(string roleName)
        {
            TestContext.GetExistingFeatureObjectOrMakeNew(roleName, () => new Role(roleName));
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
                Project project = TestContext.GetExistingFeatureObjectOrMakeNew(config.Project, () => new Project(config.Project));
                TestContext.CurrentPage.As<ArchitectPage>().ClickProject(project.UniqueName);
                Draft draft = TestContext.GetExistingFeatureObjectOrMakeNew(config.Draft, () => new Draft(config.Draft));
                TestContext.CurrentPage.As<ArchitectLibraryPage>().ClickDraft(draft.UniqueName);
                TestContext.CurrentPage.As<ArchitectCRFDraftPage>().ClickLink("Restrictions");
                Role role = TestContext.GetExistingFeatureObjectOrMakeNew(roleName, () => new Role(roleName));
                TestContext.CurrentPage.As<ArchitectRestrictionsPage>().SetEntryRestriction(config.Form, config.Field, role.UniqueName);
            }
        }
	}
}
