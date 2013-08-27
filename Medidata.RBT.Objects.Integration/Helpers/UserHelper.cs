using System;
using System.Collections.Generic;
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
            ScenarioContext.Current.Set(messageConfigs.Count, "messageCount");

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
            }

            ScenarioContext.Current.Set(externalUser.UUID, "externalUserUUID");
            ScenarioContext.Current.Set(externalUser.ID, "externalUserID");

            var user = CreateInternalRaveUser(externalUser.Login, edcRole);
            user.ExternalID = externalUser.ExternalID;
            user.ExternalSystem = ExternalSystem.GetByID(1);
            user.ExternalUser = externalUser;

            user.Save();
			ScenarioContext.Current.Set(user, "user");
        }

        public static User CreateInternalRaveUser(string login, Role edcRole = null)
        {
            var user = new User();
            var dt = new DateTime(2013, 12, 12);
            user.FirstName = "x";
            user.LastName = "x";           
            user.PIN = "12346";
            user.Login = login;
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
            user.Trained = dt;
            user.NetworkMask = string.Empty;
            user.EdcRole = edcRole;

            user.Save();
            ScenarioContext.Current.Set(user, "user");
            
            return user;
        }

        public static void LinkAccount(ExternalUser externalUser, User raveUser)
        {
            externalUser.ConnectedRaveUserID = raveUser.ID;
            externalUser.Save();
            
            raveUser.ExternalSystem = ExternalSystem.GetByID(externalUser.ExternalSystemID);
            raveUser.ExternalID = externalUser.ExternalID;
            raveUser.ExternalUser = externalUser;
            raveUser.ExternalUserName = externalUser.Login;
            raveUser.ExternalUrl = Core.Objects.Configuration.ConfigItem(ConfigTags.iMedidataBaseUrl).ToString();
            raveUser.LastExternalUpdateDate = externalUser.LastExternalUpdateDate;
            raveUser.UserGroupID = externalUser.UserGroupID;

            var users = Users.FindByExternalUserID(externalUser.ID, SystemInteraction.Use());
            
            raveUser.Active = false; // inactivate the connected user by default.
            raveUser.Save();

            foreach (var user in users)
            {
                Core.Objects.Reporting.Reports.PersistReportAssignments(externalUser.ConnectedRaveUserID,
                                                                                    user.ID, SystemInteraction.Use());
                Core.Objects.Security.SecurityUserObjectRole.PersistSecurityUserObjectRole(
                    externalUser.ConnectedRaveUserID, user.ID, SystemInteraction.Use());
                Core.Objects.eLearning.CourseUserCourseHybrid.PersistUserCourseAssignments(
                    externalUser.ConnectedRaveUserID, user.ID, SystemInteraction.Use());
                CopyRaveOnlyProfileOptions(raveUser, user);

                user.Save();
            }

            //Update Security Group, No need for User Group and Non EDC Role (UserOBjectRole).
            ExternalUserSecurityGroup.SyncExternalUserSecurityGroup(externalUser.ID);
        }


        public static void CopyRaveOnlyProfileOptions(User userSource, User userTarget)
        {
            userTarget.Credentials = userSource.Credentials;
            userTarget.SponsorApproval = userSource.SponsorApproval;
            userTarget.AccountActivation = userSource.AccountActivation;
            userTarget.IsTrainingOnly = userSource.IsTrainingOnly;
            userTarget.IsClinicalUser = userSource.IsClinicalUser;
            userTarget.IsInvestigator = userSource.IsInvestigator;
            userTarget.InvestigatorNumber = userSource.InvestigatorNumber;
            userTarget.DEANumber = userSource.DEANumber;
            userTarget.NetworkMask = userSource.NetworkMask;
            userTarget.Trained = DateTime.UtcNow;
            userTarget.TrainingSigned = true;
            userTarget.InitialSiteGroup = userSource.InitialSiteGroup;
        }
    }
}
