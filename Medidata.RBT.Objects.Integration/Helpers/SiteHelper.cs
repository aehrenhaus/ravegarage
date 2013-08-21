using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Medidata.AmazonSimpleServices;
using Medidata.Core.Objects;
using Medidata.RBT.Objects.Integration.Configuration;
using Medidata.RBT.Objects.Integration.Configuration.Models;
using Medidata.RBT.Objects.Integration.Configuration.Templates;
using Nustache.Core;
using TechTalk.SpecFlow;
using TechTalk.SpecFlow.Assist;

namespace Medidata.RBT.Objects.Integration.Helpers
{
    public static class SiteHelper
    {
        public static void MessageHandler(Table table)
        {
            var messageConfigs = table.CreateSet<SiteMessageModel>().ToList();
            ScenarioContext.Current.Set(messageConfigs.Count, "messageCount");

            foreach (var config in messageConfigs)
            {
                var message = string.Empty;

                config.MessageId = Guid.NewGuid();

                switch (config.EventType.ToLowerInvariant())
                {
                    case "post":
                        config.Uuid = config.Uuid.ToString() == "00000000-0000-0000-0000-000000000000" ? Guid.NewGuid() : config.Uuid;                    
                        ScenarioContext.Current.Add("siteUuid", config.Uuid.ToString());
                        message = Render.StringToString(SiteTemplates.POST_TEMPLATE, new { config });
                        break;
                    case "put":
                        if (config.Uuid.ToString() == "00000000-0000-0000-0000-000000000000")
                        {
                            config.Uuid = ScenarioContext.Current.Keys.Contains("siteUuid") ?
                                      new Guid(ScenarioContext.Current.Get<String>("siteUuid")) : //site was created via post message
                                      new Guid(ScenarioContext.Current.Get<Site>("site").Uuid);  //site was seeded in Rave
                        }
                        else
                        {
                            ScenarioContext.Current.Set(config.Uuid.ToString(), "siteUuid");
                        }
                        
                        message = Render.StringToString(SiteTemplates.PUT_TEMPLATE, new { config });
                        break;
                }

                SQSHelper.SendMessage(message);
            }
        }

        public static void CreateRaveSite(string siteNumber, string siteName = "SiteName")
        {
            var site = new Site(SystemInteraction.Use())
                           {
                               Active = true,
                               Number = siteNumber,
                               Name = siteName,
                               ExternalSystem = ExternalSystem.GetByID(1),
                               Uuid = Guid.NewGuid().ToString()
                           };
            site.Save();
            ScenarioContext.Current.Add("site", site);
        }
    }
}
