﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using TechTalk.SpecFlow;
using Medidata.RBT.PageObjects.Rave;
using Medidata.RBT.PageObjects.Rave.Configuration;
using TechTalk.SpecFlow.Assist;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Medidata.RBT.PageObjects.Rave.SeedableObjects;

namespace Medidata.RBT.Features.Rave
{
    /// <summary>
    /// Steps pertaining to the role
    /// </summary>
	[Binding]
	public class RoleSteps : BrowserStepsBase
	{
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
            Role role = SeedingContext.GetExistingFeatureObjectOrMakeNew(roleName, () => new Role(roleName));
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
            SeedingContext.GetExistingFeatureObjectOrMakeNew(roleName, () => new Role(roleName));
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
                WebTestContext.CurrentPage = new ArchitectPage().NavigateToSelf();
                Project project = SeedingContext.GetExistingFeatureObjectOrMakeNew(config.Project, () => new Project(config.Project));
                WebTestContext.CurrentPage.As<ArchitectPage>().ClickProject(project.UniqueName);
                Draft draft = SeedingContext.GetExistingFeatureObjectOrMakeNew(config.Draft, () => new Draft(config.Draft));
                WebTestContext.CurrentPage.As<ArchitectLibraryPage>().ClickDraft(draft.UniqueName);
                WebTestContext.CurrentPage.As<ArchitectCRFDraftPage>().ClickLink("Restrictions");
                Role role = SeedingContext.GetExistingFeatureObjectOrMakeNew(roleName, () => new Role(roleName));
                WebTestContext.CurrentPage.As<ArchitectRestrictionsPage>().SetFieldEntryRestriction(config.Form, config.Field, role.UniqueName, true);
            }
        }
        
        /// <summary>
        /// Set field entry restrictions for the role
        /// </summary>
        /// <param name="table">The location of the restriction</param>
        [StepDefinition(@"I update field Entry Restriction for role")]
        public void UpdateFieldEntryRestriction____In(Table table)
        {
            List<ConfigurationCreationModel> configurations = table.CreateSet<ConfigurationCreationModel>().ToList();
            foreach (ConfigurationCreationModel config in configurations)
            {
                Role role = SeedingContext.GetExistingFeatureObjectOrMakeNew(config.Role, () => new Role(config.Role));
                if (WebTestContext.CurrentPage.GetType() == typeof(ArchitectRestrictionsPage))
                    WebTestContext.CurrentPage.As<ArchitectRestrictionsPage>().SetFieldEntryRestriction(config.Form, config.Field, role.UniqueName, config.Selected);
                else
                    WebTestContext.CurrentPage.As<ArchitectFormDesignerPage>().SetFieldEntryRestriction(role.UniqueName, config.Selected); 
            }
        }


        /// <summary>
        /// Set field view restrictions for the role
        /// </summary>
        /// <param name="table">The location of the restriction</param>
        [StepDefinition(@"I update field View Restriction for role")]
        public void UpdateFieldViewRestriction____In(Table table)
        {
            List<ConfigurationCreationModel> configurations = table.CreateSet<ConfigurationCreationModel>().ToList();
            foreach (ConfigurationCreationModel config in configurations)
            {
                Role role = SeedingContext.GetExistingFeatureObjectOrMakeNew(config.Role, () => new Role(config.Role));
                if (WebTestContext.CurrentPage.GetType() == typeof(ArchitectRestrictionsPage))
                    WebTestContext.CurrentPage.As<ArchitectRestrictionsPage>().SetFieldViewRestriction(config.Form, config.Field, role.UniqueName, config.Selected);
                else
                    WebTestContext.CurrentPage.As<ArchitectFormDesignerPage>().SetFieldViewRestriction(role.UniqueName, config.Selected); 
            }
        }

        /// <summary>
        /// Set form view restrictions for the role
        /// </summary>
        /// <param name="table">The location of the restriction</param>
        [StepDefinition(@"I update form View Restriction for role")]
        public void UpdateViewRestrictedIsSetForRole____In(Table table)
        {
            List<ConfigurationCreationModel> configurations = table.CreateSet<ConfigurationCreationModel>().ToList();
            foreach (ConfigurationCreationModel config in configurations)
            {
                Role role = SeedingContext.GetExistingFeatureObjectOrMakeNew(config.Role, () => new Role(config.Role));
                WebTestContext.CurrentPage.As<ArchitectRestrictionsPage>().SetFormViewRestriction(config.Form, role.UniqueName, config.Selected);
            }
        }

        /// <summary>
        /// Set form entry restrictions for the role
        /// </summary>
        /// <param name="table">The location of the restriction</param>
        [StepDefinition(@"I update form Entry Restriction for role")]
        public void UpdateEntryRestrictedIsSetForRole____In(Table table)
        {
            List<ConfigurationCreationModel> configurations = table.CreateSet<ConfigurationCreationModel>().ToList();
            foreach (ConfigurationCreationModel config in configurations)
            {
                Role role = SeedingContext.GetExistingFeatureObjectOrMakeNew(config.Role, () => new Role(config.Role));
                WebTestContext.CurrentPage.As<ArchitectRestrictionsPage>().SetFormEntryRestriction(config.Form, role.UniqueName, config.Selected);
            }
        }


        /// <summary>
        /// Set global view restrictions for the role 
        /// </summary>
        /// <param name="table">The location of the restriction</param>
        [StepDefinition(@"I update Global View Restrictions for role")]
        public void UpdateGlobalViewRestrictedIsSetForRole____In(Table table)
        {
            List<ConfigurationCreationModel> configurations = table.CreateSet<ConfigurationCreationModel>().ToList();
            foreach (ConfigurationCreationModel config in configurations)
            {
                Role role = SeedingContext.GetExistingFeatureObjectOrMakeNew(config.Role, () => new Role(config.Role));
                WebTestContext.CurrentPage.As<ArchitectRestrictionsPage>().SetGlobalFormViewRestriction(config.Form, role.UniqueName, config.Selected);
            }
        }

        /// <summary>
        /// Set global entry restrictions for the role
        /// </summary>
        /// <param name="table">The location of the restriction</param>
        [StepDefinition(@"I update Global Entry Restrictions for role")]
        public void UpdateGlobalEntryRestrictedIsSetForRole____In(Table table)
        {
            List<ConfigurationCreationModel> configurations = table.CreateSet<ConfigurationCreationModel>().ToList();
            foreach (ConfigurationCreationModel config in configurations)
            {
                Role role = SeedingContext.GetExistingFeatureObjectOrMakeNew(config.Role, () => new Role(config.Role));
                WebTestContext.CurrentPage.As<ArchitectRestrictionsPage>().SetGlobalFormEntryRestriction(config.Form, role.UniqueName, config.Selected);
            }
        }
	}
}
