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
    public static class UserHelper
    {
        public static void UserMessageHandler(Table table, SimpleQueueWrapper sqsWrapper, string url)
        {
            var messageConfigs = table.CreateSet<UserMessageModel>().ToList();
            foreach (var config in messageConfigs)
            {
                var message = string.Empty;

                config.MessageId = Guid.NewGuid();
                config.UUID = Guid.NewGuid();
                ScenarioContext.Current.Add("userUuid", config.UUID.ToString());
                Console.WriteLine("User UUID: {0}", config.UUID);

                message = Render.StringToString(UserTemplates.USER_PUT_TEMPLATE, new {config});

                if (!string.IsNullOrWhiteSpace(message))
                    sqsWrapper.SendMessage(url, message);
            }
        }
    }
}
