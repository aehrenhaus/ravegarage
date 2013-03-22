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
    public static class UserHelper
    {
        public static void MessageHandler(Table table)
        {
            var messageConfigs = table.CreateSet<UserMessageModel>().ToList();
            foreach (var config in messageConfigs)
            {
                var message = string.Empty;

                config.MessageId = Guid.NewGuid();
                config.UUID = new Guid(ScenarioContext.Current.Get<string>("externalUserUUID"));

                message = Render.StringToString(UserTemplates.USER_PUT_TEMPLATE, new {config});

                SQSHelper.SendMessage(message);
            }
        }

        public static void CreateRaveUser(string login, Role edcRole = null)
        {
            ExternalUser externalUser;
            if (ScenarioContext.Current.ContainsKey("externalUserUUID"))
            {
                externalUser = ExternalUser.GetByExternalUUID(ScenarioContext.Current.Get<string>("externalUserUUID"), 1);
            }
            else
            {
                externalUser = new ExternalUser
                                   {
                                       Login = login,
                                       ExternalSystemID = 1,
                                       UUID = Guid.NewGuid().ToString(),
                                       ExternalID = 12854934
                                   };

                externalUser.Save();

                ScenarioContext.Current.Add("externalUserUUID", externalUser.UUID);
                ScenarioContext.Current.Add("externalUserID", externalUser.ID);
            }

            var user = new User();

            var dt = new DateTime(2013, 12, 12);
            user.FirstName = "x";
            user.LastName = "x";
            user.Login = User.GetNextLogin(externalUser.Login);
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
            user.InitialSiteGroup = new SiteGroup(SiteGroup.WorldSiteGroupId, SystemInteraction.Use());
            user.ExternalID = externalUser.ExternalID;
            user.ExternalSystem = ExternalSystem.GetByID(1);
            user.Trained = dt;
            user.EdcRole = edcRole;

            user.ExternalUser = externalUser;

            user.Save();
			ScenarioContext.Current.Set(user, "user");
        }
    }
}
