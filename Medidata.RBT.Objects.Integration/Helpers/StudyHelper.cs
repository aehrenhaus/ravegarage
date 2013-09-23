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
    public static class StudyHelper
    {
        public static void StudyMessageHandler(Table table)
        {
            var messageConfigs = table.CreateSet<StudyMessageModel>().ToList();

            var messagesToSend = messageConfigs.Select(config =>
                {
                    string message = null;

                    config.MessageId = Guid.NewGuid();

                    switch (config.EventType.ToLowerInvariant())
                    {
                        case "post":
                            config.UUID = Guid.NewGuid();
                            ScenarioContext.Current.Set(config.UUID.ToString(), "studyUuid");
                            Console.WriteLine("Study UUID: {0}", config.UUID);
                            message = Render.StringToString(StudyTemplates.STUDY_POST_TEMPLATE, new { config });
                            break;
                        case "put":
                            config.UUID = new Guid(ScenarioContext.Current.Get<String>("studyUuid"));
                            message = Render.StringToString(StudyTemplates.STUDY_PUT_TEMPLATE, new { config });
                            break;
                    }

                    return message;
                });

            SQSHelper.SendMessages(messagesToSend);
        }

        public static void CreateStudy(string name, string environment, int externalId, string uuid=null, bool internalStudy=false)
        {
            var project = new Project(SystemInteraction.Use())
                              {
                                  Name = name,
                                  IsActive = true,
                                  UUID = Guid.NewGuid().ToString()
                              };
            project.Save();

            var study = new Study(environment, false, project, SystemInteraction.Use())
                            {
                                ExternalID = internalStudy ? 0 : externalId,
                                ExternalSystem = internalStudy ? null :ExternalSystem.GetByID(1),
                                Uuid = uuid ?? Guid.NewGuid().ToString(),
                                TestStudy = environment.ToLowerInvariant() != "prod"
                            };
            study.Save();
            ScenarioContext.Current.Set(study.Uuid, internalStudy ? "internalStudyUuid" : "studyUuid");
            ScenarioContext.Current.Set(study, "study");
        }
    }
}
