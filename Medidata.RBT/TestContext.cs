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
using Medidata.RBT.SeleniumExtension;
using Medidata.RBT.SharedObjects;


namespace Medidata.RBT
{
	public static class Storage
	{
		//values inside FeatureContext.Current is not really the full feature, but rather a scenario.
		//So we use this static value to store varible accross the whole feature.
		//[ThreadStatic]
		public static Dictionary<string, object> FeatureValues = new Dictionary<string, object>();
		public static Dictionary<string, object> ScenarioValues = new Dictionary<string, object>();

		public static T GetFeatureLevelValue<T>(string key)
		{
			if (!Storage.FeatureValues.ContainsKey(key))
			{
				return default(T);
			}
			return (T)Storage.FeatureValues[key];
		}

		public static void SetFeatureLevelValue<T>(string key, T val)
		{
			Storage.FeatureValues[key] = val;
		}


		public static T GetScenarioLevelValue<T>(string key)
		{
			if (!Storage.ScenarioValues.ContainsKey(key))
			{
				return default(T);
			}
			return (T)Storage.ScenarioValues[key];
		}

		public static void SetScenarioLevelValue<T>(string key, T val)
		{
			Storage.ScenarioValues[key] = val;
		}
	}

	[Binding]
	public class TestContext
	{
		private static bool _watchingForDownload;
		private static FileInfo _downloadedFile;

		public static FileInfo LastDownloadFile
		{
			get
			{
				return _downloadedFile;
			}
		}

		public static RemoteWebDriver Browser { get; set; }

        public static string SpreadsheetName { get; set; }

        public static ExcelFileHelper ExcelFile { get; set; }

		#region switch browser window

		public static void SwitchBrowserWindow(string windowName)
		{
			
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
			while (Browser.Url == "about:blank")
				Thread.Sleep(500);
			
			CurrentPage = TestContext.POFactory.GetPageByUrl(new Uri(Browser.Url));
		}

		public static void SwitchToSecondBrowserWindow()
		{
			if (Browser.WindowHandles.Count < 2)
				throw new Exception("There isn't a second window");
			var secondWindowHandle = Browser.WindowHandles[1];

			IWebDriver window = Browser.SwitchTo().Window(secondWindowHandle);

			while (Browser.Url == "about:blank")
				Thread.Sleep(500);
			CurrentPage = TestContext.POFactory.GetPageByUrl(new Uri(Browser.Url));
		}


		public static void SwitchToMainBrowserWindow(bool close = false)
		{
			if (close)
				Browser.Close();

			var secondWindowHandle = Browser.WindowHandles[0];

			IWebDriver window = Browser.SwitchTo().Window(secondWindowHandle); ;

			CurrentPage = TestContext.POFactory.GetPageByUrl(new Uri(Browser.Url));
		}

		public static void AcceptAlert()
		{
			CurrentPage.As<PageBase>().GetAlertWindow().Accept();

			var uri = new Uri(Browser.Url);
			CurrentPage = TestContext.POFactory.GetPageByUrl(uri);
		}

		public static void CancelAlert()
		{
			CurrentPage.As<PageBase>().GetAlertWindow().Dismiss();
			var uri = new Uri(Browser.Url);
			CurrentPage = TestContext.POFactory.GetPageByUrl(uri);
		}

		#endregion

		public static IPage CurrentPage
		{
			get;
			set;
		}

		public static string CurrentUser
		{
			get;
			set;
		}

		public static string CurrentUserPassword
		{
			get;
			set;
		}

        /// <summary>
        /// Mapping of the name provided in the feature file to the FeatureObject object created by the FeatureObject constructor.
        /// </summary>
		public static Dictionary<string, ISeedableObject> SeedableObjects
        {
            get
            {
				var objs = Storage.GetFeatureLevelValue<Dictionary<string, ISeedableObject>>("SeedableObjects");

				if (objs == null)
				{
					objs = new Dictionary<string, ISeedableObject>();
					SeedableObjects = objs;
				}
				return objs;
            }
            set
            {
				Storage.SetFeatureLevelValue("SeedableObjects", value);
            }
        }

        /// <summary>
        /// Method to either get a FeatureObject that already exists in the FeatureObjects dictionary.
        /// Or, call that object's constructor to make a new one and add that to the FeatureObjects dictionary.
        /// </summary>
        /// <typeparam name="T">A feature object type</typeparam>
        /// <param name="originalName">The feature name of the object, the name the object is referred to as in the feature file.</param>
        /// <param name="constructor">The delegate of the call to the constructor</param>
        /// <returns></returns>
		public static T GetExistingFeatureObjectOrMakeNew<T>(string originalName, Func<T> constructor) where T : ISeedableObject
        {
			ISeedableObject seedable;
			SeedableObjects.TryGetValue(originalName, out seedable);

            if (seedable != null)
                return (T)seedable;

			seedable = constructor();

			seedable.Seed();

			//add to dictionary using both original name and unique name.
			SeedableObjects[originalName] = seedable;
			SeedableObjects[seedable.UniqueName] = seedable;

			return (T)seedable;
        }

