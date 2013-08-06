using System;
using System.Collections;
using System.Collections.Generic;
using System.Configuration;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Threading;
using Medidata.RBT.SeleniumExtension;
using Medidata.RBT.ConfigurationHandlers;

using OpenQA.Selenium;
using OpenQA.Selenium.Remote;


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
        IWebBrowser _webBrowser;

		#region Some context variables that may be used durnig test.

		public WebTestContext()
		{
			Storage = new Hashtable();
			POFactory = new PageObjectFactory(this);
            var assem = Assembly.Load(RBTConfiguration.Default.POAssembly);
			POFactory.AddAssembly(assem);
			
		}

        private void ResolveBrowser()
        {
            BrowserNames browserEnum;

            browserEnum = (BrowserNames)Enum.Parse(typeof(BrowserNames), RBTConfiguration.Default.BrowserName.ToLower());

            _webBrowser = ((IBrowserFactory)RBTModule.Instance.Container.Resolve(typeof(IBrowserFactory), ""))
                .CreateWebBrowser(browserEnum);
        }

		public FileInfo LastDownloadedFile { get; set; }

        public RBT.BaseEnhancedPDF LastLoadedPDF { get; set; }

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
				Console.WriteLine("-> [{0}] -> In DownloadFileWatcher.WaitForFile()", DateTime.Now.ToString("hh:mm:ss.fff"));
				return WaitForDownloadFinish();
			}

			/// <summary>
			/// If user does not call WaitForFile or Dispose, GC will call it to make sure file watcher is disposed.
			/// </summary>
			public void Dispose()
			{
				Console.WriteLine("-> [{0}] -> In DownloadFileWatcher.Dispose()", DateTime.Now.ToString("hh:mm:ss.fff"));
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
				Console.WriteLine("-> [{0}] -> In DownloadFileWatcher.watcher_Created()", DateTime.Now.ToString("hh:mm:ss.fff"));

				const string partExt = ".part";

				var ext = Path.GetExtension(e.FullPath);
				var partial = ext.Equals(partExt)
					? e.FullPath
					: e.FullPath + partExt;

				//ignore this temp file created by firefox
				if (ext == partExt)
				{
					Console.WriteLine("-> [{0}] -> In DownloadFileWatcher.watcher_Created() -> File extension is .part -> exitting", DateTime.Now.ToString("hh:mm:ss.fff"));
					return;
				}
				else
				{
					Console.WriteLine("-> [{0}] -> In DownloadFileWatcher.watcher_Created() -> File extension is NOT .part", DateTime.Now.ToString("hh:mm:ss.fff"));
					
					//Wait untill the final downloaded file is fully converted from .part file by firefox
					Func<bool> check = () =>
					{
						Console.WriteLine("-> [{0}] -> In DownloadFileWatcher.watcher_Created() -> Anonymous Func<bool> -> Checking if [{1}] file exists", DateTime.Now.ToString("hh:mm:ss.fff"), partial);
						var result = !File.Exists(partial);

						if(result)
							Console.WriteLine("-> [{0}] -> In DownloadFileWatcher.watcher_Created() -> Anonymous Func<bool> -> File [{1}] no longer exists", DateTime.Now.ToString("hh:mm:ss.fff"), partial);
						else
							Console.WriteLine("-> [{0}] -> In DownloadFileWatcher.watcher_Created() -> Anonymous Func<bool> -> File [{1}] still exists", DateTime.Now.ToString("hh:mm:ss.fff"), partial);

						return result;
					};

					
					var timeout = RBTConfiguration.Default.DownloadTimeout * 1000;	//Timeput in milliseconds
					Console.WriteLine("-> [{0}] -> In DownloadFileWatcher.watcher_Created() -> Configured timeout is [{1}] in ms", DateTime.Now.ToString("hh:mm:ss.fff"), timeout);

					Console.WriteLine("-> [{0}] -> In DownloadFileWatcher.watcher_Created() -> Start waiting for .part file to be deleted", DateTime.Now.ToString("hh:mm:ss.fff"));
					if (this.Wait(check, timeout, 100))
					{
						Console.WriteLine("-> [{0}] -> In DownloadFileWatcher.watcher_Created() -> _lastDownloadedFile is [{1}]", DateTime.Now.ToString("hh:mm:ss.fff"), e.FullPath);
						_lastDownloadedFile = new FileInfo(e.FullPath);
						(sender as FileSystemWatcher).Dispose();
					}
				}
			}

			private FileInfo WaitForDownloadFinish()
			{
				Console.WriteLine("-> [{0}] -> In DownloadFileWatcher.WaitForDownloadFinish()", DateTime.Now.ToString("hh:mm:ss.fff"));

				if (_watchingForDownload == false)
				{
					Console.WriteLine("-> [{0}] -> In DownloadFileWatcher.WaitForDownloadFinish() -> _watchingForDownload == false -> returning null", DateTime.Now.ToString("hh:mm:ss.fff"));
					return null;
				}

				var timeout = RBTConfiguration.Default.DownloadTimeout * 1000;	//Timeput in milliseconds
				Console.WriteLine("-> [{0}] -> In DownloadFileWatcher.WaitForDownloadFinish() -> Configured timeout is [{1}] in ms", DateTime.Now.ToString("hh:mm:ss.fff"), timeout);

				Func<bool> check = () =>
				{
					Console.WriteLine("-> [{0}] -> In DownloadFileWatcher.WaitForDownloadFinish() -> Anonymous Func<bool> -> Checking if _lastDownloadedFile != null", DateTime.Now.ToString("hh:mm:ss.fff"));
					var result = _lastDownloadedFile != null;
					if(result)
						Console.WriteLine("-> [{0}] -> In DownloadFileWatcher.WaitForDownloadFinish() -> Anonymous Func<bool> -> _lastDownloadedFile != null", DateTime.Now.ToString("hh:mm:ss.fff"));
					else
						Console.WriteLine("-> [{0}] -> In DownloadFileWatcher.WaitForDownloadFinish() -> Anonymous Func<bool> -> _lastDownloadedFile == null", DateTime.Now.ToString("hh:mm:ss.fff"));

					return result;
				};

				if (!this.Wait(check, timeout, 100))
					throw new TimeoutException("File download is taking too long");

				_watchingForDownload = false;
				context.LastDownloadedFile = _lastDownloadedFile;
				return _lastDownloadedFile;
			}

			private bool Wait(Func<bool> action, int timeout, int tries)
			{
				Console.WriteLine("-> [{0}] -> In DownloadFileWatcher.Wait()", DateTime.Now.ToString("hh:mm:ss.fff"));
				Console.WriteLine("-> [{0}] -> In DownloadFileWatcher.Wait() -> timeout param is [{1}] in ms", DateTime.Now.ToString("hh:mm:ss.fff"), timeout);
				Console.WriteLine("-> [{0}] -> In DownloadFileWatcher.Wait() -> tries param is [{1}]", DateTime.Now.ToString("hh:mm:ss.fff"), tries);

				timeout = timeout < tries ? tries : timeout;
				Console.WriteLine("-> [{0}] -> In DownloadFileWatcher.Wait() -> timeout (calculated) is [{1}] in ms", DateTime.Now.ToString("hh:mm:ss.fff"), timeout);
				var interval = (int)Math.Round((double)timeout / tries, 0);
				Console.WriteLine("-> [{0}] -> In DownloadFileWatcher.Wait() -> interval is [{1}] in ms", DateTime.Now.ToString("hh:mm:ss.fff"), interval);

				var counter = 0;
				var result = action();
				Console.WriteLine("-> [{0}] -> In DownloadFileWatcher.Wait() -> result (after first action() call) is [{1}]", DateTime.Now.ToString("hh:mm:ss.fff"), result);

				while (!result && counter <= timeout)
				{
					result = action();
					Thread.Sleep(interval);
					counter += interval;

					Console.WriteLine("-> [{0}] -> In DownloadFileWatcher.Wait() -> while loop -> counter is [{1}]", DateTime.Now.ToString("hh:mm:ss.fff"), counter);
					Console.WriteLine("-> [{0}] -> In DownloadFileWatcher.Wait() -> while loop -> result is [{1}]", DateTime.Now.ToString("hh:mm:ss.fff"), result);
				}

				return result;
			}
		
		}


		#endregion

		#region Open/close browsers / Screenshot /Report generation


		public void CloseBrowser()
		{
			//Close browser
			if (Browser != null)
			{
                try
                {
                    Browser.Quit(); //close all the open windows and calls dispose so temp profile is deleted
                }
                finally
                {
                    Browser = null;
                }
			}
		}


		/// <summary>
		/// Open a brower according to configuration
		/// </summary>
		/// <param name="browserName"></param>
		/// <returns></returns>
		public void OpenBrowser()
		{
			if (Browser == null)
			{
                ResolveBrowser();

				RemoteWebDriver webdriver = null;
					
				const int maxAttempts = 5;	//Number of times to try to create the FirefoxDriver without WebDriverException being thrown.
						
				webdriver = Misc.SafeCall(() =>
				{
					RemoteWebDriver result = null;
					try
					{
                        //Only use remote web browser when selenium server url is string is specified
                        //as we would be using selenium's grid capabilities else just create an insatnce of specific browser
						if (string.IsNullOrWhiteSpace(RBTConfiguration.Default.SeleniumServerUrl))
                            result = _webBrowser.CreateLocalWebDriver();
						else
                            result = _webBrowser.CreateRemoteWebDriver();
					}
					catch (WebDriverException wdex)
					{
						Console.WriteLine("-> WebTestContext.OpenBrowser failed while attempting to instantiate FirefoxDriver");
						Console.WriteLine(string.Format("-> WebDriverException was : {0}", wdex.Message));
						if (result != null)
						{
							Console.WriteLine("-> WebTestContext.OpenBrowser -> result was not null -> attempting call result.Quit()");
							result.Quit();
						}
						else
						{
							Console.WriteLine("-> WebTestContext.OpenBrowser -> result was null");
						}

						result = null;
					}

					return result;
				},
				(driver) => driver != null,
				maxAttempts);

				if (webdriver == null)
					throw new WebDriverException(string.Format("-> WebTestContext.OpenBrowser -> Unable to create FirefoxDriver instance after [{0}] attempts", maxAttempts));

                    

				Browser = webdriver;
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
        /// Delete all files created by previous scenarios
        /// </summary>
        /// <returns></returns>
		public void ClearDownloads()
        {
			try
			{
				var downloadDir = new DirectoryInfo(RBTConfiguration.Default.DownloadPath);
                foreach (var sub in downloadDir.GetDirectories())
                {
                    sub.Delete(true);
                }
				foreach (var file in downloadDir.GetFiles())
				{
					if (file.Name != "placeholder.txt")
						file.Delete();
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
