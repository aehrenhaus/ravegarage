using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Medidata.Core.Objects;
using Medidata.RBT.Objects.Integration.Configuration;
using Medidata.RBT.Objects.Integration.Helpers;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using TechTalk.SpecFlow;

namespace Medidata.RBT.Features.Integration.Steps
{
    [Binding]
    public class UserStudySiteSteps
    {
        [Then(@"I should see the UserStudySite assignment in the Rave database")]
        public void ThenIShouldSeeTheUserStudySiteAssignmentInTheRaveDatabase()
        {
            var study = ScenarioContext.Current.Get<Study>("studyObject");
            var site = ScenarioContext.Current.Get<Site>("siteObject");
            var studySite = StudySite.FindByStudyIDandSiteID(study.ID, site.ID, SystemInteraction.Use());
            
            var user = ScenarioContext.Current.Get<User>("userObject");          
            var isAssigned = user.IsUserAssociatedWithStudySite(studySite);
            
            Assert.IsTrue(isAssigned);
            //ScenarioContext.Current.Add("site", site);
        }
    }
}
