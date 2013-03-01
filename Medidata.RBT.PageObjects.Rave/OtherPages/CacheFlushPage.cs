using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Medidata.RBT.PageObjects.Rave
{
    public class CacheFlushPage : RavePageBase
    {
        public override string URL
        {
            get { return "CacheFlush.aspx"; }
        }

        /// <summary>
        /// Perform cached flush followed by setting webtestcontext to login page post cacheflush
        /// </summary>
        /// <param name="context"></param>
        public static void PerformCacheFlush(WebTestContext context)
        {
            CacheFlushPage cacheFlushPage = new CacheFlushPage();
            cacheFlushPage.NavigateToSelf();
            context.CurrentPage = new LoginPage();
        }

		protected override double PageNavigationTimeoutSeconds { get { return 300;/*5 mins*/ } }
    }
}
