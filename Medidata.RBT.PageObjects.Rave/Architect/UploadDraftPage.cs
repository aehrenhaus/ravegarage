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
using Medidata.RBT.PageObjects.Rave.SharedRaveObjects;
namespace Medidata.RBT.PageObjects.Rave
{
	public class UploadDraftPage : 
		ArchitectBasePage, 
		IVerifySomethingExists
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
			Browser.TryFindElementBy(b =>
                {
                    IWebElement currentStatus = Browser.FindElementByXPath("//span[@id = 'CurrentStatus']");
                    if (currentStatus.Text.Contains("Save successful")
						|| currentStatus.Text.Contains("Transaction rolled back"))
                        return currentStatus;
                    else
                        return null;
                }
                , true, waitTime);
        }

		public override string URL
		{
			get
			{
                return "Modules/Architect/UploadDraft.aspx";
			}
		}

		bool IVerifySomethingExists.VerifySomethingExist(string areaIdentifier, string type, string identifier, bool exactMatch)
		{
			if (identifier != null)
			{
                if (!string.IsNullOrEmpty(areaIdentifier) && 
                    areaIdentifier.StartsWith("Coding Dictionary:", StringComparison.InvariantCultureIgnoreCase))
                {
                    string coderDictionaryName = areaIdentifier.Substring("Coding Dictionary:".Length);
                    CodingDictionary cd = (CodingDictionary)SeedingContext.GetExistingFeatureObjectOrMakeNew<CodingDictionary>(coderDictionaryName,
                        () => { throw new Exception(string.Format("Coding Dictionary [{0}] not found", coderDictionaryName)); });

                    string uniqueCoderDictionaryName = cd.UniqueName;

                    identifier = identifier.Replace(coderDictionaryName, uniqueCoderDictionaryName);
                }
				if (!exactMatch && Browser.PageSource.Contains(identifier))
					return true;
				else
					return false;
			}
			throw new ArgumentNullException("identifier cannot be null");
		}
	}
}
