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
            var messageConfigs = table.CustomCreateSet<StudyMessageModel>().ToList();

            var messagesToSend = messageConfigs.Select(config =>
                {
                    string message = null;

                    config.MessageId = Guid.NewGuid();

                    //make sure the study name is correct.
                    AddEnvironmentToNameIfNeeded(config);

                    switch (config.EventType.ToLowerInvariant())
                    {
                        case "post":
                            //if no uuid was provided, set the value to a new guid
                            if(config.UUID == Guid.Empty) config.UUID = Guid.NewGuid();
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
                }).ToList();

            SQSHelper.SendMessages(messagesToSend);
        }

        /// <summary>
        /// For non-prod environments, the Study name must end with "(Environment Name)". 
        /// Ensure that the Name property of the provided <see cref="StudyMessageModel"/> 
        /// follows that rule. If StudyMessageModel instance does not have it's Environment
        /// property set, we assume that the environment is in the name already.
        /// </summary>
        /// <param name="config"></param>
        private static void AddEnvironmentToNameIfNeeded(StudyMessageModel config)
        {
            //If we don't have IsProd set, there's no way for us to be sure
            //what to do. So, do nothing.
            if (string.IsNullOrEmpty(config.IsProd))
                return;

            //convert the IsProd property to an actual boolean
            var isProd = bool.Parse(config.IsProd);

            //if the environment is prod, do nothing
            if (isProd)
            {
                return;
            }

            var environment = config.Environment;

            //if the environment isn't set, we can't do anything
            if (string.IsNullOrEmpty(environment))
            {
                return;
            }

            //calculate the expected suffix
            var environmentSuffix = string.Format("({0})", environment);

            //if the name already ends with the suffix, do nothing
            if (config.Name.EndsWith(environmentSuffix))
            {
                return;                
            }

            //if we got here, we need to add the environment suffix to the name
            config.Name += " " + environmentSuffix;
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
