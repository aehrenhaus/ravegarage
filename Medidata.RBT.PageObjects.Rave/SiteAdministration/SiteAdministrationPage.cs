using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Medidata.RBT.PageObjects.Rave.SiteAdministration
{
    public class SiteAdministrationBasePage : RavePageBase
    {
        public override string URL
        {
            get { return "Modules/SiteAdmin/Sites.aspx"; }
        }
    }
}