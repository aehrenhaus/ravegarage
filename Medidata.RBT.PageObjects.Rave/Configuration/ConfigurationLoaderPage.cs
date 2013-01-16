using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Medidata.RBT.PageObjects;
using OpenQA.Selenium.Support.PageObjects;
using OpenQA.Selenium;
using TechTalk.SpecFlow;
using Medidata.RBT.SeleniumExtension;
using Medidata.RBT.PageObjects.Rave.SiteAdministration;

namespace Medidata.RBT.PageObjects.Rave.Configuration
{
    public class ConfigurationLoaderPage : ConfigurationBasePage
	{
        public ConfigurationLoaderPage()
		{
			//PageFactory.InitElements(Browser, this);
		}

        /// <summary>
        /// Upload a configuration
        /// </summary>
        /// <param name="filepath">Path of the configuration to upload</param>
        public void UploadFile(string filepath)
        {
            Context.Browser.FindElementById("_ctl0_Content_CtrlDraftFile").SendKeys(filepath);
            ClickButton("Upload");
            WaitForUploadToComplete();
        }


        public override IPage ChooseFromCheckboxes(string identifier, bool isChecked, string areaIdentifier = null, string listItem = null)
        {
            if (identifier == "Template Only")
                return base.ChooseFromCheckboxes("_ctl0_Content_GetTemplate", true, areaIdentifier, listItem);
            return base.ChooseFromCheckboxes(identifier, isChecked, areaIdentifier, listItem); ;
        }

        public override string URL { get { return "Modules/Configuration/ConfigurationLoader.aspx"; } }

        /// <summary>
        /// Wait for the configuration to finish uploading
        /// </summary>
        private void WaitForUploadToComplete()
        {
            int waitTime = RaveConfiguration.Default.UploadTimeout;
			var ele = Browser.TryFindElementBy(b =>
            {
                IWebElement currentStatus = Browser.FindElementByXPath("//span[@id = '_ctl0_Content_CurrentStatus']");
                if (currentStatus.Text.Contains("Save successful"))
                    return currentStatus;
                else
                    return null;
            }
                ,true, waitTime);

			if (ele == null)
				throw new Exception(
				"Did not complete in time(" + waitTime + "s)");
        }

		public override IWebElement GetElementByName(string identifier, string areaIdentifier = null, string listItem = null)
		{
			if (identifier == "configureation settings")
				return Browser.TryFindElementByPartialID("CtrlDraftFile");

			if (identifier == "Save successful")
				return Browser.TryFindElementBySpanLinktext("Save successful");

			return base.GetElementByName(identifier, areaIdentifier, listItem);
		}
    }
}
