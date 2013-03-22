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
        /// We do not do generic cache flushes, because these can hang, causing timeout issues.
        /// This will navigate to the cache flush page.
        /// Type-specific cache flushes do not redirect to the login page, they stay on the cache flush page.
        /// Remember to navigate back to the correct page after using the cache flush.
        /// </summary>
        /// <param name="typeToFlush">The type of object to flush, must be fully quantified.</param>
        [StepDefinition(@"I perform cache flush of ""(.*)""")]
        public void GivenIPerformCacheFlushOf____(string typeToFlush)
        {
            CacheFlushPage.PerformCacheFlush(WebTestContext, typeToFlush);
        }
    }
}
