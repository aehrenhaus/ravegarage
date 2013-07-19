using System;

namespace Medidata.RBT
{
    public interface IBrowserFactory
    {
        IWebBrowser CreateWebBrowser(BrowserNames browserName);
    }
}
