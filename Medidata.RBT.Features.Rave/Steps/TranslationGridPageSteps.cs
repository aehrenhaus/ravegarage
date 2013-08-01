using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
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
        /// Click the first available # of Uses link
        /// </summary>
        [StepDefinition(@"I select the first \# of Uses link")]
        public void ISelectTheFirstOfUsesLink()
        {
            CurrentPage = CurrentPage.As<TranslationGridPage>().SelectTheFirstOfUsesLink();
        }

    }
}
