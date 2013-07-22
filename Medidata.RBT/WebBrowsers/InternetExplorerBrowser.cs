using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium.Remote;
using OpenQA.Selenium.IE;
using System.IO;

namespace Medidata.RBT
{
    /// <summary>
    /// class to encapsulate ie browser capabilites and options, and provide drive instance
    /// </summary>
    public class InternetExplorerBrowser : AbstractBrowser
    {
        DesiredCapabilities _browserCapabilities;

        /// <summary>
        /// A property to retrieve ie browser capabilities
        /// </summary>
        public override DesiredCapabilities BrowserCapabilities
        {
            get
            {
                return _browserCapabilities;
            }
        }

        /// <summary>
        /// Contructor to instantiate ie browser that initializes the desired browser capabilities
        /// </summary>
        public InternetExplorerBrowser()
        {
            CapabilityBuilder();
        }

        private void CapabilityBuilder()
        {
            _browserCapabilities = DesiredCapabilities.InternetExplorer();
        }

        /// <summary>
        /// Method to create instance of ie driver
        /// </summary>
        /// <returns>RemoteWebDriver object</returns>
        public override RemoteWebDriver CreateLocalWebDriver()
        {
            var driverPath = RBTConfiguration.Default.WebDriverPath;
            if (!Path.IsPathRooted(driverPath))
                driverPath = new DirectoryInfo(Path.Combine(AppDomain.CurrentDomain.BaseDirectory, driverPath)).FullName;

            return new InternetExplorerDriver(driverPath);
        }
    }
}
