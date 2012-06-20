using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using TechTalk.SpecFlow;
using OpenQA.Selenium.Remote;
using OpenQA.Selenium;
using System.IO;
using System.Drawing.Imaging;
using System.Collections.Specialized;

namespace Medidata.RBT
{
	[Binding]
	public class TestContext
	{

		public static RemoteWebDriver Browser
		{
			get;
			set;
			//get
			//{
			//    return GetContextValue<RemoteWebDriver>("RemoteWebDriver");
			//}
			//set
			//{

			//    ScenarioContext.Current["RemoteWebDriver"] = value;
			//}
		}

		public static IPage CurrentPage
		{
			get
			{
				return GetContextValue<IPage>("PageBase");
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

		/// <summary>
		/// This is read from a @PB.... tag on a scenario when it starts to run.
		/// This is a convention, we use the tag name as a identifer of  a scenario
		/// 
		/// </summary>
		public static string PB
		{
			get;
			private set;
		}

		public static NameValueCollection Vars
		{
			get
			{
				NameValueCollection vars = null;
				if (FeatureContext.Current.ContainsKey("Vars"))
					vars = FeatureContext.Current["Vars"] as NameValueCollection;

				if (vars == null)
				{
					vars = new NameValueCollection();
					FeatureContext.Current["Vars"] = vars;
				}
				return vars;
			}
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
			if (RBTConfiguration.Default.OneBrowserPerFeature)
				OpenBrower();
		}

		[AfterFeature()]
		public static void FeatureTeardown()
		{
			if (RBTConfiguration.Default.OneBrowserPerFeature)
				CloseBrower();
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
				PB = "NONAME";

			//restore snapshot
			//DbHelper.RestoreSnapshot();

			//LAST step: open browser
			if(!RBTConfiguration.Default.OneBrowserPerFeature)
				OpenBrower();
		}

		private static void OpenBrower()
		{
			if (Browser == null)
			{
				Browser = PageBase.OpenBrowser();
			}
		}

		private static void CloseBrower()
		{
			//Close browser
			if (Browser != null)
			{
				if (RBTConfiguration.Default.AutoCloseBrowser)
					Browser.Close();
				Browser = null;
			}
		}
		
		[AfterScenario]
		public void ScenarioTearDown()
		{
			if(!RBTConfiguration.Default.OneBrowserPerFeature)
				CloseBrower();

		}

		public static string GetTestResultPath()
		{
			string featureStartTime = CurrentFeatureStartTime.ToString().Replace(":", "-").Replace("/", "-");

			//file path
			string path = RBTConfiguration.Default.TestResultPath
				.Replace("{time}", featureStartTime);

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

					Console.WriteLine("{img "+fileName+"}");

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
