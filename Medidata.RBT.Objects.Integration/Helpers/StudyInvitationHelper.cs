using System;
using System.Collections.Generic;
using System.Linq;
using Medidata.AmazonSimpleServices;
using Medidata.Core.Objects;
using Medidata.Core.Objects.Security;
using Medidata.RBT.Objects.Integration.Configuration;
using Medidata.RBT.Objects.Integration.Configuration.Models;
using Medidata.RBT.Objects.Integration.Configuration.Templates;
using Nustache.Core;
using TechTalk.SpecFlow;
using TechTalk.SpecFlow.Assist;

namespace Medidata.RBT.Objects.Integration.Helpers
{
    public static class StudyInvitationHelper
    {
        public static void MessageHandler(Table table)
        {
            var messageConfigs = table.CreateSet<StudyInvitationMessageModel>().ToList();
            foreach (var config in messageConfigs)
            {
                var message = string.Empty;

                var edcAppAssignments = ScenarioContext.Current.ContainsKey("edcAppAssignments")
                                            ? ScenarioContext.Current.Get<AppAssignmentModel>(
                                                "edcAppAssignments")
                                            : new AppAssignmentModel();
                var architectAppAssignment = ScenarioContext.Current.ContainsKey("architectAppAssignments")
                                                 ? ScenarioContext.Current.Get<AppAssignmentModel>(
                                                     "architectAppAssignments")
                                                 : new AppAssignmentModel();
                var modulesAppAssignment = ScenarioContext.Current.ContainsKey("modulesAppAssignments")
                                               ? ScenarioContext.Current.Get<AppAssignmentModel>(
                                                   "modulesAppAssignments")
                                               : new AppAssignmentModel();
                var appAssignments = new List<AppAssignmentModel>
                                         { edcAppAssignments, architectAppAssignment, modulesAppAssignment };

                config.MessageId = Guid.NewGuid();

                switch (config.EventType.ToLowerInvariant())
                {
                    case "post":
                        config.AppAssignments = appAssignments;

                        config.UserUuid = Guid.NewGuid();
                        ScenarioContext.Current.Add("externalUserUUID", config.UserUuid.ToString());

                        config.StudyUuid = new Guid(ScenarioContext.Current.Get<Study>("study").Uuid);

                        Console.WriteLine("User UUID: {0}", config.UserUuid);
                        Console.WriteLine("Study UUID: {0}", config.StudyUuid);

                        message = Render.StringToString(StudyInvitationTemplates.POST_PUT_TEMPLATE, new { config });
                        break;
                    case "put":
                        config.AppAssignments = appAssignments;

                        config.UserUuid = new Guid(ScenarioContext.Current.Get<string>("externalUserUUID"));
                        config.UserId = ScenarioContext.Current.Get<int>("externalUserID");
                        config.StudyUuid = new Guid(ScenarioContext.Current.Get<Study>("study").Uuid);

                        Console.WriteLine("User UUID: {0}", config.UserUuid);
                        Console.WriteLine("Study UUID: {0}", config.StudyUuid);

                        message = Render.StringToString(StudyInvitationTemplates.POST_PUT_TEMPLATE, new { config });
                        break;
                    case "delete":
                        config.UserId = ScenarioContext.Current.Get<int>("externalUserID");
                        config.UserUuid = new Guid(ScenarioContext.Current.Get<string>("externalUserUUID"));
                        config.StudyUuid = new Guid(ScenarioContext.Current.Get<Study>("study").Uuid);
                        message = Render.StringToString(StudyInvitationTemplates.DELETE_TEMPLATE, new { config });
                        break;
                }

                SQSHelper.SendMessage(message);
            }
        }

        
    }
}
