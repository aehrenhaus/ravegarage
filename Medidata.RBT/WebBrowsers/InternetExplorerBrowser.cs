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
    /// 
    /// </summary>
    public class InternetExplorerBrowser : AbstractBrowser
    {
        DesiredCapabilities _browserCapabilities;

        /// <summary>
        /// 
        /// </summary>
        public override DesiredCapabilities BrowserCapabilities
        {
            get
            {
                return _browserCapabilities;
            }
        }

        /// <summary>
        /// 
        /// </summary>
        public InternetExplorerBrowser()
        {
            CapabilityBuilder();
        }

        private void CapabilityBuilder()
        {
            _browserCapabilities = DesiredCapabilities.InternetExplorer();
        }

        public override RemoteWebDriver CreateLocalWebDriver()
        {
            var driverPath = RBTConfiguration.Default.WebDriverPath;
            if (!Path.IsPathRooted(driverPath))
                driverPath = new DirectoryInfo(Path.Combine(AppDomain.CurrentDomain.BaseDirectory, driverPath)).FullName;

            return new InternetExplorerDriver(driverPath);
        }
    }
}
