using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using TechTalk.SpecFlow;
using OpenQA.Selenium;
using OpenQA.Selenium.Remote;
using System.Threading;

namespace Medidata.RBT.Common.Steps
{
    [Binding]
    public class MiscSteps : BrowserStepsBase
    {

        [StepDefinition(@"I take a screenshot")]
        public void ITakeScreenshot()
        {
            TestContext.TrySaveScreenShot();
        }

        [StepDefinition(@"I switch to ""([^""]*)"" window")]
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
			Thread.Sleep(1000);
			CurrentPage = TestContext.POFactory.GetPageByUrl(new Uri(Browser.Url));
		}

        [StepDefinition(@"I accept alert window")]
        public void WhenIAcceptAlertWindow()
        {
            CurrentPage.As<PageBase>().GetAlertWindow().Accept();
			
			var uri = new Uri(Browser.Url);
			CurrentPage = TestContext.POFactory.GetPageByUrl(uri);
        }


        [StepDefinition(@"I dismiss alert window")]
        public void WhenIDismissAlertWindow()
        {
            CurrentPage.As<PageBase>().GetAlertWindow().Dismiss();
			var uri = new Uri(Browser.Url);
			CurrentPage = TestContext.POFactory.GetPageByUrl(uri);
        }

    

		[StepDefinition(@"I switch to main window")]
		public void ISwitchToMainWindow()
		{
			//Browser.Close();
			IWebDriver window = null;
			foreach (var handle in Browser.WindowHandles)
			{
				window = Browser.SwitchTo().Window(handle);
					break;
			}
			Browser = (window as RemoteWebDriver);
			Thread.Sleep(1000);
			CurrentPage = TestContext.POFactory.GetPageByUrl(new Uri(Browser.Url));
		}

	}
}
