using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Linq;
using System.Reflection;
using System.ServiceProcess;
using Medidata.AmazonSimpleServices;
using Medidata.RBT.Objects.Integration.Helpers;
using Microsoft.Practices.Unity;
using Microsoft.Practices.Unity.Configuration;
using TechTalk.SpecFlow;
using Medidata.RBT.Objects.Integration.Configuration;
using TechTalk.SpecFlow.Configuration;

namespace Medidata.RBT.Features.Integration.Hooks
{
    [Binding]
    public class IntegrationTestRunHooks
    {
        // For additional details on SpecFlow hooks see http://go.specflow.org/doc-hooks

        private static bool IsSqsMode { get; set; }
        private static bool ShouldManageService { get; set;}

        //if we're in SQS mode, we'll need a reference to the RIS.
        private static ServiceController RaveIntegrationServiceController { get; set; }

        static IntegrationTestRunHooks()
        {
            //will be set to an instance (if needed) by BeforeTestRun
            RaveIntegrationServiceController = null;
        }

        [BeforeTestRun]
        public static void BeforeTestRun()
        {
            IntegrationTestContext.TestFailed = false;

            //are we in SQS mode? If so, we'll need to do some additional setup
            //of the rave service and message queues
            IsSqsMode = ConfigurationManager.AppSettings[AppSettingsTags.MessageDeliveryTypeKey]
                .Equals(MessageDeliveryTypes.SQS);

            //we won't manage the service in Broker mode, regardless of the service config settings.
            ShouldManageService = IsSqsMode && GetAppSettingsBooleanValueOrThrow(AppSettingsTags.ManageServiceKey);
            
            if (ShouldManageService)
            {
                //get service details from appsettings
                var serviceName = ConfigurationManager.AppSettings[AppSettingsTags.ServiceNameKey];
                var serviceMachineName = ConfigurationManager.AppSettings["ServiceMachineName"] ?? ".";

                //get a reference to the rave service, since SQS mode uses the real service.
                RaveIntegrationServiceController = new ServiceController(string.Format("Medidata Rave Integration Service - \"{0}\"",
                    serviceName), serviceMachineName);

                //stop the service, so it's not running while we update (possibly) restore the database 
                //and/or update the queue urls in application configs.
                stopRaveServiceIfStarted();
            }

            //for either mode, we need to prepare the database
            prepareDatabase();

            if (IsSqsMode)
            {
                //create the real queues and update the app configurations in the database
                createQueues();
            }

            if (ShouldManageService)
            {
                startRaveService();
            }
        }

        [AfterTestRun]
        public static void AfterTestRun()
        {
            //If the RIS service was started, this function will stop it.
            //If we don't stop it, a bunch of errors will be logged in the service
            //due to the deleted message queues.
            if (ShouldManageService)
            {
                stopRaveServiceIfStarted();
            }

            if (IsSqsMode)
            {
                IntegrationTestContext.SqsWrapper.DeleteQueue(IntegrationTestContext.SqsQueueUrl);
            }

            if (IntegrationTestContext.TestFailed)
            {

            }
            
            //restore our state to before the test runs
            DbHelper.RestoreSnapshot();

            //delete the snapshot, it's no longer needed.
            DbHelper.DeleteSnapshot();

            //TODO: replace this temporary copy of report generation with a shared class
            GenerateReport();
        }

        [BeforeScenario]
        public void BeforeScenario()
        {
            //TODO: implement logic that has to run before executing each scenario
        }

        [AfterScenario]
        public void AfterScenario()
        {
            if (ScenarioContext.Current.TestError != null)
            {
                IntegrationTestContext.TestFailed = true;
            }
        }

        private static void GenerateReport()
        {

            //TODO: remove this duplicated logic from SpecflowWebTestContext for checking the UnitTestProvider 
            var specflowSectionHandler = (ConfigurationSectionHandler)ConfigurationManager.GetSection("specFlow");

            if (!specflowSectionHandler.UnitTestProvider.Name.Contains("SpecRun")
                && specflowSectionHandler.UnitTestProvider.Name.Contains("MsTest"))
            {

                var ravePath = ConfigurationManager.AppSettings["RavePath"];

                var scriptPath = Path.Combine(ravePath, @"ravegarage\reportGen.ps1");

                var projectPath = Path.Combine(ravePath, @"ravegarage\Medidata.RBT.Features.Integration\Medidata.RBT.Features.Integration.csproj");

                var arguments = string.Format("-executionpolicy unrestricted -file \"{0}\" \"{1}\"", scriptPath, projectPath);

                var p = new System.Diagnostics.Process();

                p.StartInfo = new System.Diagnostics.ProcessStartInfo(
                   @"powershell.exe",
                   arguments);

                p.StartInfo.UseShellExecute = false;
                p.StartInfo.RedirectStandardOutput = true;

                p.Start();

                //don't wait for the script to finish
            }
        }

        private static void stopRaveServiceIfStarted()
        {
            if (RaveIntegrationServiceController != null && RaveIntegrationServiceController.CanStop)
            {
                RaveIntegrationServiceController.Stop();
                RaveIntegrationServiceController.WaitForStatus(ServiceControllerStatus.Stopped);
            }
        }

        private static void startRaveService()
        {
            if (RaveIntegrationServiceController != null)
            {
                RaveIntegrationServiceController.Start();
                RaveIntegrationServiceController.WaitForStatus(ServiceControllerStatus.Running);
            }
        }

        private static void createQueues()
        {
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
        }

        public static bool GetAppSettingsBooleanValueOrThrow(string key)
        {
            bool result;

            if (!bool.TryParse(ConfigurationManager.AppSettings[key], out result))
            {
                throw new ConfigurationErrorsException(
                    string.Format("Couldn't parse {0} value as a boolean.", key));
            }

            return result;
        }

        private static void prepareDatabase()
        {
            //if a snapshot exists...
            if (DbHelper.DoesSnapshotExist())
            {
                //the last run didn't get cleaned up, so the database
                //needs to be restored to the snapshot state
                DbHelper.RestoreSnapshot();
            }
            else
            {
                //create a new snapshot
                DbHelper.CreateSnapshot();
            }
        }
    }
}
