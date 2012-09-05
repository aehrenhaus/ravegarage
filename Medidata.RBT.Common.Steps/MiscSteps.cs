using System;
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
		/// <summary>
		/// Captures the screen of browser(if the browser supports) and save it to a local file in the configuared location
		/// The captured files will be under the step itself in report.
		/// </summary>
        [StepDefinition(@"I take a screenshot")]
        public void ITakeScreenshot()
        {
            TestContext.TrySaveScreenShot();
        }

		/// <summary>
		/// When the browser opens an other window, and next step is on that new window, you shall use this step to switch focus first.
		/// The window name is the title.
		/// </summary>
		/// <param name="windowName"></param>
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

		/// <summary>
		/// Click OK if alert window presents.
		/// </summary>
        [StepDefinition(@"I accept alert window")]
        public void IAcceptAlertWindow()
        {
            CurrentPage.As<PageBase>().GetAlertWindow().Accept();
			
			var uri = new Uri(Browser.Url);
			CurrentPage = TestContext.POFactory.GetPageByUrl(uri);
        }

		/// <summary>
		/// Click cancel if alert window presents.
		/// </summary>
        [StepDefinition(@"I dismiss alert window")]
        public void IDismissAlertWindow()
        {
            CurrentPage.As<PageBase>().GetAlertWindow().Dismiss();
			var uri = new Uri(Browser.Url);
			CurrentPage = TestContext.POFactory.GetPageByUrl(uri);
        }

    
		/// <summary>
		/// This step will switch to the first window browser opens
		/// </summary>
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

		/// <summary>
		/// pageName is the PO class name without the 'Page' part. 
		/// This step is a shortcut to jumpe to a page.
		/// </summary>
		/// <param name="pageName"></param>
		/// <param name="table"></param>
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


		/// <summary>
		/// pageName is the PO class name without the 'Page' part. 
		/// This step is a shortcut to jumpe to a page.
		/// </summary>
		/// <param name="pageName"></param>
		[StepDefinition(@"I navigate to ""([^""]*)"" page")]
		public void INavigateTo____Page(string pageName)
		{

			CurrentPage = TestContext.POFactory.GetPage(pageName.Replace(" ", "") + "Page").NavigateToSelf();
		}


		/// <summary>
		/// Save something (text) from current page to a variable.
		/// This variable can be later used by using Var string replacement method
		/// </summary>
		/// <param name="identifier"></param>
		/// <param name="varName"></param>
		[StepDefinition(@"I note down ""([^""]*)"" to ""([^""]*)""")]
		public void INoteDownCrfversionTo____(string identifier, string varName)
		{
			string text = CurrentPage.GetInfomation(identifier);
			SpecialStringHelper.SetVar(varName, text);
		}

		/// <summary>
		/// Inactivate something on page
		/// </summary>
		/// <param name="type"></param>
		/// <param name="identifier"></param>
		[StepDefinition(@"I inactivate (.+) ""([^""]*)""")]
		public void IInactivate________(string type, string identifier)
		{
			CurrentPage.As<IActivatePage>().Inactivate(type, identifier);
		}


		/// <summary>
		/// Activate something on page
		/// </summary>
		/// <param name="type"></param>
		/// <param name="identifier"></param>
		[StepDefinition(@"I activate (.+) ""([^""]*)""")]
		public void IActivate________(string type, string identifier)
		{
			CurrentPage.As<IActivatePage>().Activate(type, identifier);
		}

	}
}
