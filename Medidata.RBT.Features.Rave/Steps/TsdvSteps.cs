using TechTalk.SpecFlow;
using Medidata.RBT.PageObjects.Rave;
using TechTalk.SpecFlow.Assist;
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

        /// <summary>
        /// TSDV step to delete tier from block plan
        /// Tier can only be deleted from study not in prod environment
        /// </summary>
        /// <param name="tierName"></param>
        [StepDefinition(@"I delete the tier ""([^""]*)"" from plan")]
        public void IDeleteTier____FromPlan(string tierName)
        {
            CurrentPage.As<StudyBlockPlansPage>().DeleteTier(tierName);
        }

        /// <summary>
        /// Selects the specified tier type with subject count from the "Link Tier" option
        /// Ex: I select the tier "All Forms" and Subject Count "1"
        /// </summary>
        /// <param name="tierName"></param>
        /// <param name="subjectCount"></param>
        [StepDefinition(@"I select the tier ""([^""]*)"" and Subject Count ""([^""]*)""")]
        public void ISelectTier____AndSubjectCount____(string tierName, string subjectCount)
        {
            CurrentPage.As<StudyBlockPlansPage>().ApplyTierWithSubjectCount(tierName, subjectCount);
        }

        /// <summary>
        /// Method used to edit blocks, with the supplied information
        /// </summary>
        /// <param name="table">all attributes for each TSDV Block</param>
        [Given(@"I edit Blocks")]
        public void GivenIEditBlocks(Table table)
        {
            CurrentPage.As<BlockPlansPageBase>().BlocksEdit(table.CreateSet<TSDVObjectModel>());
        }


        /// <summary>
        /// 
        /// </summary>
        /// <param name="tierName"></param>
        /// <param name="description"></param>
        /// <param name="table"></param>
        [StepDefinition(@"I create a custom tier named ""([^""]*)"" and description ""([^""]*)"" with table")]
        public void ICreateACustomTierNamed____AndDescription____WithTable(string tierName, string description, Table table)
        {
            CurrentPage.As<BlockPlansPageBase>().ClickLink("Create Custom Tier");

            CurrentPage.As<CustomTierDraftPage>().CreateCustomTierDraft(tierName, description, table.CreateSet<CustomTierModel>());
        }

        /// <summary>
        /// Step definition to create a new plan using plan name and data entry role specified
        /// </summary>
        /// <param name="planName"></param>
        /// <param name="dataEntryRole"></param>
        [StepDefinition(@"I create a new block plan named ""([^""]*)"" with Data entry Role ""([^""]*)""")]
        public void ICreateANewBlockPlanNamed____WithDataEntryRole____(string planName, string dataEntryRole)
        {
            CurrentPage.As<BlockPlansPageBase>().CreateNewBlockPlan(planName, dataEntryRole);
        }


    }
}
