using System;
using System.Configuration;
using System.Threading;
using Medidata.RBT.Objects.Integration.Configuration;
using Medidata.RBT.Objects.Integration.Helpers;
using TechTalk.SpecFlow;
using System.IO;
using System.Reflection;
using Medidata.MEF.PluginFramework;

namespace Medidata.RBT.Features.Integration.Steps
{
    [Binding]
    public class SQSSteps : BaseClassSteps
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
            if (!ConfigurationManager.AppSettings[AppSettingsTags.MessageDeliveryType]
                     .Equals(MessageDeliveryTypes.SQS))
            {
                return;
            }

            var numVisibleMessages = IntegrationTestContext.SqsWrapper.GetApproxNumberOfMessages(IntegrationTestContext.SqsQueueUrl, true);
            var numInvisibleMessages = IntegrationTestContext.SqsWrapper.GetApproxNumberOfMessages(IntegrationTestContext.SqsQueueUrl, false);
            
            var threadSleepOffset = 5000 * ScenarioContext.Current.Get<int>("messageCount");
            Thread.Sleep(15000 + threadSleepOffset);
            var endTime = DateTime.Now.AddSeconds(100);

            while(numVisibleMessages > 0 || numInvisibleMessages > 0)
            {
                if(DateTime.Now.Ticks > endTime.Ticks) throw new TimeoutException("Message was not processed");

                numVisibleMessages = IntegrationTestContext.SqsWrapper.GetApproxNumberOfMessages(IntegrationTestContext.SqsQueueUrl, true);
                numInvisibleMessages = IntegrationTestContext.SqsWrapper.GetApproxNumberOfMessages(IntegrationTestContext.SqsQueueUrl, false);
            }
        }
    }
}
