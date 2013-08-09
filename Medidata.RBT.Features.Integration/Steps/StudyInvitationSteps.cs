using System;
using System.Collections.Generic;
using System.Linq;
using Medidata.Core.Objects;
using Medidata.Core.Objects.Security;
using Medidata.RBT.Objects.Integration.Configuration.Models;
using Medidata.RBT.Objects.Integration.Helpers;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using TechTalk.SpecFlow;
using TechTalk.SpecFlow.Assist;

namespace Medidata.RBT.Features.Integration.Steps
{
    [Binding]
    public class StudyInvitationSteps : BaseClassSteps
    {
        [Given(@"I have an EDC app assignment with the following roles?")]
        public void GivenIHaveAnEDCAppAssignmentWithTheFollowingRoles(Table table)
        {
            var roleNames = table.CreateSet<RoleNameModel>().ToList();

            var edcAppAssignments = new AppAssignmentModel() { RoleOids = new List<RoleModel>() };

            foreach (var roleNameObject in roleNames)
            {
                RoleSteps.AnEdcRoleWithName____Exists(roleNameObject.RoleName);
                var role = ScenarioContext.Current.Get<Role>("role");
                edcAppAssignments.RoleOids.Add(new RoleModel { Oid = "R|" + role.ID });
            }

            ScenarioContext.Current.Set(edcAppAssignments, "edcAppAssignments");
        }

        [Given(@"I have an Architect Security app assignment with the following roles?")]
        public void GivenIHaveAnArchitectSecurityAppAssignmentWithTheFollowingRoles(Table table)
        {
            var roleNames = table.CreateSet<RoleNameModel>().ToList();

            var architectAppAssignments = new AppAssignmentModel() { RoleOids = new List<RoleModel>() };

            foreach (var roleNameObject in roleNames)
            {
                RoleSteps.ASecurityGroupRoleWithName____Exists(roleNameObject.RoleName);
                var securityGroup = ScenarioContext.Current.Get<SecurityGroup>("securityGroup");
                architectAppAssignments.RoleOids.Add(new RoleModel { Oid = "S|" + securityGroup.ID });
            }

            ScenarioContext.Current.Set(architectAppAssignments, "architectAppAssignments");
        }

        [Given(@"I have a Modules app assignment with the following roles?")]
        public void GivenIHaveAModulesAppAssignmentWithTheFollowingRoles(Table table)
        {
            var roleNames = table.CreateSet<RoleNameModel>().ToList();

            var modulesAppAssignments = new AppAssignmentModel() { RoleOids = new List<RoleModel>() };

            foreach (var roleNameObject in roleNames)
            {
                RoleSteps.AUserGroupRoleWithName____Exists(roleNameObject.RoleName);
                var userGroup = ScenarioContext.Current.Get<UserGroup>("userGroup");
                modulesAppAssignments.RoleOids.Add(new RoleModel { Oid = "G|" + userGroup.ID });
            }

            ScenarioContext.Current.Set(modulesAppAssignments, "modulesAppAssignments");
        }

    }
}