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
    /// Steps to enable or disable page elements
    /// </summary>
    [Binding]
    public class EnableDisableSteps : BrowserStepsBase
    {
        /// <summary>
        /// Verify that a control is enabled
        /// </summary>
        /// <param name="controlName">The name of the control to verify</param>
        [StepDefinition(@"I verify ""([^""]*)"" is enabled")]
        public void ICanSee____IsEnabled(string controlName)
        {
            bool enabled = CurrentPage.As<IVerifyControlEnabledState>().VerifyControlEnabledState(controlName, true);
            Assert.IsTrue(enabled, controlName + " is disabled!");
        }

        /// <summary>
        /// Verify that a control is disabled
        /// </summary>
        /// <param name="controlName">The name of the control to verify</param>
        [StepDefinition(@"I verify ""([^""]*)"" is disabled")]
        public void ICanSee____IsDisabled(string controlName)
        {
            bool disabled = CurrentPage.As<IVerifyControlEnabledState>().VerifyControlEnabledState(controlName, false);
            Assert.IsTrue(disabled, controlName + " is enabled!");
        }

        /// <summary>
        /// Verify that a control in an area is disabled 
        /// </summary>
        /// <param name="controlName">The name of the control to verify</param>
        /// <param name="areaIdentifier">The area the control exists in</param>
        [StepDefinition(@"I verify ""([^""]*)"" is disabled in ""([^""]*)""")]
        public void ICanSee____IsDisabled(string controlName, string areaIdentifier)
		{
            bool disabled = CurrentPage.As<IVerifyControlEnabledState>().VerifyControlEnabledState(controlName, false, areaIdentifier);
            Assert.IsTrue(disabled, controlName + " is enabled!");
		}

        /// <summary>
        /// Verify that a control in an area is enabled
        /// </summary>
        /// <param name="controlName">The name of the control to verify</param>
        /// <param name="areaIdentifier">The area the control exists in</param>
        [StepDefinition(@"I verify ""([^""]*)"" is enabled in ""([^""]*)""")]
        public void ICanSee____IsEnabled(string controlName, string areaIdentifier)
        {
            bool enabled = CurrentPage.As<IVerifyControlEnabledState>().VerifyControlEnabledState(controlName, true, areaIdentifier);
            Assert.IsTrue(enabled, controlName + " is disabled!");
        }
	}
}
