using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Medidata.RBT.Objects.Integration.Configuration.Models
{
    public class SiteModel
    {
        public string Uuid { get; set; }

        public string Name { get; set;}

        public string Number { get; set; }

        public string AddressLine1 { get; set; }

        public string City { get; set; }

        public string State { get; set; }

        public string PostalCode { get; set; }

        public string Country { get; set; }

        public string Telephone { get; set; }
    }
}
