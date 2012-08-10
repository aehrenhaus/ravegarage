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
using System.Threading;
using OpenQA.Selenium.Firefox;
using OpenQA.Selenium.Chrome;
using OpenQA.Selenium.IE;

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
		/// This is a convention, we use the tag name as a identifier of  a scenario
		/// 
		/// </summary>
		public static string ScenarioUniqueName
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
		
		/// <summary>
		/// After whole test
		/// </summary>
		[AfterTestRun]
		public static void TestTearDown()
		{
			//generate report using powershell
			if (RBTConfiguration.Default.GenerateReportAfterTest)
			{
		
				System.Diagnostics.Process p = new System.Diagnostics.Process();
				p.StartInfo = new System.Diagnostics.ProcessStartInfo(
					@"powershell.exe",
					"../../../reportGen.ps1");
				p.Start();
			}

			//close browser
			if (RBTConfiguration.Default.AutoCloseBrowser)
				CloseBrower();
		}

		/// <summary>
		/// 
		/// </summary>
		[BeforeTestRun]
		public static void BeforeTestRun()
		{
			OpenBrower();
		}

		/// <summary>
		/// Before each feature
		/// </summary>
		[BeforeFeature()]
		public static void BeforeFeature()
		{
			CurrentFeatureStartTime = DateTime.Now;

				
		}

		/// <summary>
		/// After each feature
		/// </summary>
		[AfterFeature()]
		public static void AfterFeature()
		{

		}

		/// <summary>
		/// Before each scenario
		/// </summary>
		[BeforeScenario()]
		public void BeforeScenario()
		{
			//start time
			CurrentScenarioStartTime = DateTime.Now;

			//reset the screenshot counter
			ScreenshotIndex = 1;

			//set scenario name with tag that starts with PB_
			ScenarioUniqueName =  ScenarioContext.Current.ScenarioInfo.Tags.FirstOrDefault(x=>x.StartsWith(RBTConfiguration.Default.ScenarioNamePrefix));
			if (ScenarioUniqueName == null)
				ScenarioUniqueName = "Scenario_" + DateTime.Now.Ticks.ToString() ;

			//restore snapshot
			//DbHelper.RestoreSnapshot();

		}

		
		/// <summary>
		/// After each scenario
		/// </summary>
		[AfterScenario]
		public void AfterScenario()
		{
			//take a snapshot after every scenario
			TrySaveScreenShot();
		}

		/// <summary>
		/// Points to the folder that contains result files(Screenshots etc.)
		/// </summary>
		/// <returns></returns>
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
					fileName = ScenarioUniqueName+"_"+fileName+ ".jpg";

					Console.WriteLine("img->"+fileName);
					Console.WriteLine( "->"+Browser.Url);
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

		#region Private methods

		private static string MakeValidFileName(string name)
		{
			//TODO: implment
			return name;
		}


		private static void OpenBrower()
		{
			if (Browser == null)
			{
				Browser = OpenBrowser();
			}
		}


		/// <summary>
		/// Open a brower according to configuration
		/// </summary>
		/// <param name="browserName"></param>
		/// <returns></returns>
		private static RemoteWebDriver OpenBrowser(string browserName = null)
		{
			RemoteWebDriver _webdriver = null;

			var driverPath = RBTConfiguration.Default.WebDriverPath;
			if (!Path.IsPathRooted(driverPath))
				driverPath = new DirectoryInfo(Path.Combine(AppDomain.CurrentDomain.BaseDirectory, driverPath)).FullName;

			switch (RBTConfiguration.Default.BrowserName.ToLower())
			{
				case "firefox":
					FirefoxProfile p = new FirefoxProfile(RBTConfiguration.Default.FirefoxProfilePath, true);
					FirefoxBinary bin = new FirefoxBinary(RBTConfiguration.Default.BrowserPath);
					_webdriver = new FirefoxDriver(bin, p);
					break;


				case "chrome":

					_webdriver = new ChromeDriver(driverPath);
					break;


				case "ie":
					_webdriver = new InternetExplorerDriver(driverPath);
					break;

			}

			return _webdriver;
		}


		private static void CloseBrower()
		{
			//Close browser
			if (Browser != null)
			{
				Browser.Close();
				Browser = null;
			}
		}

		#endregion

		private static IPageObjectFactory _POFactory;
		public static  IPageObjectFactory POFactory
		{
			get
			{
				//TODO: this will initiallize _POFactory by the CurrentPage.
				//This is not very nice because if CurrentPage is null, the this process will fail
				if (_POFactory == null)
				{
					Type factoryType = CurrentPage.GetType()
						.Assembly
						.GetTypes()
						.FirstOrDefault(x => x.GetInterface("IPageObjectFactory") != null) ;
					_POFactory = Activator.CreateInstance(factoryType) as IPageObjectFactory;
				}
				return _POFactory;
			}
		}
	}
}
