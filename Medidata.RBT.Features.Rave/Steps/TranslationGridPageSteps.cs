using Medidata.RBT.PageObjects.Rave.Translation_Workbench;
using TechTalk.SpecFlow;

namespace Medidata.RBT.Features.Rave.Steps
{
    /// <summary>
    /// Steps pertaining to Translation Grid
    /// </summary>
    [Binding]
    public class TranslationGridPageSteps : BrowserStepsBase
    {
        /// <summary>
        /// Click the # of Uses link at a given row
        /// </summary>
        /// <param name="position">The row number</param>
        [StepDefinition(@"I select the \# of Uses link in row (.*)")]
        public void SelectTheUsesLinkInRow(int position)
        {
            CurrentPage = CurrentPage.As<TranslationGridPage>().SelectTheUsesLinkInRow(position);
        }
    }
}
