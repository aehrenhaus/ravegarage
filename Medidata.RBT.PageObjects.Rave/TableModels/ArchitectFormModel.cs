using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Medidata.RBT.PageObjects.Rave
{
    /// <summary>
    /// Model to be used/extended for architect form entry
    /// </summary>
    public class ArchitectFormModel
    {
        public string FormName { get; set; }
        public string OID { get; set; }
        public bool? Active { get; set; }
    }
}
