using Medidata.RBT.PageObjects.Rave;
using TechTalk.SpecFlow;


namespace Medidata.RBT.Features.Rave
{
    /// <summary>
    /// Steps pertaining to Monitor Site Subject Page
    /// </summary>
    [Binding]
    public class MonitorSiteSubjectPageSteps : BrowserStepsBase
    {
        /// <summary>
        /// Generate a PDF for all visits
        /// </summary>
        [StepDefinition(@"I generate PDF for all visits")]
        public void IGeneratePDFForAllVisits()
        {
            CurrentPage.As<SubjectPage>().GeneratePDFReport();
        }
    }
}