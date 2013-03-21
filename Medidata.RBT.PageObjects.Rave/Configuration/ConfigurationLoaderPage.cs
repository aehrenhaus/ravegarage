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
    public class ConfigurationLoaderPage : ConfigurationBasePage, IVerifySomethingExists
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
			int waitTime = RBTConfiguration.Default.UploadTimeout;
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

			if (areaIdentifier == "upload result")
			{
				return Browser.TryFindElementBySpanLinktext(identifier);
			}
			return base.GetElementByName(identifier, areaIdentifier, listItem);
		}

        public bool VerifySomethingExist(string areaIdentifier, string type, string identifier, bool exactMatch = false, int? amountOfTimes = null, RBT.BaseEnhancedPDF pdf = null, bool? bold = null)
		{
			areaIdentifier = areaIdentifier ?? string.Empty;

			if (areaIdentifier.Equals("log", StringComparison.InvariantCultureIgnoreCase))
			{
				var txt = Browser.TextareaById("_ctl0_Content_LogCtl");
				return txt.Value.Contains(identifier);
			}

			if (identifier.Equals("Coder Configuration were updated", StringComparison.InvariantCultureIgnoreCase))
			{
			
				return true;
			}

			if (identifier.Equals("Complete icon for Coder Configuration", StringComparison.InvariantCultureIgnoreCase))
			{
				var img = Browser.TryFindElementById("_ctl0_Content_Label_CoderConfig").Parent().Parent().Children()[0].ImageBySrc("dp_ok.gif", false);
				bool exist = img.GetCssValue("display") != "none";
				return exist;
			}

			if (identifier.Equals("Non-Conformant icon for Coder Configuration", StringComparison.InvariantCultureIgnoreCase))
			{
				bool exist = Browser.TryFindElementById("_ctl0_Content_Label_CoderConfig").Parent().Parent().Children()[0].ImageBySrc("dp_nc.gif", false).GetCssValue("display") != "none";
				return exist;
			}

			if ( areaIdentifier.Equals("Coder Configuration errors", StringComparison.InvariantCultureIgnoreCase))
			{
				var triangle = Browser.TryFindElementById("_ctl0_Content_Label_CoderConfig").Parent().Parent().Children()[2];
				triangle.ImageBySrc("arrow_right.gif").Click();
				var eleMessage = triangle.Parent().Parent().Children()[1];
				return eleMessage.Text.Contains(identifier);
			}



			return false;
		}

        public bool VerifySomethingExist(string areaIdentifier, string type, List<string> identifiers, bool exactMatch, int? amountOfTimes, RBT.BaseEnhancedPDF pdf, bool? bold)
        {
            foreach (string identifier in identifiers)
                if (VerifySomethingExist(areaIdentifier, type, identifier, exactMatch, amountOfTimes, pdf, bold) == false)
                    return false;

            return true;
        }
	}
}
