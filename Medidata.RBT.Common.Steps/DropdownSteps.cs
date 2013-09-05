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
    }
}
