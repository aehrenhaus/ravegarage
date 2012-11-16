using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Medidata.RBT.PageObjects.Rave.Configuration
{
    public class ConfigurationCreationModel
    {
        public string User { get; set; }
        public string Project { get; set; }
        public string Environment { get; set; }
        public string Role { get; set; }
        public string Site { get; set; }
        public string SecurityRole { get; set; }
        public string Form { get; set; }
        public string Field { get; set; }
        public string Draft { get; set; }
        public int LinesPerPage { get; set; }
    }
}
