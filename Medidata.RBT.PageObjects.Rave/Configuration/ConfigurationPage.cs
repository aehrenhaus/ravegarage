using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Medidata.RBT.PageObjects.Rave.Configuration
{
    public class ConfigurationPage : ConfigurationBasePage
    {
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
