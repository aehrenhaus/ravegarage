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
using System.Reflection;
using System.Drawing;
using System.Collections;


namespace Medidata.RBT
{
	/// <summary>
	/// This class represent a Selenium web test.
	/// All PO should know their context( through IPaeg.Context property).
	/// 
	/// WebTestContext should be ignorant of specflow test
	/// </summary>
	public class WebTestContext
	{
		#region Some context variables that may be used durnig test.

		public WebTestContext()
		{
			Storage = new Hashtable();
			POFactory = new PageObjectFactory(this);
			string assemPath = Path.Combine(AppDomain.CurrentDomain.BaseDirectory, RBTConfiguration.Default.POAssembly);
			var assem = Assembly.LoadFile( assemPath);
			POFactory.AddAssembly(assem);
			
		}

		public FileInfo LastDownloadedFile { get; set; }

		public FileInfo FileToUpload
		{
			get;
			set;
		}

		public IPage CurrentPage
		{
			get;
			set;
		}

		public string CurrentUser
		{
			get;
			set;
		}

		public string CurrentUserPassword
		{
			get;
			set;
		}

		public Hashtable Storage { get; set; } 



		public RemoteWebDriver Browser { get; set; }


		public PageObjectFactory POFactory
		{
			get;
			private set;
		}



		#endregion



		#region watching file download

		public DownloadFileWatcher WatchForDownload()
		{
			return new DownloadFileWatcher(this);
		}

		/// <summary>
		/// Start to watch over the target folder, till some file created in the folder.
		/// </summary>
		public class DownloadFileWatcher :IDisposable
		{
			private WebTestContext context;
			internal  DownloadFileWatcher(WebTestContext context, string path = null)
			{
				if (path == null)
					path = RBTConfiguration.Default.DownloadPath;
				this.context = context;
				WatchForDownload(path);
			}

			public FileInfo WaitForFile()
			{
				return WaitForDownloadFinish();
			}

			/// <summary>
			/// If user does not call WaitForFile or Dispose, GC will call it to make sure file watcher is disposed.
			/// </summary>
			public void Dispose()
			{
				WaitForDownloadFinish();
			}

			//the system can only watch for 1 download for a time, this flag indicates whether a download is being watched.
			private bool _watchingForDownload;
			private FileInfo _lastDownloadedFile;


			private void WatchForDownload(string path)
			{
				if (_watchingForDownload)
				{
					throw new Exception("Only 1 download task can be watched at a time.");
				}
				_watchingForDownload = true;
				_lastDownloadedFile = null;

				// Create a new FileSystemWatcher and set its properties.
				FileSystemWatcher watcher = new FileSystemWatcher();
				watcher.Path = path;

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

			private void watcher_Created(object sender, FileSystemEventArgs e)
			{
				//ignore this temp file created by firefox
				if (Path.GetExtension(e.FullPath) == ".part")
				{
					return;
				}
				_lastDownloadedFile = new FileInfo(e.FullPath);
				(sender as FileSystemWatcher).Dispose();
			}

			private FileInfo WaitForDownloadFinish()
			{
				if (_watchingForDownload == false)
					return null;

				while (_lastDownloadedFile == null)
				{
					Thread.Sleep(500);
				}

				_watchingForDownload = false;
				context.LastDownloadedFile = _lastDownloadedFile;
				return _lastDownloadedFile;
			}
		
		}


		#endregion

		#region Open/close browsers / Screenshot /Report generation


		public void CloseBrowser()
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
		public void OpenBrowser(string browserName = null)
		{
			if (Browser == null)
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
						p.SetPreference("browser.download.folderList", 2);
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

				Browser = _webdriver;
			}

		}


		public Image TrySaveScreenShot()
		{

			if (Browser is ITakesScreenshot)
			{
				MemoryStream stream = new MemoryStream();
                Browser.WaitForDocumentLoad();
				var bytes = ((ITakesScreenshot)Browser).GetScreenshot().AsByteArray;
				stream.Write(bytes,0,bytes.Length);
				return Image.FromStream(stream);
			}
			return null;
		}


		#endregion 

		#region Remove temp files



        /// <summary>
        /// Delete all temporary upload files
        /// </summary>
		public void ClearTempFiles()
        {
			try
			{
				List<String> temporaryFolders = Directory.GetDirectories(RBTConfiguration.Default.UploadPath, "*", SearchOption.AllDirectories).ToList()
					.Where(x => x.EndsWith("Temporary")).ToList();
				List<String> temporaryUploadFiles = new List<string>();
				foreach (String temporaryFolder in temporaryFolders)
					temporaryUploadFiles.AddRange(Directory.GetFiles(temporaryFolder).ToList());

				foreach (String filePath in temporaryUploadFiles)
					if (!filePath.EndsWith("placeholder.txt"))
						File.Delete(filePath);
			}
			catch
			{
				Console.WriteLine("-> ClearTempFiles failed");
			}
        }

        /// <summary>
        /// Delete all files created since the feature file began running
        /// </summary>
        /// <returns></returns>
		public void ClearDownloads()
        {
			try
			{
				var downloadDir = new DirectoryInfo(RBTConfiguration.Default.DownloadPath);
				foreach (var file in downloadDir.GetFiles())
				{
					if (file.Name != "placeholder.txt")
						file.Delete();
				}
				foreach (var sub in downloadDir.GetDirectories())
				{
					sub.Delete(true);
				}

			}
			catch
			{
				Console.WriteLine("-> ClearDownloads failed");
			}
        }

		#endregion

	}
}
