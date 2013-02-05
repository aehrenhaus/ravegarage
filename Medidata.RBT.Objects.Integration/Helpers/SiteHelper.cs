using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Medidata.Core.Objects;
using TechTalk.SpecFlow;

namespace Medidata.RBT.Objects.Integration.Helpers
{
    public static class SiteHelper
    {
        public static void CreateRaveSite(string siteNumber)
        {
            var site = new Site(SystemInteraction.Use())
                           {
                               Active = true,
                               Number = siteNumber,
                               ExternalSystem = ExternalSystem.GetByID(1),
                               Uuid = Guid.NewGuid().ToString()
                           };
            site.Save();
            ScenarioContext.Current.Add("siteObject", site);
        }
    }
}
