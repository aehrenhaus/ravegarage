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
namespace Medidata.RBT.PageObjects.Rave.UserAdministrator
{
	public class UploadUserPage : RavePageBase
	{
        /// <summary>
        /// Upload a user
        /// </summary>
        /// <param name="filepath">The path to the user to upload</param>
        public void UploadFile(string filepath)
        {
            TestContext.Browser.FindElementById("_ctl0_Content_FileUpload").SendKeys(filepath);
            ClickButton("Upload");
            WaitForUploadToComplete();
        }

        /// <summary>
        /// Wait for the user upload to complete
        /// </summary>
        private void WaitForUploadToComplete()
        {
            int waitTime = 120;
            Browser.WaitForElement(b =>
                {
                    IWebElement currentStatus = Browser.FindElementByXPath("//span[@id = 'CurrentStatus']");
                    if (currentStatus.Text.Contains("Upload successful"))
                        return currentStatus;
                    else
                        return null;
                },
                "Did not complete in time(" + waitTime + "s)", waitTime
                );
        }

		public override string URL
		{
			get
			{
                return "Modules/UserAdmin/UploadUsers.aspx";
			}
		}
	}
}
