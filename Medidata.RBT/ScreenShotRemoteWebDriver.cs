using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium;
using OpenQA.Selenium.Remote;

namespace Medidata.RBT
{
    public class ScreenShotRemoteWebDriver : RemoteWebDriver, ITakesScreenshot
    {
        /// <summary>
        /// Initializes a new instance of the ScreenShotRemoteWebDriver class. This constructor defaults proxy to http://127.0.0.1:4444/wd/hub
        /// </summary>
        /// <param name="desiredCapabilities">An OpenQA.Selenium.ICapabilities object containing the desired capabilities of the browser.</param>
        public ScreenShotRemoteWebDriver(ICapabilities desiredCapabilities)
            : base(desiredCapabilities)
        {
        }

        /// <summary>
        /// Initializes a new instance of the ScreenShotRemoteWebDriver class
        /// </summary>
        /// <param name="commandExecutor">An OpenQA.Selenium.Remote.ICommandExecutor object which executes commands for the driver.</param>
        /// <param name="desiredCapabilities">An OpenQA.Selenium.ICapabilities object containing the desired capabilities of the browser.</param>
        public ScreenShotRemoteWebDriver(ICommandExecutor commandExecutor, ICapabilities desiredCapabilities)
            : base(commandExecutor, desiredCapabilities)
        {
        }

        /// <summary>
        /// Initializes a new instance of the ScreenShotRemoteWebDriver class
        /// </summary>
        /// <param name="remoteAddress">URI containing the address of the WebDriver remote server (e.g. http://127.0.0.1:4444/wd/hub).</param>
        /// <param name="desiredCapabilities">An OpenQA.Selenium.ICapabilities object containing the desired capabilities of the browser.</param>
        public ScreenShotRemoteWebDriver(Uri remoteAddress, ICapabilities desiredCapabilities)
            : base(remoteAddress, desiredCapabilities)
        {
        }

        /// <summary>
        /// Initializes a new instance of the ScreenShotRemoteWebDriver class using the specified remote address, desired capabilities, and command timeout.
        /// </summary>
        /// <param name="remoteAddress">URI containing the address of the WebDriver remote server (e.g. http://127.0.0.1:4444/wd/hub).</param>
        /// <param name="desiredCapabilities">An OpenQA.Selenium.ICapabilities object containing the desired capabilities of the browser.</param>
        /// <param name="commandTimeout">The maximum amount of time to wait for each command.</param>
        public ScreenShotRemoteWebDriver(Uri remoteAddress, ICapabilities desiredCapabilities, TimeSpan commandTimeout)
            : base(remoteAddress, desiredCapabilities, commandTimeout)
        {
        }

        /// <summary> 
        /// Gets a <see cref="Screenshot"/> object representing the image of the page on the screen. 
        /// </summary> 
        /// <returns>A <see cref="Screenshot"/> object containing the image.</returns> 
        public Screenshot GetScreenshot()
        {
            // Get the screenshot as base64. 
            Response screenshotResponse = this.Execute(DriverCommand.Screenshot, null);
            string base64 = screenshotResponse.Value.ToString();
            // ... and convert it. 
            return new Screenshot(base64);
        }
    }
}
