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
		#region Some context variables that may be used durnig test.

		//System console writer. MSTest will set it to it's own writer, but we will wrap the MSTest's writer inside this writer 
		//so we can output to both MSTest result and console @ runtime 
		private static MultipleStreamWriter consoleWriter;


		public static FileInfo LastDownloadFile
		{
			get
			{
				return _downloadedFile;
			}
		}

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
		/// A variable holding temp string during scenario?? 
		/// </summary>
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

		public static RemoteWebDriver Browser { get; set; }


		private static IPageObjectFactory _POFactory;
		public static IPageObjectFactory POFactory
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
						.FirstOrDefault(x => x.GetInterface("IPageObjectFactory") != null && !x.IsAbstract);
					_POFactory = Activator.CreateInstance(factoryType) as IPageObjectFactory;
				}
				return _POFactory;
			}
		}

		public static SeedingOptions DefaultSeedingOption { get; set; }

		public static SeedingOptions FeatureSeedingOption { get; set; }

		#endregion


		#region Test setup and tear down

		/// <summary>
		/// After whole test
		/// </summary>
		[AfterTestRun]
		public static void TestTearDown()
		{


			if (RBTConfiguration.Default.AutoCloseBrowser)
				CloseBrower();

			GernerateReport();
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

	
			DefaultSeedingOption = new SeedingOptions(
				RBTConfiguration.Default.EnableSeeding,
				RBTConfiguration.Default.SeedFromBackendClasses,
				 RBTConfiguration.Default.SuppressSeeding);

			SpecialStringHelper.Replaced += new Action<string, string>((input, output) =>
			{
				Console.WriteLine("-> replace --> " + input + " --> " + output);
			});
		}

		/// <summary>
		/// Before each feature
		/// </summary>
		[BeforeFeature()]
		public static void BeforeFeature()
		{

			Storage.FeatureValues.Clear();
			HandleFeatureTags();
			CurrentFeatureStartTime = DateTime.Now;
            DraftCounter.ResetCounter();
		}

		private static void HandleFeatureTags()
		{
			string backend = null;
			string suppress = null;
			bool enable = false;
			bool hasSettings = false;

			foreach (var featureTag in FeatureContext.Current.FeatureInfo.Tags)
			{
				string[] parts = featureTag.Split('=');
				if (parts.Length != 2)
					continue;

				if (parts[0] == "SeedFromBackendClasses")
				{
					backend = parts[1];
					hasSettings = true;
				}
				else if (parts[0] == "SuppressSeeding")
				{
					suppress = parts[1];
					hasSettings = true;
				}
				else if (parts[0] == "EnableSeeding")
				{
					bool.TryParse(parts[1], out enable);
					hasSettings = true;
				}
			}

			//Feature will use either all default settings from config , or all settings from feature tag.
			//there is no cascading here.
			//If there are any seeding settings on the feature, then feature will use feature level setting instead of global settings

			if(hasSettings)
				FeatureSeedingOption = new SeedingOptions(enable, backend, suppress);
		}

		/// <summary>
		/// After each feature
		/// </summary>
		[AfterFeature()]
		public static void AfterFeature()
		{
			FeatureSeedingOption = null;
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
            TestContext.CurrentUser = null;

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

			SetOutput();

			Console.WriteLine("-------------> Scenario:" + ScenarioName);
			Console.WriteLine();
		}

		private void SetOutput()
		{
			if (consoleWriter == null)
			{
				consoleWriter = new MultipleStreamWriter();
				var extraConsole = ExtraConsoleWriterSetup.GetConsoleWriter();
				consoleWriter.AddStreamWriter(new FilteredWriter(extraConsole));

				//the previous Console.Out has already been redirect to MSTest output, add it back to multiple output writer, so we still see results from MSTest


			}
			if (consoleWriter.InnerWriters.Count == 2)
				consoleWriter.InnerWriters.RemoveAt(1);
			consoleWriter.AddStreamWriter(Console.Out);
			Console.SetOut(consoleWriter);
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

		#endregion

		#region watching file download

		//the system can only watch for 1 download for a time, this flag indicates whether a download is being watched.
		private static bool _watchingForDownload;

		//last downloaded file.
		private static FileInfo _downloadedFile;

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
			if (Path.GetExtension(e.FullPath) == ".part")
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
		#endregion

		#region Open/close browsers / Screenshot /Report generation

		private static void OpenBrower()
		{
			if (Browser == null)
			{
				Browser = OpenBrowser();
			}
		}


		private static void CloseBrower()
		{
			//Close browser
			if (Browser != null)
			{
                foreach (string winHandle in Browser.WindowHandles)
                {
                    IWebDriver window = Browser.SwitchTo().Window(winHandle);
                    window.Close();
                }
                Browser = null;
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

		private static void GernerateReport()
		{
	
										   System.Diagnostics.Process p = new System.Diagnostics.Process();

#if DEBUG
										   p.StartInfo = new System.Diagnostics.ProcessStartInfo(
											   @"powershell.exe",
										   "-NoExit ../../../reportGen.ps1");
										   p.Start();
										   //p.WaitForExit();
#else
				p.StartInfo = new System.Diagnostics.ProcessStartInfo(
				@"powershell.exe",
			"../../../reportGen.ps1");
			p.Start();
#endif

				     
	
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
					fileName = ScenarioName + "_" + fileName + ".jpg";

					Console.WriteLine("img->" + fileName);
					Console.WriteLine("->" + Browser.Url);
					//file path
					string screenshotPath = Path.Combine(resultPath, fileName);

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


		#endregion 

		#region Remove temp files


		/// <summary>
        /// Delete all files in the download path
        /// </summary>
        private static void DeleteAllDownloadFiles()
        {
            List<String> createdFiles = Directory.GetFiles(RBTConfiguration.Default.DownloadPath).ToList();
            foreach (String filePath in createdFiles)
				if (!filePath.EndsWith("placeholder.txt"))
				{
					//supress the error when the file is locked by excel process.

					try
					{
						File.Delete(filePath);
					}
					catch (Exception)
					{

					}
				}
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

		#endregion

	}
}
