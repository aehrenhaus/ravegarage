using System;
using System.Linq;
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
    public class UserStudySiteHelper
    {
        public static void MessageHandler(Table table)
        {
            var messageConfigs = table.CreateSet<UserStudySiteMessageModel>().ToList();

            var messagesToSend = messageConfigs.Select(config =>
                {
                    string message = null;

                    config.MessageId = Guid.NewGuid();

                    switch (config.EventType.ToLowerInvariant())
                    {
                        case "post":
                            config.SiteUUID = new Guid(ScenarioContext.Current.Get<Site>("site").Uuid);
                            config.StudyUUID = new Guid(ScenarioContext.Current.Get<Study>("study").Uuid);
                            config.UserUUID = new Guid(ScenarioContext.Current.Get<String>("externalUserUUID"));

                            message = Render.StringToString(UserStudySiteTemplates.USERSTUDYSITE_POST_TEMPLATE,
                                                            new {config});
                            break;
                        case "delete":
                            config.SiteUUID = new Guid(ScenarioContext.Current.Get<Site>("site").Uuid);
                            config.StudyUUID = new Guid(ScenarioContext.Current.Get<Study>("study").Uuid);
                            config.UserUUID = new Guid(ScenarioContext.Current.Get<String>("externalUserUUID"));
                            message = Render.StringToString(UserStudySiteTemplates.USERSTUDYSITE_DELETE_TEMPLATE,
                                                            new {config});
                            break;
                    }

                    return message;
                });

            SQSHelper.SendMessages(messagesToSend);
        }

        public static void CreateUserStudySiteAssignment(DateTime? lastExternalUpdateDate = null)
        {
            var user = ScenarioContext.Current.Get<User>("user");
            var studySite = ScenarioContext.Current.Get<StudySite>("studySite");

            var lastExternalUpdateDateToUse = lastExternalUpdateDate.HasValue
                                                  ? lastExternalUpdateDate.Value
                                                  : DateTime.Now;

            user.AddUserToStudySite(studySite, null, false, lastExternalUpdateDateToUse);
        }
    }
}
