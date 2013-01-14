using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using Medidata.AmazonSimpleServices;
using Medidata.RBT.Objects.Integration.Configuration.Models;
using Medidata.RBT.Objects.Integration.Configuration.Templates;
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
            if(!Storage.FeatureValues.ContainsKey("sqsWrapper") && !Storage.FeatureValues.ContainsKey("sqsQueueUrl"))
            {
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
        }

        [Given(@"I send the following Study POST message to SQS")]
        public void ISendTheFollowingMessageToSQS(Table table)
        {
            var sqsWrapper = Storage.GetFeatureLevelValue<SimpleQueueWrapper>("sqsWrapper");
            var url = Storage.GetFeatureLevelValue<String>("sqsQueueUrl");

            List<StudyMessageModel> messageConfigs = table.CreateSet<StudyMessageModel>().ToList();
            foreach(var config in messageConfigs)
            {
                var message = Render.StringToString(StudyTemplates.STUDY_POST_TEMPLATE, new { config });

                sqsWrapper.SendMessage(url, message);
            }
        }

        [When(@"the message is successfully processed")]
        public void WhenTheMessageIsSuccessfullyProcessed()
        {
            var sqsWrapper = Storage.GetFeatureLevelValue<SimpleQueueWrapper>("sqsQueueUrl");
            ScenarioContext.Current.Pending();
        }

        [Then(@"I should see the study in the Rave database\.")]
        public void ThenIShouldSeeTheStudyInTheRaveDatabase_()
        {
            ScenarioContext.Current.Pending();
        }

    }
}
