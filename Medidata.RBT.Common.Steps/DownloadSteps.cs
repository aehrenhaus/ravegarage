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


	}
}
