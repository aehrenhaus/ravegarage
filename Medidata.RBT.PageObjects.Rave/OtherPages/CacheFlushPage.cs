using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Collections.Specialized;

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
        /// <param name="typeToFlush">The type of object to flush</param>
        public static void PerformCacheFlush(string typeToFlush = null)
        {
            CacheFlushPage cacheFlushPage = new CacheFlushPage();
            if (typeToFlush == null)
                cacheFlushPage.NavigateToSelf();
            else
                cacheFlushPage.NavigateToSelf(new NameValueCollection() { { "type", typeToFlush } });

        }
        /// <summary>
        /// Perform cached flush followed by setting webtestcontext to login page post cacheflush
        /// </summary>
        /// <param name="context">The current web test context</param>
        /// <param name="typeToFlush">The type of object to flush</param>
        public static void PerformCacheFlush(WebTestContext context, string typeToFlush = null)
        {
            PerformCacheFlush(typeToFlush);
            if(typeToFlush == null)
                context.CurrentPage = new LoginPage();
            else
                context.CurrentPage = new CacheFlushPage();
        }

		protected override double PageNavigationTimeoutSeconds { get { return 300;/*5 mins*/ } }
    }
}
