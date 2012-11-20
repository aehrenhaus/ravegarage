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
			Browser.SwitchBrowserWindow(windowName);
			CurrentPage = TestContext.POFactory.GetPageByUrl(new Uri(Browser.Url));
		}

		/// <summary>
		/// 
		/// </summary>
		[StepDefinition(@"I switch to the second window")]
		public void ISwitchToTheSecondWindow()
		{
			Browser.SwitchToSecondBrowserWindow();
			CurrentPage = TestContext.POFactory.GetPageByUrl(new Uri(Browser.Url));
		}

		/// <summary>
		/// This step will switch to the first window browser opens
		/// </summary>
		[StepDefinition(@"I switch to main window")]
		public void ISwitchToMainWindow()
		{
			Browser.SwitchToMainBrowserWindow();
			CurrentPage = TestContext.POFactory.GetPageByUrl(new Uri(Browser.Url));
		}

		/// <summary>
		/// Click OK if alert window presents.
		/// </summary>
        [StepDefinition(@"I accept alert window")]
        public void IAcceptAlertWindow()
        {
			Browser.GetAlertWindow().Accept();
			CurrentPage = TestContext.POFactory.GetPageByUrl(new Uri(Browser.Url));
        }

		/// <summary>
		/// Click cancel if alert window presents.
		/// </summary>
        [StepDefinition(@"I dismiss alert window")]
        public void IDismissAlertWindow()
        {
			Browser.GetAlertWindow().Dismiss();
			CurrentPage = TestContext.POFactory.GetPageByUrl(new Uri(Browser.Url));
        }

		[StepDefinition(@"I verify current URL is ""([^""]*)""")]
		public void IVerifyCurrentURLIs____(string expectURL)
		{
			Assert.AreEqual(expectURL, Browser.Url);
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
		/// Navigate to a URL
		/// </summary>
		/// <param name="url"></param>
		[StepDefinition(@"I navigate to url ""(.*?)""")]
		public void INavigateToURL____(string url)
		{
			Browser.Url = url;
			var uri = new Uri(Browser.Url);
			CurrentPage = TestContext.POFactory.GetPageByUrl(uri);
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
		/// Wait for [timeValue] [timeUnit]
		/// </summary>
		/// <param name="timeValue"></param>
		/// <param name="timeUnit"></param>
		[StepDefinition(@"I wait for ([^""]*) seconds?")]
		public void IWaitFor____Of____Seconds(int timeValue)
		{
	
			System.Threading.Thread.Sleep(timeValue * 1000);

		}

		[StepDefinition(@"I wait for ([^""]*) minutes?")]
		public void IWaitFor____Of____Minutes(int timeValue)
		{
	
			System.Threading.Thread.Sleep(timeValue * 60000);
			
		}



	}

}
