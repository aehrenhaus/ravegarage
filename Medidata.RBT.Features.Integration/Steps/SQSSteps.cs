using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Threading;
using Medidata.AmazonSimpleServices;
using Medidata.RBT.Objects.Integration.Configuration.Models;
using Medidata.RBT.Objects.Integration.Configuration.Templates;
using Medidata.RBT.Objects.Integration.Helpers;
using Nustache.Core;
using TechTalk.SpecFlow;
using TechTalk.SpecFlow.Assist;

namespace Medidata.RBT.Features.Integration.Steps
{
    [Binding]
    public class SQSSteps
    {
        // For additional details on SpecFlow step definitions see http://go.specflow.org/doc-stepdef
        [Given(@"I have a SimpleQueueWrapper")]
        public void GivenIHaveASimpleQueueWrapper()
        {
            if (Storage.FeatureValues.ContainsKey("sqsWrapper") || Storage.FeatureValues.ContainsKey("sqsQueueUrl"))
                return;

            var accessKey = ConfigurationManager.AppSettings["AwsAccessKey"];
            var secretKey = ConfigurationManager.AppSettings["AwsSecretKey"];
            var region = ConfigurationManager.AppSettings["AwsRegion"];

            var sqsWrapper = new SimpleQueueWrapper(accessKey, secretKey, region);
            Storage.SetFeatureLevelValue("sqsWrapper", sqsWrapper);

            var queueName = ConfigurationManager.AppSettings["SqsQueueName"];
            try
            {
                Storage.SetFeatureLevelValue("sqsQueueUrl", sqsWrapper.GetQueueURLByQueueName(queueName));
            }
            catch (Exception e)
            {
                Storage.SetFeatureLevelValue("sqsQueueUrl", sqsWrapper.CreateQueue(queueName, 1209600)); //14 days
            }
        }

        [Given(@"I send the following (.*) messages to SQS")]
        public void ISendTheFollowing____MessagesToSQS(string resourceName, Table table)
        {
            var sqsWrapper = Storage.GetFeatureLevelValue<SimpleQueueWrapper>("sqsWrapper");
            var url = Storage.GetFeatureLevelValue<String>("sqsQueueUrl");

            switch(resourceName.ToLowerInvariant())
            {
                case "study":
                    SQSHelper.StudyMessageHandler(table, sqsWrapper, url);
                    break;
            }
        }

        [When(@"the message is successfully processed")]
        public void WhenTheMessageIsSuccessfullyProcessed()
        {
            var sqsWrapper = Storage.GetFeatureLevelValue<SimpleQueueWrapper>("sqsWrapper");
            var url = Storage.GetFeatureLevelValue<String>("sqsQueueUrl");

            Thread.Sleep(5000);

            var numVisibleMessages = sqsWrapper.GetApproximateNumberOfVisibleMessages(url);
            var numInvisibleMessages = sqsWrapper.GetApproximateNumberOfInvisibleMessages(url);
            var endTime = DateTime.Now.AddSeconds(10);

            while(numVisibleMessages > 0 || numInvisibleMessages > 0)
            {
                if(DateTime.Now.Ticks > endTime.Ticks) throw new TimeoutException("Message was not processed");
                
                numVisibleMessages = sqsWrapper.GetApproximateNumberOfVisibleMessages(url);
                numInvisibleMessages = sqsWrapper.GetApproximateNumberOfInvisibleMessages(url);
            }
        }

        [Then(@"I should see the study with UUID ""(.*)"" in the Rave database")]
        public void ThenIShouldSeeTheStudyWithUUIDInTheRaveDatabase(string p0)
        {
            ScenarioContext.Current.Pending();
        }


    }
}
