using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Medidata.AmazonSimpleServices;
using Medidata.Core.Objects;
using Medidata.RBT.Objects.Integration.Configuration.Models;
using Medidata.RBT.Objects.Integration.Configuration.Templates;
using Nustache.Core;
using TechTalk.SpecFlow;
using TechTalk.SpecFlow.Assist;

namespace Medidata.RBT.Objects.Integration.Helpers
{
    public static class SiteHelper
    {
        public static void MessageHandler(Table table, SimpleQueueWrapper sqsWrapper, string url)
        {
            var messageConfigs = table.CreateSet<SiteMessageModel>().ToList();
            foreach (var config in messageConfigs)
            {
                var message = string.Empty;

                config.MessageId = Guid.NewGuid();

                switch (config.EventType.ToLowerInvariant())
                {
                    case "post":
                        config.Uuid = Guid.NewGuid();
                        ScenarioContext.Current.Add("siteUuid", config.Uuid.ToString());
                        message = Render.StringToString(SiteTemplates.POST_TEMPLATE, new { config });
                        break;
                    case "put":
                        config.Uuid = new Guid(ScenarioContext.Current.Get<String>("siteUuid"));
                        message = Render.StringToString(SiteTemplates.PUT_TEMPLATE, new { config });
                        break;
                }

                if (!string.IsNullOrWhiteSpace(message))
                    sqsWrapper.SendMessage(url, message);
            }
        }

        public static void CreateRaveSite(string siteNumber)
        {
            var site = new Site(SystemInteraction.Use())
                           {
                               Active = true,
                               Number = siteNumber,
                               ExternalSystem = ExternalSystem.GetByID(1),
                               Uuid = Guid.NewGuid().ToString()
                           };
            site.Save();
            ScenarioContext.Current.Add("site", site);
        }
    }
}
