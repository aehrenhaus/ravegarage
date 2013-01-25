using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Medidata.Core.Objects;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using TechTalk.SpecFlow;

namespace Medidata.RBT.Features.Integration.Steps
{
    [Binding]
    public class StudySiteSteps
    {
        // For additional details on SpecFlow step definitions see http://go.specflow.org/doc-stepdef

        [Then(@"I should see the studysite in the Rave database")]
        public void ThenIShouldSeeTheStudySiteInTheRaveDatabase()
        {
            var studyUuid = ScenarioContext.Current.Get<String>("studyUuid");
            var siteUuid = ScenarioContext.Current.Get<String>("siteUuid");

            var study = Study.FindByUuid(studyUuid, 1, SystemInteraction.Use());
            var site = Site.FindByUuid(siteUuid, 1, SystemInteraction.Use());

            var studySite = StudySite.FindByStudyIDandSiteID(study.ID, site.ID, SystemInteraction.Use());

            Assert.IsNotNull(studySite);
            ScenarioContext.Current.Add("studySite", studySite);
        }
    }
}
