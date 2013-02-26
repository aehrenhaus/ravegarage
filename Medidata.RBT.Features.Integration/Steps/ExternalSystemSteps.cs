using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Medidata.Core.Objects;
using Medidata.RBT.Objects.Integration.Helpers;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using TechTalk.SpecFlow;

namespace Medidata.RBT.Features.Integration.Steps
{
    [Binding]
    public class ExternalSystemSteps
    {
        

        [Then(@"the site should have the source iMedidata")]
        public void ThenTheSiteShouldHaveTheSourceIMedidata()
        {
            var site = ScenarioContext.Current.Get<Site>("site");

            Assert.AreEqual("iMedidata", site.ExternalSystem.Name);
        }

        [Then(@"the studysite should have the source iMedidata")]
        public void ThenTheStudysiteShouldHaveTheSourceIMedidata()
        {
            var studySite = ScenarioContext.Current.Get<StudySite>("studySite");

            Assert.AreEqual("iMedidata", studySite.ExternalSystem.Name);
        }
    }
}
