using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using Medidata.Core.Objects;
using Medidata.Data;
using Medidata.Data.Configuration;
using TechTalk.SpecFlow;

namespace Medidata.RBT.Objects.Integration.Helpers
{
    public class StudySiteHelper
    {
        public static void CreateRaveStudySite(int externalId) // needs to be converted to int
        {
            Study study = ScenarioContext.Current.Get<Study>("studyObject");
            Site site = ScenarioContext.Current.Get<Site>("siteObject");
            var studySite = new StudySite(study, site, SystemInteraction.Use())
                                {
                                    ExternalID = externalId
                                };

            studySite.Save();
        }
    }
}
