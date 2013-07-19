using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium.Remote;

namespace Medidata.RBT
{
    /// <summary>
    /// 
    /// </summary>
    public class BrowserFactory : IBrowserFactory
    {
        /// <summary>
        /// 
        /// </summary>
        /// <returns></returns>
        public IWebBrowser CreateWebBrowser(BrowserNames browserName)
        {
            return (IWebBrowser)RBTModule.Instance.Container.Resolve(typeof(IWebBrowser), browserName.ToString());
        }
    }
}
