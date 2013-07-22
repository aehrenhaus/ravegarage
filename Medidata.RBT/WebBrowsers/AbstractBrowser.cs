using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium.Remote;

namespace Medidata.RBT
{
    /// <summary>
    /// Abstract web browser class to implement common functionality
    /// </summary>
    public abstract class AbstractBrowser : IWebBrowser
    {
        /// <summary>
        /// Abstract browser capability property to be implemented by concrete class
        /// </summary>
        public abstract DesiredCapabilities BrowserCapabilities
        {
            get;
        }

        /// <summary>
        /// Virtual method to create remote web driver instance to be used with selenium grid
        /// </summary>
        /// <returns></returns>
        public virtual RemoteWebDriver CreateRemoteWebDriver()
        {
            return new ScreenShotRemoteWebDriver(new Uri(RBTConfiguration.Default.SeleniumServerUrl), BrowserCapabilities, TimeSpan.FromMinutes(2));
        }

        /// <summary>
        /// abstract method to create an instance of specific web driver to be implemented by concrete class
        /// </summary>
        /// <returns></returns>
        public abstract RemoteWebDriver CreateLocalWebDriver();
    }
}
