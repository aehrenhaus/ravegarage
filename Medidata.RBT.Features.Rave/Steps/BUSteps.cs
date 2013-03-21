using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using TechTalk.SpecFlow;
using Microsoft.VisualStudio.TestTools.UnitTesting;

namespace Medidata.RBT.Features.Rave.Steps
{
	/// <summary>
	/// 
	/// </summary>
	[Binding]
	public partial class BUSteps : BrowserStepsBase
	{

		private string ComposeFullPath(string path)
		{
			//if not full network path, or local path, assume it is from development path
			if (path!=null && !path.StartsWith("\\\\") && !path.Contains(":"))
			{
				path = string.Format("{0}\\BU\\UploadFiles\\{1}", RBTConfiguration.Default.UploadPath, path);
			}
			return path;

		}

		/// <summary>
		/// 
		/// </summary>
		/// <param name="sourceDirectoryName"></param>
		/// <param name="targetDirectoryName"></param>
		[When(@"I drop files from source directory ""(.*)"" to target directory ""(.*)"" using logged in user")]
		public void WhenIDropFilesFromSourceDirectoryToTargetDirectoryUsingLoggedInUser(string sourceDirectoryName, string targetDirectoryName)
		{
			sourceDirectoryName = ComposeFullPath(sourceDirectoryName);
			targetDirectoryName = ComposeFullPath(targetDirectoryName);
			BuUploadFileHelper.CopyFilesFromSourceDirectoryToTargetDirectory(sourceDirectoryName, targetDirectoryName);
		}



		/// <summary>
		/// 
		/// </summary>
		/// <param name="sourceDirectoryName"></param>
		/// <param name="targetDirectoryName"></param>
		/// <param name="userName"></param>
		/// <param name="password"></param>
		/// <param name="domain"></param>
		[When(@"I drop files from source directory ""(.*)"" to target directory ""(.*)"" using user name ""(.*)"" and password ""(.*)"" on domain ""(.*)""")]
		public void WhenIDropFilesFromSourceDirectoryToTargetDirectoryUsingUserNameAndPasswordOnDomain(string sourceDirectoryName, string targetDirectoryName, string userName, string password, string domain)
		{
			sourceDirectoryName = ComposeFullPath(sourceDirectoryName);
			targetDirectoryName = ComposeFullPath(targetDirectoryName);
			BuUploadFileHelper.CopyFilesFromSourceDirectoryToTargetDirectoryWithImpersonation(sourceDirectoryName, targetDirectoryName, userName, password, domain);
		}


/// <summary>
/// 
/// </summary>
/// <param name="sourceDirectoryName"></param>
		[When(@"I zip the files from sourceDirectory ""(.*)""")]
		public void WhenIZipTheFilesFromSourceDirectory(string sourceDirectoryName)
		{
			sourceDirectoryName = ComposeFullPath(sourceDirectoryName);
			BuUploadFileHelper.ZipFiles(sourceDirectoryName);
		}

/// <summary>
/// 
/// </summary>
/// <param name="fileLoc"></param>
/// <param name="targetDirectoryName"></param>
		[When(@"I unzip the file ""(.*)"" from targetDirectory ""(.*)""")]
		public void WhenIUnzipTheFileFromTargetDirectory(string fileLoc, string targetDirectoryName)
		{
			targetDirectoryName = ComposeFullPath(targetDirectoryName);
			fileLoc = string.Format("{0}\\{1}", targetDirectoryName, fileLoc);
			BuUploadFileHelper.UnZipFile(fileLoc);
		}

		/// <summary>
		/// 
		/// </summary>
		/// <param name="fileNames"></param>
		/// <param name="sourceDirectoryName"></param>
		/// <param name="ftpDirectoryName"></param>
		/// <param name="ftpServer"></param>
		/// <param name="ftpUserName"></param>
		/// <param name="ftpPassword"></param>
		/// <param name="ftpMode"></param>
		[When(@"I transfer the files ""(.*)"" from source directory ""(.*)"" to ftp directory ""(.*)"" on ftp server ""(.*)"" using ftp user name ""(.*)"" and password ""(.*)"" and file transfer mode ""(.*)""")]
		public void WhenITransferTheFilesFromSourceDirectoryToFtpDirectoryOnFtpServerUsingFtpUserNameAndPasswordAndFileTransferMode(string fileNames, string sourceDirectoryName, string ftpDirectoryName, string ftpServer, string ftpUserName, string ftpPassword, string ftpMode)
		{
			sourceDirectoryName = ComposeFullPath(sourceDirectoryName);
			string[] fileNamesArray = fileNames.Split(',');
			foreach (string fileNameO in fileNamesArray)
			{
				string fileName = fileNameO.Trim();
				string ftpTarget = string.Format("ftp://{0}/{1}/{2}", ftpServer, ftpDirectoryName, fileName).Replace('\\', '/');
				string ftpsource = string.Format("{0}\\{1}", sourceDirectoryName, fileName);
				BuUploadFileHelper.UploadFileUsingFtp(ftpsource, ftpTarget, ftpUserName, ftpPassword, ftpMode);
			}
		}

/// <summary>
/// 
/// </summary>
/// <param name="fileName"></param>
/// <param name="targetDirectoryName"></param>
/// <param name="timeout"></param>
/// <param name="userName"></param>
/// <param name="password"></param>
/// <param name="domain"></param>
		[Then(@"I confirm file ""(.*)"" from network path ""(.*)"" is processed within (.*) minutes using user name ""(.*)"" and password ""(.*)"" on domain ""(.*)""")]
		public void ThenIConfirmFileFromNetworkPathIsProcessedWithinMinutesUsingUserNameAndPasswordOnDomain(string fileName, string targetDirectoryName, int timeout, string userName, string password, string domain)
		{
			bool bOK = BuUploadFileHelper.CheckFileProcessedInTargetDirectoryWithImpersonation(fileName, targetDirectoryName, timeout, userName, password, domain);
			Assert.IsTrue(bOK);
		}


		/// <summary>
		/// 
		/// </summary>
		/// <param name="fileName"></param>
		/// <param name="targetDirectoryName"></param>
		/// <param name="timeout"></param>
		[Then(@"I confirm file ""(.*)"" from network path ""(.*)"" is processed within (.*) minutes")]
		public void ThenIConfirmFileFromNetworkPathIsProcessedWithinMinutes(string fileName, string targetDirectoryName, int timeout)
		{
			bool bOK = BuUploadFileHelper.CheckFileProcessedInTargetDirectory(fileName, targetDirectoryName, timeout);
			Assert.IsTrue(bOK);
		}


	}
}
