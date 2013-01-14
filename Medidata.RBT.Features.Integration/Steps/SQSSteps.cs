using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
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

        [Given(@"I send the following Study POST message to SQS")]
        public void ISendTheFollowingMessageToSQS(Table table)
        {
            List<StudyMessageModel> messageConfigs = table.CreateSet<StudyMessageModel>().ToList();
            foreach(var config in messageConfigs)
            {
                var message = Render.StringToString(StudyTemplates.STUDY_POST_TEMPLATE, new { config });


            }
        }

        [When(@"the message is successfully processed")]
        public void WhenTheMessageIsSuccessfullyProcessed()
        {
            ScenarioContext.Current.Pending();
        }

        [Then(@"I should see the study in the Rave database\.")]
        public void ThenIShouldSeeTheStudyInTheRaveDatabase_()
        {
            ScenarioContext.Current.Pending();
        }

    }
}
