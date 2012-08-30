using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Medidata.RBT.Features;
using TechTalk.SpecFlow;
using Medidata.RBT.PageObjects;
using Medidata.RBT.PageObjects.Rave;
using System.IO;

using System.Data;
using OpenQA.Selenium;
using OpenQA.Selenium.Remote;
using System.Threading;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Medidata.RBT.Common.Steps;
using Medidata.RBT;

namespace Medidata.RBT.Features.Rave
{
    [Binding]
    public class
        SubjectPageSteps : BrowserStepsBase
    {

        [Then(@"I can see Add Event lock icon")]
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
            bool canSee = false;
            IWebElement element = CurrentPage.As<SubjectPage>().CanSeeControl(btnValue);

            if (element != null)
                canSee = true;

            Assert.IsTrue(canSee);
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

        [StepDefinition(@"I can not see ""([^""]*)"" button")]
        public void ICanNotSee____Button(string value)
        {
            bool result = false;
            IWebElement element = CurrentPage.As<SubjectPage>().CanSeeControl(value);

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
            bool result = false;
            IWebElement element = CurrentPage.As<SubjectPage>().CanSeeControl(label);

            if (element != null)
            {
                element.Click();
                result = true;
            }

            Assert.IsTrue(result);
        }
    }
}