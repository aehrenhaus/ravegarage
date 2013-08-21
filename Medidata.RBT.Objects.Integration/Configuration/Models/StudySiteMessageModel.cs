using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Medidata.RBT.Objects.Integration.Configuration.Models
{
    public class StudySiteMessageModel
    {
        public string EventType { get; set; }
        public string StudySiteName { get; set; }
        public string StudySiteNumber { get; set; }
        public int ExternalStudyId { get; set; }
        public DateTime LastExternalUpdateDate { get; set; }
        public string Source { get; set; }
        public string Active { get; set; }
        public string SiteName { get; set; }
        public string SiteNumber { get; set; }
        public int StudySiteId { get; set; }
        public int StudyId { get; set; }
        public int SiteId { get; set; }
        public Guid StudySiteUuid { get; set; }
        public Guid StudyUuid { get; set; }
        public Guid SiteUuid { get; set; }
        public DateTime Timestamp { get; set; }
        public Guid MessageId { get; set; }
        public int ExternalID { get; set; }
    }
}
