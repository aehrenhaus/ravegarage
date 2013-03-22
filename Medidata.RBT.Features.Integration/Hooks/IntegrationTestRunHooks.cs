using System;
using System.Configuration;
using System.IO;
using System.Reflection;
using System.ServiceProcess;
using Medidata.AmazonSimpleServices;
using Medidata.RBT.Objects.Integration.Helpers;
using Microsoft.Practices.Unity;
using Microsoft.Practices.Unity.Configuration;
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
            DbHelper.RestoreDatabase();

            IntegrationTestContext.TestFailed = false;

            if (!ConfigurationManager.AppSettings[AppSettingsTags.MessageDeliveryType]
                     .Equals(MessageDeliveryTypes.SQS))
            {
                return;
            }

            var accessKey = ConfigurationManager.AppSettings["AwsAccessKey"];
            var secretKey = ConfigurationManager.AppSettings["AwsSecretKey"];
            var region = ConfigurationManager.AppSettings["AwsRegion"];

            IntegrationTestContext.SqsWrapper = new SimpleQueueWrapper(accessKey, secretKey, region);

            var edcQueueName = Guid.NewGuid();
            var modulesQueueName = Guid.NewGuid();
            var securityQueueName = Guid.NewGuid();

            IntegrationTestContext.SqsQueueUrl = IntegrationTestContext.SqsWrapper.CreateQueue(edcQueueName.ToString(), 1209600);
            Console.WriteLine("EDC Queue URL: {0}", IntegrationTestContext.SqsQueueUrl);

            Console.WriteLine("Modules Queue URL: {0}",
                IntegrationTestContext.SqsWrapper.CreateQueue(modulesQueueName.ToString(), 1209600));
            Console.WriteLine("Security Queue URL: {0}",
                IntegrationTestContext.SqsWrapper.CreateQueue(securityQueueName.ToString(), 1209600));

            SQSHelper.UpdateQueueUuid(SQSHelper.EDC_APP_NAME, edcQueueName);
            SQSHelper.UpdateQueueUuid(SQSHelper.MODULES_APP_NAME, modulesQueueName);
            SQSHelper.UpdateQueueUuid(SQSHelper.SECURITY_APP_NAME, securityQueueName);

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
            if (ConfigurationManager.AppSettings[AppSettingsTags.MessageDeliveryType]
                     .Equals(MessageDeliveryTypes.SQS))
            {
                IntegrationTestContext.SqsWrapper.DeleteQueue(IntegrationTestContext.SqsQueueUrl);
            }

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
