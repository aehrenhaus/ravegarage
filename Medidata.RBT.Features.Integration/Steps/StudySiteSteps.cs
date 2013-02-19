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
            var study = ScenarioContext.Current.Get<Study>("study");
            var site = Site.FindByUuid(ScenarioContext.Current.Get<string>("siteUuid"), 1, SystemInteraction.Use());

            var studySite = StudySite.FindByStudyIDandSiteID(study.ID, site.ID, SystemInteraction.Use());

            Assert.IsNotNull(studySite);
            ScenarioContext.Current.Set(studySite, "studySite");
        }

        [Then(@"I should not see the studysite in the Rave database")]
        public void ThenIShouldNotSeeTheStudysiteInTheRaveDatabase()
        {
            var study = ScenarioContext.Current.Get<Study>("study");
            var site = ScenarioContext.Current.ContainsKey("site")
                           ? ScenarioContext.Current.Get<Site>("site")
                           : Site.FindByUuid(ScenarioContext.Current.Get<string>("siteUuid"), 1, SystemInteraction.Use());

            var studySite = StudySite.FindByStudyIDandSiteID(study.ID, site.ID, SystemInteraction.Use());

            Assert.IsTrue(studySite == null || studySite.Active);
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

        [Then(@"the studysite should have the source iMedidata")]
        public void ThenTheStudysiteShouldHaveTheSourceIMedidata()
        {
            var studySite = ScenarioContext.Current.Get<StudySite>("studySite");

            Assert.AreEqual(1, studySite.ExternalSystem.ID);
        }

        [Given(@"the studysite exists with the study site number ""(.*)"" and the given study and site")]
        public void GivenTheStudysiteExistsWithTheStudySiteNumber____AndTheGivenStudyAndSite(string number)
        {
            var study = ScenarioContext.Current.Get<Study>("study");
            var site = ScenarioContext.Current.Get<Site>("site");

            var studySite = new StudySite(study, site, SystemInteraction.Use())
                                {
                                    StudySiteNumber = number,
                                    Uuid = Guid.NewGuid().ToString()
                                };
            
            ScenarioContext.Current.Add("studySite", studySite);
        }

    }
}
