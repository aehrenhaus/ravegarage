using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Medidata.RBT.PageObjects;
using OpenQA.Selenium.Support.PageObjects;
using OpenQA.Selenium;

using System.Collections.Specialized;
using TechTalk.SpecFlow;
using Medidata.RBT.SeleniumExtension;

using Medidata.RBT.PageObjects.Rave.SiteAdministration;
using Medidata.RBT.PageObjects.Rave.Configuration;

namespace Medidata.RBT.PageObjects.Rave.Lab
{
	public class LabLoaderPage : LabPageBase, IVerifySomethingExists
    {
        public LabLoaderPage()
        {
            //PageFactory.InitElements(Browser, this);
        }

        /// <summary>
        /// Upload a Lab
        /// </summary>
        /// <param name="filepath">Path of the Lab to upload</param>
        /// <param name="stayOnPage">stay on this page afterwards</param>
        public void UploadFile(string filepath)
        {
            Context.Browser.FindElementById("_ctl0_Content_FileUpload").SendKeys(filepath);
            ClickButton("Upload");
            WaitForUploadToComplete();
        }

        public override IPage ChooseFromCheckboxes(string identifier, bool isChecked, string areaIdentifier = null, string listItem = null)
        {
            if (identifier == "Template Only")
                return base.ChooseFromCheckboxes("_ctl0_Content_GetTemplate", true, areaIdentifier, listItem);
            return base.ChooseFromCheckboxes(identifier, isChecked, areaIdentifier, listItem); ;
        }

        public override string URL { get { return "Modules/LabAdmin/LabLoader.aspx"; } }

        /// <summary>
        /// Wait for the Lab to finish uploading
        /// </summary>
        private void WaitForUploadToComplete()
        {
            int waitTime = 480;
           var ele =  Browser.TryFindElementBy(b =>
            {
                IWebElement currentStatus = Browser.FindElementById("CurrentStatus");
                if (currentStatus.Text.Contains("Upload successful.") ||currentStatus.Text.Contains("Transaction rolled back."))
                    return currentStatus;
                else
                    return null;
            } ,true, waitTime );
		   if (ele == null)
			   throw new Exception("Did not complete in time(" + waitTime + "s)");
        }

        #region ICanVerifyExist

        public bool VerifyTableRowsExist(string tableIdentifier, Table matchTable, int? amountOfTimes = null)
        {
            throw new NotImplementedException();
        }

        public bool VerifyControlExist(string identifier)
        {
            throw new NotImplementedException();
        }

        bool IVerifySomethingExists.VerifySomethingExist(string areaIdentifier, string type, string identifier, bool exactMatch, int? amountOfTimes)
		{
			if (identifier != null)
			{
                if (!exactMatch && Browser.PageSource.Contains(identifier))
					return true;
				else
					return false;
			}
			throw new NotImplementedException();
		}

        #endregion
    }
}
