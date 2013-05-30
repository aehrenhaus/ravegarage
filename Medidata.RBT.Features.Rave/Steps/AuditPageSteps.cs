using TechTalk.SpecFlow;
using Medidata.RBT.PageObjects.Rave;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using TechTalk.SpecFlow.Assist;
using Medidata.RBT.PageObjects.Rave.TableModels;
using OpenQA.Selenium;

namespace Medidata.RBT.Features.Rave
{
    /// <summary>
    /// Steps pertaining to User Administration
    /// </summary>
	[Binding]
	public class AuditPageSteps : BrowserStepsBase
    {
        /// <summary>
        /// Verifies various controls are disabled
        /// </summary>
        /// <param name="table"></param>
        [StepDefinition(@"I verify Audit controls are disabled")]
        public void ThenIVerifyAuditControlsAreDisabled(Table table)
        {
            var models = table.CreateSet<ControlTypeModel>();
            IWebElement element;
            bool allDisabled = true;

            foreach (var model in models)
            {
                try
                {
                    element = CurrentPage.As<AuditsPage>().GetElementByName(model.Name);
                }
                catch // exception in this case means element is not found, so that's "good"
                {
                    continue;
                }
                if (element != null && element.Enabled) // if it's null, still "good"
                {
                    allDisabled = false;  // we found an enabled control, so we are done, failing method
                    break;
                }
            }
            Assert.IsTrue(allDisabled);
        }

        /// <summary>
        /// Verifies various controls are enabled
        /// </summary>
        /// <param name="table"></param>
        [StepDefinition(@"I verify Audit controls are enabled")]
        public void ThenIVerifyAuditControlsAreEnabled(Table table)
        {
            var models = table.CreateSet<ControlTypeModel>();
            IWebElement element;
            bool allEnabled = true;

            foreach (var model in models)
            {
                try
                {
                    element = CurrentPage.As<AuditsPage>().GetElementByName(model.Name);
                }
                catch // exception means control not found
                {
                    allEnabled = false;
                    break;
                }
                if (element != null && !element.Enabled) // null means control not found
                {
                    allEnabled = false;
                    break;
                }
            }
            Assert.IsTrue(allEnabled);
        }
	}
}
