using TechTalk.SpecFlow;
using Medidata.RBT.PageObjects.Rave.EDC;

namespace Medidata.RBT.Features.Rave
{
    [Binding]
    public class MonitorSiteSubjectPageSteps : BrowserStepsBase
    {
        [StepDefinition(@"I generate PDF for all visits")]
        public void IGeneratePDFForAllVisits()
        {
            CurrentPage.As<MonitorSiteSubjectPage>().GeneratePDFReport();
        }
    }
}