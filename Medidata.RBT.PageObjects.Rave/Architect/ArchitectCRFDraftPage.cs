using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium.Support.PageObjects;
using OpenQA.Selenium;
using OpenQA.Selenium.Remote;
using OpenQA.Selenium.Support.UI;
using Medidata.RBT.SeleniumExtension;
using TechTalk.SpecFlow;

namespace Medidata.RBT.PageObjects.Rave
{
    public class ArchitectCRFDraftPage : ArchitectBasePage, IVerifySomethingExists
	{
        /// <summary>
        /// Publish a crf
        /// </summary>
        /// <param name="crfVersion">The unique name of the crf to publish</param>
        /// <returns>This page</returns>
		public ArchitectCRFDraftPage PublishCRF(string crfVersion)
		{
			Type("_ctl0_Content_TxtCRFVersion", crfVersion);
			//ClickButton("Publish to CRF Version");
            Browser.TryFindElementBy(By.XPath(string.Format(".//input[contains(@id,'{0}')]", "_ctl0_Content_BtnPublish"))).Click(); // works for both "Publish to CRF Version" and "Publish to Global Library Version"
			return this;
		}


		public override IPage NavigateTo(string name)
		{
			if (name == "Edit Checks")
			{
				Browser.TryFindElementById("TblOuter").Link(name).Click();
		
				return new ArchitectChecksPage();
			}


            if (name == "Forms")
            {
                Browser.TryFindElementById("TblOuter").Link(name).Click();

                return new ArchitectFormsPage();
            }


			return base.NavigateTo(name);
		}


		public override string GetInfomation(string identifier)
		{
			if (identifier == "crfversion")
				return GetLatestCRFVersion();
			return base.GetInfomation(identifier);
		}


        public string GetLatestCRFVersion()
        {
            var trs = Browser.Table("VersionGrid").Children()[0].Children();
            var tr = trs[1];
            var td = tr.Children()[0];
            var text = td.Text.Trim();
            return text;
        }
        
		public override string URL
		{
			get
			{
				return "Modules/Architect/CrfDraftPage.aspx";
			}
		}

        /// <summary>
        /// Helper method to find the control td id based on the control name
        /// </summary>
        /// <param name="areaIdentifier"></param>
        /// <returns></returns>
        private IWebElement FindControlTdFromAreaIdentifier(string areaIdentifier)
        {
            IWebElement elem = Browser.TryFindElementByXPath(string.Format(".//td/span[text()='{0}']", areaIdentifier)).Parent();
            int controlPosition = elem.Parent().Children().IndexOf(elem) + 1; //find the position of the control td
            int controlTrPosition = elem.Parent().Parent().Children().IndexOf(elem.Parent()) + 2; //find the position of the control tr

            //find the td corresponding to the same position as the configuration name but in the second tr
            IWebElement controlTd = elem.TryFindElementByXPath(string.Format("../../tr[position()={0}]/td[position()={1}]", controlTrPosition, controlPosition));

            return controlTd;
        }

        /// <summary>
        /// Helper method to support the generic VerifySomethingExist to add support for verifying the text exist
        /// This method support text verification and can verify dropdown and textbox controls
        /// selected text verification
        /// </summary>
        /// <param name="areaIdentifier"></param>
        /// <param name="identifier"></param>
        /// <returns></returns>
        private bool VerifyTextExist(string areaIdentifier, string identifier)
        {
            bool textExists = false;
            if (areaIdentifier != null)
            {
                IWebElement controlTdElem = FindControlTdFromAreaIdentifier(areaIdentifier);
                if (controlTdElem != null && controlTdElem.Children().Count() > 0)
                {
                    IWebElement controlElem = controlTdElem.Children()[0];
                    
                    if (controlElem.TagName.Equals("select", StringComparison.InvariantCultureIgnoreCase))
                    {
                        SelectElement selectElem = new SelectElement(controlElem);
                        textExists = selectElem.SelectedOption.Text.Equals(identifier, StringComparison.InvariantCultureIgnoreCase);
                    }
                    else if (controlElem.TagName.Equals("input", StringComparison.InvariantCultureIgnoreCase))
                    {
                        textExists = controlElem.GetAttribute("value").Equals(identifier, StringComparison.InvariantCultureIgnoreCase);
                    }
                    return textExists;
                }
            }
            else
            {
                if (Browser.TryFindElementsBy(By.XPath(string.Format(".//td/span[text()='{0}']", identifier))).Count > 0)
                    textExists = true;
                return textExists;
            }
            throw new NotImplementedException(
                string.Format("Verify text exist does not have implementation for area identifier {0} and identifier {1}", areaIdentifier, identifier));
        }

        #region IVerifySomethingExist
        /// <summary>
        /// Implementation of the IVerifySomethingExist interface for ArchitectCRFDraftPage
        /// </summary>
        /// <param name="areaIdentifier"></param>
        /// <param name="type"></param>
        /// <param name="identifier"></param>
        /// <param name="exactMatch"></param>
        /// <returns></returns>
        public bool VerifySomethingExist(string areaIdentifier, string type, string identifier, bool exactMatch = true, int? amountOfTimes = null, BaseEnhancedPDF pdf = null, bool? bold = null)
        {
            if (type.Equals("text", StringComparison.InvariantCultureIgnoreCase))
                return VerifyTextExist(areaIdentifier, identifier);
            else
            {
                //if specified type does not exist then throw not implemented exception
                throw new NotImplementedException(string.Format("No implementation exist for type {0}", type));
            }
        }

        /// <summary>
        /// Implementation of the IVerifySomethingExist interface for ArchitectCRFDraftPage
        /// </summary>
        /// <param name="areaIdentifier"></param>
        /// <param name="type"></param>
        /// <param name="identifiers">List of identifiers</param>
        /// <param name="exactMatch"></param>
        /// <returns></returns>
        public bool VerifySomethingExist(string areaIdentifier, string type, List<string> identifiers, bool exactMatch = false, int? amountOfTimes = null, RBT.BaseEnhancedPDF pdf = null, bool? bold = null)
        {
            foreach (string identifier in identifiers)
                if (VerifySomethingExist(areaIdentifier, type, identifier, exactMatch, amountOfTimes, pdf, bold) == false)
                    return false;
            return true;
        }
        #endregion
	
	}
}
