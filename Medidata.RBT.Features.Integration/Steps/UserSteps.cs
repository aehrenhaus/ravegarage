using System.Linq;
using Medidata.Core.Common.Utilities;
using Medidata.Core.Objects;
using Medidata.RBT.Objects.Integration.Helpers;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using TechTalk.SpecFlow;

namespace Medidata.RBT.Features.Integration.Steps
{
    [Binding]
    public class UserSteps
    {
        // For additional details on SpecFlow step definitions see http://go.specflow.org/doc-stepdef

        [Given(@"the User with login ""(.*)"" exists in the Rave database")]
        public void TheUserWithLogin____ExistsInTheRaveDatabase(string login)
        {
            UserHelper.CreateRaveUser(login);
        }

        [Then(@"I should see the user in the Rave database")]
        public void ThenIShouldSeeTheUserInTheRaveDatabase()
        {
            var externalUser = ExternalUser.Fetch(ScenarioContext.Current.Get<int>("externalUserID"));
            Assert.IsNotNull(externalUser);

            var users = Users.FindByExternalUserID(externalUser.ID, SystemInteraction.Use());

            var user = users.FirstOrDefault(x => x.EdcRole == null);

            Assert.IsNotNull(user);

            ScenarioContext.Current.Set(user, "user"); //updates the user in the context to reflect updates made by RISS
        }

        [StepDefinition(@"the user should have Email ""(.*)""")]
        public void TheUserShouldHaveEmail____(string email)
        {
            var user = ScenarioContext.Current.Get<User>("user");
            Assert.AreEqual(email, user.Email);
        }

        [StepDefinition(@"the user should have Login ""(.*)""")]
        public void TheUserShouldHaveLogin____(string login)
        {
            var user = ScenarioContext.Current.Get<User>("user");
            Assert.AreEqual(login, user.Login);
        }

        [StepDefinition(@"the user should have FirstName ""(.*)""")]
        public void TheUserShouldHaveFirstName____(string firstName)
        {
            var user = ScenarioContext.Current.Get<User>("user");
            Assert.AreEqual(firstName, user.FirstName);
        }

        [StepDefinition(@"the user should have MiddleName ""(.*)""")]
        public void TheUserShouldHaveMiddleName____(string middleName)
        {
            var user = ScenarioContext.Current.Get<User>("user");
            Assert.AreEqual(middleName, user.MiddleName);
        }

        [StepDefinition(@"the user should have LastName ""(.*)""")]
        public void TheUserShouldHaveLastName____(string lastName)
        {
            var user = ScenarioContext.Current.Get<User>("user");
            Assert.AreEqual(lastName, user.LastName);
        }

        [StepDefinition(@"the user should have Address1 ""(.*)""")]
        public void TheUserShouldHaveAddress1____(string address1)
        {
            var user = ScenarioContext.Current.Get<User>("user");
            Assert.AreEqual(address1, user.AddressLine1);
        }

        [StepDefinition(@"the user should have City ""(.*)""")]
        public void TheUserShouldHaveCity____(string city)
        {
            var user = ScenarioContext.Current.Get<User>("user");
            Assert.AreEqual(city, user.City);
        }

        [StepDefinition(@"the user should have State ""(.*)""")]
        public void TheUserShouldHaveState____(string state)
        {
            var user = ScenarioContext.Current.Get<User>("user");
            Assert.AreEqual(state, user.State);
        }

        [StepDefinition(@"the user should have PostalCode ""(.*)""")]
        public void TheUserShouldHavePostalCode____(string postalCode)
        {
            var user = ScenarioContext.Current.Get<User>("user");
            Assert.AreEqual(postalCode, user.PostalCode);
        }

        [StepDefinition(@"the user should have Country ""(.*)""")]
        public void TheUserShouldHaveCountry____(string country)
        {
            var user = ScenarioContext.Current.Get<User>("user");
            Assert.AreEqual(country, user.Country);
        }

        [StepDefinition(@"the user should have Telephone ""(.*)""")]
        public void TheUserShouldHaveTelephone____(string telephone)
        {
            var user = ScenarioContext.Current.Get<User>("user");
            Assert.AreEqual(telephone, user.Telephone);
        }

        [StepDefinition(@"the user should have Locale ""(.*)""")]
        public void TheUserShouldHaveLocale____(string locale)
        {
            var user = ScenarioContext.Current.Get<User>("user");
            Assert.AreEqual(locale, user.Localization);
        }

        [StepDefinition(@"the user should have TimeZone ""(.*)""")]
        public void TheUserShouldHaveTimeZone____(string timeZone)
        {
            var user = ScenarioContext.Current.Get<User>("user");
            var userTimeZone = Timezone.Fetch(user.TimeZone);
            Assert.IsTrue(userTimeZone.TimezoneDisplay.Contains(timeZone));
        }
    }
}
