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
using Medidata.RBT.PageObjects.Rave.SharedRaveObjects;

namespace Medidata.RBT.PageObjects.Rave
{
    public abstract class BlockPlansPageBase : RavePageBase
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

                Role role = TestContext.GetExistingFeatureObjectOrMakeNew(dataEntryRole, () => new Role(dataEntryRole, false));
                if (role != null)
                {
                    var entryRoleDropdown = Browser.TryFindElementBy(By.TagName("Select"));
                    new SelectElement(entryRoleDropdown).SelectByText(role.UniqueName);
                }

                this.ClickLink("Save");
            }

            return this;
        }

        public IPage BlocksEdit(IEnumerable<TSDVObjectModel> blocks)
        {
            foreach (var block in blocks)
            {
                ModifyBlock(block.Name, block.SubjectCount);
            }
            return this;
        }

        public void ModifyBlock(string tierName, int subjectCount = -1)
        {
            Browser.TryFindElementByLinkText("Architect Defined").Parent().Parent().Images()[0].Click();
            Browser.FindElementsByPartialId("EditBlockNameTextBox")[0].EnhanceAs<Textbox>().SetText(tierName);
            Browser.FindElementsByPartialId("EditBlockSizeTextBox")[0].EnhanceAs<Textbox>().SetText(subjectCount.ToString());
            Browser.FindElementsByPartialId("EditBlockSizeTextBox")[0].Parent().Parent().Parent().Images()[2].Click();
        }
    }
}
