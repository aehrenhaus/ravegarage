
using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using Medidata.Core.Common.Utilities;
using Medidata.Core.Objects;
using Medidata.Core.Objects.Security;
using TechTalk.SpecFlow;

namespace Medidata.RBT.Objects.Integration.Helpers
{
    public static class RoleHelper
    {
        private const string locale = "eng";

        public static void AddRoleToDB(string name, bool viewAllSites = false)
        {
            Role role;
            if (!Role.IsRoleNameUnique(name))
            {
                role = Roles.GetAllRoles().FindByName(name);
            }
            else
            {
                role = new Role
                           {
                               RoleName = name,
                               IsActive = true                              
                           };

                if(viewAllSites)
                {
                    var user = ScenarioContext.Current.Get<User>("user");
                    role.SetPermissions(new ArrayList(){ RolePermissionsEnum.ViewAllSites }, user.ID);
                }
                
                role.Save();    
            }
            ScenarioContext.Current.Set(role, "role");
        }

        public static void AddSecurityGroupToDB(string name)
        {
            SecurityGroup securityGroup = null;
            if(!SecurityGroup.IsNameUnique(name, locale))
            {
                var securityGroupCollection = new SecurityGroupCollection();
                securityGroupCollection.Load(SystemInteraction.Use());

                for (var i = 0; i < securityGroupCollection.Count; i++)
                {
                    if (securityGroupCollection[i].Name != name) continue;

                    securityGroup = securityGroupCollection[i];
                    break;
                }
            }
            else
            {
                securityGroup = new SecurityGroup(SystemInteraction.Use())
                                    {
                                        Name = name,
                                        Active = true
                                    };
                securityGroup.Save();
            }
            ScenarioContext.Current.Set(securityGroup, "securityGroup");
        }

        public static void AddUserGroupToDB(string name, bool needsArchitect = false)
        {
            var userGroup = UserGroup.FetchByName(name, locale);

            if (userGroup == null)
            {
                userGroup = new UserGroup() {GroupName = name};
                if (needsArchitect) userGroup.SetPermissions(new ArrayList() {UserGroupPermissionsEnum.SeeAllModules});
                userGroup.Save();

                if (needsArchitect)
                {
                    UserModule.NewUserModule(InstalledModule.Load().FindByModuleName("ARCH").ID, userGroup.ID);
                }
            }
            ScenarioContext.Current.Set(userGroup, "userGroup");
        }

        public static void AssignUserToStudyWithCurrentRole()
        {
            var externalUserId = ScenarioContext.Current.ContainsKey("externalUserID")
                                     ? ScenarioContext.Current.Get<int>("externalUserID")
                                     : 0;
            var study = ScenarioContext.Current.Get<Study>("study");
            var role = ScenarioContext.Current.Get<Role>("role");
            var user = ScenarioContext.Current.Get<User>("user");

            user.EdcRole = role;
            user.Save();

            if (externalUserId > 0) ExternalUserRole.StudySave(1, externalUserId, 0, study.Uuid, role.ID, DateTime.Now);
            else user.AddUserToStudy(study, role);
        }

        public static bool IsUserAssignedToSecurityGroup(List<SecurityGroup> securityGroups, string roleName)
        {
            return securityGroups.FirstOrDefault(x => x.Name == roleName) != null;
        }
    }
}