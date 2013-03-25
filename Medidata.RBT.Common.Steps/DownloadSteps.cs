using System;
using System.Collections.Generic;
using Medidata.RBT.SeleniumExtension;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using TechTalk.SpecFlow;
using System.IO;
using TechTalk.SpecFlow.Assist;
using System.Linq;


namespace Medidata.RBT.Common.Steps
{
    /// <summary>
    /// Download and upload files.
    /// </summary>
	[Binding]
	public class DownloadSteps : BrowserStepsBase
	{
        /// <summary>
        /// Click a button to download a file
        /// </summary>
        /// <param name="button">The value of the button to download (the text in the button)</param>
		[StepDefinition(@"I click the ""([^""]*)"" button to download")]
		public void IClickThe___ButtonToDownload(string button)
		{
			using (var fileWatcher = WebTestContext.WatchForDownload())
			{
				var linkButton = Browser.TryFindElementByLinkText(button, false);
				if (linkButton != null)
				{
					linkButton.Click();
				}
				else
					CurrentPage.ClickButton(button);
			}
		}

        /// <summary>
        /// Verify that a file exists in the download folder
        /// </summary>
        /// <param name="fileName">Name of the file to find</param>
        [StepDefinition(@"I verify file ""(.*)"" was downloaded")]
        public void ThenIVerifyFile____WasDownloaded(string fileName)
        {
            try
            {
                DirectoryInfo downloadDir = new DirectoryInfo(RBTConfiguration.Default.DownloadPath);
                FileInfo[] matchingFiles = downloadDir.GetFiles(fileName, SearchOption.AllDirectories);

                Assert.IsTrue(matchingFiles != null && matchingFiles.Count() > 0, String.Format("File {0} was not found in the downloads folder", fileName));
            }
            catch
            {
                Console.WriteLine("-> Find file failed");
            }
        }

        /// <summary>
        /// Verify that a file does not exist in the download folder
        /// </summary>
        /// <param name="fileName">Name of the file to look for</param>
        [StepDefinition(@"I verify file ""(.*)"" was not downloaded")]
        public void ThenIVerifyFile____WasNotDownloaded(string fileName)
        {
            try
            {
                DirectoryInfo downloadDir = new DirectoryInfo(RBTConfiguration.Default.DownloadPath);
                FileInfo[] matchingFiles = downloadDir.GetFiles(fileName, SearchOption.AllDirectories);

                Assert.IsTrue(matchingFiles != null || matchingFiles.Count() == 0, String.Format("File {0} was found in the downloads folder", fileName));
            }
            catch
            {
                Console.WriteLine("-> Find file failed");
            }
        }
	}
}
