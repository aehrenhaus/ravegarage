using System;
using System.Linq;
using Medidata.Core.Objects;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using TechTalk.SpecFlow;

namespace Medidata.RBT.Features.Integration.Steps
{
    [Binding]
    public class UserSteps
    {
        // For additional details on SpecFlow step definitions see http://go.specflow.org/doc-stepdef

        [Then(@"I should see the user in the Rave database")]
        public void ThenIShouldSeeTheUserInTheRaveDatabase()
        {
            var uuid = ScenarioContext.Current.Get<String>("userUuid");
            var externalUser = ExternalUser.GetByExternalUUID(uuid, 1);

            Assert.IsNotNull(externalUser);

            var users = Users.FindByExternalUserID(externalUser.ID, SystemInteraction.Use());

            var user = users.FirstOrDefault(x => x.EdcRole == null); // this can be extended to look for specific roles
            Assert.IsNotNull(user);

            ScenarioContext.Current.Add("user", user);
        }
    }
}
