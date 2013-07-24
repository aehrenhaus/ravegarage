using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium.Remote;
using System.IO;
using OpenQA.Selenium.Chrome;
using Medidata.RBT.ConfigurationHandlers;

namespace Medidata.RBT
{
    /// <summary>
    /// class used to specify capabilities and options for chrome browser
    /// </summary>
    public class ChromeBrowser : AbstractBrowser
    {
        DesiredCapabilities _browserCapabilities;

        /// <summary>
        /// Property to retieve chrome browser capabilites
        /// </summary>
        public override DesiredCapabilities BrowserCapabilities
        {
            get
            {
                return _browserCapabilities;
            }
        }

        /// <summary>
        /// Contructor to create an instance of Chrome browser class
        /// </summary>
        public ChromeBrowser()
        {
            CapabilityBuilder();
        }

        private void CapabilityBuilder()
        {
            _browserCapabilities = DesiredCapabilities.Chrome();
        }

        /// <summary>
        /// Method to create instance of chrome driver
        /// </summary>
        /// <returns>RemoteWebDriver object</returns>
        public override RemoteWebDriver CreateLocalWebDriver()
        {
            var driverPath = RBTConfiguration.Default.WebDriverPath;
            if (!Path.IsPathRooted(driverPath))
                driverPath = new DirectoryInfo(Path.Combine(AppDomain.CurrentDomain.BaseDirectory, driverPath)).FullName;

            return new ChromeDriver(driverPath);
        }
    }
}
