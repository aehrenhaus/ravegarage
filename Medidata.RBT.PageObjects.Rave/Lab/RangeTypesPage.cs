using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium.Support.PageObjects;
using OpenQA.Selenium;
using OpenQA.Selenium.Remote;
using TechTalk.SpecFlow;
using Medidata.RBT.SeleniumExtension;
using System.Collections.Specialized;
using System.Collections.ObjectModel;

namespace Medidata.RBT.PageObjects.Rave.Lab
{
    public class RangeTypesPage : LabPageBase
    {
        public override string URL
        {
            get
            {
                return "Modules/LabAdmin/RangeTypes.aspx";
            }
        }

        /// <summary>
        /// Add a range type
        /// </summary>
        /// <param name="rangeTypeName">The name of the range type to be added</param>
        public void AddRangeType(string rangeTypeName)
        {
            this.ClickLink("Add New");

            IWebElement nameInput = Browser.TryFindElementBy(By.XPath("//table[@id = '_ctl0_Content_MainDataGrid']//input"));
            if (nameInput != null)
            {
                nameInput.EnhanceAs<Textbox>().SetText(rangeTypeName);
                IWebElement tr = nameInput.Parent().Parent();
                IWebElement acceptButton = tr.FindElements(By.XPath(".//img")).FirstOrDefault(x => x.GetAttribute("src").EndsWith("i_ccheck.gif"));
                acceptButton.Click();
            }
        }
    }
}
