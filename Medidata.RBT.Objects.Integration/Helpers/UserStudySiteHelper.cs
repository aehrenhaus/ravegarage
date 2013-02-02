using System;
using System.Linq;
using Medidata.AmazonSimpleServices;
using Medidata.RBT.Objects.Integration.Configuration.Models;
using Medidata.RBT.Objects.Integration.Configuration.Templates;
using Nustache.Core;
using TechTalk.SpecFlow;
using TechTalk.SpecFlow.Assist;

namespace Medidata.RBT.Objects.Integration.Helpers
{
    public class UserStudySiteHelper
    {
        public static void MessageHandler(Table table, SimpleQueueWrapper sqsWrapper, string url)
        {
            var messageConfigs = table.CreateSet<UserStudySiteMessageModel>().ToList();
            foreach (var config in messageConfigs)
            {
                var message = string.Empty;

                config.MessageId = Guid.NewGuid();

                switch (config.EventType.ToLowerInvariant())
                {
                    case "post":
                        config.UUID = Guid.NewGuid();
                        ScenarioContext.Current.Add("userStudySiteUuid", config.UUID);
                        message = Render.StringToString(UserStudySiteTemplates.USERSTUDYSITE_POST_TEMPLATE, new { config });
                        break;
                    case "delete":
                        message = Render.StringToString(UserStudySiteTemplates.USERSTUDYSITE_DELETE_TEMPLATE, new { config });
                        break;
                }

                if (!string.IsNullOrWhiteSpace(message))
                    sqsWrapper.SendMessage(url, message);
            }
        }
    }
}
