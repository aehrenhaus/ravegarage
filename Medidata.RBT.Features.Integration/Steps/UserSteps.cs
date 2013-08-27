using System;
using System.Linq;
using Medidata.Core.Objects;
using Medidata.RBT.Objects.Integration.Helpers;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using TechTalk.SpecFlow;
using Medidata.RBT.Objects.Integration.Configuration.Models;
using TechTalk.SpecFlow.Assist;

namespace Medidata.RBT.Features.Integration.Steps
{
    [Binding]
    public class UserSteps : BaseClassSteps
    {
        // For additional details on SpecFlow step definitions see http://go.specflow.org/doc-stepdef

        [Given(@"the User with login ""(.*)"" exists in the Rave database")]
        public void TheUserWithLogin____ExistsInTheRaveDatabase(string login)
        {
            UserHelper.CreateRaveUser(login);
        }

        [Given(@"the internal User with login ""(.*)"" exists in the Rave database")]
        public void GivenTheInternalUserWithLoginExistsInTheRaveDatabase(string login)
        {
            UserHelper.CreateInternalRaveUser(login);
        }

        [Then(@"I should see the user in the Rave database")]
        public void ThenIShouldSeeTheUserInTheRaveDatabase()
        {
            var externalUser = ExternalUser.GetByExternalUUID(ScenarioContext.Current.Get<string>("externalUserUUID"), 1);
           
            Assert.IsNotNull(externalUser);

            var users = Users.FindByExternalUserID(externalUser.ID, SystemInteraction.Use());

            var user = users.FirstOrDefault();

            Assert.IsNotNull(user);

            ScenarioContext.Current.Set(user, "user"); //updates the user in the context to reflect updates made by RISS
        }

        [Then(@"I should see the iMedidata user in the Rave database")]
        public void ThenIShouldSeeTheIMedidataUserInTheRaveDatabase()
        {
            ThenIShouldSeeTheUserInTheRaveDatabase();
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
        public void TheUserShouldHaveTelephone____(string Telephone)
        {
            var user = ScenarioContext.Current.Get<User>("user");
            Assert.AreEqual(Telephone, user.Telephone);
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

        [Then(@"user's ExternalSystem value corresponds to iMedidata")]
        public void ThenTheUserShouldHaveTheExternalSystemIMedidata()
        {
            var user = ScenarioContext.Current.Get<User>("user");
            Assert.AreEqual(ExternalSystem.GetByID(1), user.ExternalSystem);
        }

        [Then(@"there should be (.*) active internal user for the external user")]
        public void ThenThereShouldBeInternalUserForTheExternalUser(int userCount)
        {
            var externalUser = ExternalUser.GetByExternalUUID(ScenarioContext.Current.Get<string>("externalUserUUID"), 1);
            var users = Users.FindByExternalUserID(externalUser.ID, SystemInteraction.Use());
            Assert.AreEqual(userCount, users.Count(x => x.Active));
        }

        [When(@"the iMedidata user links their account to the Rave User")]
        public void WhenTheIMedidataUserLinksTheirAccountToTheRaveUser()
        {
            var user = ScenarioContext.Current.Get<User>("user");
            var externalUser = ExternalUser.GetByExternalUUID(ScenarioContext.Current.Get<string>("externalUserUUID"), 1);
            UserHelper.LinkAccount(externalUser, user);
        }

        [Then(@"the user should have Title ""(.*)""")]
        public void ThenTheUserShouldHaveTitle____(string title)
        {
            var user = ScenarioContext.Current.Get<User>("user");
            Assert.AreEqual(title, user.Title);
        }

        [Then(@"the user should have Institution ""(.*)""")]
        public void ThenTheUserShouldHaveInstitution____(string institution)
        {
            var user = ScenarioContext.Current.Get<User>("user");
            Assert.AreEqual(institution, user.InstitutionName);
        }

        [StepDefinition(@"the user should have Address2 ""(.*)""")]
        public void TheUserShouldHaveAddress2____(string address2)
        {
            var user = ScenarioContext.Current.Get<User>("user");
            Assert.AreEqual(address2, user.AddressLine2);
        }

        [StepDefinition(@"the user should have Address3 ""(.*)""")]
        public void TheUserShouldHaveAddress3____(string address3)
        {
            var user = ScenarioContext.Current.Get<User>("user");
            Assert.AreEqual(address3, user.AddressLine3);
        }

        [Then(@"the user should have Fax ""(.*)""")]
        public void ThenTheUserShouldHaveFax____(string fax)
        {
            var user = ScenarioContext.Current.Get<User>("user");
            Assert.AreEqual(fax, user.Facsimile);
        }

        [Then(@"the user should have LastExternalUpdateDate ""(.*)""")]
        public void ThenTheUserShouldHaveLastExternalUpdateDate____(DateTime lastExternalUpdateDate)
        {
            var user = ScenarioContext.Current.Get<User>("user");
            Assert.AreEqual(lastExternalUpdateDate, user.LastExternalUpdateDate);
        }

        [Then(@"the user should exist with the following properties")]
        public void ThenTheSiteShouldExistWithTheFollowingProperties(Table table)
        {
            var messageConfigs = table.CreateSet<UserMessageModel>().ToList();

            foreach (var config in messageConfigs)
            {
                if (config.Email != null)
                    TheUserShouldHaveEmail____(config.Email);
                if (config.Login != null)
                    TheUserShouldHaveLogin____(config.Login);
                if (config.FirstName != null)
                    TheUserShouldHaveFirstName____(config.FirstName);
                if (config.MiddleName != null)
                    TheUserShouldHaveMiddleName____(config.MiddleName);
                if (config.LastName != null)
                    TheUserShouldHaveLastName____(config.LastName);
                if (config.Address1 != null)
                    TheUserShouldHaveAddress1____(config.Address1);
                if (config.Address2 != null)
                    TheUserShouldHaveAddress2____(config.Address2);
                if (config.Address3 != null)
                    TheUserShouldHaveAddress3____(config.Address3);
                if (config.City != null)
                    TheUserShouldHaveCity____(config.City);
                if (config.State != null)
                    TheUserShouldHaveState____(config.State);
                if (config.PostalCode != null)
                    TheUserShouldHavePostalCode____(config.PostalCode);
                if (config.Country != null)
                    TheUserShouldHaveCountry____(config.Country);
                if (config.Telephone != null)
                    TheUserShouldHaveTelephone____(config.Telephone);
                if (config.Locale != null)
                    TheUserShouldHaveLocale____(config.Locale);
                if (config.TimeZone != null)
                    TheUserShouldHaveTimeZone____(config.TimeZone);
                if (config.Title != null)
                    ThenTheUserShouldHaveTitle____(config.Title);
                if (config.Institution != null)
                    ThenTheUserShouldHaveInstitution____(config.Institution);
                if (config.Fax != null)
                    ThenTheUserShouldHaveFax____(config.Fax);
                if (!config.LastExternalUpdateDate.Equals(new DateTime(1, 1, 1)))
                    ThenTheUserShouldHaveLastExternalUpdateDate____(config.LastExternalUpdateDate);
            }
        }
    }
}