﻿using System;
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
        /// Create a new block plan for study based on plan name and entry role
        /// </summary>
        /// <param name="planName"></param>
        /// <param name="dataEntryRole"></param>
        public IPage CreateNewBlockPlan(string planName, string dataEntryRole)
        {

            //only do this if the block plan already doesn't exist
            IWebElement elem = Browser.FindElementById("_ctl0_Content__ctl0_AddNewBlockPlanLabel");
            if (elem != null && elem.Displayed)
            {
                this.ClickLink("New Block Plan");
                Textbox planNameTextbox = Browser.TryFindElementByPartialID("NewBlockPlanNameTextBox").EnhanceAs<Textbox>();
                planNameTextbox.Clear();
                planNameTextbox.SetText(planName);

                var entryRoleDropdown = Browser.TryFindElementBy(By.TagName("Select"));
                new SelectElement(entryRoleDropdown).SelectByText(dataEntryRole);

                this.ClickLink("Save");
            }

            return this;
        }
    }
}
