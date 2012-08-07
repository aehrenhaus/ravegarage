using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using TechTalk.SpecFlow;
using OpenQA.Selenium;
using OpenQA.Selenium.Remote;
using System.Threading;
using System.Collections.Specialized;

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
			//TODO: got to be a better way
			//wait for the window to appear
			Thread.Sleep(3000);

            bool found = false;
			IWebDriver window = null;
			foreach (var handle in Browser.WindowHandles)
			{
				window = Browser.SwitchTo().Window(handle);
                if (window.Title == windowName)
                {
                    found = true;
                    break;
                }
			}
            if (!found) throw new Exception(string.Format("window {0} not found", windowName));
			Browser = (window as RemoteWebDriver);
			
			CurrentPage = TestContext.POFactory.GetPageByUrl(new Uri(Browser.Url));
		}

        [StepDefinition(@"I accept alert window")]
        public void IAcceptAlertWindow()
        {
            CurrentPage.As<PageBase>().GetAlertWindow().Accept();
			
			var uri = new Uri(Browser.Url);
			CurrentPage = TestContext.POFactory.GetPageByUrl(uri);
        }


        [StepDefinition(@"I dismiss alert window")]
        public void IDismissAlertWindow()
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


		[StepDefinition(@"I navigate to ""([^""]*)"" page with parameters")]
		public void INavigateTo____PageWithParameters(string pageName, Table table)
		{
			//TODO:Set parameters from table
			PageBase page = TestContext.POFactory.GetPage(pageName.Replace(" ", "") + "Page") as PageBase;
			NameValueCollection parameters = new NameValueCollection();
			foreach (var row in table.Rows)
			{
				parameters[row["Name"]] = row["Value"];
			}
			CurrentPage = page.NavigateToSelf(parameters);
		}

		[StepDefinition(@"I navigate to ""([^""]*)"" page")]
		public void INavigateTo____Page(string pageName)
		{

			CurrentPage = TestContext.POFactory.GetPage(pageName.Replace(" ", "") + "Page").NavigateToSelf();
		}
	}
}
