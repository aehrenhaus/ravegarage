﻿using TechTalk.SpecFlow;
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
    public class SubjectPageSteps : BrowserStepsBase
    {
        /// <summary>
        /// Method to check if ADD event lock icon is or is not displayed on subject page
        /// </summary>
        /// <param name="not">not is used when the button should not be seen</param>
        [StepDefinition(@"I can (not )?see Add Event lock icon")]
        public void ICanSeeAddEventLockIcon(string not)
        {
            if(not.ToLower().Equals("not "))
                Assert.IsNull(Browser.TryFindElementById("_ctl0_Content_SubjectAddEvent_DisableMatrixImage"));
            else
                Assert.IsNotNull(Browser.TryFindElementById("_ctl0_Content_SubjectAddEvent_DisableMatrixImage"));
        }

        /// <summary>
        /// Verify that the specified button is visible
        /// </summary>
        /// <param name="not">not is used when the button should not be seen</param>
        /// <param name="btnValue">The value of the button (the text within it)</param>
        [StepDefinition(@"I can (not )?see ""([^""]*)"" button")]
        [StepDefinition(@"I can (not )?see ""([^""]*)"" radio button")]
        public void ICanSee____Button(string not, string btnValue)
        {
            bool canSee = CurrentPage.As<IVerifySomethingExists>()
                .VerifySomethingExist(null, "control", btnValue, true);

            if (not.ToLower().Equals("not "))
                Assert.IsFalse(canSee);
            else
                Assert.IsTrue(canSee);
        }

        /// <summary>
        /// Verify that the dropdown is visible and enabled/disabled according to the passed in paramter
        /// </summary>
        /// <param name="enabled">Whether or not the dropdown is enabled</param>
        /// <param name="label">The label of the dropdown</param>
        [StepDefinition(@"I can see ""([^""]*)"" dropdown labeled ""([^""]*)""")]
        public void ICanSee____DropdownLabeled____(string enabled, string label)
        {
            bool isDisabled = false;
            if (enabled.ToLower() == "disabled")
                isDisabled = true;

            IWebElement element = CurrentPage.As<SubjectPage>().GetElementByName(label);
            Assert.IsTrue(isDisabled == !element.Enabled);
        }

        /// <summary>
        /// Verify that the dropdown is not visible
        /// </summary>
        /// <param name="label">The label of the dropdown</param>
        [StepDefinition(@"I can not see dropdown labeled ""([^""]*)""")]
        public void ICanNotSeeDropdownLabeled____(string label)
        {
            bool result = false;
            IWebElement element = CurrentPage.As<SubjectPage>().GetElementByName(label);

            if (element == null)
                result = true;

            Assert.IsTrue(result);
        }

        /// <summary>
        /// Verify that the tooltip is visible on a button
        /// </summary>
        /// <param name="toolTip">The tooltip to verify</param>
        /// <param name="label">The value of the button (I.E. the text within the button)</param>
        [StepDefinition(@"I can see tooltip ""([^""]*)"" on button labeled ""([^""]*)""")]
        public void ICanSeeToolTip____On____WithID____(string toolTip, string label)
        {
            bool result = false;
            IWebElement element = CurrentPage.As<SubjectPage>().GetElementByName(label);

            if (element != null && element.GetAttribute("title").Equals(toolTip))
                result = true;

            Assert.IsTrue(result);
        }

        /// <summary>
        /// The specified button is available
        /// </summary>
        /// <param name="value">The value of the button</param>
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

        /// <summary>
        /// Verify link or label is or is not visible
        /// </summary>
        /// <param name="not">not is used when the link or label should not be seen</param>
        /// <param name="label">The text of the link or label</param>
        [StepDefinition(@"I can (not )?see link ""([^""]*)""")]
        [StepDefinition(@"I can (not )?see the label ""([^""]*)""")]
        public void ICanSeeLink(string not, string label)
        {
			bool result = CurrentPage.As<IVerifySomethingExists>().VerifySomethingExist(null,null,label);

            if (not.ToLower().Equals("not "))
                Assert.IsFalse(result);
            else
                Assert.IsTrue(result);
        }

        /// <summary>
        /// Click a radio button with specified label
        /// </summary>
        /// <param name="label">The text of the radio button's label</param>
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

        /// <summary>
        /// Verify a task summary
        /// </summary>
        /// <param name="table">The task summary to verify</param>
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

        /// <summary>
        /// Expand the task summary box
        /// </summary>
        [Given(@"I expand Task Summary")]
        public void GivenIExpandTaskSummary()
        {
            CurrentPage.As<ITaskSummaryContainer>()
                .GetTaskSummary()
                .Expand();
        }
    }
}