using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Threading;
using Medidata.Data;
using Medidata.RBT.Objects.Integration.Configuration;
using Medidata.Rave.Integration.Interfaces;
using Medidata.Rave.Integration.Logging;
using Medidata.Rave.Integration.Objects.Brokers.Objects;
using Medidata.Rave.Integration.Service;
using Newtonsoft.Json;
using Medidata.Interfaces.Logging;
using TechTalk.SpecFlow;

namespace Medidata.RBT.Objects.Integration.Helpers
{
    public static class SQSHelper
    {
        public static string EDC_APP_NAME = "Rave_iMedidata_Edc_App";
        public static string MODULES_APP_NAME = "Rave_iMedidata_Modules_App";
        public static string SECURITY_APP_NAME = "Rave_iMedidata_Security_App";

        public static void UpdateQueueUuid(string queueName, Guid queueUuid)
        {
            try
            {
                Agent.ExecuteNonQuery(Agent.DefaultHint, "spRISS_UpdateIntegratedApplicationUUID",
                                      new object[] {queueUuid, queueName});
            }
            catch (System.Data.DataException dex)
            {
                throw new Exception("Database error while trying to update queue uuid.", dex);
            }
        }

        /// <summary>
        /// Sends provided messages using Amazon SQS and waits for all messages to be received.
        /// </summary>
        /// <param name="messages"></param>
        public static void SendMessages(IEnumerable<string> messages)
        {
            var messagesToProcess = messages.Where(m => !string.IsNullOrEmpty(m)).ToList();

            if (!messagesToProcess.Any())
            {
                return;
            }

            //the action used to deliver messages
            Action<string> messageSender = null;
            //the action used to wait for messages to be received
            Action<int> messageReceptionWatcher = null;

            if (ConfigurationManager.AppSettings[AppSettingsTags.MessageDeliveryTypeKey]
                .Equals(MessageDeliveryTypes.SQS))
            {
                //send using SQS
                messageSender = (m) => 
                    IntegrationTestContext.SqsWrapper.SendMessage(IntegrationTestContext.SqsQueueUrl, m);

                //wait for queue to clear
                messageReceptionWatcher = (i) => SQSHelper.WaitForQueueToClear(messagesToProcess.Count);

            }
            else if (ConfigurationManager.AppSettings[AppSettingsTags.MessageDeliveryTypeKey]
                .Equals(MessageDeliveryTypes.Broker))
            {
                //create out broker instance
                ILogWrapper logWrapper = new LogWrapper();
                var broker = new Broker(logWrapper);

                //send using use the broker
                messageSender = (m) => broker.Route(CreateSyncServiceMessage(m));

                //nop for waiting, since we aren't using the queue
                messageReceptionWatcher = (i) => { };
            }
            else
            {
                var unknownMessageDeliveryTypeMessage = string.Format("Invalid {0} value {1}.", 
                    AppSettingsTags.MessageDeliveryTypeKey, 
                    ConfigurationManager.AppSettings[AppSettingsTags.MessageDeliveryTypeKey]);

                throw new ConfigurationErrorsException(unknownMessageDeliveryTypeMessage);
            }

            //neither of these should be null, because an exception would have been thrown
            //for an unsupported delivery type.
            messagesToProcess.ForEach(message => messageSender(message));
            messageReceptionWatcher(messagesToProcess.Count);
        }

        public static void WaitForQueueToClear(int numberOfMessagesSent)
        {
            var numVisibleMessages = IntegrationTestContext.SqsWrapper.GetApproxNumberOfMessages(IntegrationTestContext.SqsQueueUrl, true);
            var numInvisibleMessages = IntegrationTestContext.SqsWrapper.GetApproxNumberOfMessages(IntegrationTestContext.SqsQueueUrl, false);

            var threadSleepOffset = 5000 * numberOfMessagesSent;
            Thread.Sleep(15000 + threadSleepOffset);
            var endTime = DateTime.Now.AddSeconds(100);

            while (numVisibleMessages > 0 || numInvisibleMessages > 0)
            {
                if (DateTime.Now.Ticks > endTime.Ticks) throw new TimeoutException("Message was not processed");

                numVisibleMessages = IntegrationTestContext.SqsWrapper.GetApproxNumberOfMessages(IntegrationTestContext.SqsQueueUrl, true);
                numInvisibleMessages = IntegrationTestContext.SqsWrapper.GetApproxNumberOfMessages(IntegrationTestContext.SqsQueueUrl, false);
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
