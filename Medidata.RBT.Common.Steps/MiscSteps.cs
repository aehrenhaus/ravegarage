﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using TechTalk.SpecFlow;
using OpenQA.Selenium;
using OpenQA.Selenium.Remote;

namespace Medidata.RBT.Common.Steps
{
	[Binding]
	public class MiscSteps:BrowserStepsBase
	{

		[StepDefinition(@"I take a screenshot")]
		public void ITakeScreenshot()
		{
			TestContext.TrySaveScreenShot();
		}

		[Given(@"I switch to ""([^""]*)"" window")]
		public void ISwitchTo____Window(string windowName)
		{
			IWebDriver window = null;
			foreach (var handle in Browser.WindowHandles)
			{
				window = Browser.SwitchTo().Window(handle);
				if (window.Title == windowName)
					break;
			}
			Browser = (window as RemoteWebDriver);
		}


	}
}
