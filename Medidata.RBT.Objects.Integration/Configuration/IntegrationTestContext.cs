using Medidata.AmazonSimpleServices;

namespace Medidata.RBT.Objects.Integration.Configuration
{
    public static class IntegrationTestContext
    {
        public static SimpleQueueWrapper SqsWrapper { get; set; }
        public static string SqsQueueUrl { get; set; }
        public static bool TestFailed { get; set; }
    }
}
