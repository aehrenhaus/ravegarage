using TechTalk.SpecFlow;
using Medidata.RBT.PageObjects.Rave;
using TechTalk.SpecFlow.Assist;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Medidata.RBT.PageObjects.Rave.AmendmentManager;
using System.Collections.Generic;

namespace Medidata.RBT.Features.Rave
{
    /// <summary>
    /// Steps pertaining to architect
    /// </summary>
	[Binding]
	public class ArchitectSteps : BrowserStepsBase
	{
        /// <summary>
        /// Create a draft from the project and version passed in
        /// </summary>
        /// <param name="draftName">The name of the draft to create</param>
        /// <param name="project">The project to create the draft from</param>
        /// <param name="version">The version to create the draft from</param>
		[StepDefinition(@"I create Draft ""([^""]*)"" from Project ""([^""]*)"" and Version ""([^""]*)""")]
		public void ICreateDraft____FromProject____AndVersion____(string draftName, string project, string version)
		{
			draftName = SpecialStringHelper.Replace(draftName);
			project =SpecialStringHelper.Replace(project);
			version = SpecialStringHelper.Replace(version);
			CurrentPage = CurrentPage.As<ArchitectLibraryPage>().CreateDraftFromProject(draftName,project,version);
		}

        /// <summary>
        /// Select a draft 
        /// </summary>
        /// <param name="draftName">Name of the draft to select</param>
        [StepDefinition(@"I select Draft ""([^""]*)""")]
        public void GivenICreateDraft____FromProject____AndVersion____(string draftName)
        {
            draftName = SpecialStringHelper.Replace(draftName);
            CurrentPage = CurrentPage.As<ArchitectLibraryPage>().SelectDraft(draftName);
        }

        /// <summary>
        /// Publish the CRF version
        /// </summary>
        /// <param name="crfVersion">The version to publish</param>
		[StepDefinition(@"I publish CRF Version ""([^""]*)""")]
		public void IPublishCRFVersion____(string crfVersion)
		{
			crfVersion = SpecialStringHelper.Replace(crfVersion);
			CurrentPage.As<ArchitectCRFDraftPage>().PublishCRF(crfVersion);
		}

        /// <summary>
        /// Publish the CRF version to specific site or sites
        /// </summary>
        /// <param name="crfVersion">The version to publish</param>
        /// <param name="sites">The site or sites to push the version to</param>
		[StepDefinition(@"I push CRF Version ""([^""]*)"" to ""([^""]*)""")]
		public void IPublishCRFVersion____(string crfVersion, string sites)
		{
			crfVersion = SpecialStringHelper.Replace(crfVersion);
			sites = SpecialStringHelper.Replace(sites);
			CurrentPage.As<ArchitectLibraryPage>().PushVersion(crfVersion,"Prod", sites);
		}

        /// <summary>
        /// Migrate all subjects in amendment manager
        /// </summary>
		[StepDefinition(@"I migrate all Subjects")]
		public void IMigrateAllSubjects()
		{
			CurrentPage = CurrentPage.As<AMMigrationExecutePage>().Migrate();
		}

        /// <summary>
        /// Verify the last migration has completed
        /// </summary>
        [StepDefinition(@"I verify Job Status is set to Complete")]
        public void ISelectMigrationResultsAndVerifyJobStatusIsSetToComplete()
		{
			CurrentPage.As<AMMigrationResultPage>().WaitForComplete();
		}

        /// <summary>
        /// Search for a form
        /// </summary>
        /// <param name="form">Form to search for</param>
        [StepDefinition(@"I search for form ""([^""]*)""")]
        public void ISearchForForm____(string form)
        {
            CurrentPage = CurrentPage.As<ArchitectFormsPage>().SearchForForm(form);
        }

        /// <summary>
        /// Select fields in a form
        /// </summary>
        /// <param name="form">Form to select the fields from</param>
        [StepDefinition(@"I select Fields for Form ""([^""]*)""")]
        public void ISelectFieldsForForm____(string form)
        {
            ISearchForForm____(form);
            CurrentPage = CurrentPage.As<ArchitectFormsPage>().SelectFieldsForForm(form);
        }

        /// <summary>
        /// Edit a field
        /// </summary>
        /// <param name="field">The field to edit</param>
        [StepDefinition(@"I edit Field ""([^""]*)""")]
        public void IEditField____(string field)
        {
            CurrentPage = CurrentPage.As<ArchitectFormDesignerPage>().EditField(field);
        }
        
        /// <summary>
        /// Expand field checks
        /// </summary>
        [StepDefinition(@"I expand ""Field Edit Checks""")]
        public void IExpandFieldEditChecks()
        {
            CurrentPage = CurrentPage.As<ArchitectFormDesignerPage>().ExpandEditChecks();
        }

