﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;
using ICSharpCode.SharpZipLib.Zip;
using System.Net;
using System.Security.Principal;
using System.Runtime.InteropServices; // DllImport
using System.Security.Permissions;
using System.DirectoryServices;
using System.DirectoryServices.AccountManagement;
using ICSharpCode.SharpZipLib.Checksums;
using System.Data;

namespace Medidata.RBT
{
	/// <summary>
	/// Class for general file functionality.
	/// </summary>
	public static class BuUploadFileHelper
	{
		#region Public Methods

		/// <summary>
		/// Unzips the file
		/// </summary>
		/// <param name="fileLoc">full path to the file to be unzipped</param>
		///   <returns>full path to the unzipped file</returns>
		public static string UnZipFile(string fileLoc)
		{
			if (!File.Exists(fileLoc)) throw new Exception(String.Format("File: {0} doesn't exist", fileLoc));

			FileInfo fi = new FileInfo(fileLoc);
			string dirPath = fi.DirectoryName;
			string fileOutName = string.Empty;

			using (FileStream fileStreamIn = new FileStream(fileLoc, FileMode.Open, FileAccess.Read))
			{
				using (ZipInputStream zipInStream = new ZipInputStream(fileStreamIn))
				{
					ZipEntry currentEntry = zipInStream.GetNextEntry();
					while (currentEntry != null)
					{
						fileOutName = dirPath + @"\" + currentEntry.Name;

						using (FileStream fileStreamOut = new FileStream(fileOutName, FileMode.Create, FileAccess.Write))
						{
							int size;
							byte[] buffer = new byte[4096];
							do
							{
								size = zipInStream.Read(buffer, 0, buffer.Length);
								fileStreamOut.Write(buffer, 0, size);
							} while (size > 0);
						}
						currentEntry = zipInStream.GetNextEntry();
					}
				}
			}
			return fileOutName;
		}

		/// <summary>
		/// zips the files in current folder
		/// </summary>
		/// <param name="fileLoc">full path to the file to be unzipped</param>
		///   <returns>full path to the unzipped file</returns>
		public static string ZipFiles(string sourceDirectoryName)
		{
			string zipOutputFileName = string.Format("{0}\\{1}", sourceDirectoryName, "test.zip");
			if (!Directory.Exists(sourceDirectoryName)) throw new Exception(String.Format("Directory: {0} doesn't exist", sourceDirectoryName));
			if (Directory.GetFiles(sourceDirectoryName).Length <= 0) throw new Exception(String.Format("No files in Directory: {0} doesn't exist", sourceDirectoryName));

			DirectoryInfo sourceDirectory = null;
			try
			{
				sourceDirectory = new DirectoryInfo(sourceDirectoryName);
			}
			catch
			{
				throw;
			}

			using (FileStream tempFileStream = new FileStream(zipOutputFileName, FileMode.OpenOrCreate, FileAccess.ReadWrite, FileShare.None))
			using (ZipOutputStream zipOutput = new ZipOutputStream(tempFileStream))
			{
				// Zip with highest compression.
				zipOutput.SetLevel(9);
				Crc32 crc = new Crc32();
				FileInfo[] fileInfos = sourceDirectory.GetFiles();
				foreach (FileInfo fileInfo in fileInfos)
				{
					if (fileInfo.FullName.Equals(zipOutputFileName))
					{
						continue;
					}

					using (FileStream fileStream = new FileStream(fileInfo.FullName, FileMode.Open, FileAccess.Read, FileShare.Read))
					{
						// Read full stream to in-memory buffer.
						byte[] buffer = new byte[fileStream.Length];
						fileStream.Read(buffer, 0, buffer.Length);
						// Create a new entry for the current file.
						ZipEntry entry = new ZipEntry(fileInfo.Name);
						entry.DateTime = DateTime.Now;

						// set Size and the crc, because the information
						// about the size and crc should be stored in the header
						// if it is not set it is automatically written in the footer.
						// (in this case size == crc == -1 in the header)
						// Some ZIP programs have problems with zip files that don't store
						// the size and crc in the header.
						entry.Size = fileStream.Length;
						fileStream.Close();

						// Reset and update the crc.
						crc.Reset();
						crc.Update(buffer);

						// Update entry and write to zip stream.
						entry.Crc = crc.Value;
						zipOutput.PutNextEntry(entry);
						zipOutput.Write(buffer, 0, buffer.Length);

						// Get rid of the buffer, because this
						// is a huge impact on the memory usage.
						buffer = null;
					}
				}

				// Finalize the zip output.
				zipOutput.Finish();

				// Flushes the create and close.
				zipOutput.Flush();
				zipOutput.Close();
			}

			return zipOutputFileName;
		}