		public static DateTime? CurrentScenarioStartTime
		{
			get
			{
				return Storage.GetScenarioLevelValue<DateTime?>("CurrentScenarioStartTime");
			}
			set
			{
				Storage.SetScenarioLevelValue("CurrentScenarioStartTime", value);
			}
		}

        public static string ScenarioText
        {
            get
            {
				return Storage.GetFeatureLevelValue<string>("ScenarioText");
            }
            set
            {
               Storage.SetFeatureLevelValue("ScenarioText", value);
            }
        }

		public static DateTime? CurrentFeatureStartTime { get; set; }

		public static int ScreenshotIndex { get; private set; }

		/// <summary>
		/// This is read from a @PB.... tag on a scenario when it starts to run.
		/// This is a convention, we use the tag name as a identifier of  a scenario
		/// 
		/// </summary>
		public static string ScenarioName { get; private set; }

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

		private static void Do()
		{
			System.Diagnostics.Process p = new System.Diagnostics.Process();

#if DEBUG
			p.StartInfo = new System.Diagnostics.ProcessStartInfo(
				@"powershell.exe",
			"-NoExit ../../../reportGen.ps1");
#else
				p.StartInfo = new System.Diagnostics.ProcessStartInfo(
				@"powershell.exe",
			"../../../reportGen.ps1");
#endif
			p.Start();
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
            DeleteAllDownloadFiles();
            DeleteAllDownloadDirectories();
            DeleteFilesInTemporaryUploadDirectories();

			SpecialStringHelper.Replaced += new Action<string, string>((input, output) =>
			{
				Console.WriteLine("replace --> " + input + " --> " + output);
			});
		}

		/// <summary>
		/// Before each feature
		/// </summary>
		[BeforeFeature()]
		public static void BeforeFeature()
		{
			Storage.FeatureValues.Clear();
            
			CurrentFeatureStartTime = DateTime.Now;
            DraftCounter.ResetCounter();
		}

		/// <summary>
		/// After each feature
		/// </summary>
		[AfterFeature()]
		public static void AfterFeature()
		{
            Factory.DeleteObjectsMarkedForFeatureDeletion();
            DeleteCreatedFiles();
            DeleteCreatedDirectories();
		}

		/// <summary>
		/// Before each scenario
		/// </summary>
		[BeforeScenario()]
		public void BeforeScenario()
		{
			Storage.ScenarioValues.Clear();

			//start time
			CurrentScenarioStartTime = DateTime.Now;

			//reset the screenshot counter
			ScreenshotIndex = 1;

			//set scenario name with tag that starts with PB_
			ScenarioName =  ScenarioContext.Current.ScenarioInfo.Tags.FirstOrDefault(x=>x.StartsWith(RBTConfiguration.Default.ScenarioNamePrefix));
			if (ScenarioName == null)
				ScenarioName = "Scenario_" + DateTime.Now.Ticks.ToString() ;

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

            Factory.DeleteObjectsMarkedForScenarioDeletion();
            DeleteCreatedFiles();
            DeleteCreatedDirectories();
		}

