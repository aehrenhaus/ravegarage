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
    public class SiteSteps
    {
        [Given(@"the Site with site number ""(.*)"" exists in the Rave database")]
        public void TheSiteWithSiteNumber____ExistsInTheRaveDatabase(string siteNumber)
        {
            SiteHelper.CreateRaveSite(siteNumber);
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
        public void ThenTheSiteShouldHaveAddress1(string address1)
        {
            var site = ScenarioContext.Current.Get<Site>("site");

            Assert.AreEqual(address1, site.AddressLine1);
        }


        [Then(@"the site should have the ExternalId ""(.*)""")]
        public void ThenTheSiteShouldHaveTheExternalId(int externalId)
        {
            var site = ScenarioContext.Current.Get<Site>("site");

            Assert.AreEqual(externalId, site.ExternalID);
        }

        [Then(@"the site should have the name ""(.*)""")]
        public void ThenTheSiteShouldHaveTheName(string siteName)
        {
            var site = ScenarioContext.Current.Get<Site>("site");

            Assert.AreEqual(siteName, site.Name);
        }

        [Then(@"the site should have the SiteNumber ""(.*)""")]
        public void ThenTheSiteShouldHaveTheSiteNumber(string siteNumber)
        {
            var site = ScenarioContext.Current.Get<Site>("site");

            Assert.AreEqual(siteNumber, site.Number);
        }

        [Then(@"the site should have a LastExternalUpdateDate ""(.*)""")]
        public void ThenTheSiteShouldHaveALastExternalUpdateDate(DateTime lastExternalUpdateDate)
        {
            var site = ScenarioContext.Current.Get<Site>("site");

            Assert.AreEqual(lastExternalUpdateDate, site.LastExternalUpdateDate);
        }

        [Then(@"the site should have City ""(.*)""")]
        public void ThenTheSiteShouldHaveCity(string city)
        {
            var site = ScenarioContext.Current.Get<Site>("site");

            Assert.AreEqual(city, site.City);
        }

        [Then(@"the site should have State ""(.*)""")]
        public void ThenTheSiteShouldHaveState(string state)
        {
            var site = ScenarioContext.Current.Get<Site>("site");

            Assert.AreEqual(state, site.State);
        }

        [Then(@"the site should have PostalCode ""(.*)""")]
        public void ThenTheSiteShouldHavePostalCode(string postalCode)
        {
            var site = ScenarioContext.Current.Get<Site>("site");

            Assert.AreEqual(postalCode, site.PostalCode);
        }


        [Then(@"the site should have Country ""(.*)""")]
        public void ThenTheSiteShouldHaveCountry(string country)
        {
            var site = ScenarioContext.Current.Get<Site>("site");

            Assert.AreEqual(country, site.Country);
        }

        [Then(@"the site should have Telephone ""(.*)""")]
        public void ThenTheSiteShouldHaveTelephone(string telephone)
        {
            var site = ScenarioContext.Current.Get<Site>("site");

            Assert.AreEqual(telephone, site.Telephone);
        }

        [Then(@"and the site should have ExternalSystemName ""(.*)""")]
        public void AndTheSiteShouldHaveExternalSystemName(string externalSystemName)
        {
            var site = ScenarioContext.Current.Get<Site>("site");

            Assert.AreEqual(externalSystemName, site.ExternalSystem.Name);
        }

        [Then(@"the site should have the UUID ""(.*)""")]
        public void ThenTheSiteShouldHaveTheUUID(string uuid)
        {
            var site = ScenarioContext.Current.Get<Site>("site");

            Assert.AreEqual(uuid, site.Uuid);
        }

        [Then(@"I should see the site has audits in the Rave database")]
        public void ThenIShouldSeeTheSiteHasAuditsInTheRaveDatabase()
        {
            var site = ScenarioContext.Current.Get<Site>("site");

            Audits siteAudits = Audits.Load(site);
            Assert.IsTrue(siteAudits.Count > 0);

            ScenarioContext.Current.Add("siteAudits", siteAudits);
        }

        [Then(@"I should see the audits were performed by user ""(.*)""")]
        public void ThenIShouldSeeTheAuditsWerePerformedBy(string userType)
        {
            var siteAudits = ScenarioContext.Current.Get<Audits>("siteAudits");

            Assert.AreEqual(siteAudits[siteAudits.Count - 1].AuditUser, userType);
        }


        [Then(@"I should see the audit action type ""(.*)""")]
        public void ThenIShouldSeeTheAuditActionType(string auditActionType)
        {
            var siteAudits = ScenarioContext.Current.Get<Audits>("siteAudits");

            Assert.AreEqual(siteAudits[siteAudits.Count - 1].SubCategory.ToString(), auditActionType);
        }

        [Then(@"I should see the audit action ""(.*)""")]
        public void ThenIShouldSeeTheAuditAction(string auditAction)
        {
            var siteAudits = ScenarioContext.Current.Get<Audits>("siteAudits");

            Assert.AreEqual(siteAudits[siteAudits.Count - 1].Readable, auditAction);
        }

    }
}
