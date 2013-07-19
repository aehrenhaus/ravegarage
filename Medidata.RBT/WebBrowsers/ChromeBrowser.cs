using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium.Remote;
using System.IO;
using OpenQA.Selenium.Chrome;

namespace Medidata.RBT
{
    /// <summary>
    /// 
    /// </summary>
    public class ChromeBrowser : AbstractBrowser
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
        public ChromeBrowser()
        {
            CapabilityBuilder();
        }

        private void CapabilityBuilder()
        {
            _browserCapabilities = DesiredCapabilities.Chrome();
        }

        public override RemoteWebDriver CreateLocalWebDriver()
        {
            var driverPath = RBTConfiguration.Default.WebDriverPath;
            if (!Path.IsPathRooted(driverPath))
                driverPath = new DirectoryInfo(Path.Combine(AppDomain.CurrentDomain.BaseDirectory, driverPath)).FullName;

            return new ChromeDriver(driverPath);
        }
    }
}
