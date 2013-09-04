﻿using System;
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
    public class UploadUserPage : RavePageBase, IVerifyObjectExistence
	{
        /// <summary>
        /// Upload a user
        /// </summary>
        /// <param name="filepath">The path to the user to upload</param>
        public void UploadFile(string filepath)
        {
            Context.Browser.FindElementById("_ctl0_Content_FileUpload").SendKeys(filepath);
            ClickButton("Upload");
            WaitForUploadToComplete();
        }

        /// <summary>
        /// Wait for the user upload to complete
        /// </summary>
        private void WaitForUploadToComplete()
        {
            int waitTime = 120;
            var ele = Browser.TryFindElementBy(b =>
                {
                    IWebElement currentStatus = Browser.FindElementByXPath("//span[@id = 'CurrentStatus']");
                    if (currentStatus.Text.Contains("Upload successful"))
                        return currentStatus;
                    else
                        return null;
                },true, waitTime
                );
			if (ele == null)
				throw new Exception("Did not complete in time(" + waitTime + "s)");
        }

		public override string URL
		{
			get
			{
                return "Modules/UserAdmin/UploadUsers.aspx";
			}
		}

        public bool VerifyObjectExistence(string areaIdentifier, string type, string identifier, bool exactMatch = false,
                                          int? amountOfTimes = null, BaseEnhancedPDF pdf = null, bool? bold = null,
                                          bool shouldExist = true)
        {
            if (!string.IsNullOrEmpty(areaIdentifier) && areaIdentifier.Equals("log", StringComparison.InvariantCultureIgnoreCase))
            {
                var txt = Browser.TextareaById("LogCtl");
                return txt.Value.Contains(identifier);
            }

            return false;
        }

        public bool VerifyObjectExistence(string areaIdentifier, string type, List<string> identifiers, bool exactMatch = false,
                                          int? amountOfTimes = null, BaseEnhancedPDF pdf = null, bool? bold = null,
                                          bool shouldExist = true)
        {
            throw new NotImplementedException();
        }
	}
}
