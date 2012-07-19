using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Medidata.RBT.Features;
using TechTalk.SpecFlow;
using Medidata.RBT.PageObjects;
using Medidata.RBT.PageObjects.Rave;
using System.IO;
using Microsoft.Practices.EnterpriseLibrary.Data;
using System.Data;
using Microsoft.VisualStudio.TestTools.UnitTesting;

namespace Medidata.RBT.Features.Rave
{
	[Binding]
	public class TsdvSteps : BrowserStepsBase
	{

        [Then(@"I verify that Tiers in subject override table are not in the following order")]
        public void ThenIVerifyThatTiersInSubjectOverrideTableAreNotInTheFollowingOrder(Table table)
        {
            bool isSubjectRandomized = CurrentPage.As<SubjectOverridePage>().IsSubjectsRandomized(table);
            Assert.IsTrue(isSubjectRandomized, "Subjects enrolled sequentially");
        }

        [StepDefinition(@"I filter by site ""([^""]*)""")]
        public void AndIfilterBySite(string siteName)
        {
            CurrentPage.As<SubjectOverridePage>().FilterBySite(siteName);
        }

        [When(@"I include all subjects in TSDV")]
        public void WhenIIncludeAllSubjectsInTSDV()
        {
           ScenarioContext.Current.Pending();
        }

        [StepDefinition(@"I inactivate the plan")]
        public void AndIInactivatePlan()
        {
            CurrentPage.As<SiteBlockPlansPage>().InactivatePlan();
        }

        [StepDefinition(@"I activate the plan")]
        public void AndIActivatePlan()
        {
            CurrentPage.As<SiteBlockPlansPage>().ActivatePlan();
        }
    
    }
}
