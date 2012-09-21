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
    public class BlockPlansPageBase : RavePageBase
    {

        public IPage InactivatePlan()
        {
            IWebElement elem = Browser.TryFindElementByLinkText("Inactivate");
            if (elem != null)
            {
                elem.Click();
                TestContext.CurrentPage.As<PageBase>().GetAlertWindow().Accept();
            }
            return this;
        }

        public IPage ActivatePlan()
        {
            IWebElement elem = Browser.TryFindElementByLinkText("Activate");
            if (elem != null)
            {
                elem.Click();
                TestContext.CurrentPage.As<PageBase>().GetAlertWindow().Accept();
            }
            return this;
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
    }
}
