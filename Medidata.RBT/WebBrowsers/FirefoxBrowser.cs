using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium;
using OpenQA.Selenium.Firefox;
using OpenQA.Selenium.Remote;
using System.IO;
using Medidata.RBT.ConfigurationHandlers;

namespace Medidata.RBT
{
    /// <summary>
    /// class to encapsulate firefox browser capabilites and options, and provide drive instance
    /// </summary>
    public class FirefoxBrowser : AbstractBrowser
    {
        DesiredCapabilities _browserCapabilities;

        /// <summary>
        /// A property to retrieve firefox browser capabilities
        /// </summary>
        public override DesiredCapabilities BrowserCapabilities
        {
            get
            {
                return _browserCapabilities;
            }
        }

        /// <summary>
        /// Contructor to instantiate firefox browser that initializes the desired browser capabilities
        /// </summary>
        public FirefoxBrowser()
        {
            CapabilityBuilder();
        }

        private void CapabilityBuilder()
        {
            _browserCapabilities = DesiredCapabilities.Firefox();
            FirefoxProfile p = GetFirefoxProfile();
            _browserCapabilities.SetCapability(FirefoxDriver.ProfileCapabilityName, p);
            _browserCapabilities.SetCapability(FirefoxDriver.BinaryCapabilityName,
                Path.Combine(AppDomain.CurrentDomain.BaseDirectory, RBTConfiguration.Default.BrowserPath));
        }

        private FirefoxProfile GetFirefoxProfile()
        {
            FirefoxProfile p = new FirefoxProfile();
            p.SetPreference("browser.download.folderList", 2);
            p.SetPreference("browser.download.manager.showWhenStarting", false);
            p.SetPreference("browser.download.dir", RBTConfiguration.Default.DownloadPath.ToUpper());
            p.SetPreference("browser.helperApps.neverAsk.saveToDisk", RBTConfiguration.Default.AutoSaveMimeTypes);
            return p;
        }

        /// <summary>
        /// Method to create instance of firefox driver
        /// </summary>
        /// <returns>RemoteWebDriver object</returns>
        public override RemoteWebDriver CreateLocalWebDriver()
        {
            return new FirefoxDriver(_browserCapabilities);
        }
    }
}
