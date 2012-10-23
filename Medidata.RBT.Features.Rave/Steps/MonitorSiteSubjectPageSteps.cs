using Medidata.RBT.PageObjects.Rave;
using TechTalk.SpecFlow;


namespace Medidata.RBT.Features.Rave
{
    [Binding]
    public class MonitorSiteSubjectPageSteps : BrowserStepsBase
    {
        [StepDefinition(@"I generate PDF for all visits")]
        public void IGeneratePDFForAllVisits()
        {
            CurrentPage.As<SubjectPage>().GeneratePDFReport();
        }
    }
}