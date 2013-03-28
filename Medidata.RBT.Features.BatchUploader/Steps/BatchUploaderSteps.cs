using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using TechTalk.SpecFlow;
using Microsoft.VisualStudio.TestTools.UnitTesting;

namespace Medidata.RBT.Features.BatchUploader.Steps
{
    /// <summary>
    /// Batch Uploader specific steps
    /// </summary>
    [Binding]
    public partial class BatchUploaderSteps : BrowserStepsBase
    {

		/// <summary>
		/// verify the batch upload file from the network path is processed by batch uploader.
		/// As part of the verification, verify that the file dissapears from this folder since BatchUploader would delete the file after processing.
		/// use impersonated credentials from configuration file
		/// </summary>
		/// <param name="fileName"></param>
		/// <param name="targetDirectoryName"></param>
		[StepDefinition(@"I verify file ""(.*)"" from network path ""(.*)"" is processed using user impersonation")]
		public void ThenIVerifyFile____FromNetworkPath____IsProcessedUsingUserImpersonation(string fileName, string targetDirectoryName)
		{
			((HashSet<string>)FeatureContext.Current["DirectoriesToCleanUp"]).Add(targetDirectoryName);
			FeatureContext.Current.Add(fileName, targetDirectoryName);
			string userName = RBTConfiguration.Default.ImpersonationUserName;
			string password = RBTConfiguration.Default.ImpersonationPassword;
			string domain = RBTConfiguration.Default.ImpersonationDomain;
			int batchUploadMaxWaitTime = BatchUploaderConfiguration.Default.BatchUploadMaxWaitMinutes;
			bool bOK = FileHelper.CheckFileDisappearsFromTargetDirectoryWithImpersonation(fileName, targetDirectoryName, batchUploadMaxWaitTime, userName, password, domain);
			Assert.IsTrue(bOK);
		}

		/// <summary>
		/// verify the batch upload file from the network path is processed by batch uploader.
		/// As part of the verification, verify that the file dissapears from this folder since BatchUploader would delete the file after processing.
		/// </summary>
		/// <param name="fileName"></param>
		/// <param name="targetDirectoryName"></param>
		[StepDefinition(@"I verify file ""(.*)"" from network path ""(.*)"" is processed")]
		public void ThenIVerifyFile____FromNetworkPath____IsProcessed(string fileName, string targetDirectoryName)
		{
			((HashSet<string>)FeatureContext.Current["DirectoriesToCleanUp"]).Add(targetDirectoryName);
			int batchUploadMaxWaitMinutes = BatchUploaderConfiguration.Default.BatchUploadMaxWaitMinutes;
			bool bOK = FileHelper.CheckFileDisappearsFromTargetDirectory(fileName, targetDirectoryName, batchUploadMaxWaitMinutes);
			Assert.IsTrue(bOK);
		}


		[BeforeFeature("BatchUploader")]
		public static void BeforeFeature()
		{
			if (!FeatureContext.Current.ContainsKey("DirectoriesToCleanUp"))
			{
				FeatureContext.Current.Add("DirectoriesToCleanUp", new HashSet<string>());
			}
			((HashSet<string>)FeatureContext.Current["DirectoriesToCleanUp"]).Clear();
		}

		[AfterFeature("BatchUploader")]
		public static void AfterFeature()
		{
			int BatchUploadMaxFileAgeDays = BatchUploaderConfiguration.Default.BatchUploadMaxFileAgeDays;
			List<string> subDirectoriesToClean = new List<string>() { "Input", "Log", "Old", "System Log" };
			foreach (string directory in ((HashSet<string>)FeatureContext.Current["DirectoriesToCleanUp"]))
			{
				string parentDirectory = string.Format("{0}\\..", directory);
				foreach (string subDirectory in subDirectoriesToClean)
				{
					FileHelper.DeleteOldFilesInDirectory(string.Format("{0}\\{1}", parentDirectory, subDirectory), BatchUploadMaxFileAgeDays);
				}
			}
		}

	}
}
