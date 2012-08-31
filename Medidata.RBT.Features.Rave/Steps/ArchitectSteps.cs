using TechTalk.SpecFlow;
using Medidata.RBT.PageObjects.Rave;
using TechTalk.SpecFlow.Assist;
using Microsoft.VisualStudio.TestTools.UnitTesting;

namespace Medidata.RBT.Features.Rave
{
	[Binding]
	public class ArchitectSteps : BrowserStepsBase
	{
		[StepDefinition(@"I publish and push CRF Version ""([^""]*)"" of Draft ""([^""]*)"" to site ""([^""]*)"" in Study ""([^""]*)""")]
		public void IPublishAndPushCRFVersion____OfDraftToSite____InStudy____(string crfName, string draftName, string siteName, string studyName)
		{

		}

		[StepDefinition(@"I create Draft ""([^""]*)"" from Project ""([^""]*)"" and Version ""([^""]*)""")]
		public void GivenICreateDraft____FromProject____AndVersion____(string draftName, string project, string version)
		{
			draftName = SpecialStringHelper.Replace( draftName);
			project =SpecialStringHelper.Replace(project);
			version = SpecialStringHelper.Replace(version);
			CurrentPage = CurrentPage.As<ArchitectLibraryPage>().CreateDraftFromProject(draftName,project,version);
		}


        [StepDefinition(@"I select Draft ""([^""]*)""")]
        public void GivenICreateDraft____FromProject____AndVersion____(string draftName)
        {
            draftName = SpecialStringHelper.Replace(draftName);
            CurrentPage = CurrentPage.As<ArchitectLibraryPage>().SelectDraft(draftName);
        }


		[StepDefinition(@"I publish CRF Version ""([^""]*)""")]
		public void GivenIPublishCRFVersion____(string crfVersion)
		{
			crfVersion = SpecialStringHelper.Replace(crfVersion);
			CurrentPage.As<ArchitectCRFDraftPage>().PublishCRF(crfVersion);
			
		}

		[StepDefinition(@"I push CRF Version ""([^""]*)"" to ""([^""]*)""")]
		public void GivenIPublishCRFVersion____(string crfVersion, string sites)
		{
			crfVersion = SpecialStringHelper.Replace(crfVersion);
			sites = SpecialStringHelper.Replace(sites);
			CurrentPage.As<ArchitectLibraryPage>().PushVersion(crfVersion,"Prod", sites);

		}

		[StepDefinition(@"I select ""Target\{RndNum\(3\)}"" from ""Target CRF""")]
		public void GivenISelectTargetRndNum3FromTargetCRF()
		{
			ScenarioContext.Current.Pending();
		}

		[StepDefinition(@"I select ""V1"" from ""Source CRF""")]
		public void GivenISelectV1FromSourceCRF()
		{
			ScenarioContext.Current.Pending();
		}

		[StepDefinition(@"I migrate all Subjects")]
		public void IMigrateAllSubjects()
		{
			CurrentPage = CurrentPage.As<AMMigrationExecutePage>().Migrate();
		}

        [StepDefinition(@"I verify Job Status is set to Complete")]
		public void GivenISelectMigrationResultsAndVerifyJobStatusIsSetToComplete()
		{
			CurrentPage.As<AMMigrationResultPage>().WaitForComplete();
		}

        [StepDefinition(@"I search for form ""([^""]*)""")]
        public void ISearchForForm____(string form)
        {
            CurrentPage = CurrentPage.As<ArchitectFormsPage>().SearchForForm(form);
        }

        [StepDefinition(@"I select Fields for Form ""([^""]*)""")]
        public void ISelectFieldsForForm____(string form)
        {
            ISearchForForm____(form);
            CurrentPage = CurrentPage.As<ArchitectFormsPage>().SelectFieldsForForm(form);
        }

        [StepDefinition(@"I edit Field ""([^""]*)""")]
        public void IEditField____(string field)
        {
            CurrentPage = CurrentPage.As<ArchitectFormDesignerPage>().EditField(field);
        }
        
        [StepDefinition(@"I expand ""Field Edit Checks""")]
        public void IExpandFieldEditChecks()
        {
            CurrentPage = CurrentPage.As<ArchitectFormDesignerPage>().ExpandEditChecks();
        }


        [StepDefinition(@"I enter ranges for Field Edit Checks and save")]
        public void IEnterRangesForFieldEditChecksAndSave(Table table)
        {
            IEnterRangesForFieldEditChecks(table);

            CurrentPage.As<ArchitectFormDesignerPage>().Save();
        }


        [StepDefinition(@"I enter ranges for Field Edit Checks")]
        public void IEnterRangesForFieldEditChecks(Table table)
        {
             CurrentPage.As<ArchitectFormDesignerPage>().FillRangesForFieldEditChecks(table.CreateSet<FieldModel>());
        }


        [StepDefinition(@"I should see ranges for Field Edit Checks")]
        public void ISeeRangesForFieldEditChecks(Table table)
        {
            bool found = CurrentPage.As<ArchitectFormDesignerPage>().FerifyRangesForFieldEditChecks(table.CreateSet<FieldModel>());
            Assert.IsTrue(found, "Ranges for field do not match.");
        }

        [StepDefinition(@"I should not see ranges for Field Edit Checks")]
        public void IDontSeeRangesForFieldEditChecks(Table table)
        {
            bool found = CurrentPage.As<ArchitectFormDesignerPage>().FerifyRangesForFieldEditChecks(table.CreateSet<FieldModel>());
            Assert.IsFalse(found, "Ranges for field do match.");
        }

        //TODO: abstract this, since not only architect pages display messages
        [StepDefinition(@"I should not see ""([^""]*)"" message")]
        public void IDontSeeMessage____(string message)
        {
             bool found = CurrentPage.As<ArchitectFormDesignerPage>().PageContainsMessage(message);
             Assert.IsFalse(found, "Message " + message + " is found.");
        }

        [StepDefinition(@"I should see ""([^""]*)"" message")]
        public void ISeeMessage____(string message)
        {
            bool found = CurrentPage.As<ArchitectFormDesignerPage>().PageContainsMessage(message);
            Assert.IsTrue(found, "Message " + message + " is not found.");
        }

	}

}
