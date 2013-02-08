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
            var siteUuid = ScenarioContext.Current.Get<String>("siteUuid");

            var site = Site.FindByUuid(siteUuid, 1, SystemInteraction.Use());

            Assert.IsNotNull(site);
            ScenarioContext.Current.Add("site", site);
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

    }
}
