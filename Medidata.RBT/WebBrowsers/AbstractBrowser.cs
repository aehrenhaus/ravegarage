using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium.Remote;

namespace Medidata.RBT
{
    public abstract class AbstractBrowser : IWebBrowser
    {
        public abstract DesiredCapabilities BrowserCapabilities
        {
            get;
        }

        public virtual RemoteWebDriver CreateRemoteWebDriver()
        {
            return new ScreenShotRemoteWebDriver(new Uri(RBTConfiguration.Default.SeleniumServerUrl), BrowserCapabilities, TimeSpan.FromMinutes(2));
        }

        public abstract RemoteWebDriver CreateLocalWebDriver();
    }
}
