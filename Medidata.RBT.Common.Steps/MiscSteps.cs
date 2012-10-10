using System;
using TechTalk.SpecFlow;
using OpenQA.Selenium;
using OpenQA.Selenium.Remote;
using System.Threading;
using System.Collections.Specialized;
using Microsoft.VisualStudio.TestTools.UnitTesting;

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
			TestContext.SwitchBrowserWindow(windowName);
		}

		/// <summary>
		/// 
		/// </summary>
		[StepDefinition(@"I switch to the second window")]
		public void ISwitchToTheSecondWindow()
		{
			TestContext.SwitchToSecondBrowserWindow();
		}

		/// <summary>
		/// This step will switch to the first window browser opens
		/// </summary>
		[StepDefinition(@"I switch to main window")]
		public void ISwitchToMainWindow()
		{
			TestContext.SwitchToMainBrowserWindow();
		}

		/// <summary>
		/// Click OK if alert window presents.
		/// </summary>
        [StepDefinition(@"I accept alert window")]
        public void IAcceptAlertWindow()
        {
			TestContext.AcceptAlert();
        }

		/// <summary>
		/// Click cancel if alert window presents.
		/// </summary>
        [StepDefinition(@"I dismiss alert window")]
        public void IDismissAlertWindow()
        {
			TestContext.CancelAlert();
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
		[StepDefinition(@"I wait for ([^""]*) ([^""]*)")]
		public void IWaitFor____Of____(int timeValue, string timeUnit)
		{
			switch (timeUnit)
			{
				case "second":
				case "seconds":
					System.Threading.Thread.Sleep(timeValue * 1000);
					break;
				case "minute":
				case "minutes":
					System.Threading.Thread.Sleep(timeValue * 60000);
					break;
				case "hour":
				case "hours":
					System.Threading.Thread.Sleep(timeValue * 3600000);
					break;
				default:
					throw new Exception("Not supported time unit: " + timeUnit);
			}
		}
	}
}
