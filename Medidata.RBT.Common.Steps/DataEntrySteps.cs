using System;
using TechTalk.SpecFlow;
using OpenQA.Selenium;
using OpenQA.Selenium.Remote;
using System.Threading;
using System.Collections.Specialized;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Medidata.RBT.SeleniumExtension;
using System.IO;

namespace Medidata.RBT.Common.Steps
{
    /// <summary>
    /// Steps for data entry
    /// </summary>
    [Binding]
    public class DataEntry : BrowserStepsBase
    {
        /// <summary>
        /// Enter a value into a textbox
        /// </summary>
        /// <param name="valueToEnter">Value to enter</param>
        /// <param name="identifier">Identifier for textbox</param>
        [StepDefinition(@"I enter value ""(.*)"" in ""(.*)"" ""(.*)""")]
        public void GivenIEnterValue____In____Textbox(string valueToEnter, string identifier, string typeOfObject)
        {
            if(typeOfObject.Equals("textbox"))
                CurrentPage.As<IEnterValues>().EnterIntoTextbox(identifier, valueToEnter);
        }
	}
}
