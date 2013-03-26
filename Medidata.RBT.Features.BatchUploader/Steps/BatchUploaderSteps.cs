using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using TechTalk.SpecFlow;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Medidata.RBT.Features.BatchUploader.Helpers;

namespace Medidata.RBT.Features.BatchUploader.Steps
{
    /// <summary>
    /// 
    /// </summary>
    [Binding]
    public partial class BatchUploaderSteps : BrowserStepsBase
    {

		/// <summary>
		/// 
		/// </summary>
		/// <param name="fileName"></param>
		/// <param name="targetDirectoryName"></param>
		[StepDefinition(@"I verify file ""(.*)"" from network path ""(.*)"" is processed using user impersonation")]
		public void ThenIVerifyFile____FromNetworkPath____IsProcessedUsingUserImpersonation(string fileName, string targetDirectoryName)
		{
			string userName = RBTConfiguration.Default.ImpersonationUserName;
			string password = RBTConfiguration.Default.ImpersonationPassword;
			string domain = RBTConfiguration.Default.ImpersonationDomain;
			int batchUploadMaxWaitTime = BatchUploaderConfiguration.Default.BatchUploadMaxWaitTime;
			bool bOK = BatchUploadFileHelper.CheckFileProcessedInTargetDirectoryWithImpersonation(fileName, targetDirectoryName, batchUploadMaxWaitTime, userName, password, domain);
			Assert.IsTrue(bOK);
		}

		/// <summary>
		/// 
		/// </summary>
		/// <param name="fileName"></param>
		/// <param name="targetDirectoryName"></param>
		[StepDefinition(@"I verify file ""(.*)"" from network path ""(.*)"" is processed")]
		public void ThenIVerifyFile____FromNetworkPath____IsProcessed(string fileName, string targetDirectoryName)
		{
			int batchUploadMaxWaitTime = BatchUploaderConfiguration.Default.BatchUploadMaxWaitTime;
			bool bOK = BatchUploadFileHelper.CheckFileProcessedInTargetDirectory(fileName, targetDirectoryName, batchUploadMaxWaitTime);
			Assert.IsTrue(bOK);
		}

		[When(@"I do something")]
		public void WhenIDoSomething()
		{
			ScenarioContext.Current.Pending();
		}

		[When(@"I do something else")]
		public void WhenIDoSomethingElse()
		{
			ScenarioContext.Current.Pending();
		}

	}
}
