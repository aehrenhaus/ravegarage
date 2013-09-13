using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using TechTalk.SpecFlow;
using Microsoft.VisualStudio.TestTools.UnitTesting;

namespace Medidata.RBT.Common.Steps
{
    [Binding]
    public class DropdownSteps: BrowserStepsBase
    {
        /// <summary>
        /// Step to verify a particular option is selected on architect check action dropdown
        /// </summary>
        /// <param name="optionText"></param>
        /// <param name="dropdown"></param>
        [StepDefinition(@"I verify option ""([^""]*)"" is selected in ""([^""]*)"" dropdown")]
        public void IVerifyOption____IsSelectedIn____Dropdown(string optionText, string dropdown)
        {
            var result = CurrentPage.As<IVerifyDropdownState>()
                .IsOptionSelected(optionText, dropdown);

            Assert.IsTrue(result);
        }

        /// <summary>
        /// Step to veify that specified option does not exist in the dropdown selection list
        /// </summary>
        /// <param name="optionText"></param>
        /// <param name="dropdown"></param>
        [StepDefinition(@"I verify option ""([^""]*)"" does not exist in ""([^""]*)"" dropdown")]
        public void IVerifyOption____DoesNotExistIn____Dropdown(string optionText, string dropdown)
        {
            var result = CurrentPage.As<IVerifyDropdownState>().OptionExist(optionText, dropdown);

            Assert.IsFalse(result);
        }

        /// <summary>
        /// Step to veify that specified option exists in the dropdown selection list
        /// </summary>
        /// <param name="optionText"></param>
        /// <param name="dropdown"></param>
        [StepDefinition(@"I verify option ""([^""]*)"" exists in ""([^""]*)"" dropdown")]
        public void IVerifyOption____ExistsIn____Dropdown(string optionText, string dropdown)
        {
            var result = CurrentPage.As<IVerifyDropdownState>().OptionExist(optionText, dropdown);

            Assert.IsTrue(result);
        }

    }
}
