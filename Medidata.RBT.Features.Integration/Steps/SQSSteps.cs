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
    }
}
