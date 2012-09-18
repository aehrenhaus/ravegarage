using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium;

namespace Medidata.RBT.PageObjects.Rave.Configuration
{
    public class ConfigurationPage : ConfigurationBasePage
    {
        public override IWebElement GetElementByName(string identifier, string areaIdentifier = null, string listItem = null)
        {
            //if (identifier == "Active Projects")
            //    return Browser.Table("_ctl0_Content_ProjectGrid");
            //if (identifier == "Inactive Projects")
            //    return Browser.Table("_ctl0_Content_InactiveProjectGrid");

            return base.GetElementByName(identifier, areaIdentifier, listItem);
        }


        public override IPage ClickLink(string linkText)
        {
            base.ClickLink(linkText);

            if (linkText == "Add New Draft")
                return new ArchitectNewDraftPage();

            return this;
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
