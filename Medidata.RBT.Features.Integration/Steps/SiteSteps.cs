using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Medidata.Core.Objects;
using Medidata.RBT.Objects.Integration.Helpers;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using TechTalk.SpecFlow;

namespace Medidata.RBT.Features.Integration.Steps
{
    [Binding]
    public class SiteSteps : BaseClassSteps
    {
        [Given(@"the Site with site number ""(.*)"" exists in the Rave database")]
        public void TheSiteWithSiteNumber____ExistsInTheRaveDatabase(string siteNumber)
        {
            SiteHelper.CreateRaveSite(siteNumber);
        }

        [Given(@"the Site with name ""(.*)"" and site number ""(.*)"" exists in the Rave database")]
        public void TheSiteWithName____AndSiteNumber____ExistsInTheRaveDatabase(string siteName, string siteNumber)
        {
            SiteHelper.CreateRaveSite(siteNumber, siteName);
        }

        [Then(@"I should see the site in the Rave database")]
        public void ThenIShouldSeeTheSiteInTheRaveDatabase()
        {
            var siteUuid = ScenarioContext.Current.Keys.Contains("siteUuid") ?
                           ScenarioContext.Current.Get<String>("siteUuid") : //site was created via post message
                           ScenarioContext.Current.Get<Site>("site").Uuid;  //site was seeded in Rave

            var site = Site.FindByUuid(siteUuid, 1, SystemInteraction.Use());

            Assert.IsNotNull(site);

            ScenarioContext.Current.Set(site, "site");
        }

        [Then(@"the site should have Address1 ""(.*)""")]
        public void ThenTheSiteShouldHaveAddress1____(string address1)
        {
            var site = ScenarioContext.Current.Get<Site>("site");

            Assert.AreEqual(address1, site.AddressLine1);
        }


        [Then(@"the site should have the ExternalId ""(.*)""")]
        public void ThenTheSiteShouldHaveTheExternalId____(int externalId)
        {
            var site = ScenarioContext.Current.Get<Site>("site");

            Assert.AreEqual(externalId, site.ExternalID);
        }

        [Then(@"the site should have the name ""(.*)""")]
        public void ThenTheSiteShouldHaveTheName____(string siteName)
        {
            var site = ScenarioContext.Current.Get<Site>("site");

            Assert.AreEqual(siteName, site.Name);
        }

        [Then(@"the site should have the SiteNumber ""(.*)""")]
        public void ThenTheSiteShouldHaveTheSiteNumber____(string siteNumber)
        {
            var site = ScenarioContext.Current.Get<Site>("site");

            Assert.AreEqual(siteNumber, site.Number);
        }

        [Then(@"the site should have a LastExternalUpdateDate ""(.*)""")]
        public void ThenTheSiteShouldHaveALastExternalUpdateDate____(DateTime lastExternalUpdateDate)
        {
            var site = ScenarioContext.Current.Get<Site>("site");

            Assert.AreEqual(lastExternalUpdateDate, site.LastExternalUpdateDate);
        }

        [Then(@"the site should have City ""(.*)""")]
        public void ThenTheSiteShouldHaveCity____(string city)
        {
            var site = ScenarioContext.Current.Get<Site>("site");

            Assert.AreEqual(city, site.City);
        }

        [Then(@"the site should have State ""(.*)""")]
        public void ThenTheSiteShouldHaveState____(string state)
        {
            var site = ScenarioContext.Current.Get<Site>("site");

            Assert.AreEqual(state, site.State);
        }

        [Then(@"the site should have PostalCode ""(.*)""")]
        public void ThenTheSiteShouldHavePostalCode____(string postalCode)
        {
            var site = ScenarioContext.Current.Get<Site>("site");

            Assert.AreEqual(postalCode, site.PostalCode);
        }


        [Then(@"the site should have Country ""(.*)""")]
        public void ThenTheSiteShouldHaveCountry____(string country)
        {
            var site = ScenarioContext.Current.Get<Site>("site");

            Assert.AreEqual(country, site.Country);
        }

        [Then(@"the site should have Telephone ""(.*)""")]
        public void ThenTheSiteShouldHaveTelephone____(string telephone)
        {
            var site = ScenarioContext.Current.Get<Site>("site");

            Assert.AreEqual(telephone, site.Telephone);
        }

        [Then(@"the site should have the UUID ""(.*)""")]
        public void ThenTheSiteShouldHaveTheUUID____(string uuid)
        {
            var site = ScenarioContext.Current.Get<Site>("site");

            Assert.AreEqual(uuid, site.Uuid);
        }
    }
}
