using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium;
using Medidata.RBT.SeleniumExtension;

namespace Medidata.RBT.PageObjects.Rave.Configuration
{
    public class RoleActionsConfigPage : ConfigurationBasePage
    {
        /// <summary>
        /// Select actions for given role
        /// </summary>
        public bool ClickEditFromRoleActionGridAndCheckState(string ActionName)
        {
            //FindTable
            IWebElement edcRoleActionsTable = TestContext.Browser.TryFindElementByPartialID("RoleActionsGrid");
            //FindRow
            IWebElement edcRoleActionRow = edcRoleActionsTable.TryFindElementBy(By.XPath("//td[normalize-space(text())='" + ActionName + "']")).Parent();
            //Click Link
            edcRoleActionRow.TryFindElementBy(By.XPath("td/a")).Click();
            //now entered into edit mode
            //FindTable
            edcRoleActionsTable = TestContext.Browser.TryFindElementByPartialID("RoleActionsGrid");
            //FindRow
            edcRoleActionRow = edcRoleActionsTable.TryFindElementBy(By.XPath("//td[normalize-space(text())='" + ActionName + "']")).Parent();
            //check whether checkbox is ticked or not
            Checkbox actionUsedCheckbox = edcRoleActionRow.TryFindElementByPartialID("ActionUsedBox").EnhanceAs<Checkbox>();
            return actionUsedCheckbox.Selected;
        }

        public override string URL
        {
            get
            {
                return "Modules/Configuration/RoleActionsConfig.aspx";
            }
        }
    }
}
