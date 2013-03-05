using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Medidata.RBT.PageObjects.Rave.TableModels.PDF
{
    public class PDFCreationModel
    {
        public string Name { get; set; }
        public string Profile { get; set; }
        public string Study { get; set; }
        public string Environment { get; set; }
        public string Role { get; set; }
        public string SiteGroups { get; set; }
        public string Sites { get; set; }
        public string Subjects { get; set; }
        public string Locale { get; set; }
        public string CRFVersion { get; set; }
        public string FormExclusions { get; set; }
        public string FolderExclusions { get; set; }
    }
}
