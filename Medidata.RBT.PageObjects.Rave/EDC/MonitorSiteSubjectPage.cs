using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Medidata.RBT.PageObjects.Rave.EDC
{
    public class MonitorSiteSubjectPage : SubjectPage
    {
        public void GeneratePDFReport()
        {
            ClickLink("PDF Report");
            new PromptsPage().GenerateReport();
        }
    }
}
