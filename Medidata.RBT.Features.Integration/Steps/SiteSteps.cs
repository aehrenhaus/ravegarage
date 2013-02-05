using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Medidata.RBT.Objects.Integration.Helpers;
using TechTalk.SpecFlow;

namespace Medidata.RBT.Features.Integration.Steps
{
    [Binding]
    public class SiteSteps
    {
        [Given(@"the Site with site number ""(.*)"" exists in the Rave database")]
        public void TheSiteWithSiteNumber____ExistsInTheRaveDatabase(string siteNumber)
        {
            SiteHelper.CreateRaveSite(siteNumber);
        }
    }
}
