using System;

namespace Medidata.RBT
{
    /// <summary>
    /// interface for implementing browser factory class
    /// </summary>
    public interface IBrowserFactory
    {
        IWebBrowser CreateWebBrowser(BrowserNames browserName);
    }
}
