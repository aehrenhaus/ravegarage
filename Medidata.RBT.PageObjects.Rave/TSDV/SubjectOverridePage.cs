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
    public class SubjectOverridePage : SubjectManagementPageBase
    {
        public override IWebElement GetElementByName(string name)
        {
            if (name == "Search")
                return Browser.FindElementById("_ctl0_Content_HeaderControl_SearchLabel");
            return base.GetElementByName(name);
        }

        public override IPage ChooseFromDropdown(string name, string text)
        {
            if (name == "Select Site")
            {
                Browser.Textbox("_ctl0_Content_HeaderControl_slSite_TxtBx").SetText(text);
                Browser.FindElementById("_ctl0_Content_HeaderControl_slSite").Textboxes()[1].Click();
                var option = Browser.WaitForElement(b => b.FindElements(By.XPath("//div[@id='_ctl0_Content_HeaderControl_slSite_PickListBox']/div")).FirstOrDefault(elm => elm.Text == text),
                    "");
                option.Click();

            }
            return this;
        }

        public IPage FilterBySite(string sitename)
        {
            ChooseFromDropdown("Select Site", sitename);
            var search = GetElementByName("Search");
            search.Click();
            return this;
        }

        /// <summary>
        /// Determines whether enrolled subjects have been randomized on initla enrollment top the site.
        /// </summary>
        /// <param name="table">The table.</param>
        /// <returns>
        ///   <c>true</c> if [is subjects randomized] [the specified table]; otherwise, <c>false</c>.
        /// </returns>
        public bool IsSubjectsRandomized(Table table)
        {
            bool IsSubjectsRandomized = false;
            var subjectsDiv = Browser.TryFindElementBy(By.Id("SubjectOverrideDiv"));
            foreach (TableRow row in table.Rows)
            {
                IWebElement rowTable = subjectsDiv.TryFindElementByPartialID(String.Format("_ctl{0}_SubjectOverrideItemsTable", row[1]));
                if (rowTable != null)
                {
                    IsSubjectsRandomized = !rowTable.FindElements(By.TagName("td"))[2].Text.Trim().ToLower().Contains(row[0].ToString().Trim().ToLower());
                    if (IsSubjectsRandomized) 
                        break;
                }
            }

            return IsSubjectsRandomized;
        }

        public override string URL
        {
            get
            {
                return "Modules/Reporting/TSDV/SubjectOverride.aspx";
            }
        }
    }
}
