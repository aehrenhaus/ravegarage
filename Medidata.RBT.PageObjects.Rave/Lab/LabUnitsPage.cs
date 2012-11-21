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
    public class LabUnitsPage : LabPageBase
    {
        public override string URL
        {
            get
            {
                return "Modules/LabAdmin/LabUnitsPage.aspx";
            }
        }

        /// <summary>
        /// Add a lab unit
        /// </summary>
        /// <param name="labUnitName">The name of the lab unit to be added</param>
        public void AddLabUnit(string labUnitName)
        {
            this.ClickLink("Add Lab Unit");
            ReadOnlyCollection<IWebElement> rows = Browser.TryFindElementBy(By.XPath("//table[@id = '_ctl0_Content_LabUnitsGrid']"))
                .EnhanceAs<HtmlTable>().Rows();

            foreach (IWebElement row in rows.Reverse<IWebElement>())
            {
                IWebElement nameInput = row.TryFindElementByPartialID("TextBoxUnitName");
                if (nameInput != null)
                {
                    nameInput.EnhanceAs<Textbox>().SetText(labUnitName);
                    IWebElement tr = nameInput.Parent().Parent();
                    IWebElement acceptButton = tr.FindElements(By.XPath(".//img")).FirstOrDefault(x => x.GetAttribute("src").EndsWith("i_ccheck.gif"));
                    acceptButton.Click();
                    break;
                }
            }
        }
    }
}
