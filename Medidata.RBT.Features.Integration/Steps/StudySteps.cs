using System;
using Medidata.Core.Objects;
using Medidata.RBT.Objects.Integration.Helpers;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using TechTalk.SpecFlow;

namespace Medidata.RBT.Features.Integration.Steps
{
    [Binding]
    public class StudySteps
    {
        // For additional details on SpecFlow step definitions see http://go.specflow.org/doc-stepdef

        [Given(@"the study with name ""(.*)"" and environment ""(.*)"" with ExternalId ""(.*)"" exists in the Rave database")]
        public void GivenTheStudyWithName____AndEnvironment____AndExternalId____ExistsInTheRaveDatabase(string name, string environment, int externalStudyId)
        {
            StudyHelper.CreateStudy(name, environment, externalStudyId);
        }
        
        [Then(@"I should see the study in the Rave database")]
        public void ThenIShouldSeeTheStudyInTheRaveDatabase()
        {
            var uuid = ScenarioContext.Current.Get<String>("studyUuid");
            var study = Study.FindByUuid(uuid, 1, SystemInteraction.Use());

            Assert.IsNotNull(study);
            ScenarioContext.Current.Set(study, "study");
        }

        [Then(@"the study with ExternalId ""(.*)"" should not be in the Rave database")]
        public void ThenTheStudyWithExternalId____ShouldNotBeInTheRaveDatabase(int externalId)
        {
            var study = Study.FindByExternalID(externalId, 1, SystemInteraction.Use());

            Assert.IsNull(study);
        }

        [Then(@"I should see a study named ""(.*)"" with Project Name ""(.*)"" environment ""(.*)"" and ExternalId ""(.*)"" in the Rave database")]
        public void ThenIShouldSeeAStudyNamed____WithProjectName____Environment____AndExternalId____InTheRaveDatabase(string name, string projectName, string environment, int externalId)
        {
            var study = Study.FindByExternalID(externalId, 1, SystemInteraction.Use());

            Assert.IsNotNull(study);
            Assert.AreEqual(study.Name, name);
            Assert.AreEqual(study.Project.Name, projectName);
            Assert.AreEqual(study.Environment, environment);
        }


        [Then(@"the study should have Name ""(.*)""")]
       public void ThenTheStudyShouldHaveName____(string name)
        {
            var study = ScenarioContext.Current.Get<Study>("study");

            Assert.AreEqual(name, study.Name);
        }

        [Then(@"the study should have Project Name ""(.*)""")]
        public void ThenTheStudyShouldHaveProjectName____(string projectName)
        {
            var study = ScenarioContext.Current.Get<Study>("study");

            Assert.AreEqual(projectName, study.Project.Name);
        }


        [Then(@"the study should have Environment ""(.*)""")]
        public void ThenTheStudyShouldHaveEnvironment____(string environment)
        {
            var study = ScenarioContext.Current.Get<Study>("study");

            Assert.AreEqual(environment, study.Environment);
        }

        [Then(@"the study should have Description ""(.*)""")]
        public void ThenTheStudyShouldHaveDescription____(string description)
        {
            var study = ScenarioContext.Current.Get<Study>("study");

            Assert.AreEqual(description, study.Project.Description);
        }

        [Then(@"the study should have LastExternalUpdateDate ""(.*)""")]
        public void ThenTheStudyShouldHaveLastExternalUpdateDate____(DateTime updated)
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
        public void ThenTheStudyShouldHaveExternalId____(int externalId)
        {
            var study = ScenarioContext.Current.Get<Study>("study");

            Assert.AreEqual(externalId, study.ExternalID);
        }

        [Then(@"the study should have EnrollmentTarget ""(.*)""")]
        public void ThenTheStudyShouldHaveEnrollmentTarget____(int enrollmentTarget)
        {
            var study = ScenarioContext.Current.Get<Study>("study");
            
            Assert.AreEqual(enrollmentTarget, study.EnrollmentTarget);
        }
    }
}
