using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Medidata.Core.Objects;
using Medidata.RBT.Objects.Integration.Helpers;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using TechTalk.SpecFlow;
using TechTalk.SpecFlow.Assist;
using Medidata.RBT.Objects.Integration.Configuration.Models;

namespace Medidata.RBT.Features.Integration.Steps
{
    [Binding]
    public class SiteSteps : BaseClassSteps
    {
        [Given(@"the following sites? exists? in the rave database:")]
        public void GivenTheFollowingSitesExistInTheRaveDatabase(Table table)
        {
            SiteHelper.CreateRaveSites(table);
        }


        [Then(@"I should see the site in the Rave database")]
        public void ThenIShouldSeeTheSiteInTheRaveDatabase()
        {
            var siteUuid = ScenarioContext.Current.Keys.Contains("siteUuid") ?
                           ScenarioContext.Current.Get<String>("siteUuid") : //site was created via post message
                           ScenarioContext.Current.Get<Site>("site").Uuid;  //site was seeded in Rave

            var loadedSite = Site.FindByUuid(siteUuid, 1, SystemInteraction.Use());

            Assert.IsNotNull(loadedSite);

            ScenarioContext.Current.Set(loadedSite, "site");
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

        [Then(@"the site should have the Name ""(.*)""")]
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
        public void ThenTheSiteShouldHaveTelephone____(string Telephone)
        {
            var site = ScenarioContext.Current.Get<Site>("site");

            Assert.AreEqual(Telephone, site.Telephone); //remove this
        }

        [Then(@"the site should have the UUID ""(.*)""")]
        public void ThenTheSiteShouldHaveTheUUID____(string uuid)
        {
            var site = ScenarioContext.Current.Get<Site>("site");

            Assert.AreEqual(uuid, site.Uuid);
        }

        [Then(@"the site should exist with the following properties")]
        public void ThenTheSiteShouldExistWithTheFollowingProperties(Table table)
        {
            var messageConfigs = table.CreateSet<SiteMessageModel>().ToList();

            foreach (var config in messageConfigs)
            {
                if (config.Name != null)
                    ThenTheSiteShouldHaveTheName____(config.Name);
                if (config.Number != null)
                    ThenTheSiteShouldHaveTheSiteNumber____(config.Number);
                if (config.Address1 != null)
                    ThenTheSiteShouldHaveAddress1____(config.Address1);
                if (config.City != null)
                    ThenTheSiteShouldHaveCity____(config.City);
                if (config.State != null)
                    ThenTheSiteShouldHaveState____(config.State);
                if (config.Country != null)
                    ThenTheSiteShouldHaveCountry____(config.Country);
                if (config.PostalCode != null)
                    ThenTheSiteShouldHavePostalCode____(config.PostalCode);
                if (config.Country != null)
                    ThenTheSiteShouldHaveCountry____(config.Country);
                if (config.Telephone != null)
                    ThenTheSiteShouldHaveTelephone____(config.Telephone);
                if (!config.Uuid.Equals(new Guid("00000000-0000-0000-0000-000000000000")))
                    ThenTheSiteShouldHaveTheUUID____(config.Uuid.ToString());
                if (config.ExternalID != 0)
                    ThenTheSiteShouldHaveTheExternalId____(config.ExternalID);
                if (config.Source != null)
                {
                    if (config.Source.ToLower().Equals("imedidata"))
                    {
                        var ext = new ExternalSystemSteps();
                        ext.ThenTheSiteShouldHaveTheSourceIMedidata();
                    }
                    else
                        throw new NotImplementedException("Can't check for Source other than iMedidata.");
                }
                if (!config.LastExternalUpdateDate.Equals(new DateTime(1, 1, 1)))
                    ThenTheSiteShouldHaveALastExternalUpdateDate____(config.LastExternalUpdateDate);
            }

        }
    }
}
