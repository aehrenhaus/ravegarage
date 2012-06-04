using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using TechTalk.SpecFlow;
using OpenQA.Selenium.Remote;
using OpenQA.Selenium;
using System.IO;
using System.Drawing.Imaging;

namespace Medidata.RBT
{
	[Binding]
	public class TestContext
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

		public static int ScreenshotIndex
		{
			get;
			private set;
		}

		public static string PB
		{
			get;
			private set;
		}

		public static T GetContextValue<T>(string key)
		{
			if (!ScenarioContext.Current.ContainsKey(key))
			{
				return default(T);
			}
			return (T)ScenarioContext.Current[key];
		}

		public  static void SetContextValue<T>(string key, T val)
		{
			ScenarioContext.Current[key] = val;
		}

		[BeforeFeature()]
		public static void FeatureSetup()
		{
			CurrentFeatureStartTime = DateTime.Now;
		}

		[BeforeScenario()]
		public void ScenarioSetup()
		{
			//start time
			CurrentScenarioStartTime = DateTime.Now;

			//reset the screenshot counter
			ScreenshotIndex = 1;

			//set scenario name with tag that starts with PB_
			PB =  ScenarioContext.Current.ScenarioInfo.Tags.FirstOrDefault(x=>x.StartsWith("PB_"));
			if (PB == null)
				PB = "[NO NAME]";
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
				
				if(RBTConfiguration.Default.AutoCloseBrowser)
					Browser.Close();
				Browser = null;
			}

		}

		public static string GetTestResultPath()
		{
			string featureName = MakeValidFileName("feature Name");
			string featureStartTime = CurrentFeatureStartTime.ToString().Replace(":", "-").Replace("/", "-");

			//file path
			string path = Path.Combine(
				RBTConfiguration.Default.TestResultPath,
				featureStartTime,
				featureName,
				PB);

			return path;
		}

		public static void TrySaveScreenShot(string fileName=null)
		{
			if (!RBTConfiguration.Default.TakeScreenShots)
				return;
			try
			{
				if (Browser is ITakesScreenshot)
				{
					string resultPath = GetTestResultPath();

					fileName = fileName ?? ScreenshotIndex.ToString();
					fileName = PB+"_"+fileName+ ".jpg";

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

			ScreenshotIndex++;
		}

		private static string MakeValidFileName(string name)
		{
			//TODO: implment
			return name;
		}
	}
}
