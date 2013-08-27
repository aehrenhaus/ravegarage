using System;

namespace Medidata.RBT.Objects.Integration.Configuration.Models
{
    public class UserMessageModel
    {
        public string Email { get; set; }
        public string Login { get; set; }
        public Guid UUID { get; set; }
        public int ID { get; set; }
        public string FirstName { get; set; }
        public string MiddleName { get; set; }
        public string LastName { get; set; }
        public string Address1 { get; set; }
        public string Address2 { get; set; }
        public string Address3 { get; set; }
        public string City { get; set; }
        public string State { get; set; }
        public string PostalCode { get; set; }
        public string Country { get; set; }
        public string Telephone { get; set; }
        public string Mobile { get; set; }
        public string Pager { get; set; }
        public string Fax { get; set; }
        public string Locale { get; set; }
        public string TimeZone { get; set; }
        public string Title { get; set; }
        public string Department { get; set; }
        public string Institution { get; set; }
        public DateTime Timestamp { get; set; }
        public Guid MessageId { get; set; }
        public DateTime LastExternalUpdateDate { get; set; }
    }
}
