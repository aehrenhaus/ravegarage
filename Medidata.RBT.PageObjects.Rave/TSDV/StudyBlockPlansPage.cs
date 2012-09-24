using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium.Support.PageObjects;
using OpenQA.Selenium;
using OpenQA.Selenium.Remote;
using Medidata.RBT.SeleniumExtension;
using TechTalk.SpecFlow;
using OpenQA.Selenium.Support.UI;

namespace Medidata.RBT.PageObjects.Rave
{
    public class StudyBlockPlansPage : BlockPlansPageBase
    {
        public override string URL
        {
            get
            {
                return "Modules/Reporting/TSDV/EnvironmenttBlockPlans.aspx";
            }
        }

        /// <summary>
        /// To delete a tier passed by tier name
        /// Note: no need to pass content in parenthesis ex: if tier name is 
        /// "No Forms (Default Tier)" then only pass "No Forms" as tier name 
        /// </summary>
        /// <param name="tierName"></param>
        /// <returns></returns>
        public IPage DeleteTier(string tierName)
        {
            IWebElement elem = Browser.TryFindElementBySpanLinktext(GetFullTierName(tierName));
            if (elem != null)
            {
                IWebElement parentElem = elem.Parent().Parent();
                if (parentElem != null)
                {
                    IWebElement delButton = parentElem.TryFindElementByPartialID("TierDeleteDiv");
                    if (delButton != null)
                    {
                        delButton.Click();
                        TestContext.CurrentPage.As<PageBase>().GetAlertWindow().Accept();
                    }
                }
            }

            return this;
        }

        /// <summary>
        /// Pass the tier name and subject count to this method.
        /// It will apply the tier name if it exist in the dropdown list
        /// Also, it will apply the required subject count
        /// </summary>
        /// <param name="tierName"></param>
        /// <param name="subjectCount"></param>
        /// <returns></returns>
        public IPage ApplyTierWithSubjectCount(string tierName, string subjectCount)
        {
            IWebElement elem = Browser.TryFindElementByLinkText("Link Tier");
            if (elem != null)
            {
                elem.Click();
                IWebElement tierElement = Browser.TryFindElementByPartialID("TierToSelect");
                if (tierElement != null)
                {
                    //dropdown to select the element by name of the tier
                    var dropdowns = tierElement.FindElements(By.TagName("Select")).ToList();
                    new SelectElement(dropdowns[0]).SelectByText(tierName);
                    //enter the subject count in the textbox
                    var countTxtBox = tierElement.Textbox("LinkNewTierBlockSizeTextBox");
                    countTxtBox.SetText(subjectCount);
                    //save the user desired settings
                    var saveBtn = tierElement.TryFindElementByPartialID("LinkNewTierSaveLabel");
                    saveBtn.Click();
                }
            }
            return this;
        }

        #region helper methods
        private string GetFullTierName(string tierName)
        {
            switch (tierName)
            {
                case "No Form":
                    return "No Forms (Default Tier)";
                case "All Forms":
                    return "All Forms (Default Tier)";
                case "Architect Defined":
                    return "Architect Defined (Default Tier)";
                default:
                    return tierName + " (Custom Tier)";
            }
        }
        #endregion
    }
}
