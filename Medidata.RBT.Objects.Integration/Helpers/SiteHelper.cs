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

        public static void CreateRaveSites(Table table)
        {
            //NOTE: putting table processing logic here to be consistent with MessageHandler
            var interaction = SystemInteraction.Use();

            var siteModels = table.CreateSet<SiteModel>();

            //name and number should are required.
            if (siteModels.Any(sm => sm.Name == null || sm.Number == null))
            {
                throw new ArgumentException("Both site name and number must be specified for all sites in scenario definition.");
            }

            siteModels.ToList().ForEach(sm =>
                {
                    var site = new Site(interaction)
                    {
                        Active = true,
                        ExternalSystem = ExternalSystem.GetByID(1),

                        Uuid = sm.Uuid ?? Guid.NewGuid().ToString(),
                        Name = sm.Name,
                        Number = sm.Number,

                        AddressLine1 = sm.AddressLine1,
                        City = sm.City,
                        State = sm.State,
                        PostalCode = sm.PostalCode,
                        Country = sm.Country,
                        Telephone = sm.Telephone,                        
                    };

                    site.Save();

                    //TODO: discuss this architecture, this shouldn't be here...specify UUIDs explicitly in scenario definition.
                    ScenarioContext.Current.Add("site", site);
                });
        }
    }
}
