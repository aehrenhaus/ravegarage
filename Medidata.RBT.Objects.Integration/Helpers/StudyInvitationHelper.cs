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
            ScenarioContext.Current.Set(messageConfigs.Count, "messageCount");
            
            foreach (var config in messageConfigs)
            {
                var isStudyInvitation = config.InvitationType.ToLower() == ResourceNames.STUDY_INVITATION;

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
                config.Resource = isStudyInvitation ? "study_invitation" : "study_group_invitation";
                config.ObjectType = isStudyInvitation ? "study" : "study_group";

                switch (config.EventType.ToLowerInvariant())
                {
                    case "post":
                        config.AppAssignments = appAssignments;

                        config.UserUuid = ScenarioContext.Current.ContainsKey("externalUserUUID")
                                              ? new Guid(ScenarioContext.Current.Get<string>("externalUserUUID"))
                                              : Guid.NewGuid();
                        config.UserId = ScenarioContext.Current.ContainsKey("externalUserID")
                                            ? ScenarioContext.Current.Get<int>("externalUserID")
                                            : new Random().Next();
                        
                        ScenarioContext.Current.Set(config.UserUuid.ToString(), "externalUserUUID");
                        ScenarioContext.Current.Set(config.UserId, "externalUserID");

                        config.StudyUuid = config.StudyUuid.ToString() == "00000000-0000-0000-0000-000000000000"
                                               ? new Guid(ScenarioContext.Current.Get<Study>("study").Uuid)
                                               : config.StudyUuid;

                        Console.WriteLine("User UUID: {0}", config.UserUuid);
                        Console.WriteLine("Study UUID: {0}", config.StudyUuid);

                        message = Render.StringToString(StudyInvitationTemplates.POST_PUT_TEMPLATE, new { config });
                        break;
                    case "put":
                        config.AppAssignments = appAssignments;

                        config.UserUuid = new Guid(ScenarioContext.Current.Get<string>("externalUserUUID"));
                        config.UserId = ScenarioContext.Current.Get<int>("externalUserID");

                        config.StudyUuid = config.StudyUuid.ToString() == "00000000-0000-0000-0000-000000000000"
                                               ? (ScenarioContext.Current.ContainsKey("study")
                                                      ? new Guid(ScenarioContext.Current.Get<Study>("study").Uuid)
                                                      : Guid.NewGuid())
                                               : config.StudyUuid;

                        Console.WriteLine("User UUID: {0}", config.UserUuid);
                        Console.WriteLine("Study UUID: {0}", config.StudyUuid);

                        message = Render.StringToString(StudyInvitationTemplates.POST_PUT_TEMPLATE, new { config });
                        break;
                    case "delete":
                        config.UserUuid = new Guid(ScenarioContext.Current.Get<string>("externalUserUUID"));
                        config.UserId = ScenarioContext.Current.Get<int>("externalUserID");

                        config.StudyUuid = config.StudyUuid.ToString() == "00000000-0000-0000-0000-000000000000"
                                               ? (ScenarioContext.Current.ContainsKey("study")
                                                      ? new Guid(ScenarioContext.Current.Get<Study>("study").Uuid)
                                                      : Guid.NewGuid())
                                               : config.StudyUuid;

                        message = Render.StringToString(StudyInvitationTemplates.DELETE_TEMPLATE, new { config });
                        break;
                }

                SQSHelper.SendMessage(message);
            }
        }

        
    }
}
