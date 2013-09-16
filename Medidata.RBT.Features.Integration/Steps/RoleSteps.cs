using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Medidata.Core.Common.Utilities;
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
    public class RoleSteps : BaseClassSteps
    {
        private const string locale = "eng";

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

        [Then(@"the user should have an EDC Role with ViewAllSites permission")]
        public void ThenTheUserShouldHaveAnEDCRoleWithViewAllSitesPermission()
        {
            var user = ScenarioContext.Current.Get<User>("user");
            var role = Role.Fetch(user.EdcRole.ID);
            Assert.AreEqual(role.PermissionsList[0], RolePermissionsEnum.ViewAllSites);
        }


        [Given(@"an EDC Role with Name ""(.*)"" and ViewAllSites permission exists in the Rave database")]
        public static void AnEdcRoleWithName____AndViewAllSitesPermissionExists(string name)
        {
            RoleHelper.AddRoleToDB(name, true);
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

        [Given(@"the user is assigned to the study with the following EDC roles?")]
        public void GivenTheUserIsAssignedToTheStudyWithTheFollowingEDCRoles(Table table)
        {
            var externalUser = ExternalUser.GetByExternalUUID(ScenarioContext.Current.Get<string>("externalUserUUID"), 1);

            var study = ScenarioContext.Current.Get<Study>("study");

            var roleNames = table.CreateSet<RoleNameModel>().ToList();
            var roles = Roles.GetAllRoles(); // get existing roles

            foreach (var roleNameObject in roleNames)
            {
                var user = ScenarioContext.Current.Get<User>("user");

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
                    UserHelper.CreateRaveUser(externalUser.Login, role);
                }

                ExternalUserRole.StudySave(1, externalUser.ID, study.ExternalID, study.Uuid, role.ID, DateTime.MinValue);
            }
        }

        [Then(@"the user should be assigned to the study with the following EDC roles?")]
        public void ThenTheUserShouldBeAssignedToTheStudyWithTheFollowingEDCRoles(Table table)
        {
            var externalUser = ExternalUser.GetByExternalUUID(ScenarioContext.Current.Get<string>("externalUserUUID"), 1);

            var study = ScenarioContext.Current.Get<Study>("study");

            var roleNames = table.CreateSet<RoleNameModel>().ToList();
            var roles = Roles.GetAllRoles();

            foreach (var roleNameObject in roleNames)
            {
                var role = roles.FindByName(roleNameObject.RoleName);
                var user = User.FindByRoleAndExternalID(role, externalUser.ExternalID, 1, SystemInteraction.Use());
                Assert.IsTrue(user != null);

                Assert.IsTrue(user.IsUserAssociatedWithStudy(study));
            }
        }

        [Then(@"the user should not be assigned to the study with the following EDC roles?")]
        public void ThenTheUserShouldNotBeAssignedToTheStudyWithTheFollowingEDCRoles(Table table)
        {
            var externalUser = ExternalUser.GetByExternalUUID(ScenarioContext.Current.Get<string>("externalUserUUID"), 1);

            var study = ScenarioContext.Current.Get<Study>("study");

            var roleNames = table.CreateSet<RoleNameModel>().ToList();
            var roles = Roles.GetAllRoles();

            foreach (var roleNameObject in roleNames)
            {
                var role = roles.FindByName(roleNameObject.RoleName);
                var user = User.FindByRoleAndExternalID(role, externalUser.ExternalID, 1, SystemInteraction.Use());
                Assert.IsTrue(user != null);

                Assert.IsFalse(user.IsUserAssociatedWithStudy(study));
            }
        }

        [Then(@"the user should be assigned to iMedidataEDC user group")]
        public void ThenTheUserShouldHaveTheIMedidataEDCUserGroupAssigned()
        {
            int iMedidataEdcUserGroupId;
            Int32.TryParse(Configuration.ConfigItem(ConfigTags.iMedidataEdcUserGroupID) as string, out iMedidataEdcUserGroupId);

            var externalUser = ExternalUser.GetByExternalUUID(ScenarioContext.Current.Get<string>("externalUserUUID"), 1);

            Assert.AreEqual(iMedidataEdcUserGroupId, externalUser.UserGroupID);
        }

        [Then(@"the user should be assigned to the following SecurityGroups? on the study")]
        public void ThenTheUserShouldBeAssignedToTheFollowingSecurityGroupsOnTheStudy(Table table)
        {
            var externalUser = ExternalUser.GetByExternalUUID(ScenarioContext.Current.Get<string>("externalUserUUID"), 1);

            var study = ScenarioContext.Current.Get<Study>("study");

            var roleNames = table.CreateSet<RoleNameModel>().ToList();

            var securityGroupIds = ExternalUserSecurityGroup.LoadSecurityGroupIDsByExternalUserIDandUUID(
                externalUser.ID, study.Uuid, true);
            var securityGroups =
                securityGroupIds.Select(securityGroupId => SecurityGroup.Fetch(securityGroupId, SystemInteraction.Use()))
                    .ToList();

            foreach (var roleNameObject in roleNames)
            {
                Assert.IsNotNull(RoleHelper.IsUserAssignedToSecurityGroup(securityGroups, roleNameObject.RoleName));
            }
        }

        [Then(@"the user should be assigned to the following UserGroup? on the study")]
        public void ThenTheUserShouldBeAssignedToTheFollowingUserGroupsOnTheStudy(Table table)
        {
            var externalUser = ExternalUser.GetByExternalUUID(ScenarioContext.Current.Get<string>("externalUserUUID"), 1);

            var study = ScenarioContext.Current.Get<Study>("study");

            var roleNames = table.CreateSet<RoleNameModel>().ToList();
            foreach (var roleNameObject in roleNames)
            {
                var userGroup = UserGroup.FetchByName(roleNameObject.RoleName, locale);
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

        [Given(@"the user is assigned to the following Security Groups? on the study")]
        public void GivenTheUserIsAssignedToTheFollowingSecurityGroupsOnTheStudy(Table table)
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
            var externalUser = ExternalUser.GetByExternalUUID(ScenarioContext.Current.Get<string>("externalUserUUID"), 1);
            var study = ScenarioContext.Current.Get<Study>("study");

            AUserGroupRoleWithName____Exists(userGroupName);
            var userGroup = ScenarioContext.Current.Get<UserGroup>("userGroup");
            externalUser.AddUserGroupForStudy(userGroup.ID, study.Uuid, true);
        }

        [Then(@"the user should not be assigned to the following SecurityGroups?")]
        public void ThenTheUserShouldNotBeAssignedToTheFollowingSecurityGroups(Table table)
        {
            var externalUser = ExternalUser.GetByExternalUUID(ScenarioContext.Current.Get<string>("externalUserUUID"), 1);

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

        [Then(@"the user should not be assigned to the following UserGroup? on the study")]
        public void ThenTheUserShouldNotBeAssignedToTheFollowingUserGroupsOnTheStudy(Table table)
        {
            var externalUser = ExternalUser.GetByExternalUUID(ScenarioContext.Current.Get<string>("externalUserUUID"), 1);

            var study = ScenarioContext.Current.Get<Study>("study");

            var roleNames = table.CreateSet<RoleNameModel>().ToList();
            foreach (var roleNameObject in roleNames)
            {
                var userGroup = UserGroup.FetchByName(roleNameObject.RoleName, locale);
                var userGroupsForStudy = externalUser.GetUserGroupForStudy(study.Uuid, true);
                Assert.IsFalse(userGroupsForStudy.Contains(userGroup.ID));
            }
        }

        [Then(@"the user with EDC Role ""(.*)"" should be assigned to the following studies")]
        public void ThenTheUserWithEDCRoleShouldBeAssignedToTheFollowingStudies(string roleName, Table table)
        {
            var externalUser = ExternalUser.GetByExternalUUID(ScenarioContext.Current.Get<string>("externalUserUUID"), 1);
            var role = Roles.GetAllRoles().FindByName(roleName);
            var user = User.FindByRoleAndExternalID(role, externalUser.ExternalID, 1, SystemInteraction.Use());

            var studies = table.CreateSet<StudyModel>().ToList();
            foreach (var studyModel in studies)
            {
                var study = Study.FindByUuid(studyModel.Uuid, SystemInteraction.Use(), 1);
                Assert.IsTrue(user.IsUserAssociatedWithStudy(study),
                    string.Format("User with Id {0} is not associated with study with Uuid {1}", user.ID, study.Uuid));
            }
        }

        [Then(@"the user with EDC Role ""(.*)"" should not be assigned to the following studies")]
        public void ThenTheUserWithEDCRoleShouldNotBeAssignedToTheFollowingStudies(string roleName, Table table)
        {
            var externalUser = ExternalUser.GetByExternalUUID(ScenarioContext.Current.Get<string>("externalUserUUID"), 1);
            var role = Roles.GetAllRoles().FindByName(roleName);
            var users = Users.FindByExternalUserID(externalUser.ID, SystemInteraction.Use());
            var user = users.First(x => x.EdcRole == role && x.ID != externalUser.ConnectedRaveUserID);

            var studies = table.CreateSet<StudyModel>().ToList();
            foreach (var studyModel in studies)
            {
                var study = Study.FindByUuid(studyModel.Uuid, SystemInteraction.Use(), 1);
                Assert.IsFalse(user.IsUserAssociatedWithStudy(study));
            }
        }

        [Then(@"the user with EDC Role ""(.*)"" should not be assigned to the following internal studies")]
        public void ThenTheUserWithEDCRoleShouldNotBeAssignedToTheFollowingInternalStudies(string roleName, Table table)
        {
            var externalUser = ExternalUser.GetByExternalUUID(ScenarioContext.Current.Get<string>("externalUserUUID"), 1);
            var role = Roles.GetAllRoles().FindByName(roleName);
            var users = Users.FindByExternalUserID(externalUser.ID, SystemInteraction.Use());
            var user = users.First(x => x.EdcRole == role && x.ID != externalUser.ConnectedRaveUserID);
            //var user = User.FindByRoleAndExternalID(role, externalUser.ExternalID, 1, SystemInteraction.Use());

            var studies = table.CreateSet<StudyModel>().ToList();
            foreach (var studyModel in studies)
            {
                var studyId = Study.GetIDByNameAndEnvironment(studyModel.StudyName, studyModel.Environment, locale,
                                                            SystemInteraction.Use());
                var study = Study.Fetch(studyId, SystemInteraction.Use());
                Assert.IsFalse(user.IsUserAssociatedWithStudy(study));
            }
        }

        [Then(@"the user with EDC Role ""(.*)"" should be assigned to the following SecurityGroups?")]
        public void ThenTheUserWithEDCRoleShouldBeAssignedToTheFollowingSecurityGroups(string roleName, Table table)
        {
            var externalUser = ExternalUser.GetByExternalUUID(ScenarioContext.Current.Get<string>("externalUserUUID"), 1);
            var role = Roles.GetAllRoles().FindByName(roleName);
            var user = User.FindByRoleAndExternalID(role, externalUser.ExternalID, 1, SystemInteraction.Use());

            var roleNames = table.CreateSet<RoleNameModel>().ToList();

            ///// only necessary for calling LoadSecurityGroupIDsByExternalUserID - not actually used.
            var externalUserSecurityGroupIDsBySecurityGroupID = new Dictionary<int, Int64>();
            var externalUserSecurityGroupIDs = new List<Int64>();
            /////
            
            var securityGroupIds = ExternalUserSecurityGroup.LoadSecurityGroupIDsByExternalUserID(externalUser.ID,
                                                                                                  out externalUserSecurityGroupIDsBySecurityGroupID,
                                                                                                  out externalUserSecurityGroupIDs);

            var securityGroups =
                securityGroupIds.Select(securityGroupId => SecurityGroup.Fetch(securityGroupId, SystemInteraction.Use()))
                    .ToList();
                
            foreach (var roleNameObject in roleNames)
            {
                Assert.IsTrue(RoleHelper.IsUserAssignedToSecurityGroup(securityGroups, roleNameObject.RoleName));
            }
        }

        [Then(@"the user with EDC Role ""(.*)"" should be assigned to the following UserGroup?")]
        public void ThenTheUserWithEDCRoleShouldBeAssignedToTheFollowingUserGroups(string roleName, Table table)
        {
            var externalUser = ExternalUser.GetByExternalUUID(ScenarioContext.Current.Get<string>("externalUserUUID"), 1);
            var role = Roles.GetAllRoles().FindByName(roleName);
            var user = User.FindByRoleAndExternalID(role, externalUser.ExternalID, 1, SystemInteraction.Use());

            var roleNames = table.CreateSet<RoleNameModel>().ToList();
            foreach (var roleNameObject in roleNames)
            {
                var userGroup = UserGroup.FetchByName(roleNameObject.RoleName, locale);
                Assert.AreEqual(user.UserGroupID, userGroup.ID);
            }
        }

        [Given(@"a UserGroup Role with Name ""(.*)"" and Architect permissions exists in the Rave database")]
        public void GivenAUserGroupRoleWithNameAndArchitectPermissionsExistsInTheRaveDatabase(string userGroupName)
        {
            RoleHelper.AddUserGroupToDB(userGroupName, true);
        }
        
        [Then(@"the user should have the default architect security role assigned")]
        public void ThenTheUserShouldHaveTheDefaultArchitectSecurityRoleAssigned()
        {
            var externalUser = ExternalUser.GetByExternalUUID(ScenarioContext.Current.Get<string>("externalUserUUID"), 1);
            var study = ScenarioContext.Current.Get<Study>("study");
            var projectCreatorDefaultRole = Configuration.GetProjectCreatorDefaultRole();

            var roles = ExternalUserRole.LoadRoleIDsByExternalUserID(externalUser.ID, study.Uuid, true);
            Assert.IsTrue(roles.Any(x => x == projectCreatorDefaultRole));
        }

        [Then(@"an internal user with role ""(.*)"" exists")]
        public void ThenAnInternalUserWithRoleExists(string roleName)
        {
            var externalUser = ExternalUser.GetByExternalUUID(ScenarioContext.Current.Get<string>("externalUserUUID"), 1);
            var role = Roles.GetAllRoles().FindByName(roleName);
            var user = User.FindByRoleAndExternalID(role, externalUser.ExternalID, 1, SystemInteraction.Use());
            Assert.IsNotNull(user);
            ScenarioContext.Current.Set(user, "user");
        }

    }
}
