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

        //if we're in SQS mode, we'll need a reference to the RIS.
        private static ServiceController RaveIntegrationServiceController { get; set; }

        static IntegrationTestRunHooks()
        {
            RaveIntegrationServiceController = null;
        }

        [BeforeTestRun]
        public static void BeforeTestRun()
        {
            IntegrationTestContext.TestFailed = false;

            //are we in SQS mode? If so, we'll need to do some additional setup
            //of the rave service and message queues
            var isSqsMode = ConfigurationManager.AppSettings[AppSettingsTags.MessageDeliveryType]
                .Equals(MessageDeliveryTypes.SQS);

            if (isSqsMode)
            {
                //get a reference to the rave service, since SQS mode uses the real service.
                RaveIntegrationServiceController = new ServiceController(string.Format("Medidata Rave Integration Service - \"{0}\"",
                    ConfigurationManager.AppSettings["ServiceName"]));

                //stop the service, before dropping and restoring the database
                //this avoids a bunch of errors being logged by the RIS while
                //the database is down.
                stopRaveServiceIfStarted();
            }

            //for either mode, we drop and restore the database
            DbHelper.RestoreDatabase();

            if (isSqsMode)
            {
                //create the real queues and update the app configurations in the database
                createQueues();

                //start the real rave service, which will read our updated configurations.
                startRaveService();    
            }
        }

        [AfterTestRun]
        public static void AfterTestRun()
        {
            //If the RIS service was started, this function will stop it.
            //If we don't stop it, a bunch of errors will be logged in the service
            //due to the deleted message queues.
            stopRaveServiceIfStarted();

            if (ConfigurationManager.AppSettings[AppSettingsTags.MessageDeliveryType]
                     .Equals(MessageDeliveryTypes.SQS))
            {
                IntegrationTestContext.SqsWrapper.DeleteQueue(IntegrationTestContext.SqsQueueUrl);
            }

            if(IntegrationTestContext.TestFailed)
            {
                
            }

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
            if(ScenarioContext.Current.TestError != null)
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

                System.Diagnostics.Process p = new System.Diagnostics.Process();

                p.StartInfo = new System.Diagnostics.ProcessStartInfo(
                   @"powershell.exe",
                   arguments);

                //TODO: gerrard debug code
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

            var queueNames = getQueueNames(
                new[] { SQSHelper.EDC_APP_NAME, 
                    SQSHelper.MODULES_APP_NAME, 
                    SQSHelper.SECURITY_APP_NAME });

            var edcQueueName = queueNames[SQSHelper.EDC_APP_NAME];
            var modulesQueueName = queueNames[SQSHelper.MODULES_APP_NAME];
            var securityQueueName = queueNames[SQSHelper.SECURITY_APP_NAME];

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

        /// <summary>
        /// Creates a Dictionary containing Guids for each application name provided. Each guid is based on a combination 
        /// of the application name, the current windows username and the machine name on which the tests are being run.
        /// </summary>
        /// <param name="appNames"></param>
        /// <returns></returns>
        private static Dictionary<string, Guid> getQueueNames(IEnumerable<string> appNames)
        {
            //just a random guid to make sure all generated guids are in a custom namespace
            const string mdsolNamespaceQuid = "359d6391-ae61-48e9-a0bf-1997c8e70a7f";
            var nsGuid = Guid.Parse(mdsolNamespaceQuid);

            var machineName = Environment.MachineName;

            // ReSharper disable PossibleNullReferenceException
            var username = System.Security.Principal.WindowsIdentity.GetCurrent().Name.Split('\\').Last();
            // ReSharper restore PossibleNullReferenceException

            var uniqueString = string.Format("{0}.{1}.mdsol.com", username, machineName);

            var result = new Dictionary<string, Guid>();

            appNames.ToList().ForEach(appName =>
            {
                var uniqueAppName = string.Format("{0}.{1}", appName, uniqueString);

                result.Add(appName, GuidUtility.Create(nsGuid, uniqueAppName));
            });

            return result;
        }
    }
}
