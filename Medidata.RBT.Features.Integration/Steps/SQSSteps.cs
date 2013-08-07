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
    public class SQSSteps
    {
        static bool initializedPluginFramework;

        [StepDefinition(@"I send the following (.*) message(?:s)? to SQS")]
        public void ISendTheFollowing____MessagesToSQS(string resourceName, Table table)
        {
            if (!initializedPluginFramework) // get plugins since they don't exist at first
            {
                initializedPluginFramework = true;
                string pluginDir = ConfigurationManager.AppSettings["PluginDirectory"];
                if (!Path.IsPathRooted(pluginDir))
                {
                    pluginDir = Path.Combine(Path.GetDirectoryName(Assembly.GetAssembly(this.GetType()).Location), pluginDir);
                }
                ServiceManager.InitializeServiceManager(new PluginEnvironment(pluginDir));
            }

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
            Thread.Sleep(15000);
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
