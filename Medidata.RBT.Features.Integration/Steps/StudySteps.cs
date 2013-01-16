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
    }
}
