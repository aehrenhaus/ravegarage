using System;
using System.Threading;
using Medidata.RBT.Objects.Integration.Configuration;
using Medidata.RBT.Objects.Integration.Helpers;
using TechTalk.SpecFlow;

namespace Medidata.RBT.Features.Integration.Steps
{
    [Binding]
    public class SQSSteps
    {
        [StepDefinition(@"I send the following (.*) message(?:s)? to SQS")]
        public void ISendTheFollowing____MessagesToSQS(string resourceName, Table table)
        {
            switch(resourceName.ToLowerInvariant())
            {
                case "study":
                    StudyHelper.StudyMessageHandler(table, IntegrationTestContext.SqsWrapper, IntegrationTestContext.SqsQueueUrl);
                    break;
            }
        }

        [When(@"the messages? (?:is|are) successfully processed")]
        public void WhenTheMessageIsSuccessfullyProcessed()
        {
            var numVisibleMessages = IntegrationTestContext.SqsWrapper.GetApproximateNumberOfVisibleMessages(IntegrationTestContext.SqsQueueUrl);
            var numInvisibleMessages = IntegrationTestContext.SqsWrapper.GetApproximateNumberOfInvisibleMessages(IntegrationTestContext.SqsQueueUrl);
            Thread.Sleep(5000);
            var endTime = DateTime.Now.AddSeconds(30);

            while(numVisibleMessages > 0 || numInvisibleMessages > 0)
            {
                if(DateTime.Now.Ticks > endTime.Ticks) throw new TimeoutException("Message was not processed");

                numVisibleMessages = IntegrationTestContext.SqsWrapper.GetApproximateNumberOfVisibleMessages(IntegrationTestContext.SqsQueueUrl);
                numInvisibleMessages = IntegrationTestContext.SqsWrapper.GetApproximateNumberOfInvisibleMessages(IntegrationTestContext.SqsQueueUrl);
            }
        }
    }
}
