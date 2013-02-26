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
        [Given(@"the current User is assigned to the the current StudySite")]
        public void GivenTheCurrentUserIsAssignedToTheTheCurrentStudySite()
        {
            UserStudySiteHelper.CreateUserStudySiteAssignment();
        }


        [Then(@"I should see the UserStudySite assignment in the Rave database")]
        public void ThenIShouldSeeTheUserStudySiteAssignmentInTheRaveDatabase()
        {
            var study = ScenarioContext.Current.Get<Study>("study");
            var site = ScenarioContext.Current.Get<Site>("site");
            var studySite = StudySite.FindByStudyIDandSiteID(study.ID, site.ID, SystemInteraction.Use());
            
            var user = ScenarioContext.Current.Get<User>("user");          
            var isAssigned = user.IsUserAssociatedWithStudySite(studySite);
            
            Assert.IsTrue(isAssigned);
        }

        [Then(@"The user should not have a UserStudySite assignment in the Rave database")]
        public void ThenTheUserShouldNotBeAssignedToTheStudySite()
        {
            var study = ScenarioContext.Current.Get<Study>("study");
            var site = ScenarioContext.Current.Get<Site>("site");
            var studySite = StudySite.FindByStudyIDandSiteID(study.ID, site.ID, SystemInteraction.Use());

            var user = ScenarioContext.Current.Get<User>("user");
            var isAssigned = user.IsUserAssociatedWithStudySite(studySite);

            Assert.IsFalse(isAssigned);
        }
    }
}
