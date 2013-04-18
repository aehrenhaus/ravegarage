using System;
using System.Configuration;
using Medidata.Data;
using Medidata.RBT.Objects.Integration.Configuration;
using Medidata.Rave.Integration.Interfaces;
using Medidata.Rave.Integration.Logging;
using Medidata.Rave.Integration.Objects.Brokers.Objects;
using Medidata.Rave.Integration.Service;
using Newtonsoft.Json;

namespace Medidata.RBT.Objects.Integration.Helpers
{
    public static class SQSHelper
    {
        public static string EDC_APP_NAME = "Rave_iMedidata_Edc_App";
        public static string MODULES_APP_NAME = "Rave_iMedidata_Modules_App";
        public static string SECURITY_APP_NAME = "Rave_iMedidata_Security_App";

        public static void UpdateQueueUuid(string queueName, Guid queueUuid)
        {
            Agent.ExecuteNonQuery(Agent.DefaultHint, "spRISS_UpdateIntegratedApplicationUUID", new object[]{ queueUuid, queueName});
        }

        public static void SendMessage(string message)
        {
            if (string.IsNullOrWhiteSpace(message))
            {
                return;
            }

            if (ConfigurationManager.AppSettings[AppSettingsTags.MessageDeliveryType]
                .Equals(MessageDeliveryTypes.SQS))
            {
                if (!string.IsNullOrWhiteSpace(message))
                    IntegrationTestContext.SqsWrapper.SendMessage(IntegrationTestContext.SqsQueueUrl, message);
            }
            else if (ConfigurationManager.AppSettings[AppSettingsTags.MessageDeliveryType]
                .Equals(MessageDeliveryTypes.Broker))
            {
                ILogWrapper logWrapper = new LogWrapper();
                var broker = new Broker(logWrapper);
                broker.Route(CreateSyncServiceMessage(message));
            }
        }

        private static ISyncServiceMessage CreateSyncServiceMessage(string message)
        {
            ISyncServiceMessage syncServiceMessage = JsonConvert.DeserializeObject<SyncServiceMessage>(message);
            syncServiceMessage.ExternalSystemId = 1;

            return syncServiceMessage;
        }
    }
}
