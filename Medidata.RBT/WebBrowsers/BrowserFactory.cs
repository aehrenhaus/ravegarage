using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium.Remote;

namespace Medidata.RBT
{
    /// <summary>
    /// Factory class to let user retrieve browser objects with different capabilities and options
    /// </summary>
    public class BrowserFactory : IBrowserFactory
    {
        /// <summary>
        /// Method that return IWebBrowser object based on the browser name
        /// unity container is used to resolve the dependency based on browser name
        /// </summary>
        /// <returns></returns>
        public IWebBrowser CreateWebBrowser(BrowserNames browserName)
        {
            return (IWebBrowser)RBTModule.Instance.Container.Resolve(typeof(IWebBrowser), browserName.ToString());
        }
    }
}
