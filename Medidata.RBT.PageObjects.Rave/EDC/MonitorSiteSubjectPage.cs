using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Medidata.RBT.PageObjects.Rave.EDC
{
    public class MonitorSiteSubjectPage : SubjectPage
    {
        /// <summary>
        /// Generate a pdf report. Extract the downloaded pdf, and save its contents in ScenarioText to be used later.
        /// </summary>
        /// <returns></returns>
        public void GeneratePDFReport()
        {
            ClickLink("PDF Report");
            new PromptsPage().GenerateReport();
        }
    }
}
