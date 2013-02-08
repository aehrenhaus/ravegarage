
using System;
using Medidata.Core.Objects;
using Medidata.Core.Objects.Security;
using TechTalk.SpecFlow;

namespace Medidata.RBT.Objects.Integration.Helpers
{
    public static class RoleHelper
    {
        public static void AddRoleToDB(string name)
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
                role.Save();    
            }
            ScenarioContext.Current.Set(role, "role");
        }

        public static void AddSecurityGroupToDB(string name)
        {
            SecurityGroup securityGroup = null;
            if(!SecurityGroup.IsNameUnique(name, "eng"))
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

        public static void AddUserGroupToDB(string name)
        {
            var userGroup = UserGroup.FetchByName(name, "eng");

            if (userGroup == null)
            {
                userGroup = new UserGroup() {GroupName = name};
                userGroup.Save();
            }
            ScenarioContext.Current.Set(userGroup, "userGroup");
        }

        public static void AssignUserToStudyWithCurrentRole()
        {
            var externalUserId = ScenarioContext.Current.Get<int>("externalUserID");
            var studyUuid = ScenarioContext.Current.Get<Study>("study").Uuid;
            var role = ScenarioContext.Current.Get<Role>("role");
            var user = ScenarioContext.Current.Get<User>("user");

            user.EdcRole = role;
            user.Save();

            ExternalUserRole.StudySave(1, externalUserId, 0, studyUuid, role.ID, DateTime.Now);
        }
    }
}
