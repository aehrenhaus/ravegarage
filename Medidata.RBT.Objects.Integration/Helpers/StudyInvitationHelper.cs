
using System;
using Medidata.Core.Objects;
using TechTalk.SpecFlow;

namespace Medidata.RBT.Objects.Integration.Helpers
{
    public static class StudyInvitationHelper
    {
        public static void AssignUserToStudy()
        {
            var externalUserID = ScenarioContext.Current.Get<int>("externalUserID");
            var studyUuid = ScenarioContext.Current.Get<String>("studyUuid");
            var roleID = ScenarioContext.Current.Get<int>("roleID");
            var user = ScenarioContext.Current.Get<User>("userObject");

            user.EdcRole = Role.Fetch(roleID);
            user.Save();

            ExternalUserRole.StudySave(1, externalUserID,
                                                    0, studyUuid, roleID, DateTime.Now,
                                                    true);
        }
    }
}