		public static void UploadFileUsingFtp(string ftpsource, string ftpTarget, string ftpUserName, string ftpPassword, string ftpMode)
		{
			// Get the object used to communicate with the server.
			FtpWebRequest request = (FtpWebRequest)WebRequest.Create(ftpTarget);
			request.Method = WebRequestMethods.Ftp.UploadFile;
			request.Credentials = new NetworkCredential(ftpUserName, ftpPassword);
			if (ftpMode.Equals("binary", StringComparison.OrdinalIgnoreCase))
			{
				request.UseBinary = true;
			}
			// Copy the contents of the file to the request stream.
			byte[] fileContents = File.ReadAllBytes(ftpsource);//haven't tested the ascii mode
			request.ContentLength = fileContents.Length;

			using (Stream requestStream = request.GetRequestStream())
			{
				requestStream.Write(fileContents, 0, fileContents.Length);
			}

			FtpWebResponse response = (FtpWebResponse)request.GetResponse();

			Console.WriteLine("Upload File Complete, status {0}", response.StatusDescription);

			response.Close();
		}

		public static void CopyFilesFromSourceDirectoryToTargetDirectory(string sourceDirectoryName, string targetDirectoryName)
		{
			DirectoryInfo sourceDirectory = null;
			try
			{
				sourceDirectory = new DirectoryInfo(sourceDirectoryName);
			}
			catch
			{
				throw;
			}

			FileInfo[] fileInfos = sourceDirectory.GetFiles();
			if (fileInfos != null)
			{
				foreach (FileInfo fileInfo in fileInfos)
				{
					try
					{
						fileInfo.CopyTo(string.Format("{0}\\{1}", targetDirectoryName, fileInfo.Name), true);
					}
					catch
					{
						throw;
					}
				}
			}
		}

		//note: userName, password, and domain in plain text; dangerous******************
		public static void CopyFilesFromSourceDirectoryToTargetDirectoryWithImpersonation(string sourceDirectoryName, string targetDirectoryName, string username, string password, string domain)
		{
			IntPtr tokenHandle = IntPtr.Zero;
			IntPtr duplicateTokenHandle = IntPtr.Zero;
			try
			{
				WindowsIdentity identity = ImpersonateUser(username, password, domain, out tokenHandle, out duplicateTokenHandle);
				using (WindowsImpersonationContext context = identity.Impersonate())
				{
					CopyFilesFromSourceDirectoryToTargetDirectory(sourceDirectoryName, targetDirectoryName);
				}
				identity.Dispose();
			}
			catch
			{
				throw;
			}
			finally
			{
				if (tokenHandle != IntPtr.Zero)
				{
					NativeMethods.CloseHandle(tokenHandle);
				}
				if (duplicateTokenHandle != IntPtr.Zero)
				{
					NativeMethods.CloseHandle(duplicateTokenHandle);
				}
			}
		}

		public static bool CheckFileProcessedInTargetDirectory(string fileName, string targetDirectoryName, int timeout)
		{
			DateTime dtExpiry = DateTime.Now.AddMinutes(timeout);
			bool found = false;

			while (DateTime.Now < dtExpiry)
			{
				found = false;
				DirectoryInfo targetDirectory = new DirectoryInfo(targetDirectoryName);
				FileInfo[] fileInfos = targetDirectory.GetFiles();
				if (fileInfos != null)
				{
					foreach (FileInfo fileInfo in fileInfos)
					{
						try
						{
							if (fileInfo.Name.StartsWith(fileName.Substring(0, fileName.LastIndexOf('.')), StringComparison.InvariantCultureIgnoreCase))
							{
								found = true;
								break;
							}
						}
						catch
						{
							throw;
						}
					}
				}
				if (found)
				{
					System.Threading.Thread.Sleep(60000);
				}
				else
				{
					break;
				}
			}
			return !found;
		}


