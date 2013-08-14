using System;
using System.Linq;
using Medidata.RBT.Objects.Integration.Helpers;
using Medidata.Core.Objects;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using TechTalk.SpecFlow;
using Medidata.RBT.Objects.Integration.Configuration.Models;
using TechTalk.SpecFlow.Assist;

namespace Medidata.RBT.Features.Integration.Steps
{
    [Binding]
    public class StudySiteSteps : BaseClassSteps
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

        [Then(@"the studysite should have the StudySiteId ""(.*)""")]
        public void ThenTheStudysiteShouldHaveTheStudySiteId____(int studySiteId)
        {
            var studySite = ScenarioContext.Current.Get<StudySite>("studySite");

            Assert.AreEqual(studySiteId, studySite.ID);
        }

        [Then(@"the studysite should have the StudySiteName \(same as SiteName\) ""(.*)""")]
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

        [Then(@"the studysite should be active")]
        public void ThenTheStudysiteShouldBeActive()
        {
            var studySite = ScenarioContext.Current.Get<StudySite>("studySite");

            Assert.AreEqual(true, studySite.Active);
        }

        [Then(@"the studysite should exist with the following properties")]
        public void ThenTheSiteShouldExistWithTheFollowingProperties(Table table)
        {
            var messageConfigs = table.CreateSet<StudySiteMessageModel>().ToList();

            foreach (var config in messageConfigs)
            {
                if (config.ExternalID != 0)
                    ThenTheStudysiteShouldHaveExternalID____(config.ExternalID);
                if (config.StudySiteName != null)
                    ThenTheStudysiteShouldHaveTheStudySiteName____(config.StudySiteName);
                if (config.StudySiteNumber != null)
                    ThenTheStudysiteShouldHaveTheStudySiteNumber____(config.StudySiteNumber);
                if (config.ExternalStudyId != 0)
                    ThenTheStudysiteShouldHaveTheExternalStudyId(config.ExternalStudyId);
                if (!config.LastExternalUpdateDate.Equals(new DateTime(1, 1, 1)))
                    ThenTheStudysiteShouldHaveALastExternalUpdateDate____(config.LastExternalUpdateDate);
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
                if (config.Active != null)
                {
                    var active = bool.Parse(config.Active);
                    if (active)
                        ThenTheStudysiteShouldBeActive();
                    else
                        ThenTheStudysiteShouldBeInactive();
                }
            }
        }
    }
}
