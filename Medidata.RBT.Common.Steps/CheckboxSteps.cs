using System;
using TechTalk.SpecFlow;
using OpenQA.Selenium;
using OpenQA.Selenium.Remote;
using System.Threading;
using System.Collections.Specialized;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Medidata.RBT.SeleniumExtension;
using System.IO;
using Medidata.RBT.StateVerificationInterfaces;

namespace Medidata.RBT.Common.Steps
{
    /// <summary>
    /// Steps to verify or manipulate checkboxes
    /// </summary>
    [Binding]
    public class CheckboxSteps : BrowserStepsBase
    {
        /// <summary>
        /// Verify a check box is checked
        /// </summary>
        /// <param name="identifier">The identifier of the checkbox</param>
        [StepDefinition(@"I verify ""([^""]*)"" is checked")]
        public void IVerify____IsChecked(string identifier)
        {
            Assert.IsTrue(CurrentPage.As<IVerifyCheckboxState>().VerifyCheckboxState(identifier, true), identifier + "is unchecked!");
        }

        /// <summary>
        /// Verify a check box is checked in an area
        /// </summary>
        /// <param name="identifier">The identifier of the checkbox</param>
        /// <param name="areaIdentifier">The area the checkbox exists in</param>
        [StepDefinition(@"I verify ""([^""]*)"" is checked in ""([^""]*)""")]
        public void IVerify____IsCheckedInArea____(string identifier, string areaIdentifier)
        {
            Assert.IsTrue(CurrentPage.As<IVerifyCheckboxState>().VerifyCheckboxState(identifier, true, areaIdentifier), identifier + "is unchecked!");
        }

        /// <summary>
        /// Verify a check box is unchecked
        /// </summary>
        /// <param name="identifier">The identifier of the checkbox</param>
        [StepDefinition(@"I verify ""([^""]*)"" is unchecked")]
        public void IVerify____IsUnchecked(string identifier)
        {
            Assert.IsTrue(CurrentPage.As<IVerifyCheckboxState>().VerifyCheckboxState(identifier, false), identifier + "is checked!");
        }

        /// <summary>
        /// Verify a check box is unchecked
        /// </summary>
        /// <param name="identifier">The identifier of the checkbox</param>
        /// <param name="areaIdentifier">The area the checkbox should not exist in</param>
        [StepDefinition(@"I verify ""([^""]*)"" is unchecked in ""([^""]*)""")]
        public void IVerify____IsUncheckedInArea____(string identifier, string areaIdentifier)
        {
            Assert.IsTrue(CurrentPage.As<IVerifyCheckboxState>().VerifyCheckboxState(identifier, false, areaIdentifier), identifier + "is checked!");
        }

        /// <summary>
        /// Check a checkbox in an area
        /// </summary>
        /// <param name="identifier">The identifier of the checkbox</param>
        /// <param name="areaName">The area the checkbox should not exist in</param>
        [StepDefinition(@"I check ""([^""]*)"" in ""([^""]*)""")]
        public void ICheck____In____(string identifier, string areaName)
        {
            CurrentPage.ChooseFromCheckboxes(identifier, true, areaName);
        }

        /// <summary>
        /// Check a checbox in a list
        /// (eg. I check "locked" on "Study1" in "Studies")
        /// </summary>
        /// <param name="identifier">The identifier of the checkbox</param>
        /// <param name="listItem">The specific item in the list the checkbox exists in</param>
        /// <param name="listIdentifier">The list the checkbox exists in</param>
        [StepDefinition(@"I check ""([^""]*)"" on ""([^""]*)"" in ""([^""]*)""")]
        public void ICheck____On___In____(string identifier, string listItem, string listIdentifier)
        {
            CurrentPage.ChooseFromCheckboxes(identifier, true, listIdentifier, listItem);
        }

        /// <summary>
        /// Check a check box
        /// </summary>
        /// <param name="identifier">The identifier of the checkbox</param>
        [StepDefinition(@"I check ""([^""]*)""")]
        public void ICheck____(string identifier)
        {
            CurrentPage = CurrentPage.ChooseFromCheckboxes(identifier, true);
        }

        /// <summary>
        /// I uncheck a checkbox
        /// </summary>
        /// <param name="identifier">The identifier of the checkbox</param>
        /// <param name="areaIdentifier">The area the checkbox should exist in</param>
        [StepDefinition(@"I uncheck ""([^""]*)"" in ""([^""]*)""")]
        public void IUncheck____In____(string identifier, string areaIdentifier)
        {
            CurrentPage.ChooseFromCheckboxes(identifier, false, areaIdentifier);
        }

        /// <summary>
        /// Uncheck a checbox in a list
        /// (eg. I uncheck "locked" on "Study1" in "Studies")
        /// </summary>
        /// <param name="identifier">The identifier of the checkbox</param>
        /// <param name="listItem">The specific item in the list the checkbox exists in</param>
        /// <param name="areaIdentifier">The list the checkbox exists in</param>
        [StepDefinition(@"I uncheck ""([^""]*)"" on ""([^""]*)"" in ""([^""]*)""")]
        public void IUncheck____On____In____(string identifier, string listItem, string areaIdentifier)
        {
            CurrentPage.ChooseFromCheckboxes(identifier, false, areaIdentifier, listItem);
        }

        /// <summary>
        /// Uncheck a checkbox
        /// </summary>
        /// <param name="identifier">The identifier of the checkbox</param>
        [StepDefinition(@"I uncheck ""([^""]*)""")]
        public void IUncheck____(string identifier)
        {
            CurrentPage = CurrentPage.ChooseFromCheckboxes(identifier, false);
        }
	}
}
