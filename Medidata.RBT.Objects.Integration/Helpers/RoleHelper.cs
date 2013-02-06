
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
    }
}
