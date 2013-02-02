using System;
using System.Linq;
using Medidata.AmazonSimpleServices;
using Medidata.Core.Objects;
using Medidata.RBT.Objects.Integration.Configuration.Models;
using Medidata.RBT.Objects.Integration.Configuration.Templates;
using Nustache.Core;
using TechTalk.SpecFlow;
using TechTalk.SpecFlow.Assist;

namespace Medidata.RBT.Objects.Integration.Helpers
{
    public static class StudyHelper
    {
        public static void StudyMessageHandler(Table table, SimpleQueueWrapper sqsWrapper, string url)
        {
            var messageConfigs = table.CreateSet<StudyMessageModel>().ToList();
            foreach (var config in messageConfigs)
            {
                var message = string.Empty;

                config.MessageId = Guid.NewGuid();

                switch (config.EventType.ToLowerInvariant())
                {
                    case "post":
                        config.UUID = Guid.NewGuid();
                        ScenarioContext.Current.Add("studyUuid", config.UUID.ToString());
                        Console.WriteLine("Study UUID: {0}", config.UUID);
                        message = Render.StringToString(StudyTemplates.STUDY_POST_TEMPLATE, new { config });
                        break;
                    case "put":
                        config.UUID = new Guid(ScenarioContext.Current.Get<String>("studyUuid"));
                        message = Render.StringToString(StudyTemplates.STUDY_PUT_TEMPLATE, new { config});
                        break;
                }

                if (!string.IsNullOrWhiteSpace(message))
                    sqsWrapper.SendMessage(url, message);
            }
        }

        public static void CreateRaveStudy(string name, string environment)
        {
            var project = new Project(SystemInteraction.Use()) { Name = name, IsActive = true, UUID = new Guid().ToString() };           
            project.Save();

            var study = new Study("env", false, project, SystemInteraction.Use());
            study.Save();
            ScenarioContext.Current.Add("studyObject", study);
        }
    }
}
