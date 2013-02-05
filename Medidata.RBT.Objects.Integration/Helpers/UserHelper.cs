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
    public static class UserHelper
    {
        public static void MessageHandler(Table table, SimpleQueueWrapper sqsWrapper, string url)
        {
            var messageConfigs = table.CreateSet<UserMessageModel>().ToList();
            foreach (var config in messageConfigs)
            {
                var message = string.Empty;

                config.MessageId = Guid.NewGuid();
                config.UUID = new Guid(ScenarioContext.Current.Get<string>("externalUserUUID"));

                message = Render.StringToString(UserTemplates.USER_PUT_TEMPLATE, new {config});

                if (!string.IsNullOrWhiteSpace(message))
                    sqsWrapper.SendMessage(url, message);
            }
        }

        public static void CreateRaveUser(string login)
        {
            var externalUser = new ExternalUser
                {
                    ExternalSystemID = 1, 
                    UUID = Guid.NewGuid().ToString(), 
                    ExternalID = 12854934
                };

            externalUser.Save();

            ScenarioContext.Current.Add("externalUserUUID", externalUser.UUID);
            ScenarioContext.Current.Add("externalUserID", externalUser.ID);

            var user = new User();

            var dt = new DateTime(2013, 12, 12);
            user.FirstName = "x";
            user.LastName = "x";
            user.Login = login;
            user.PIN = "12346";
            user.PasswordExpires = dt;
            user.Enabled = true;
            user.TrainingSigned = true;
            user.IsInvestigator = false;
            user.SponsorApproval = true;
            user.AccountActivation = true;
            user.LockedOut = false;
            user.Active = true;
            user.Guid = Guid.NewGuid().ToString();
            user.IsTrainingOnly = false;
            user.IsClinicalUser = false;
            user.ExternalID = externalUser.ExternalID;
            user.ExternalSystem = ExternalSystem.GetByID(1);
            user.Trained = dt;

            user.ExternalUser = externalUser;

            user.Save();
            ScenarioContext.Current.Add("userObject", user);
        }
    }
}
