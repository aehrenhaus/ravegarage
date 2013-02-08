
using System;
using Medidata.Core.Objects;
using TechTalk.SpecFlow;

namespace Medidata.RBT.Objects.Integration.Helpers
{
    public static class RoleHelper
    {
        public static void AddRoleToDB(string name)
        {
            var role = new Role
                           {
                               RoleName = name,
                               IsActive = true
                           };
            role.Save();
            ScenarioContext.Current.Add("roleID", role.ID);
        }

        public static void AssignUserToStudyWithCurrentRole()
        {
            var externalUserID = ScenarioContext.Current.Get<int>("externalUserID");
            var studyUuid = ScenarioContext.Current.Get<Study>("study").Uuid;
            var roleID = ScenarioContext.Current.Get<int>("roleID");
            var user = ScenarioContext.Current.Get<User>("user");

            user.EdcRole = Role.Fetch(roleID);
            user.Save();

            ExternalUserRole.StudySave(1, externalUserID, 0, studyUuid, roleID, DateTime.Now);
        }
    }
}