        /// <summary>
        /// Enter ranges for Field Edit Checks and save
        /// </summary>
        /// <param name="table">Ranges to enter</param>
        [StepDefinition(@"I enter ranges for Field Edit Checks and save")]
        public void IEnterRangesForFieldEditChecksAndSave(Table table)
        {
            IEnterRangesForFieldEditChecks(table);

            CurrentPage.As<ArchitectFormDesignerPage>().Save();
        }

        /// <summary>
        /// Enter ranges for Field Edit Checks, don't save
        /// </summary>
        /// <param name="table">Ranges to enter</param>
        [StepDefinition(@"I enter ranges for Field Edit Checks")]
        public void IEnterRangesForFieldEditChecks(Table table)
        {
             CurrentPage.As<ArchitectFormDesignerPage>().FillRangesForFieldEditChecks(table.CreateSet<FieldModel>());
        }

        /// <summary>
        /// Verify the ranges against field edit checks exist or do not, depending on the not parameter
        /// </summary>
        /// <param name="not">Whether to verify the range exists or doesn't</param>
        /// <param name="table">The data to verify</param>
        [StepDefinition(@"I should (not )?see ranges for Field Edit Checks")]
        public void ISeeRangesForFieldEditChecks(string not, Table table)
        {
            bool found = CurrentPage.As<ArchitectFormDesignerPage>().VerifyRangesForFieldEditChecks(table.CreateSet<FieldModel>());
            if (not.ToLower().Equals("not "))
                Assert.IsFalse(found, "Ranges for field do match.");
            else
                Assert.IsTrue(found, "Ranges for field do not match.");
        }

        /// <summary>
        /// Enter coder configuration data such as coding level, priority and locale followed by saving the new settings
        /// </summary>
        /// <param name="table"></param>
        [StepDefinition(@"I enter data in architect coder configuration and save")]
        public void IEnterDataInCoderConfigurationAndSave(Table table)
        {
            IEnumerable<ArchitectCoderConfigurationModel> coderConfigurations = table.CreateSet<ArchitectCoderConfigurationModel>();

            foreach (ArchitectCoderConfigurationModel coderConf in coderConfigurations)
            {
                CurrentPage.As<ArchitectCoderConfigPage>().FillCoderConfigurationData(coderConf);
            }

            CurrentPage.ClickButton("Save");
        }

        /// <summary>
        /// Enable/disable coder workflow variables such as 'IsApprovalRequired, IsAutoRequired'
        /// </summary>
        /// <param name="table"></param>
        [StepDefinition(@"I set the coder workflow variables")]
        public void ISetTheCoderWorkflowVariables(Table table)
        {
            IEnumerable<CoderWorkflowVariableModel> coderWorkflowVariables = table.CreateSet<CoderWorkflowVariableModel>();

            foreach (CoderWorkflowVariableModel coderWorkflowVariable in coderWorkflowVariables)
            {
                CurrentPage.As<ArchitectCoderConfigPage>().SetCoderWorkflowVariable(coderWorkflowVariable);
            }
        }

        /// <summary>
        /// Add coder Supplemental or Component terms
        /// </summary>
        /// <param name="termName">Term name, Supplemental or Component</param>
        /// <param name="table">Table containing information about Supplemental/Component term to be added</param>
        [StepDefinition(@"I add the coder ""([^""]*)"" terms")]
        public void IAddTheCoderTerms(string termName, Table table)
        {
            IEnumerable<CoderTermModel> coderTerms = table.CreateSet<CoderTermModel>();

            foreach (CoderTermModel coderTerm in coderTerms)
            {
                CurrentPage.As<ArchitectCoderConfigPage>().AddCoderTerm(termName, coderTerm);
            }
        }

        /// <summary>
        /// Step to enter architect field setting related data followed by saving it
        /// </summary>
        /// <param name="table"></param>
        [StepDefinition(@"I enter data in Architect Field and save")]
        public void IEnterDataInArchitectFieldAndSave(Table table)
        {
            CurrentPage.As<ArchitectFormDesignerPage>().FillDataPoints(table.CreateSet<FieldModel>());
        }

        /// <summary>
        /// Step to let deleted the coder configuration supplemental or component terms
        /// </summary>
        /// <param name="termName"></param>
        /// <param name="table"></param>
        [StepDefinition(@"I delete the coder ""([^""]*)"" terms")]
        public void IDeleteTheCoderTerms(string termName, Table table)
        {
            IEnumerable<CoderTermModel> coderTerms = table.CreateSet<CoderTermModel>();

            foreach (CoderTermModel coderTerm in coderTerms)
            {
                CurrentPage.As<ArchitectCoderConfigPage>().DeleteCoderTerm(termName, coderTerm);
            }
        }

        /// <summary>
        /// Step to select the CRF version from the architect library page
        /// </summary>
        /// <param name="versionName"></param>
        [StepDefinition(@"I select CRF version ""([^""]*)""")]
        public void ISelectCRFVersion(string versionName)
        {
            CurrentPage.As<ArchitectLibraryPage>().SelectCrfVersion(versionName);
        }


	}
}
