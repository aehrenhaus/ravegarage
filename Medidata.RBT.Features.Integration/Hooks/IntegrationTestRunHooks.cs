using System;
using System.Configuration;
using System.IO;
using System.Reflection;
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
            Objects.Integration.Helpers.DbHelper.RestoreDatabase();

            IntegrationTestContext.TestFailed = false;

            var accessKey = ConfigurationManager.AppSettings["AwsAccessKey"];
            var secretKey = ConfigurationManager.AppSettings["AwsSecretKey"];
            var region = ConfigurationManager.AppSettings["AwsRegion"];

            IntegrationTestContext.SqsWrapper = new SimpleQueueWrapper(accessKey, secretKey, region);

            var queueName = Guid.NewGuid();
            IntegrationTestContext.SqsQueueUrl = IntegrationTestContext.SqsWrapper.CreateQueue(queueName.ToString(), 1209600);
            Console.WriteLine("Queue URL: {0}", IntegrationTestContext.SqsQueueUrl);

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
            
            if(IntegrationTestContext.TestFailed)
            {
                
            }
        }

        [BeforeScenario]
        public void BeforeScenario()
        {
            //TODO: implement logic that has to run before executing each scenario
        }

        [AfterScenario]
        public void AfterScenario()
        {
            if(ScenarioContext.Current.TestError != null)
            {
                IntegrationTestContext.TestFailed = true;
            }
        }
    }
}
