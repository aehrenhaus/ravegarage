using System;
using Medidata.Core.Objects;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using TechTalk.SpecFlow;

namespace Medidata.RBT.Features.Integration.Steps
{
    [Binding]
    public class StudySteps
    {
        // For additional details on SpecFlow step definitions see http://go.specflow.org/doc-stepdef
        [Given(@"the study with name ""(.*)"" and environment ""(.*)"" exists in the Rave database")]
        public void GivenTheStudyWithName____AndEnvironment____ExistsInTheRaveDatabase(string name, string environment)
        { // see implementation for Given the user with name... in UserSteps.cs
            ScenarioContext.Current.Pending();
        }

        [Then(@"I should see the study in the Rave database")]
        public void ThenIShouldSeeTheStudyInTheRaveDatabase()
        {
            var uuid = ScenarioContext.Current.Get<String>("studyUuid");
            var study = Study.FindByUuid(uuid, 1, SystemInteraction.Use());

            Assert.IsNotNull(study);
            ScenarioContext.Current.Add("study", study);
        }

        [Then(@"the study should have Name ""(.*)""")]
       public void ThenTheStudyShouldHaveName____(string name)
        {
            var study = ScenarioContext.Current.Get<Study>("study");

            Assert.AreEqual(name, study.Name);
        }

        [Then(@"the study should have Environment ""(.*)""")]
        public void ThenTheStudyShouldHaveEnvironment____(string environment)
        {
            var study = ScenarioContext.Current.Get<Study>("study");

            Assert.AreEqual(environment, study.Environment);
        }

        [Then(@"the study should have Description ""(.*)""")]
        public void ThenTheStudyShouldHaveDescription(string description)
        {
            var study = ScenarioContext.Current.Get<Study>("study");

            Assert.AreEqual(description, study.Project.Description);
        }

        [Then(@"the study should have LastExternalUpdateDate ""(.*)""")]
        public void ThenTheStudyShouldHaveLastExternalUpdateDate(DateTime updated)
        {
            var study = ScenarioContext.Current.Get<Study>("study");

            Assert.AreEqual(updated, study.LastExternalUpdateDate);
        }

        [Then(@"the study should not be TestStudy")]
        public void ThenTheStudyShouldNotBeTestStudy()
        {
            var study = ScenarioContext.Current.Get<Study>("study");

            Assert.AreEqual(false, study.TestStudy);
        }

        [Then(@"the study should have ExternalID ""(.*)""")]
        public void ThenTheStudyShouldHaveExternalId(int externalId)
        {
            var study = ScenarioContext.Current.Get<Study>("study");

            Assert.AreEqual(externalId, study.ExternalID);
        }

    }
}
