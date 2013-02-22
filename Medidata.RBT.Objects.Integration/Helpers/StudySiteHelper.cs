using System;using System.Collections.Generic;
using System.Linq;
using System.Text;
using Medidata.AmazonSimpleServices;
using Medidata.RBT.Objects.Integration.Configuration;
using Medidata.RBT.Objects.Integration.Configuration.Models;
using Medidata.RBT.Objects.Integration.Configuration.Templates;
using Nustache.Core;
using Medidata.Core.Objects;
using Medidata.Data;
using Medidata.Data.Configuration;
using TechTalk.SpecFlow;
using TechTalk.SpecFlow.Assist;

namespace Medidata.RBT.Objects.Integration.Helpers
{
    public static class StudySiteHelper
    {
        public static void MessageHandler(Table table)
        {
            var messageConfigs = table.CreateSet<StudySiteMessageModel>().ToList();
            ScenarioContext.Current.Set(messageConfigs.Count, "messageCount");

            foreach (var config in messageConfigs)
            {
                var message = string.Empty;

                config.MessageId = Guid.NewGuid();

                switch (config.EventType.ToLowerInvariant())
                {
                    case "post":
                        config.StudySiteUuid = Guid.NewGuid();
                        config.SiteUuid = Guid.NewGuid();
                        config.StudyUuid = new Guid(ScenarioContext.Current.Get<Study>("study").Uuid); // scenarios should verify that study already exists.
                        
                        ScenarioContext.Current.Set(config.StudySiteUuid.ToString(), "studySiteUuid");
                        ScenarioContext.Current.Set(config.SiteUuid.ToString(), "siteUuid");

                        Console.WriteLine("StudySite UUID: {0}", config.StudySiteUuid);
                        Console.WriteLine("Study UUID: {0}", config.StudyUuid);
                        Console.WriteLine("Site UUID: {0}", config.SiteUuid);

                        message = Render.StringToString(StudySiteTemplates.POST_TEMPLATE, new { config });
                        break;
                    case "put":
                        config.StudyUuid = new Guid(ScenarioContext.Current.Get<Study>("study").Uuid);
                        config.SiteUuid = new Guid(ScenarioContext.Current.Get<string>("siteUuid"));
                        config.StudySiteUuid = new Guid(ScenarioContext.Current.Get<string>("studySiteUuid"));
                        
                        message = Render.StringToString(StudySiteTemplates.PUT_TEMPLATE, new { config });
                        break;
                    case "delete":
                        config.StudyUuid = new Guid(ScenarioContext.Current.Get<Study>("study").Uuid);
                        config.SiteUuid = new Guid(ScenarioContext.Current.Get<string>("siteUuid"));
                        config.StudySiteUuid = new Guid(ScenarioContext.Current.Get<string>("studySiteUuid"));

                        message = Render.StringToString(StudySiteTemplates.DELETE_TEMPLATE, new { config });
                        break;
                }

                SQSHelper.SendMessage(message);
            }
        }

		public static void CreateRaveStudySite(int externalId)
		{
            var study = ScenarioContext.Current.Get<Study>("study");
            var site = ScenarioContext.Current.Get<Site>("site");
            
            var studySite = new StudySite(study, site, SystemInteraction.Use())
                                {
                                    ExternalID = externalId,
                                    ExternalSystem = ExternalSystem.GetByID(1)
                                };
            studySite.Save();
		    ScenarioContext.Current.Add("studySite", studySite);
		}
    }
}
