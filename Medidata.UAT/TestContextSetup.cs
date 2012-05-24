using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using TechTalk.SpecFlow;
using OpenQA.Selenium.Remote;
using OpenQA.Selenium;
using System.IO;
using System.Drawing.Imaging;

namespace Medidata.UAT
{
	[Binding]
	public class TestContextSetup
	{

		public static RemoteWebDriver Browser
		{
			get
			{
				return GetContextValue<RemoteWebDriver>("RemoteWebDriver");
			}
			set
			{

				ScenarioContext.Current["RemoteWebDriver"] = value;
			}
		}

		public static PageBase CurrentPage
		{
			get
			{
				return GetContextValue<PageBase>("PageBase");
			}
			set
			{
				ScenarioContext.Current["PageBase"] = value;
			}
		}

		public static DateTime? CurrentScenarioStartTime
		{
			get
			{
				return GetContextValue<DateTime?>("CurrentScenarioStartTime");
			}
			set
			{
				ScenarioContext.Current["CurrentScenarioStartTime"] = value;
			}
		}

		public static DateTime? CurrentFeatureStartTime
		{
			get;
			set;
		}

		private static T GetContextValue<T>(string key)
		{
			if (!ScenarioContext.Current.ContainsKey(key))
			{
				return default(T);
			}
			return (T)ScenarioContext.Current[key];

		}

		[BeforeFeature()]
		public static void FeatureSetup()
		{
			CurrentFeatureStartTime = DateTime.Now;
		}

		[BeforeScenario()]
		public void ScenarioSetup()
		{
			CurrentScenarioStartTime = DateTime.Now;
		}


		[BeforeScenario("Web")]
		public void ScenarioSetupWeb()
		{
			if (Browser == null)
			{
				Browser = PageBase.OpenBrowser();
			}
		}

		[AfterScenario("Web")]
		public void ScenarioTearDownWeb()
		{
			if (Browser != null)
			{
			//	TrySaveScreenShot(Browser);
				
				if(UATConfiguration.Default.AutoCloseBrowser)
					Browser.Close();
				Browser = null;
			}

		}

		public static string GetTestResultPath()
		{
			string scenarioName = ReplaceIlligalFileNameChars("scenaroi");//ScenarioContext.Current.ScenarioInfo.Title)
			string featureName = ReplaceIlligalFileNameChars("feature Name");
			string featureStartTime = CurrentFeatureStartTime.ToString().Replace(":", "-").Replace("/", "-");

			//file path
			string path = Path.Combine(
				UATConfiguration.Default.TestResultPath,
				featureStartTime,
				featureName,
				scenarioName);

			return path;
		}

		public static void TrySaveScreenShot(string fileName=null)
		{
			if (!UATConfiguration.Default.TakeScreenShots)
				return;
			try
			{
				if (Browser is ITakesScreenshot)
				{
					string resultPath = GetTestResultPath();

					string time = DateTime.Now.ToString().Replace(":", "-").Replace("/", "-");
					fileName = fileName ?? time;
					fileName += ".jpg";

					//file path
					string screenshotPath = Path.Combine(resultPath,fileName);

					Directory.CreateDirectory(new FileInfo(screenshotPath).DirectoryName);
					var screenShot = ((ITakesScreenshot)Browser).GetScreenshot();
					screenShot.SaveAsFile(screenshotPath, ImageFormat.Jpeg);

				}
			}
			catch
			{
			}
		}

		private static string ReplaceIlligalFileNameChars(string name)
		{
			//TODO: implment
			return name;
		}
	}
}
