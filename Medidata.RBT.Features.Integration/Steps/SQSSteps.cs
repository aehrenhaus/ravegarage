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
                case "user":
                    UserHelper.MessageHandler(table, IntegrationTestContext.SqsWrapper, IntegrationTestContext.SqsQueueUrl);
                    break;
                case "userstudysite":
                    UserStudySiteHelper.MessageHandler(table, IntegrationTestContext.SqsWrapper,
                                                           IntegrationTestContext.SqsQueueUrl);
                    break;
                case "studysite":
                    StudySiteHelper.MessageHandler(table, IntegrationTestContext.SqsWrapper, IntegrationTestContext.SqsQueueUrl);
                    break;
            }
        }

        [When(@"the messages? (?:is|are) successfully processed")]
        public void WhenTheMessageIsSuccessfullyProcessed()
        {
            var numVisibleMessages = IntegrationTestContext.SqsWrapper.GetApproxNumberOfMessages(IntegrationTestContext.SqsQueueUrl, true);
            var numInvisibleMessages = IntegrationTestContext.SqsWrapper.GetApproxNumberOfMessages(IntegrationTestContext.SqsQueueUrl, false);
            Thread.Sleep(10000);
            var endTime = DateTime.Now.AddSeconds(30);

            while(numVisibleMessages > 0 || numInvisibleMessages > 0)
            {
                if(DateTime.Now.Ticks > endTime.Ticks) throw new TimeoutException("Message was not processed");

                numVisibleMessages = IntegrationTestContext.SqsWrapper.GetApproxNumberOfMessages(IntegrationTestContext.SqsQueueUrl, true);
                numInvisibleMessages = IntegrationTestContext.SqsWrapper.GetApproxNumberOfMessages(IntegrationTestContext.SqsQueueUrl, false);
            }
        }
    }
}
