using TechTalk.SpecFlow;
using TechTalk.SpecFlow.Assist;
using Medidata.RBT.PageObjects.Rave;
using OpenQA.Selenium;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Medidata.RBT.PageObjects.Rave.TableModels;

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

            IWebElement element = CurrentPage.As<SubjectPage>().CanSeeControl("_ctl0_Content_SubjectAddEvent_DisableMatrixIcon");
            if (element != null)
            {
                result = true;
                element.Click();
            }
            Assert.IsTrue(result);
        }

        [StepDefinition(@"I can see Add Event lock icon")]
        public void ICanSeeAddEventLockIcon()
        {
            bool result = false;
            IWebElement element = CurrentPage.As<SubjectPage>().CanSeeControl("_ctl0_Content_SubjectAddEvent_DisableMatrixIcon");
            if (element != null)
                result = true;
            Assert.IsTrue(result);
        }

        [StepDefinition(@"I can see ""([^""]*)"" button")]
        public void ICanSee____Button(string btnValue)
        {
            bool canSee = CurrentPage.As<ICanVerifyExist>()
                .VerifyControlExist(btnValue);

            Assert.IsTrue(canSee);
        }

        [StepDefinition(@"I can not see ""([^""]*)"" button")]
        public void ICanNotSee____Button(string btnValue)
        {
            bool canSee = CurrentPage.As<ICanVerifyExist>()
                .VerifyControlExist(btnValue);

            Assert.IsFalse(canSee);
        }

        [StepDefinition(@"I can see ""([^""]*)"" dropdown labeled ""([^""]*)""")]
        public void ICanSee____DropdownLabeled____(string enabled, string label)
        {
            bool isDisabled = false;
            if (enabled.ToLower() == "disabled")
                isDisabled = true;

            bool result = false;
            IWebElement element = CurrentPage.As<SubjectPage>().CanSeeControl(label);

            if (element != null && element.GetAttribute("disabled").ToLower() == isDisabled.ToString().ToLower())
                result = true;

            Assert.IsTrue(result);

        }

        [StepDefinition(@"I can see tooltip ""([^""]*)"" on button labeled ""([^""]*)""")]
        public void ICanSeeToolTip____On____WithID____(string toolTip, string label)
        {
            bool result = false;
            IWebElement element = CurrentPage.As<SubjectPage>().CanSeeControl(label);

            if (element != null && element.GetAttribute("title").Equals(toolTip))
                result = true;

            Assert.IsTrue(result);
        }

        [StepDefinition(@"The ""([^""]*)"" button is available")]
        public void The____ButtonIsAvailable(string value)
        {
            bool result = false;
            IWebElement element = CurrentPage.As<SubjectPage>().CanSeeControl(value);

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

        [StepDefinition(@"I click radiobutton with label ""([^""]*)""")]
        public void IClickRadiobuttonWithLabel____(string label)
        {
            bool result = false;
            IWebElement element = CurrentPage.As<SubjectPage>().CanSeeControl(label);

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

                Assert.AreEqual(model.Pages, item.Pages);
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