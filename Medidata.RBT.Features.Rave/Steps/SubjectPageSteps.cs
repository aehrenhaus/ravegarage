using TechTalk.SpecFlow;
using TechTalk.SpecFlow.Assist;
using Medidata.RBT.PageObjects.Rave;
using OpenQA.Selenium;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Medidata.RBT.PageObjects.Rave.TableModels;
using Medidata.RBT.SeleniumExtension;

namespace Medidata.RBT.Features.Rave
{
    [Binding]
    public class
        SubjectPageSteps : BrowserStepsBase
    {

        /// <summary>
        /// Step def to click on add icon which will bring user to subject level audit page
        /// </summary>
        [StepDefinition(@"I click Add Event lock icon")]
        public void IClickAddEventLockIcon()
        {
            bool result = false;

            IWebElement element = Browser.FindElementById("_ctl0_Content_SubjectAddEvent_DisableMatrixHyperlink");
            if (element != null)
            {
                result = true;
                element.Click();
            }
            Assert.IsTrue(result);
        }

        /// <summary>
        /// Method to check if ADD event lock icon is displayed on subject page
        /// </summary>
        [StepDefinition(@"I can see Add Event lock icon")]
        public void ICanSeeAddEventLockIcon()
        {
            Assert.IsNotNull(Browser.TryFindElementById("_ctl0_Content_SubjectAddEvent_DisableMatrixImage"));
        }

        /// <summary>
        /// Method to check if ADD event lock icon is not displayed on subject page
        /// </summary>
        [StepDefinition(@"I can not see Add Event lock icon")]
        public void ICanNotSeeAddEventLockIcon()
        {
            Assert.IsNull(Browser.TryFindElementById("_ctl0_Content_SubjectAddEvent_DisableMatrixImage"));
        }

        [StepDefinition(@"I can see ""([^""]*)"" button")]
        [StepDefinition(@"I can see ""([^""]*)"" radio button")]
        public void ICanSee____Button(string btnValue)
        {
            bool canSee = CurrentPage.As<IVerifySomethingExists>()
                .VerifySomethingExist(null,"control",btnValue);

            Assert.IsTrue(canSee);
        }

        [StepDefinition(@"I can not see ""([^""]*)"" button")]
        [StepDefinition(@"I can not see ""([^""]*)"" radio button")]
        public void ICanNotSee____Button(string btnValue)
        {
			bool canSee = CurrentPage.As<IVerifySomethingExists>()
				 .VerifySomethingExist(null, "control", btnValue);

            Assert.IsFalse(canSee);
        }

        [StepDefinition(@"I can see ""([^""]*)"" dropdown labeled ""([^""]*)""")]
        public void ICanSee____DropdownLabeled____(string enabled, string label)
        {
            bool isDisabled = false;
            if (enabled.ToLower() == "disabled")
                isDisabled = true;

            IWebElement element = CurrentPage.As<SubjectPage>().GetElementByName(label);
            Assert.IsTrue(isDisabled == !element.Enabled);
        }

        [StepDefinition(@"I can not see dropdown labeled ""([^""]*)""")]
        public void ICanNotSeeDropdownLabeled____(string label)
        {
            bool result = false;
            IWebElement element = CurrentPage.As<SubjectPage>().GetElementByName(label);

            if (element == null)
                result = true;

            Assert.IsTrue(result);
        }

        [StepDefinition(@"I can see tooltip ""([^""]*)"" on button labeled ""([^""]*)""")]
        public void ICanSeeToolTip____On____WithID____(string toolTip, string label)
        {
            bool result = false;
            IWebElement element = CurrentPage.As<SubjectPage>().GetElementByName(label);

            if (element != null && element.GetAttribute("title").Equals(toolTip))
                result = true;

            Assert.IsTrue(result);
        }

        [StepDefinition(@"The ""([^""]*)"" button is available")]
        public void The____ButtonIsAvailable(string value)
        {
            bool result = false;
            IWebElement element = CurrentPage.As<SubjectPage>().GetElementByName(value);

            if (element != null)
            {
                result = true;
                if (element.GetAttribute("value").ToLower() != value.ToLower())
                    element.Click(); // e.g. click "Enable" button to turn to "Disable"
            }

            Assert.IsTrue(result);
        }

        /// <summary>
        /// Submit a form
        /// </summary>
        /// <param name="formName">The form to submit</param>
        [StepDefinition(@"I submit the form ""([^""]*)""")]
        public void ISubmitTheForm____(string formName)
        {
            CurrentPage.As<SubjectPage>().SelectForm(formName);
            CurrentPage.As<CRFPage>().SaveForm();
        }

        [StepDefinition(@"I can see link ""([^""]*)""")]
        [StepDefinition(@"I can see the label ""([^""]*)""")]
        public void ICanSeeLink(string label)
        {
			bool result = CurrentPage.As<IVerifySomethingExists>().VerifySomethingExist(null,null,label);

            Assert.IsTrue(result);
        }

        [StepDefinition(@"I can not see link ""([^""]*)""")]
        public void ICanNotSeeLink(string label)
        {
			bool result = CurrentPage.As<IVerifySomethingExists>().VerifySomethingExist(null, null, label);

            Assert.IsFalse(result);
        }

        [StepDefinition(@"I click radiobutton with label ""([^""]*)""")]
        public void IClickRadiobuttonWithLabel____(string label)
        {
            bool result = false;
            IWebElement element = CurrentPage.As<SubjectPage>().GetElementByName(label);

            if (element != null)
            {
                element.Click();
                result = true;
            }

            Assert.IsTrue(result);
        }

        [StepDefinition(@"I verify the task summary")]
        public void IVerifyTheTaskSummary(Table table)
        {
            var models = table.CreateSet<TaskSummaryItemModel>();
            var taskSummary = CurrentPage.As<ITaskSummaryContainer>()
                .GetTaskSummary();
            
            foreach (var model in models)
            {
                TaskSummaryItem item = taskSummary.GetTaskSummaryItem(model.Task);

                Assert.IsNotNull(item,
                    string.Format("Task Summary does not contain Task Item \"{0}\"", model.Task));
                Assert.AreEqual(model.PageCount, item.PageCount);
            }
        }

        [Given(@"I expand Task Summary")]
        public void GivenIExpandTaskSummary()
        {
            CurrentPage.As<ITaskSummaryContainer>()
                .GetTaskSummary()
                .Expand();
        }


    }
}