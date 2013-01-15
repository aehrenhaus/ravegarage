using System;
using System.Threading;
using Medidata.AmazonSimpleServices;
using Medidata.Core.Objects;
using Medidata.RBT.Objects.Integration.Configuration;
using Medidata.RBT.Objects.Integration.Helpers;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using TechTalk.SpecFlow;

namespace Medidata.RBT.Features.Integration.Steps
{
    [Binding]
    public class SQSSteps
    {
        [Given(@"I send the following (.*) messages to SQS")]
        public void ISendTheFollowing____MessagesToSQS(string resourceName, Table table)
        {
            switch(resourceName.ToLowerInvariant())
            {
                case "study":
                    SQSHelper.StudyMessageHandler(table, IntegrationTestContext.SqsWrapper, IntegrationTestContext.SqsQueueUrl);
                    break;
            }
        }

        [When(@"the message is successfully processed")]
        public void WhenTheMessageIsSuccessfullyProcessed()
        {
            Thread.Sleep(5000);

            var numVisibleMessages = IntegrationTestContext.SqsWrapper.GetApproximateNumberOfVisibleMessages(IntegrationTestContext.SqsQueueUrl);
            var numInvisibleMessages = IntegrationTestContext.SqsWrapper.GetApproximateNumberOfInvisibleMessages(IntegrationTestContext.SqsQueueUrl);
            var endTime = DateTime.Now.AddSeconds(10);

            while(numVisibleMessages > 0 || numInvisibleMessages > 0)
            {
                if(DateTime.Now.Ticks > endTime.Ticks) throw new TimeoutException("Message was not processed");

                numVisibleMessages = IntegrationTestContext.SqsWrapper.GetApproximateNumberOfVisibleMessages(IntegrationTestContext.SqsQueueUrl);
                numInvisibleMessages = IntegrationTestContext.SqsWrapper.GetApproximateNumberOfInvisibleMessages(IntegrationTestContext.SqsQueueUrl);
            }
        }

        [Then(@"I should see the study with UUID ""(.*)"" in the Rave database")]
        public void ThenIShouldSeeTheStudyWithUUID____InTheRaveDatabase(string uuid)
        {
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
