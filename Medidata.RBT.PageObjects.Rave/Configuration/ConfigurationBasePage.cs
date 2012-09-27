using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using TechTalk.SpecFlow;

namespace Medidata.RBT.PageObjects.Rave.Configuration
{
    
    public class ConfigurationBasePage :PageBase
    {

        public override IPage NavigateTo(string name)
        {
            Browser.FindElementByLinkText(name).Click();
            switch (name)
            {
                case "Configuration Loader": return new ConfigurationLoaderPage();
                case "Other Settings":
                    return new ConfigurationSettingsPage(); 
                case "Coder Configuration":
                    return new CoderConfigurationPage();
                case "Configuration":
                    return new ConfigurationPage();
            }
            throw new Exception("Dont know how to navigate to " + name);
        }

        

    }
}
