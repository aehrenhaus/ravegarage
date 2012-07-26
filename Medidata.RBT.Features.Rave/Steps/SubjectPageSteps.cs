using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Medidata.RBT.Features;
using TechTalk.SpecFlow;
using Medidata.RBT.PageObjects;
using Medidata.RBT.PageObjects.Rave;
using System.IO;
using Microsoft.Practices.EnterpriseLibrary.Data;
using System.Data;
using OpenQA.Selenium;
using OpenQA.Selenium.Remote;
using System.Threading;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Medidata.RBT.Common.Steps;

namespace Medidata.RBT.Features.Rave
{
    [Binding]
    public class 
        SubjectPageSteps : BrowserStepsBase
    {
        [StepDefinition(@"I check Lock checkbox")]
        public void ICheckLockCheckbox()
        {
            CurrentPage.ChooseFromCheckboxes(null, "_ctl0_Content__ctl0_CB_Lock_0", true);
        }
        

        [Then(@"I can see Add Event lock icon")]
        public void ICanSeeAddEventLockIcon()
        {
            bool result = false;
            IWebElement element = CurrentPage.As<IPage>().CanSeeControl("_ctl0_Content_SubjectAddEvent_DisableMatrixIcon");
            if (element != null)
                result = true;
            Assert.IsTrue(result);
        }

        [StepDefinition(@"I can see ""([^""]*)"" button")]
        public void ICanSee____Button(string btnValue)
        {
            string id = "";

            if (btnValue == "Add")
                id = "_ctl0_Content_SubjectAddEvent_SaveBtn";
            else if (btnValue == "Enable" || btnValue == "Disable")
                id = "_ctl0_Content_SubjectAddEvent_LockAddEventSaveBtn";
            else
                id = btnValue;

            bool canSee = false;
            IWebElement element = CurrentPage.As<IPage>().CanSeeControl(id);

            if (element != null)
                canSee = true;

            Assert.IsTrue(canSee);
        }

        [StepDefinition(@"I can see ""([^""]*)"" dropdown labeled ""([^""]*)""")]
        public void ICanSee____DropdownLabeled____(string enabled, string label)
        {
            string id = "";

            if (label == "Add Event")
                id = "_ctl0_Content_SubjectAddEvent_MatrixList";
            else
                id = label;

            bool isDisabled = false;
            if (enabled.ToLower() == "disabled")
                isDisabled = true;

            bool result = false;
            IWebElement element = CurrentPage.As<IPage>().CanSeeControl(id);

            if (element != null && element.GetAttribute("disabled").ToLower() == isDisabled.ToString().ToLower())
                result = true;

            Assert.IsTrue(result);

        }

        [StepDefinition(@"I can see tooltip ""([^""]*)"" on button labeled ""([^""]*)""")]
        public void ICanSeeToolTip____On____WithID____(string toolTip, string label)
        {
            string id = "";

            if (label == "Add")
                id = "_ctl0_Content_SubjectAddEvent_SaveBtn";
            else if (label == "Enable" || label == "Disable")
                id = "_ctl0_Content_SubjectAddEvent_LockAddEventSaveBtn";
            else
                id = label;

            bool result = false;
            IWebElement element = CurrentPage.As<IPage>().CanSeeControl(id);

            if (element != null && element.GetAttribute("title").Equals(toolTip))
                result = true;

            Assert.IsTrue(result);
        }

        [StepDefinition(@"I have seeded ""([^""]*)"" button")]
        public void IHaveSeeded____Button(string value)
        {
            bool result = false;
            string id = "";

            if (value == "Add")
                id = "_ctl0_Content_SubjectAddEvent_SaveBtn";
            else if (value == "Enable" || value == "Disable")
                id = "_ctl0_Content_SubjectAddEvent_LockAddEventSaveBtn";

            IWebElement element = CurrentPage.As<IPage>().CanSeeControl(id);

            if (element != null)
            {
                result = true;
                if (element.GetAttribute("value").ToLower() != value.ToLower())
                    element.Click(); // e.g. click "Enable" button to turn to "Disable"
            }

            Assert.IsTrue(result);

        }

        [StepDefinition(@"I can not see ""([^""]*)"" button")]
        public void ICanNotSee____Button(string value)
        {
            bool result = false;
            string id = "";

            if (value == "Add")
                id = "_ctl0_Content_SubjectAddEvent_SaveBtn";
            else if (value == "Enable" || value == "Disable")
                id = "_ctl0_Content_SubjectAddEvent_LockAddEventSaveBtn";

            IWebElement element = CurrentPage.As<IPage>().CanSeeControl(id);

            if (element != null)
            {
                if (value == "" || value.ToLower() == element.GetAttribute("value").ToLower())
                    result = true;
            }

            Assert.IsFalse(result);
        }

        [StepDefinition(@"I click radiobutton with label ""([^""]*)""")]
        public void IClickRadiobuttonWithLabel____(string label)
        {
            string id = "";

            if (label == "Set")
                id = "_ctl0_Content__ctl0_RadioButtons_0";
            else if (label == "Clear")
                id = "_ctl0_Content__ctl0_RadioButtons_1";
            else
                id = label;

            bool result = false;
            IWebElement element = CurrentPage.As<IPage>().CanSeeControl(id);

            if (element != null)
            {
                element.Click();
                result = true;
            }

            Assert.IsTrue(result);
        }
    }
}
