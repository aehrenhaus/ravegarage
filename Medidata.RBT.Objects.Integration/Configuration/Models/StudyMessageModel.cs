using System;

namespace Medidata.RBT.Objects.Integration.Configuration.Models
{
    public class StudyMessageModel
    {
        public string EventType { get; set; }
        public string Name { get; set; }
        public string IsProd { get; set; }
        public string Description { get; set; }
        public int ID { get; set; }
        public Guid UUID { get; set; }
        public DateTime Timestamp { get; set; }
        public Guid MessageId { get; set; }
    }
}
