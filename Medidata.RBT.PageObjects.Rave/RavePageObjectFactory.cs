using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Reflection;

namespace Medidata.RBT.PageObjects.Rave
{
    public class RavePageObjectFactory : AbstractPageObjectFactory
    {
        protected override System.Reflection.Assembly[] GetContainingAssemblies()
        {
            return new Assembly[] { typeof(RavePageObjectFactory).Assembly };
        }

        public override IPage GetPageByUrl(Uri uri)
        {
            IPage page = base.GetPageByUrl(uri);
            if (page.GetType() == typeof(PageBase))
                return new RavePageBase();
            else
                return page;
        }

    }
}
