using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium.Remote;

namespace Medidata.RBT
{
    /// <summary>
    /// Interface that can be used to define capabilities and options for a web browser
    /// and provide the necessary drivers
    /// </summary>
    public interface IWebBrowser
    {
        /// <summary>
        /// Property to define various Selenium desired capabilities for the browser of choice
        /// </summary>
        DesiredCapabilities BrowserCapabilities { get; }

        /// <summary>
        /// Method to instantiate web driver controlled by selenium grid hub
        /// </summary>
        /// <returns>remote web driver</returns>
        RemoteWebDriver CreateRemoteWebDriver();

        /// <summary>
        /// Method to instantiate web driver without calling selenium grid hub
        /// </summary>
        /// <returns>remote web driver</returns>
        RemoteWebDriver CreateLocalWebDriver();
    }
}
