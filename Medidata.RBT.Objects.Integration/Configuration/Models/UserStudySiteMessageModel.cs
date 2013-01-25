using System;

namespace Medidata.RBT.Objects.Integration.Configuration.Models
{
    public class UserStudySiteMessageModel
    {
        public string EventType { get; set; }
        public Guid UUID { get; set; }
        public DateTime UpdatedAt { get; set; }
        public int UserID { get; set; }
        public Guid UserUUID { get; set; }
        public int StudySiteID { get; set; }
        public Guid StudyUUID { get; set; }
        public Guid SiteUUID { get; set; }
        public Guid StudySiteUUID { get; set; }
        public DateTime Timestamp { get; set; }
        public Guid MessageId { get; set; }

    }
}
