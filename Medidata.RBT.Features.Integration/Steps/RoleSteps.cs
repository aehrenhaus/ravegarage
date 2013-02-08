using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
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
    public class RoleSteps
    {
        [Given(@"the current User is assigned to the current Study with current Role")]
        public void CurrentUserAssignedToCurrentStudyWithCurrentRole()
        {
            RoleHelper.AssignUserToStudyWithCurrentRole();
        }

        [Given(@"an EDC Role with Name ""(.*)"" exists in the Rave database")]
        public static void AnEdcRoleWithName____Exists(string name)
        {
            RoleHelper.AddRoleToDB(name);
        }

        [Given(@"a SecurityGroup Role with Name ""(.*)"" exists in the Rave database")]
        public static void ASecurityGroupRoleWithName____Exists(string name)
        {
            RoleHelper.AddSecurityGroupToDB(name);
        }

        [Given(@"a UserGroup Role with Name ""(.*)"" exists in the Rave database")]
        public static void AUserGroupRoleWithName____Exists(string name)
        {
            RoleHelper.AddUserGroupToDB(name);
        }

        [Given(@"the user is assigned to the study with the following EDC role\(s\)")]
        public void GivenTheUserIsAssignedToTheStudyWithTheFollowingEDCRoleS(Table table)
        {
            var externalUserUuid = ScenarioContext.Current.Get<string>("externalUserUUID");
            var externalUser = ExternalUser.GetByExternalUUID(externalUserUuid, 1);

            var study = ScenarioContext.Current.Get<Study>("study");

            var roleNames = table.CreateSet<RoleNameModel>().ToList();
            var roles = Roles.GetAllRoles(); // get existing roles

            var user = ScenarioContext.Current.Get<User>("user");

            foreach (var roleNameObject in roleNames)
            {
                var role = roles.FindByName(roleNameObject.RoleName);
                if (role == null) // create role that doesn't exist
                {
                    RoleHelper.AddRoleToDB(roleNameObject.RoleName);
                    role = ScenarioContext.Current.Get<Role>("role");
                }

                if (user.EdcRole == null)
                {
                    user.EdcRole = role;
                    user.Save();
                }
                else
                {
                    user = UserHelper.CreateRaveUserWithEdcRole(role);
                }

                ExternalUserRole.StudySave(1, externalUser.ID, study.ExternalID, study.Uuid, role.ID, DateTime.MinValue);
            }
        }

        [Then(@"the user should be assigned to the study with the following EDC role\(s\)")]
        public void ThenTheUserShouldBeAssignedToTheStudyWithTheFollowingEDCRoleS(Table table)
        {
            var externalUserUuid = ScenarioContext.Current.Get<string>("externalUserUUID");
            var externalUser = ExternalUser.GetByExternalUUID(externalUserUuid, 1);

            var study = ScenarioContext.Current.Get<Study>("study");

            var roleNames = table.CreateSet<RoleNameModel>().ToList();
            var roles = Roles.GetAllRoles();

            foreach (var roleNameObject in roleNames)
            {
                var role = roles.FindByName(roleNameObject.RoleName);
                var user = User.FindByRoleAndExternalID(role, externalUser.ExternalID, 1, SystemInteraction.Use());
                Assert.IsTrue(user != null);

                var userIsAssociatedWithStudy = user.IsUserAssociatedWithStudy(study);
                Assert.IsTrue(userIsAssociatedWithStudy);
            }
        }

        [Then(@"the user should not be assigned to the study with the following EDC role\(s\)")]
        public void ThenTheUserShouldNotBeAssignedToTheStudyWithTheFollowingEDCRoleS(Table table)
        {
            var externalUserUuid = ScenarioContext.Current.Get<string>("externalUserUUID");
            var externalUser = ExternalUser.GetByExternalUUID(externalUserUuid, 1);

            var study = ScenarioContext.Current.Get<Study>("study");

            var roleNames = table.CreateSet<RoleNameModel>().ToList();
            var roles = Roles.GetAllRoles();

            foreach (var roleNameObject in roleNames)
            {
                var role = roles.FindByName(roleNameObject.RoleName);
                var user = User.FindByRoleAndExternalID(role, externalUser.ExternalID, 1, SystemInteraction.Use());
                Assert.IsTrue(user != null);

                var userIsAssociatedWithStudy = user.IsUserAssociatedWithStudy(study);
                Assert.IsFalse(userIsAssociatedWithStudy);
            }
        }

        [Then(@"the user should have the iMedidataEDC user group assigned")]
        public void ThenTheUserShouldHaveTheIMedidataEDCUserGroupAssigned()
        {
            int iMedidataEdcUserGroupId;
            int.TryParse(Configuration.ConfigItem(ConfigTags.iMedidataEdcUserGroupID) as string, out iMedidataEdcUserGroupId);

            var externalUserUuid = ScenarioContext.Current.Get<string>("externalUserUUID");
            var externalUser = ExternalUser.GetByExternalUUID(externalUserUuid, 1);

            Assert.AreEqual(iMedidataEdcUserGroupId, externalUser.UserGroupID);
        }

        [Then(@"the user should be assigned to the following SecurityGroup\(s\) on the study")]
        public void ThenTheUserShouldBeAssignedToTheFollowingSecurityGroupSOnTheStudy(Table table)
        {
            var externalUserUuid = ScenarioContext.Current.Get<string>("externalUserUUID");
            var externalUser = ExternalUser.GetByExternalUUID(externalUserUuid, 1);

            var study = ScenarioContext.Current.Get<Study>("study");

            var roleNames = table.CreateSet<RoleNameModel>().ToList();

            var securityGroupIds = ExternalUserSecurityGroup.LoadSecurityGroupIDsByExternalUserIDandUUID(
                externalUser.ID, study.Uuid, true);
            var securityGroups =
                securityGroupIds.Select(securityGroupId => SecurityGroup.Fetch(securityGroupId, SystemInteraction.Use()))
                    .ToList();

            foreach (var roleNameObject in roleNames)
            {
                var secGrp = securityGroups.FirstOrDefault(securityGroup => securityGroup.Name == roleNameObject.RoleName);
                Assert.IsNotNull(secGrp);
            }
        }

        [Then(@"the user should be assigned to the following UserGroup\(s\) on the study")]
        public void ThenTheUserShouldBeAssignedToTheFollowingUserGroupSOnTheStudy(Table table)
        {
            var externalUserUuid = ScenarioContext.Current.Get<string>("externalUserUUID");
            var externalUser = ExternalUser.GetByExternalUUID(externalUserUuid, 1);

            var study = ScenarioContext.Current.Get<Study>("study");

            var roleNames = table.CreateSet<RoleNameModel>().ToList();
            foreach (var roleNameObject in roleNames)
            {
                var userGroup = UserGroup.FetchByName(roleNameObject.RoleName, "eng");
                var userGroupsForStudy = externalUser.GetUserGroupForStudy(study.Uuid, true);
                Assert.IsTrue(userGroupsForStudy.Contains(userGroup.ID));
            }
        }

        [Then(@"the Rave user with EDC role ""(.*)"" should be inactive")]
        public void ThenTheRaveUserWithEdcRoleShouldBeInactive(string roleName)
        {
            var externalUserUuid = ScenarioContext.Current.Get<string>("externalUserUUID");
            var externalUser = ExternalUser.GetByExternalUUID(externalUserUuid, 1);

            var roles = Roles.GetAllRoles();
            var role = roles.FindByName(roleName);

            var user = User.FindByRoleAndExternalID(role, externalUser.ExternalID, 1, SystemInteraction.Use());
            
            Assert.IsFalse(user.Active);
        }

        [Given(@"the user is assigned to the following Security Group\(s\) on the study")]
        public void GivenTheUserIsAssignedToTheFollowingSecurityGroupSOnTheStudy(Table table)
        {
            var externalUserUuid = ScenarioContext.Current.Get<string>("externalUserUUID");
            var externalUser = ExternalUser.GetByExternalUUID(externalUserUuid, 1);
            
            var study = ScenarioContext.Current.Get<Study>("study");
            
            var roleNames = table.CreateSet<RoleNameModel>().ToList();
            foreach (var roleNameObject in roleNames)
            {
                ASecurityGroupRoleWithName____Exists(roleNameObject.RoleName);
                var securityGroup = ScenarioContext.Current.Get<SecurityGroup>("securityGroup");
                ExternalUserSecurityGroup.Save(externalUser.ID, securityGroup.ID, study.Uuid, true, DateTime.MinValue);
            }
        }

        [Given(@"the User is assigned to the ""(.*)"" User Group on the study")]
        public void GivenTheUserIsAssignedToTheUserGroupOnTheStudy(string userGroupName)
        {
            var externalUserUuid = ScenarioContext.Current.Get<string>("externalUserUUID");
            var externalUser = ExternalUser.GetByExternalUUID(externalUserUuid, 1);
            var study = ScenarioContext.Current.Get<Study>("study");

            AUserGroupRoleWithName____Exists(userGroupName);
            var userGroup = ScenarioContext.Current.Get<UserGroup>("userGroup");
            externalUser.AddUserGroupForStudy(userGroup.ID, study.Uuid, true);
        }

        [Then(@"the user should not be assigned to the following SecurityGroup\(s\)")]
        public void ThenTheUserShouldNotBeAssignedToTheFollowingSecurityGroupS(Table table)
        {
            var externalUserUuid = ScenarioContext.Current.Get<string>("externalUserUUID");
            var externalUser = ExternalUser.GetByExternalUUID(externalUserUuid, 1);

            var study = ScenarioContext.Current.Get<Study>("study");

            var roleNames = table.CreateSet<RoleNameModel>().ToList();

            var securityGroupIds = ExternalUserSecurityGroup.LoadSecurityGroupIDsByExternalUserIDandUUID(
                externalUser.ID, study.Uuid, true);
            var securityGroups =
                securityGroupIds.Select(securityGroupId => SecurityGroup.Fetch(securityGroupId, SystemInteraction.Use()))
                    .ToList();

            foreach (var roleNameObject in roleNames)
            {
                var secGrp = securityGroups.FirstOrDefault(securityGroup => securityGroup.Name == roleNameObject.RoleName);
                Assert.IsNull(secGrp);
            }
        }

        [Then(@"the user should not be assigned to the following UserGroup\(s\) on the study")]
        public void ThenTheUserShouldNotBeAssignedToTheFollowingUserGroupSOnTheStudy(Table table)
        {
            var externalUserUuid = ScenarioContext.Current.Get<string>("externalUserUUID");
            var externalUser = ExternalUser.GetByExternalUUID(externalUserUuid, 1);

            var study = ScenarioContext.Current.Get<Study>("study");

            var roleNames = table.CreateSet<RoleNameModel>().ToList();
            foreach (var roleNameObject in roleNames)
            {
                var userGroup = UserGroup.FetchByName(roleNameObject.RoleName, "eng");
                var userGroupsForStudy = externalUser.GetUserGroupForStudy(study.Uuid, true);
                Assert.IsFalse(userGroupsForStudy.Contains(userGroup.ID));
            }
        }

    }
}
