using System;
using Medidata.Data;
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
    }
}
