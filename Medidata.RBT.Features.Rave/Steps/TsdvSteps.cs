using TechTalk.SpecFlow;
using Medidata.RBT.PageObjects.Rave;
using TechTalk.SpecFlow.Assist;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Medidata.RBT.PageObjects.Rave.TSDV;
using System.Collections.Generic;
using Medidata.RBT.PageObjects.Rave.TableModels;

namespace Medidata.RBT.Features.Rave
{
    /// <summary>
    /// Steps pertaining to TSDV
    /// </summary>
	[Binding]
	public class TsdvSteps : BrowserStepsBase
	{
        /// <summary>
        /// Verify that tiers in the subject override table are not in the specified order
        /// </summary>
        /// <param name="table">The order of the the tiers in the subject override table</param>
        [StepDefinition(@"I verify that Tiers in subject override table are not in the following order")]
        public void IVerifyThatTiersInSubjectOverrideTableAreNotInTheFollowingOrder(Table table)
        {
            bool isSubjectRandomized = CurrentPage.As<SubjectOverridePage>().IsSubjectsRandomized(table);
            Assert.IsTrue(isSubjectRandomized, "Subjects enrolled sequentially");
        }

        [StepDefinition(@"I verify that Tiers in subject override table are in the following order")]
        public void ThenIVerifyThatTiersInSubjectOverrideTableAreInTheFollowingOrder(Table table)
        {
            bool isSubjectRandomized = CurrentPage.As<SubjectOverridePage>().VerifyTableRowsExist(table);
            Assert.IsTrue(isSubjectRandomized, "Subjects enrolled to wrong tiers");
        }

        /// <summary>
        /// Verify that there is not a repeating pattern in every rowsTotal rows in a list of rowsTotal amount of rows
        /// </summary>
        /// <param name="rowsOfGroup">Check for a repeating pattern every amount of rows equal to this</param>
        /// <param name="rowsTotal">The amount of rows to check for the repeating pattern</param>
		[StepDefinition(@"I verify every (.*) rows of subjects in (.*) rows do not have tiers pattern")]
		public void IVerifyEvery____RowsOfSubjectsIn____RowsDoNotHaveTiersPattern(int rowsOfGroup, int rowsTotal)
		{
			CurrentPage.As<SubjectOverridePage>().AsserEachGroupOfSubjectsHaveDifferentTierNames(rowsOfGroup, rowsTotal);
		}

        /// <summary>
        /// Verify that out of a table of permutations that one has been used every blockSize of subjects
        /// </summary>
        /// <param name="blockSize">The amount of subjects to search</param>
        /// <param name="table">The table of permutations to look for</param>
		[StepDefinition(@"I verify that one of the following Permutations has been used every (.+) subjects")]
		public void IVerifyThatOneOfTheFolowingPermutationsHasBeenUsedEvery____Subjects(int blockSize, Table table)
		{
			CurrentPage.As<SubjectOverridePage>().CheckRepeatPattern(blockSize, table.CreateSet<Permutations>());
		}

        /// <summary>
        /// Verify that out of a table of permutations that one has been used every blockSize of subjects with the passed in name
        /// </summary>
        /// <param name="blockSize">The amount of subjects to search</param>
        /// <param name="name">The subject to search for</param>
        /// <param name="table">The table of permutations to look for</param>
		[StepDefinition(@"I verify that one of the following Permutations has been used every (.+) subjects with name (.+)")]
		public void IVerifyThatOneOfTheFolowingPermutationsHasBeenUsedEvery____Subjects(int blockSize, string name, Table table)
		{
			CurrentPage.As<SubjectOverridePage>().CheckRepeatPattern(blockSize, table.CreateSet<Permutations>(), name);
		}

        /// <summary>
        /// Include a certain number of subjects in TSDV
        /// </summary>
        /// <param name="numSubjects">Number of subjects to include</param>
        [StepDefinition(@"I include ([^""]*) subjects in TSDV")]
        public void IInclude____SubjectsInTSDV(string numSubjects)
        {
            int num;
            if (int.TryParse(numSubjects, out num))
                CurrentPage.As<SubjectIncludePage>().IncludeSubjects(num);
        }

        /// <summary>
        /// Inactivate a TSDV plan
        /// </summary>
        [StepDefinition(@"I inactivate the plan")]
        public void IInactivatePlan()
        {
            CurrentPage.As<BlockPlansPageBase>().InactivatePlan();
        }

        /// <summary>
        /// Activate a TSDV plan
        /// </summary>
        [StepDefinition(@"I activate the plan")]
        public void IActivatePlan()
        {
            CurrentPage.As<BlockPlansPageBase>().ActivatePlan();
        }

        /// <summary>
        /// Method used to edit blocks, with the supplied information
        /// </summary>
        /// <param name="table">all attributes for each TSDV Block</param>
        [StepDefinition(@"I edit Blocks")]
        public void GivenIEditBlocks(Table table)
        {
            CurrentPage.As<BlockPlansPageBase>().BlocksEdit(table.CreateSet<TSDVObjectModel>());
        }

        /// <summary>
        /// TSDV step to delete tier from block plan
        /// Tier can only be deleted from study not in prod environment
        /// </summary>
        /// <param name="tierName"></param>
        [StepDefinition(@"I delete the tier ""([^""]*)"" from plan")]
        public void IDeleteTier____FromPlan(string tierName)
        {
			CurrentPage.As<BlockPlansPageBase>().DeleteTier(tierName);
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
			CurrentPage.As<BlockPlansPageBase>().ApplyTierWithSubjectCount(tierName, subjectCount, null);
        }

      
        [StepDefinition(@"I select the tier ""(.*)"" and Subject Count ""(.*)"" for ""(.*)""")]
        public void ISelectTier____AndSubjectCount____For___(string tierName, string subjectCount, string areaIndentifier)
        {
            CurrentPage.As<BlockPlansPageBase>().ApplyTierWithSubjectCount(tierName, subjectCount, areaIndentifier);
        }

