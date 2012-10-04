using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Medidata.RBT.PageObjects.Rave
{
    public class ArchitectObjectModel
    {
        public string Name { get; set; }
        public string From { get; set; }
        public string To { get; set; }
        public string OID { get; set; }
        public bool Active { get; set; }
        public string Format { get; set; }
    }
}
