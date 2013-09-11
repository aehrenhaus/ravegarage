using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Medidata.RBT.Objects.Integration.Configuration
{
    public struct MessageDeliveryTypes
    {
        public const string SQS = "SQS";
        public const string Broker = "Broker";
    }

    public struct AppSettingsTags
    {
        public const string MessageDeliveryTypeKey = "MessageDeliveryType";
        public const string AwsAccessKey = "AwsAccessKey";
        public const string AwsSecretKey = "AwsSecretKey";
        public const string AwsRegionKey = "AwsRegion";

        public const string ManageServiceKey = "ManageService";
        public const string ServiceNameKey = "ServiceName";
        public const string ServiceMachineNameKey = "ServiceMachineName";
    }
}
