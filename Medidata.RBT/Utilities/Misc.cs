using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;
using ICSharpCode.SharpZipLib.Zip;
using System.Threading;

namespace Medidata.RBT
{
	public class Misc
	{

		/// <summary>
		/// Unzip all zip files in the download path provided in the app.config returns a list of the extracted files' paths.
		/// </summary>
		public static List<String> UnzipAllDownloads()
		{
            Thread.Sleep(5000);
			List<String> extractedFilePaths = new List<string>();
			List<String> zipFilePaths = Directory.GetFiles(RBTConfiguration.Default.DownloadPath, "*.zip").ToList();
			foreach (String zipFilePath in zipFilePaths)
				extractedFilePaths.AddRange(UnZipAndExtract(zipFilePath));

			return extractedFilePaths;
		}

		/// <summary>
		///Unzips a zip file.
		///<param name="zipFilePath">File path of the object to be unzipped. (e.g. c:/folder1/folder2/mysuperawesomefile.zip)</param>
		///<returns>A list of the extracted files' file paths.</returns>
		///</summary>
		private static List<String> UnZipAndExtract(string zipFilePath)
		{
			List<String> extractedFilePaths = new List<string>();

			using (FileStream fileStreamIn = new FileStream(zipFilePath, FileMode.Open))
			{
				using (ZipInputStream zipInputStream = new ZipInputStream(fileStreamIn))
				{
                    ZipEntry currentEntry = null;
                    while((currentEntry = zipInputStream.GetNextEntry()) != null)
                    {
                        String fullZipToPath = "";
                        if (RBTConfiguration.Default.DownloadPath.EndsWith("\\"))
                            fullZipToPath = RBTConfiguration.Default.DownloadPath + currentEntry.Name.Replace("/", "\\");
                        else
                            fullZipToPath = RBTConfiguration.Default.DownloadPath + "\\" + currentEntry.Name.Replace("/", "\\");

                        string directoryName = Path.GetDirectoryName(fullZipToPath);
                        if (directoryName.Length > 0)
                            Directory.CreateDirectory(directoryName);

                        using (FileStream fileStreamOut = new FileStream(fullZipToPath, FileMode.Create, FileAccess.Write))
                        {
                            int size;
                            byte[] buffer = new byte[4096];
                            do
                            {
                                size = zipInputStream.Read(buffer, 0, buffer.Length);
                                fileStreamOut.Write(buffer, 0, size);
                            } while (size > 0);
                        }
                        extractedFilePaths.Add(fullZipToPath);
                    }
				}
			}

			return extractedFilePaths;
		}

		/// <summary>
		/// Calls Func&lt;T&gt; action N times, where N is given by tries parameter, or untill Func&lt;T, bool&gt; predicate returns true.
		/// </summary>
		/// <typeparam name="T"></typeparam>
		/// <param name="action">Action to be performed. Cannot be null.</param>
		/// <param name="predicate">Predicate to validate the result of action argument. Cannot be null.</param>
		/// <param name="tries">Number of tries to attempt to call action delegate.</param>
		/// <returns>Value returned by action delegate.</returns>
		public static T SafeCall<T>(Func<T> action, Func<T, bool> predicate, uint tries = 1)
		{
			T result;

			do
			{
				result = action();
				tries--;
			}
			while (!predicate(result) && tries > 0);

			return result;
		}

		/// <summary>
		/// Calls Func&lt;T&gt; action within a timespan window or untill Func&lt;T, bool&gt; predicate returns true.
		/// </summary>
		/// <typeparam name="T"></typeparam>
		/// <param name="action">Action to be performed. Cannot be null.</param>
		/// <param name="predicate">Predicate to validate the result of action argument. Cannot be null.</param>
		/// <param name="window">TimeSpan window durring which a call to action delegate is repeatedly attempted.</param>
		/// <returns>Value returned by action delegate.</returns>
		public static T SafeCall<T>(Func<T> action, Func<T, bool> predicate, TimeSpan window)
		{
			T result;

			do
			{
				var start = DateTime.Now.Ticks;

				result = action();
				Thread.Sleep(window.Milliseconds / 10);

				var end = DateTime.Now.Ticks;

				var delta = TimeSpan.FromTicks(end - start);
				window = window - delta;
			}
			while (!predicate(result) && window.Milliseconds > 0);

			return result;
		}
	}
}
