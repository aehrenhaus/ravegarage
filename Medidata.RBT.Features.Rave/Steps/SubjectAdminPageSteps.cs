using TechTalk.SpecFlow;
using TechTalk.SpecFlow.Assist;
using Medidata.RBT.PageObjects.Rave;
using OpenQA.Selenium;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Medidata.RBT.PageObjects.Rave.TableModels;
using Medidata.RBT.SeleniumExtension;

namespace Medidata.RBT.Features.Rave
{
    /// <summary>
    /// The steps pertaining to the the subject page
    /// </summary>
    [Binding]
    public class SubjectAdminPageSteps : BrowserStepsBase
    {
        /// <summary>
        /// Verifies various controls are disabled
        /// </summary>
        /// <param name="table"></param>
        [StepDefinition(@"I verify Subject Administration controls are disabled")]
        public void ThenIVerifySubjectAdminControlsAreDisabled(Table table)
        {
            var models = table.CreateSet<ControlTypeModel>();
            IWebElement element;
            bool allDisabled = true;

            foreach (var model in models)
            {
                try
                {
                    element = CurrentPage.As<SubjectAdminPage>().GetElementByName(model.Name);
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
        [StepDefinition(@"I verify Subject Administration controls are enabled")]
        public void ThenIVerifySubjectAdminControlsAreEnabled(Table table)
        {
            var models = table.CreateSet<ControlTypeModel>();
            IWebElement element;
            bool allEnabled = true;

            foreach (var model in models)
            {
                try
                {
                    element = CurrentPage.As<SubjectAdminPage>().GetElementByName(model.Name);
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