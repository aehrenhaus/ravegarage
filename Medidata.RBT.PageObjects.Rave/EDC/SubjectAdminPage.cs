using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium.Support.PageObjects;
using OpenQA.Selenium;
using OpenQA.Selenium.Remote;
using Medidata.RBT.SeleniumExtension;
using TechTalk.SpecFlow;


namespace Medidata.RBT.PageObjects.Rave
{
    public class SubjectAdminPage : BaseEDCPage
    {

        public override string URL
        {
            get
            {
                return "Modules/EDC/SubjectAdmin.aspx";
            }
        }


        public override IWebElement GetElementByName(string identifier, string areaIdentifier = null, string listItem = null)
        {
            IWebElement element;
            string id = "";

            if (identifier == "Add Form" || identifier == "LAdd Form")
                id = "_ctl0_Content_AddForm1_SubmitButton";
            else if (identifier == "Add Folder" || identifier == "LAdd Folder")
                id = "_ctl0_Content_AddFolder1_SubmitButton";
            else if (identifier == "Save" || identifier == "LSave")
                id = "_ctl0_Content_ActivateList1_btnSave";
            else if (identifier == "Cancel" || identifier == "LCancel")
                id = "_ctl0_Content_ActivateList1_btnCancel";

            if (string.IsNullOrWhiteSpace(id))
                element = base.GetElementByName(identifier, areaIdentifier, listItem);
            else
                element = Browser.TryFindElementById(id);

            return element;
        }
    }
}
