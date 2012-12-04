using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Medidata.RBT.PageObjects.Rave.SharedRaveObjects
{
    /// <summary>
    /// The report matrix assigned against the project
    /// </summary>
    public class MatrixAssignment
    {
        public string Study { get; set; }
        public string Site { get; set; }
        public string Subject { get; set; }
        public string Report { get; set; }
    }
}
