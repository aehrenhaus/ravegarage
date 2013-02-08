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
                case ResourceNames.STUDY:
                    StudyHelper.StudyMessageHandler(table);
                    break;
                case ResourceNames.USER:
                    UserHelper.MessageHandler(table);
                    break;
                case ResourceNames.USER_STUDY_SITE:
                    UserStudySiteHelper.MessageHandler(table);
                    break;
                case ResourceNames.STUDY_SITE:
                    StudySiteHelper.MessageHandler(table);
                    break;
                case ResourceNames.SITE:
                    SiteHelper.MessageHandler(table);
                    break;
				case ResourceNames.STUDY_INVITATION:
                    StudyInvitationHelper.MessageHandler(table);
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
