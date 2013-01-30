using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Medidata.RBT.PageObjects.Rave
{
    public class PDFCreationModel
    {
        public string Name { get; set; }
        public string Profile { get; set; }
        public string Study { get; set; }
        public string Environment { get; set; }
        public string Role { get; set; }
        public string SiteGroup { get; set; }
        public string Site { get; set; }
        public string Subject { get; set; }
        public string Locale { get; set; }
        public string CRFVersion { get; set; }
        public string FormExclusions { get; set; }
    }
}
