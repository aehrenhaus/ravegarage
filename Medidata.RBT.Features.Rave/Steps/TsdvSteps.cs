using TechTalk.SpecFlow;
using Medidata.RBT.PageObjects.Rave;

using Microsoft.VisualStudio.TestTools.UnitTesting;

namespace Medidata.RBT.Features.Rave
{
	[Binding]
	public class TsdvSteps : BrowserStepsBase
	{

        [StepDefinition(@"I verify that Tiers in subject override table are not in the following order")]
        public void IVerifyThatTiersInSubjectOverrideTableAreNotInTheFollowingOrder(Table table)
        {
            bool isSubjectRandomized = CurrentPage.As<SubjectOverridePage>().IsSubjectsRandomized(table);
            Assert.IsTrue(isSubjectRandomized, "Subjects enrolled sequentially");
        }

        [StepDefinition(@"I filter by site ""([^""]*)""")]
        public void IfilterBySite(string siteName)
        {
            CurrentPage.As<SubjectManagementPageBase>().FilterBySite(siteName);
        }

        [StepDefinition(@"I include ([^""]*) subjects in TSDV")]
        public void IIncludeAllSubjectsInTSDV(string numSubjects)
        {
            int num;
            if (int.TryParse(numSubjects, out num))
                CurrentPage.As<SubjectIncludePage>().IncludeSubjects(num);
        }

        [StepDefinition(@"I inactivate the plan")]
        public void IInactivatePlan()
        {
            CurrentPage.As<BlockPlansPageBase>().InactivatePlan();
        }

        [StepDefinition(@"I activate the plan")]
        public void IActivatePlan()
        {
            CurrentPage.As<BlockPlansPageBase>().ActivatePlan();
        }
    }
}