        [StepDefinition(@"I update the tier ""(.*)"" and Subject Count ""(.*)"" for ""(.*)""")]
        public void IUpdateTier____AndSubjectCount____For___(string tierName, string subjectCount, string areaIndentifier)
        {
            CurrentPage.As<BlockPlansPageBase>().UpdateTierWithSubjectCount(tierName, subjectCount, areaIndentifier);
        }

        /// <summary>
        /// Remove all custom tiers
        /// </summary>
		[StepDefinition(@"I remove all custom tiers")]
		public void IRemoveAllCustomTiers()
		{
			CurrentPage.As<TiersPage>().RemoveTiers();
		}

        /// <summary>
        /// Create a custom tier with a passed in name, description, and table
        /// </summary>
        /// <param name="tierName">Name of the tier</param>
        /// <param name="description">Description of the tier</param>
        /// <param name="table">Table of the tier</param>
        [StepDefinition(@"I create a custom tier named ""([^""]*)"" and description ""([^""]*)"" with table")]
        public void ICreateACustomTierNamed____AndDescription____WithTable(string tierName, string description, Table table)
        {
            CurrentPage.As<BlockPlansPageBase>().ClickLink("Create Custom Tier");

            CurrentPage.As<CustomTierDraftPage>().CreateCustomTierDraft(tierName, description, table.CreateSet<CustomTierModel>());
        }

        /// <summary>
        /// Step definition to create a new plan using plan name and data entry role specified
        /// </summary>
        /// <param name="planName">The name of the block plan</param>
        /// <param name="dataEntryRole">The data entry role of the block plan</param>
        [StepDefinition(@"I create a new block plan named ""([^""]*)"" with Data entry Role ""([^""]*)""")]
        public void ICreateANewBlockPlanNamed____WithDataEntryRole____(string planName, string dataEntryRole)
        {
              CurrentPage.As<BlockPlansPageBase>().CreateNewBlockPlan(planName, dataEntryRole);
        }

		/// <summary>
		/// Enables TSDV by calling spTSDVGlobalSwitch
		/// </summary>
		[StepDefinition(@"TSDV is enabled")]
		public void TsdvIsEnabled()
		{
            TsdvDao.Instance.TSDVEnabled = true;
		}

		/// <summary>
		/// Disables TSDV by calling spTSDVGlobalSwitch
		/// </summary>
		[StepDefinition(@"TSDV is disabled")]
		public void TsdvIsDisabled()
		{
            TsdvDao.Instance.TSDVEnabled = false;
		}

        /// <summary>
        /// Select fields for custom tier
        /// </summary>
        /// <param name="table"></param>
        [StepDefinition(@"I select fields in Custom Tier and save")]
        public void ISelectFieldsInCustomTierAndSave(Table table)
        {
            IEnumerable<TSDVFormFieldsModel> fields = table.CreateSet<TSDVFormFieldsModel>();

            CurrentPage.As<CustomTierDraftPage>().SelectFieldsCustomTierDraft(fields, false, true);

        }

        /// <summary>
        /// Select fields for custom tier without publish
        /// </summary>
        /// <param name="table"></param>
        [StepDefinition(@"I select fields in Custom Tier")]
        public void ISelectFieldsInCustomTier(Table table)
        {
            IEnumerable<TSDVFormFieldsModel> fields = table.CreateSet<TSDVFormFieldsModel>();

            CurrentPage.As<CustomTierDraftPage>().SelectFieldsCustomTierDraft(fields, false, false);

        }

        /// <summary>
        /// Select button "Publish Draft" with check "Run Retrospective"
        /// </summary>
        [StepDefinition(@"I select button ""Publish Draft"" with check ""Run Retrospective""")]
        public void PublishDraftWithRunRetrospective()
        {
            CurrentPage = CurrentPage.As<CustomTierDraftPage>().PublishDraftWithRunRetrospective();
        }


        /// <summary>
        /// Is the verify custom tier included field.
        /// </summary>
        /// <param name="table">The table.</param>
        [StepDefinition(@"I verify Custom Tier Field")]
        public void IVerifyCustomTierIncludedField(Table table)
        {
            IEnumerable<TSDVFormFieldsModel> fields = table.CreateSet<TSDVFormFieldsModel>();

            bool actual = CurrentPage.As<CustomTierPage>().SelectFieldsCustomTierDraft(fields, true, false);

            Assert.AreEqual(true, actual, "Field(s) not included in TSDV Custom Tier");
        }

        /// <summary>
        /// Method used to edit blocks, with the supplied information
        /// </summary>
        /// <param name="table">all attributes for each TSDV Block</param>
        [StepDefinition(@"I create a new block and save")]
        public void ICreateANewBlockAndSave(Table table)
        {
           CurrentPage.As<BlockPlansPageBase>().AddBlocks(table.CreateSet<TSDVBlockModel>());
        }

        /// <summary>
        /// Move a Subject to another Tier
        /// </summary>
        /// <param name="table"></param>
        [StepDefinition(@"I Override Subject")]
        public void ThenIOverrideSubject(Table table)
        {
            CurrentPage = CurrentPage.As<SubjectOverridePage>().OverrideSubject(table);
        }
	}
}
