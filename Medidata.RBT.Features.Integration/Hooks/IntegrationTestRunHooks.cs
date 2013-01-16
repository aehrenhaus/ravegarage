using System;
using System.Configuration;
using System.ServiceProcess;
using Medidata.AmazonSimpleServices;
using Medidata.RBT.Objects.Integration.Helpers;
using TechTalk.SpecFlow;
using Medidata.RBT.Objects.Integration.Configuration;

namespace Medidata.RBT.Features.Integration.Hooks
{
    [Binding]
    public class IntegrationTestRunHooks
    {
        // For additional details on SpecFlow hooks see http://go.specflow.org/doc-hooks

        [BeforeTestRun]
        public static void BeforeTestRun()
        {
            var accessKey = ConfigurationManager.AppSettings["AwsAccessKey"];
            var secretKey = ConfigurationManager.AppSettings["AwsSecretKey"];
            var region = ConfigurationManager.AppSettings["AwsRegion"];

            IntegrationTestContext.SqsWrapper = new SimpleQueueWrapper(accessKey, secretKey, region);

            var queueName = Guid.NewGuid();
            IntegrationTestContext.SqsQueueUrl = IntegrationTestContext.SqsWrapper.CreateQueue(queueName.ToString(), 1209600);

            SQSHelper.UpdateQueueUuid(SQSHelper.EDC_APP_NAME, queueName);
            SQSHelper.UpdateQueueUuid(SQSHelper.MODULES_APP_NAME, Guid.NewGuid());
            SQSHelper.UpdateQueueUuid(SQSHelper.SECURITY_APP_NAME, Guid.NewGuid());

            var service = new ServiceController(string.Format("Medidata Rave Integration Service - \"{0}\"", 
                ConfigurationManager.AppSettings["ServiceName"]));

            if(service.CanStop)
            {
                service.Stop();
                service.WaitForStatus(ServiceControllerStatus.Stopped);
            }

            service.Start();
            service.WaitForStatus(ServiceControllerStatus.Running);
        }

        [AfterTestRun]
        public static void AfterTestRun()
        {
            IntegrationTestContext.SqsWrapper.DeleteQueue(IntegrationTestContext.SqsQueueUrl);
        }

        [BeforeScenario]
        public void BeforeScenario()
        {
            //TODO: implement logic that has to run before executing each scenario
        }

        [AfterScenario]
        public void AfterScenario()
        {
            //TODO: implement logic that has to run after executing each scenario
        }
    }
}
