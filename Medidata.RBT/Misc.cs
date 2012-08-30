﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;
using ICSharpCode.SharpZipLib.Zip;

namespace Medidata.RBT
{
	public class Misc
	{

		/// <summary>
		/// Unzip all zip files in the download path provided in the app.config returns a list of the extracted files' paths.
		/// </summary>
		public static List<String> UnzipAllDownloads()
		{
			List<String> extractedFilePaths = new List<string>();
			List<String> zipFilePaths = Directory.GetFiles(TestContext.DownloadPath, "*.zip").ToList();
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
					ZipEntry currentEntry = zipInputStream.GetNextEntry();
					String fullZipToPath = "";
					if (TestContext.DownloadPath.EndsWith("\\"))
						fullZipToPath = TestContext.DownloadPath + currentEntry.Name.Replace("/", "\\");
					else
						fullZipToPath = TestContext.DownloadPath + "\\" + currentEntry.Name.Replace("/", "\\");

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

			return extractedFilePaths;
		}


	}
}
