using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Medidata.RBT.Objects.Integration.Configuration.Models
{
    public class SiteMessageModel
    {
        public string EventType { get; set; }
        public DateTime Timestamp { get; set; }
        public Guid MessageId { get; set; }

        public int Id { get; set; }
        public string Name { get; set; }
        public string Number { get; set; }
        public Guid Uuid { get; set; }
        public int ExternalID { get; set; }
        public string Source { get; set; }
        public DateTime LastExternalUpdateDate { get; set; }

        public string City { get; set; }
        public string Country { get; set; }
        public string State { get; set; }
        public string PostalCode { get; set; }
        public string Address1 { get; set; }
        public string Address2 { get; set; }
        public string Address3 { get; set; }
        public string Telephone { get; set; }
        public string Fax { get; set; }
        public DateTime UpdatedAt { get; set; }     
    }
}
