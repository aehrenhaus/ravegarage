using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Medidata.RBT.SeleniumExtension;
using TechTalk.SpecFlow;
using Medidata.RBT.PageObjects.Rave;

namespace Medidata.RBT.Features.Rave.Steps
{
    /// <summary>
    /// steps to perform cache flush
    /// </summary>
    [Binding]
    public class CacheFlushSteps : BrowserStepsBase
    {
        /// <summary>
        /// Use this step to perform cache flush when necessary
        /// Remember this will bring you to login page
        /// Additional steps should be added if support needed
        /// to login and navigate to specific page post cache flush
        /// </summary>
        [StepDefinition(@"I perform cache flush")]
        public void GivenIRunCacheFlush()
        {
            CacheFlushPage.PerformCacheFlush(WebTestContext);
        }

    }
}