        [AfterStep()]
        public void AfterStep()
        {
            if (RBTConfiguration.Default.TakeScreenShotsEveryStep)
            {
                TrySaveScreenShot(true);
            }
            
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

		public static void TrySaveScreenShot(bool explicitTake = false)
		{
            //If configured to take sceenshot after every step, don't take those from step command to avoid duplicate
            if (RBTConfiguration.Default.TakeScreenShotsEveryStep && !explicitTake)
				return;

			try
			{
				if (Browser is ITakesScreenshot)
				{
					string resultPath = GetTestResultPath();

					var fileName = ScreenshotIndex.ToString();
					fileName = ScenarioName+"_"+fileName+ ".jpg";

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
					p.SetPreference("browser.download.folderList",2);
					p.SetPreference("browser.download.manager.showWhenStarting", false);
					p.SetPreference("browser.download.dir", RBTConfiguration.Default.DownloadPath.ToUpper());
					p.SetPreference("browser.helperApps.neverAsk.saveToDisk", RBTConfiguration.Default.AutoSaveMimeTypes);
			
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



		/// <summary>
		/// returns the last download file's full name
		/// </summary>
		/// <returns></returns>
		public static void WatchForDownload()
		{
			if (_watchingForDownload)
			{
				throw new Exception("Only 1 download task can be watched at a time.");
			}
			_watchingForDownload = true;
			_downloadedFile = null;

			// Create a new FileSystemWatcher and set its properties.
			FileSystemWatcher watcher = new FileSystemWatcher();
			watcher.Path = RBTConfiguration.Default.DownloadPath;

			/* Watch for changes in LastAccess and LastWrite times, and 
			   the renaming of files or directories. */
			watcher.NotifyFilter = NotifyFilters.LastAccess | NotifyFilters.LastWrite
			   | NotifyFilters.FileName | NotifyFilters.DirectoryName;

			watcher.IncludeSubdirectories = false;

			// Only watch text files.
			watcher.Filter = "*.*";

			// Add event handlers.

			watcher.Created += new FileSystemEventHandler(watcher_Created);

			
			// Begin watching.
			watcher.EnableRaisingEvents = true; 
		}

		static void watcher_Created(object sender, FileSystemEventArgs e)
		{
			//ignore this temp file created by firefox
			if (Path.GetExtension(e.FullPath)==".part")
			{
				return;
			}
			_downloadedFile = new FileInfo(e.FullPath);
		}

		public static FileInfo WaitForDownloadFinish()
		{
			while (_downloadedFile == null)
			{
				Thread.Sleep(500);
			}

			_watchingForDownload = false;

			return _downloadedFile;
		}


        /// <summary>
        /// Delete all files in the download path
        /// </summary>
        private static void DeleteAllDownloadFiles()
        {
            List<String> createdFiles = Directory.GetFiles(RBTConfiguration.Default.DownloadPath).ToList();
            foreach (String filePath in createdFiles)
                if (!filePath.EndsWith("placeholder.txt"))
                    File.Delete(filePath);
        }

        /// <summary>
        /// Delete all directories in the download path
        /// </summary>
        private static void DeleteAllDownloadDirectories()
        {
            List<String> createdDirectories = Directory.GetDirectories(RBTConfiguration.Default.DownloadPath).ToList();
            foreach (String directoryPath in createdDirectories)
                Directory.Delete(directoryPath, true);
        }

        /// <summary>
        /// Delete all temporary upload files
        /// </summary>
        private static void DeleteFilesInTemporaryUploadDirectories()
        {
            List<String> temporaryFolders = Directory.GetDirectories(RBTConfiguration.Default.UploadPath, "*", SearchOption.AllDirectories).ToList()
                .Where(x => x.EndsWith("Temporary")).ToList();
            List<String> temporaryUploadFiles = new List<string>();
            foreach(String temporaryFolder in temporaryFolders)
                temporaryUploadFiles.AddRange(Directory.GetFiles(temporaryFolder).ToList());

            foreach (String filePath in temporaryUploadFiles)
                if (!filePath.EndsWith("placeholder.txt"))
                    File.Delete(filePath);
        }

        /// <summary>
        /// Delete all files created since the feature file began running
        /// </summary>
        /// <returns></returns>
        private static void DeleteCreatedFiles()
        {
            List<String> createdFiles = Directory.GetFiles(RBTConfiguration.Default.DownloadPath).ToList();
            foreach(String filePath in createdFiles)
            {
                DateTime lastWriteTime = File.GetLastWriteTime(filePath);
                if (lastWriteTime >= CurrentFeatureStartTime)
                    if (!filePath.EndsWith("placeholder.txt"))
                        File.Delete(filePath);
            }
        }

        /// <summary>
        /// Delete all directories created since the feature file began running
        /// </summary>
        /// <returns></returns>
        private static void DeleteCreatedDirectories()
        {
            List<String> createdDirectories = Directory.GetDirectories(RBTConfiguration.Default.DownloadPath).ToList();
            foreach (String directoryPath in createdDirectories)
            {
                DateTime lastWriteTime = File.GetLastWriteTime(directoryPath);
                if (lastWriteTime >= CurrentFeatureStartTime)
                {
                    Directory.Delete(directoryPath, true);
                }
            }
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
				if (CurrentPage == null)
					return new EmptyPOFactory();
				if (_POFactory == null)
				{
					Type factoryType = CurrentPage.GetType()
						.Assembly
						.GetTypes()
						.FirstOrDefault(x => x.GetInterface("IPageObjectFactory") != null && !x.IsAbstract) ;
					_POFactory = Activator.CreateInstance(factoryType) as IPageObjectFactory;
				}
				return _POFactory;
			}
		}
	}
}
