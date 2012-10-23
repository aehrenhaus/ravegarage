using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium;
using Medidata.RBT.SeleniumExtension;

namespace Medidata.RBT.PageObjects.Rave.Configuration
{
    public class WorkflowConfigPage : ConfigurationBasePage
    {
        public override IPage ClickLink(string linkText)
        {
            base.ClickLink(linkText);

            if (linkText == "Add New Draft")
                return new ArchitectNewDraftPage();

            return this;
        }

        /// <summary>
        /// Set the review group to active or inactive.
        /// </summary>
        /// <param name="reviewGroupNumber">The review group to change</param>
        /// <param name="isActive">isActive is true if you want it to be active and false for inactive</param>
        public void SetReviewGroup(int reviewGroupNumber, bool isActive)
        {
            IWebElement reviewGroupTable = TestContext.Browser.TryFindElementByPartialID("ReviewGroupsGrid");
            IWebElement reviewGroupRow = reviewGroupTable.TryFindElementBy(By.XPath("//td[normalize-space(text())='" + reviewGroupNumber + "']")).Parent();
            //Click the edit button
            reviewGroupRow.TryFindElementBy(By.XPath("td/a")).Click();
            //Might need to reload the row here
            reviewGroupTable = TestContext.Browser.TryFindElementByPartialID("ReviewGroupsGrid");
            reviewGroupRow = reviewGroupTable.TryFindElementBy(By.XPath("//td[normalize-space(text())='" + reviewGroupNumber + "']")).Parent();
            Checkbox isActiveCheckbox = reviewGroupRow.TryFindElementBy(By.XPath("td/input[contains(@id,'ReviewGroupActive')]")).EnhanceAs<Checkbox>();
            if (isActive)
                isActiveCheckbox.Check();
            else
                isActiveCheckbox.Uncheck();
            //Click update button
            reviewGroupRow.TryFindElementBy(By.XPath("td/a[normalize-space(text() = '  Update')]")).Click();
        }

        public override string URL
        {
            get
            {
                return "Modules/Configuration/WorkflowConfig.aspx";
            }
        }
    }
}
