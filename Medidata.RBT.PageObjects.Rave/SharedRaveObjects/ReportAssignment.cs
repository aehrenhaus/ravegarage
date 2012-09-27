using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Medidata.RBT.PageObjects.Rave.SharedRaveObjects
{
    public class ReportAssignment
    {

        public string ReportName { get; set; }
        public Guid UserID { get; set; }


        public ReportAssignment(string reportName)
        {
            this.ReportName = reportName;
        }
    }
}
