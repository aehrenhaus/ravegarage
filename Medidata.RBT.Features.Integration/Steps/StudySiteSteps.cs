using System;using System.Collections.Generic;
using System.Linq;
using System.Text;
using Medidata.RBT.Objects.Integration.Helpers;
using Medidata.Core.Objects;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using TechTalk.SpecFlow;

namespace Medidata.RBT.Features.Integration.Steps
{
    [Binding]
    public class StudySiteSteps
    {
        // For additional details on SpecFlow step definitions see http://go.specflow.org/doc-stepdef
        
		[Given(@"the StudySite with ExternalId ""(.*)"" exists in the Rave database")]
        public void TheStudySiteWithExternalID____ExistsInTheRaveDatabase(int externalId)
        {
            StudySiteHelper.CreateRaveStudySite(externalId);
        }

        [Then(@"I should see the studysite in the Rave database")]
        public void ThenIShouldSeeTheStudySiteInTheRaveDatabase()
        {
            var studyUuid = ScenarioContext.Current.Get<String>("studyUuid");
            var siteUuid = ScenarioContext.Current.Get<String>("siteUuid");

            var study = Study.FindByUuid(studyUuid, 1, SystemInteraction.Use());
            var site = Site.FindByUuid(siteUuid, 1, SystemInteraction.Use());

            var studySite = StudySite.FindByStudyIDandSiteID(study.ID, site.ID, SystemInteraction.Use());

            Assert.IsNotNull(studySite);
            ScenarioContext.Current.Add("studySite", studySite);
        }

        [Then(@"the studysite should have the StudySiteId ""(.*)""")]
        public void ThenTheStudysiteShouldHaveTheStudySiteId____(int studySiteId)
        {
            var studySite = ScenarioContext.Current.Get<StudySite>("studySite");

            Assert.AreEqual(studySiteId, studySite.ID);
        }

        [Then(@"the studysite should have the StudySiteName ""(.*)""")]
        public void ThenTheStudysiteShouldHaveTheStudySiteName____(string studySiteName)
        {
            var studySite = ScenarioContext.Current.Get<StudySite>("studySite");

            Assert.AreEqual(studySiteName, studySite.Name);
        }

        [Then(@"the studysite should have the StudySiteNumber ""(.*)""")]
        public void ThenTheStudysiteShouldHaveTheStudySiteNumber____(string studySiteNumber)
        {
            var studySite = ScenarioContext.Current.Get<StudySite>("studySite");

            Assert.AreEqual(studySiteNumber, studySite.StudySiteNumber);
        }

        [Then(@"the studysite should have the ExternalStudyId ""(.*)""")]
        public void ThenTheStudysiteShouldHaveTheExternalStudyId(int externalStudyId)
        {
            var studySite = ScenarioContext.Current.Get<StudySite>("studySite");

            Assert.AreEqual(externalStudyId, studySite.Study.ExternalID);
        }

        [Then(@"the studysite should have the ExternalSiteId ""(.*)""")]
        public void ThenTheStudysiteShouldHaveTheExternalSiteId(int externalSiteId)
        {
            var studySite = ScenarioContext.Current.Get<StudySite>("studySite");

            Assert.AreEqual(externalSiteId, studySite.Site.ExternalID);
        }

        [Then(@"the studysite should have the SiteName ""(.*)""")]
        public void ThenTheStudysiteShouldHaveTheSiteName____(string siteName)
        {
            var studySite = ScenarioContext.Current.Get<StudySite>("studySite");

            Assert.AreEqual(siteName, studySite.Site.Name);
        }

        [Then(@"the studysite should have the SiteNumber ""(.*)""")]
        public void ThenTheStudysiteShouldHaveTheSiteNumber____(string siteNumber)
        {
            var studySite = ScenarioContext.Current.Get<StudySite>("studySite");

            Assert.AreEqual(siteNumber, studySite.Site.Number);
        }

        [Then(@"the studysite should have a LastExternalUpdateDate ""(.*)""")]
        public void ThenTheStudysiteShouldHaveALastExternalUpdateDate____(DateTime lastExternalUpdateDate)
        {
            var studySite = ScenarioContext.Current.Get<StudySite>("studySite");

            Assert.AreEqual(lastExternalUpdateDate, studySite.LastExternalUpdateDate);
        }

        [Then(@"the studysite should have ExternalID ""(.*)""")]
        public void ThenTheStudysiteShouldHaveExternalID____(int externalId)
        {
            var studySite = ScenarioContext.Current.Get<StudySite>("studySite");

            Assert.AreEqual(externalId, studySite.ExternalID);
        }

        [Then(@"the studysite should be inactive")]
        public void ThenTheStudysiteShouldBeInactive()
        {
            var studySite = ScenarioContext.Current.Get<StudySite>("studySite");

            Assert.AreEqual(false, studySite.Active);
        }

    }
}
