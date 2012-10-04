using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium.Support.PageObjects;
using OpenQA.Selenium;
using OpenQA.Selenium.Remote;
using Medidata.RBT.SeleniumExtension;
using System.IO;
using System.Threading;
using TechTalk.SpecFlow;
namespace Medidata.RBT.PageObjects.Rave
{
	public class UploadDraftPage : ArchitectBasePage
	{
        /// <summary>
        /// Upload a UploadDraft
        /// </summary>
        /// <param name="filepath">Path to the UploadDraft to upload</param>
        public void UploadFile(string filepath)
        {
            Browser.FindElementById("CtrlDraftFile").SendKeys(filepath);
            ClickButton("Upload");
            WaitForUploadToComplete();
        }

        /// <summary>
        /// Wait for the UploadDraft to finish uploading
        /// </summary>
        private void WaitForUploadToComplete()
        {
            int waitTime = 480;
			Browser.WaitForElement(b =>
                {
                    IWebElement currentStatus = Browser.FindElementByXPath("//span[@id = 'CurrentStatus']");
                    if (currentStatus.Text.Contains("Save successful"))
                        return currentStatus;
                    else
                        return null;
                }
                ,
                "Did not complete in time(" + waitTime + "s)", waitTime
                );
        }

		public override string URL
		{
			get
			{
                return "Modules/Architect/UploadDraft.aspx";
			}
		}
	}
}
