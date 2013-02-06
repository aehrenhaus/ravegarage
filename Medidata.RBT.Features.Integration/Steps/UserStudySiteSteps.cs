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
            var studyUuid = ScenarioContext.Current.Get<String>("studyUuid");
            var study = Study.FindByUuid(studyUuid, 1, SystemInteraction.Use());
            var siteUuid = ScenarioContext.Current.Get<String>("siteUuid");
            var site = Site.FindByUuid(siteUuid, 1, SystemInteraction.Use());
            var studySite = StudySite.FindByStudyIDandSiteID(study.ID, site.ID, SystemInteraction.Use());
            
            var user = ScenarioContext.Current.Get<User>("userObject");          
            var isAssigned = user.IsUserAssociatedWithStudySite(studySite);
            
            Assert.IsTrue(isAssigned);
        }

        [Then(@"The user should not have a UserStudySite assignment in the Rave database")]
        public void ThenTheUserShouldNotBeAssignedToTheStudySite()
        {
            var studyUuid = ScenarioContext.Current.Get<String>("studyUuid");
            var study = Study.FindByUuid(studyUuid, 1, SystemInteraction.Use());
            var siteUuid = ScenarioContext.Current.Get<String>("siteUuid");
            var site = Site.FindByUuid(siteUuid, 1, SystemInteraction.Use());
            var studySite = StudySite.FindByStudyIDandSiteID(study.ID, site.ID, SystemInteraction.Use());

            var user = ScenarioContext.Current.Get<User>("userObject");
            var isAssigned = user.IsUserAssociatedWithStudySite(studySite);

            Assert.IsFalse(isAssigned);
        }
    }
}
