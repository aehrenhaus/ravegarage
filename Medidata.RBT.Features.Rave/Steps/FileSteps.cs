using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using TechTalk.SpecFlow;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Medidata.RBT.PageObjects.Rave.TableModels;
using TechTalk.SpecFlow.Assist;
using Medidata.RBT.ConfigurationHandlers;

namespace Medidata.RBT.Features.Rave.Steps
{
	/// <summary>
	/// Generic File related steps including zip/unzip, ftp, and file copy with/out impersonation.
	/// </summary>
	[Binding]
	public partial class FileSteps : BrowserStepsBase
	{

		private string ComposeFullPath(string path)
		{
			//if not a fully qualified network path, or a fully qualified local path, assume it is from relative development path
			if (path!=null && !path.StartsWith("\\\\") && !path.Contains(":"))
			{
				path = string.Format("{0}\\{1}", RBTConfiguration.Default.UploadPath, path);
			}
			return path.Replace('/', '\\');

		}

		/// <summary>
		/// use file copy to transfer files from a local directory to another directory
		/// </summary>
		/// <param name="sourceDirectoryName"></param>
		/// <param name="targetDirectoryName"></param>
		[StepDefinition(@"I drop files from source directory ""(.*)"" to target directory ""(.*)""")]
		public void WhenIDropFilesFromSourceDirectory____ToTargetDirectory____(string sourceDirectoryName, string targetDirectoryName)
		{
			sourceDirectoryName = ComposeFullPath(sourceDirectoryName);
			targetDirectoryName = ComposeFullPath(targetDirectoryName);
			FileHelper.CopyFilesFromSourceDirectoryToTargetDirectory(sourceDirectoryName, targetDirectoryName);
		}

		/// <summary>
		/// use file copy to transfer files from a local directory to another directory
		/// use impersonated credentials from configuration file to access target file system.
		/// </summary>
		/// <param name="sourceDirectoryName"></param>
		/// <param name="targetDirectoryName"></param>
		[StepDefinition(@"I drop files from source directory ""(.*)"" to target directory ""(.*)"" using user impersonation")]
		public void WhenIDropFilesFromSourceDirectory____ToTargetDirectory___UsingUserImpersonation(string sourceDirectoryName, string targetDirectoryName)
		{
			string userName = RBTConfiguration.Default.ImpersonationUserName;
			string password = RBTConfiguration.Default.ImpersonationPassword;
			string domain = RBTConfiguration.Default.ImpersonationDomain;

			sourceDirectoryName = ComposeFullPath(sourceDirectoryName);
			targetDirectoryName = ComposeFullPath(targetDirectoryName);
			FileHelper.CopyFilesFromSourceDirectoryToTargetDirectoryWithImpersonation(sourceDirectoryName, targetDirectoryName, userName, password, domain);
		}

		/// <summary>
		/// Zips files from given directory. Zip file would be named as the directoryName.zip.
		/// </summary>
		/// <param name="directoryName"></param>
		[StepDefinition(@"I zip the files from Directory ""(.*)""")]
		public void WhenIZipTheFilesFromDirectory____(string directoryName)
		{
			directoryName = ComposeFullPath(directoryName);
			FileHelper.ZipFiles(directoryName);
		}


		/// <summary>
		/// Unzips the zipFile found in the Directory
		/// </summary>
		/// <param name="fileLoc"></param>
		/// <param name="directoryName"></param>
		[StepDefinition(@"I unzip the file ""(.*)"" in Directory ""(.*)""")]
		public void WhenIUnzipTheFile____InDirectory____(string fileLoc, string directoryName)
		{
			directoryName = ComposeFullPath(directoryName);
			fileLoc = string.Format("{0}\\{1}", directoryName, fileLoc);
			FileHelper.UnZipFiles(fileLoc);
		}

		/// <summary>
		/// use ftp credencials from configuration file to transfer given fils from local directory to ftp directory using specific ftp mode
		/// </summary>
		/// <param name="table"></param>
		[StepDefinition(@"I transfer")]
		public void WhenITransfer(Table table)
		{
			string fileNames = string.Empty;
			string sourceDirectory = string.Empty;
			string ftpDirectory = string.Empty;
			string ftpMode = string.Empty;

			IEnumerable<FtpModel> fields = table.CreateSet<FtpModel>();
			foreach (FtpModel field in fields)
			{
				fileNames = field.FileNames;
				sourceDirectory = field.SourceDirectory;
				ftpDirectory = field.FtpDirectory;
				ftpMode = field.FtpMode;
			}

			sourceDirectory = ComposeFullPath(sourceDirectory);
			string[] fileNamesArray = fileNames.Split(',');

			string ftpServer = RBTConfiguration.Default.FtpServer;
			string ftpUserName = RBTConfiguration.Default.FtpUserName;
			string ftpPassword = RBTConfiguration.Default.FtpPassword;

			foreach (string fileNameO in fileNamesArray)
			{
				string fileName = fileNameO.Trim();
				string ftpTarget = string.Format("ftp://{0}/{1}/{2}", ftpServer, ftpDirectory, fileName).Replace('\\', '/');
				string ftpSource = string.Format("{0}\\{1}", sourceDirectory, fileName);
				FileHelper.UploadFileUsingFtp(ftpSource, ftpTarget, ftpUserName, ftpPassword, ftpMode);
			}

		}
	}
}
