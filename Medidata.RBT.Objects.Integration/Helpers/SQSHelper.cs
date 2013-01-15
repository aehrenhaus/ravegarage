using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using Medidata.AmazonSimpleServices;
using Medidata.Core.Common.Utilities;
using Medidata.Data;
using Medidata.RBT.Objects.Integration.Configuration.Models;
using Medidata.RBT.Objects.Integration.Configuration.Templates;
using Nustache.Core;
using TechTalk.SpecFlow;
using TechTalk.SpecFlow.Assist;

namespace Medidata.RBT.Objects.Integration.Helpers
{
    public static class SQSHelper
    {
        public static string EDC_APP_NAME = "Rave_iMedidata_Edc_App";
        public static string MODULES_APP_NAME = "Rave_iMedidata_Modules_App";
        public static string SECURITY_APP_NAME = "Rave_iMedidata_Security_App";

        public static void UpdateQueueUuid(string queueName, Guid queueUuid)
        {
            Agent.ExecuteNonQuery(Agent.DefaultHint, "spRISS_UpdateIntegratedApplicationUUID", new object[]{ queueUuid, queueName});
        }

        public static void StudyMessageHandler(Table table, SimpleQueueWrapper sqsWrapper, string url)
        {
            var messageConfigs = table.CreateSet<StudyMessageModel>().ToList();
            foreach (var config in messageConfigs)
            {
                var message = string.Empty;
                switch(config.EventType.ToLowerInvariant())
                {
                    case "post":
                        message = Render.StringToString(StudyTemplates.STUDY_POST_TEMPLATE, new { config });
                        break;
                }

                if(!string.IsNullOrWhiteSpace(message))
                    sqsWrapper.SendMessage(url, message);
            }
        }
    }
}