		//note: userName, password, and domain in plain text; dangerous******************
		public static bool CheckFileProcessedInTargetDirectoryWithImpersonation(string fileName, string targetDirectoryName, int timeout, string username, string password, string domain)
		{
			IntPtr tokenHandle = IntPtr.Zero;
			IntPtr duplicateTokenHandle = IntPtr.Zero;

			bool processed = false;
			try
			{
				WindowsIdentity identity = ImpersonateUser(username, password, domain, out tokenHandle, out duplicateTokenHandle);
				using (WindowsImpersonationContext context = identity.Impersonate())
				{
					processed = CheckFileProcessedInTargetDirectory(fileName, targetDirectoryName, timeout);
				}
				identity.Dispose();
			}
			catch
			{
				throw;
			}
			finally
			{
				if (tokenHandle != IntPtr.Zero)
				{
					NativeMethods.CloseHandle(tokenHandle);
				}
				if (duplicateTokenHandle != IntPtr.Zero)
				{
					NativeMethods.CloseHandle(duplicateTokenHandle);
				}
			}
			return processed;

		}

		//note: userName, password, and domain in plain text; dangerous******************
		private static WindowsIdentity ImpersonateUser(string userName, string password, string domainName, out IntPtr tokenHandle, out IntPtr duplicateTokenHandle)
		{
			tokenHandle = IntPtr.Zero;
			duplicateTokenHandle = IntPtr.Zero;
			if ((domainName == null || domainName.Length == 0) && !userName.Contains("\\")) domainName = Dns.GetHostName();
			bool loginReturnValue = NativeMethods.LogonUser(userName, domainName, password, (int)NativeMethods.Constants.Win32LogonNewCredentials, (int)NativeMethods.Constants.Win32ProviderDefault, ref tokenHandle);
			if (!loginReturnValue)
			{
				int errorCode = Marshal.GetLastWin32Error();
				throw new Exception(string.Format("{0}", errorCode));
			}
			bool dupeReturnValue = NativeMethods.DuplicateToken(tokenHandle, (int)NativeMethods.Constants.SecurityImpersonation, ref duplicateTokenHandle);
			if (!dupeReturnValue)
			{
				int errorCode = Marshal.GetLastWin32Error();
				throw new Exception(string.Format("{0}", errorCode));
			}
			WindowsIdentity newId = new WindowsIdentity(duplicateTokenHandle);
			return newId;
		}

		private sealed class NativeMethods
		{
			public enum Constants : int
			{
				Win32ProviderDefault = 0,
				/// <summary>
				/// Interactive Logon.
				/// </summary>
				Win32LogonInteractive = 2,
				Win32LogonNewCredentials = 9,
				/// <summary>
				/// Security Impersonation.
				/// </summary>
				SecurityImpersonation = 2
			}


			#region Public Static Methods
			/// <summary>
			/// Log a user on to a windows domain.
			/// </summary>
			[return: MarshalAs(UnmanagedType.Bool)]
			[DllImport("advapi32.dll", SetLastError = true)]
			public static extern bool LogonUser(String lpszUsername, String lpszDomain, String lpszPassword, int dwLogonType, int dwLogonProvider, ref IntPtr phToken);

			/// <summary>
			/// Duplicate a token.
			/// </summary>
			[return: MarshalAs(UnmanagedType.Bool)]
			[DllImport("advapi32.dll", CharSet = CharSet.Auto, SetLastError = true)]
			public extern static bool DuplicateToken(IntPtr existingTokenHandle, int securityImpersonationLevel, ref IntPtr duplicateTokenHandle);

			[return: MarshalAs(UnmanagedType.Bool)]
			[DllImport("kernel32.dll", CharSet = CharSet.Auto)]
			public extern static bool CloseHandle(IntPtr handle);

			#endregion

			#region Private Constructor
			/// <summary>
			/// Private Constructor.
			/// </summary>
			private NativeMethods()
			{
			}
			#endregion
		}
		#endregion Public Methods
	}
}
