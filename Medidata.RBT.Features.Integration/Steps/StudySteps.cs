using System;
using Medidata.Core.Objects;
using Medidata.RBT.Objects.Integration.Helpers;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using TechTalk.SpecFlow;
using TechTalk.SpecFlow.Assist;
using Medidata.RBT.Objects.Integration.Configuration.Models;
using System.Linq;

namespace Medidata.RBT.Features.Integration.Steps
{
    [Binding]
    public class StudySteps : BaseClassSteps
    {
        // For additional details on SpecFlow step definitions see http://go.specflow.org/doc-stepdef

        [Given(@"the study with name ""(.*)"" and environment ""(.*)"" with ExternalId ""(.*)"" exists in the Rave database")]
        public void GivenTheStudyWithName____AndEnvironment____AndExternalId____ExistsInTheRaveDatabase(string name, string environment, int externalStudyId)
        {
            name = SpecFlowHelper.PrepareString(name);
            environment = SpecFlowHelper.PrepareString(environment);

            StudyHelper.CreateStudy(name, environment, externalStudyId);
        }

        [Given(@"the study with name ""(.*)"" and environment ""(.*)"" with UUID ""(.*)"" exists in the Rave database")]
        public void GivenTheStudyWithNameAndEnvironmentWithUUIDExistsInTheRaveDatabase(string name, string environment, string uuid)
        {
            name = SpecFlowHelper.PrepareString(name);
            environment = SpecFlowHelper.PrepareString(environment);

            StudyHelper.CreateStudy(name, environment, new Random().Next(int.MaxValue), uuid);
        }

        [Given(@"the iMedidata study with name ""(.*)"" and environment ""(.*)"" with UUID ""(.*)"" exists in the Rave database")]
        public void GivenTheIMedidataStudyWithNameAndEnvironmentWithUUIDExistsInTheRaveDatabase(string name, string environment, string uuid)
        {
            GivenTheStudyWithNameAndEnvironmentWithUUIDExistsInTheRaveDatabase(name, environment, uuid);
        }

        [Given(@"the internal study with name ""(.*)"" and environment ""(.*)"" exists")]
        public void GivenTheInternalStudyWithNameExists(string name, string environment)
        {
            name = SpecFlowHelper.PrepareString(name);
            environment = SpecFlowHelper.PrepareString(environment);

            StudyHelper.CreateStudy(name, environment, new Random().Next(int.MaxValue), Guid.NewGuid().ToString(), true);
        }

        [Then(@"I should see the study in the Rave database")]
        public void ThenIShouldSeeTheStudyInTheRaveDatabase()
        {
            var uuid = ScenarioContext.Current.Get<String>("studyUuid");
            var study = Study.FindByUuid(uuid, SystemInteraction.Use(), 1);

            Assert.IsNotNull(study);
            ScenarioContext.Current.Set(study, "study");
        }

        [Then(@"I should see the study with UUID ""(.*)"" in the Rave database")]
        public void ThenIShouldSeeTheStudyInTheRaveDatabase(string uuid)
        {
            var study = Study.FindByUuid(uuid, SystemInteraction.Use(), 1);

            Assert.IsNotNull(study);
            ScenarioContext.Current.Set(study, "study");
        }

        [Then(@"I should not see the study with UUID ""(.*)"" in the Rave database")]
        public void ThenIShouldNotSeeTheStudyWithUUIDInTheRaveDatabase(string uuid)
        {
            var study = Study.FindByUuid(uuid, SystemInteraction.Use(), 1);

            Assert.IsNull(study, string.Format("The study with UUID {0} exists.", uuid));
        }


        [Then(@"the study with ExternalId ""(.*)"" should not be in the Rave database")]
        public void ThenTheStudyWithExternalId____ShouldNotBeInTheRaveDatabase(int externalId)
        {
            Assert.IsNull(Study.FindByExternalID(externalId, 1, SystemInteraction.Use()));
        }

        [Then(@"I should see a study named ""(.*)"" with environment ""(.*)"" and ExternalId ""(.*)"" in the Rave database")]
        public void ThenIShouldSeeAStudyNamed____WithProjectName____Environment____AndExternalId____InTheRaveDatabase(string name, string environment, int externalId)
        {
            var study = Study.FindByExternalID(externalId, 1, SystemInteraction.Use());

            Assert.IsNotNull(study);
            Assert.AreEqual(study.Name, name);
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
            projectName = SpecFlowHelper.PrepareString(projectName);

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

        [Then(@"the study should exist with the following properties")]
        public void ThenTheStudyShouldExistWithTheFollowingProperties(Table table)
        {
            var messageConfigs = table.CustomCreateSet<StudyMessageModel>().ToList();

            foreach (var config in messageConfigs)
            {
                if (config.Name != null)
                    ThenTheStudyShouldHaveName____(config.Name);
                if (config.Environment != null)
                    ThenTheStudyShouldHaveEnvironment____(config.Environment);
                if (config.Description != null)
                    ThenTheStudyShouldHaveDescription____(config.Description);
                if (!config.LastExternalUpdateDate.Equals(new DateTime(1, 1, 1)))
                    ThenTheStudyShouldHaveLastExternalUpdateDate____(config.LastExternalUpdateDate);
                if (config.TestStudy != null)
                {
                    var boolvalue = bool.Parse(config.TestStudy);
                    if (!boolvalue)
                        ThenTheStudyShouldNotBeTestStudy();
                    else
                        throw new NotImplementedException("Verification for Test Study not implemented yet");
                }
                if (config.ExternalID != 0)
                    ThenTheStudyShouldHaveExternalId____(config.ExternalID);
                if (config.EnrollmentTarget != 0)
                    ThenTheStudyShouldHaveEnrollmentTarget____(config.EnrollmentTarget);
            }
        }
    }
}
