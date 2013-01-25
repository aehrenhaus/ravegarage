using System;
using System.Linq;
using Medidata.AmazonSimpleServices;
using Medidata.RBT.Objects.Integration.Configuration.Models;
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
                        break;
                    case "delete":
                        break;
                }

                if (!string.IsNullOrWhiteSpace(message))
                    sqsWrapper.SendMessage(url, message);
            }
        }
    }
}
