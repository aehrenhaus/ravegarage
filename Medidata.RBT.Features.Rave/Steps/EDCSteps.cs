using System;
using System.Collections.Generic;
using Medidata.RBT.SeleniumExtension;
using TechTalk.SpecFlow;
using Medidata.RBT.PageObjects.Rave;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using TechTalk.SpecFlow.Assist;
using Medidata.RBT.PageObjects.Rave.SharedRaveObjects;
using System.Linq;
using OpenQA.Selenium;
using Medidata.RBT.PageObjects.Rave.TableModels;

namespace Medidata.RBT.Features.Rave
{
    /// <summary>
    /// Steps pertaining to EDC
    /// </summary>
    [Binding]
    public partial class EDCSteps : BrowserStepsBase
    {
        /// <summary>
        /// Select a study with a particular environment
        /// </summary>
        /// <param name="studyName">Study to select</param>
        /// <param name="environment">Environment to select</param>
		[StepDefinition(@"I select Study ""([^""]*)"" \([^\)]*\)")]
		public void ISelectStudy____AndSite____Env____(string studyName,string environment)
		{
			CurrentPage = CurrentPage.As<HomePage>()
				.SelectStudy(SeedingContext.GetExistingFeatureObjectOrMakeNew(studyName, () => new Project(studyName)).UniqueName,environment);
		}

        /// <summary>
        /// Select study on Home page
        /// </summary>
        /// <param name="studyName">Study to select</param>
        [StepDefinition(@"I select Study ""([^""]*)""")]
        public void ISelectStudy____AndSite____(string studyName)
        {
			ISelectStudy____AndSite____Env____(studyName, null);
        }

        /// <summary>
        /// Select study and site on Home page
        /// </summary>
        /// <param name="studyName">Study to select</param>
        /// <param name="siteName">Site to select</param>
        [StepDefinition(@"I select Study ""([^""]*)"" and Site ""([^""]*)""")]
        public void ISelectStudy____AndSite____(string studyName, string siteName)
        {
            CurrentPage = CurrentPage.As<HomePage>()
                .SelectStudy(SeedingContext.GetExistingFeatureObjectOrMakeNew(studyName, () => new Project(studyName)).UniqueName)
                .SelectSite(SeedingContext.GetExistingFeatureObjectOrMakeNew(siteName, () => new Site(siteName)).UniqueName);
        }

        /// <summary>
        /// Create a certain number of random subjects in a specified location
        /// </summary>
        /// <param name="subjectCount">Amount of subjects to create</param>
        /// <param name="subjectName">The initials of the subjects to create</param>
        /// <param name="studyName">The study to create the subjects in</param>
        /// <param name="environment">The environment to create the subjects in</param>
        /// <param name="siteName">The site to create the subjects in</param>
		[StepDefinition(@"I create ([^""]*) random Subjects with name ""([^""]*)"" in Study ""([^""]*)"" \(([^\)]*)\) in Site ""([^""]*)""")]
		public void ICreate____RandomSubjectsWithName____inStudy____Env____inSite____(int subjectCount, string subjectName, string studyName,string environment, string siteName)
		{
			for (int i = 0; i < subjectCount; i++)
			{
				var page = CurrentPage.As<HomePage>().SelectStudy(studyName,environment).SelectSite(siteName);
				var randomSubjectNumber = SpecialStringHelper.Replace("{RndNum<num1>(5)}");

				IEnumerable<FieldModel> dps = new List<FieldModel>
				{
					new FieldModel{ Field= "Subject Number", Data=randomSubjectNumber },
					new FieldModel{ Field= "Subject Initials", Data=subjectName }
				};
				page.CreateSubject(dps);
				page.NavigateTo("Home");
			}
		}

        /// <summary>
        /// As it's name
        /// </summary>
        /// <param name="subjectCount"></param>
        /// <param name="subjectName"></param>
        /// <param name="studyName"></param>
        /// <param name="siteName"></param>
        [StepDefinition(@"I create ([^""]*) random Subjects with name ""([^""]*)"" in Study ""([^""]*)"" in Site ""([^""]*)""")]
        public void ICreate____RandomSubjectsWithName____inStudy____inSite____(int subjectCount, string subjectName, string studyName, string siteName)
        {
			ICreate____RandomSubjectsWithName____inStudy____Env____inSite____(subjectCount, subjectName, studyName, null, siteName);
        }

        /// <summary>
        /// Select a subject from list on Home page
        /// </summary>
        [StepDefinition(@"I select a Subject ""([^""]*)""")]
        [StepDefinition(@"I select subject ""([^""]*)""")]
        public void ISelectASubject____(string subjectSearchString)
        {
            CurrentPage = CurrentPage.As<HomePage>().SelectSubject(SpecialStringHelper.Replace(subjectSearchString));
        }

        /// <summary>
        /// Create a subject and fill the primary form.
        /// </summary>
        /// <param name="table"></param>
        [StepDefinition(@"I create a Subject")]
        public void ICreateASubject____(Table table)
        {
            SpecialStringHelper.ReplaceTableColumn(table, "Data");
            CurrentPage = CurrentPage.As<HomePage>().CreateSubject(table.CreateSet<FieldModel>());
        }
    
        /// <summary>
        /// Re eneter subject and fill the primary form.
        /// </summary>
        /// <param name="table"></param>
        [StepDefinition(@"I enter data on Primary Form")]
        public void IReenterASubjectOnPrimaryPage(Table table)
        {
            SpecialStringHelper.ReplaceTableColumn(table, "Data");
            CurrentPage = CurrentPage.As<PrimaryRecordPage>().ReenterSubjectPrimaryPage(table.CreateSet<FieldModel>());
        }


        /// <summary>
        /// Select forlder on DEC page
        /// </summary>
        /// <param name="folderName"></param>
        [StepDefinition(@"I select Folder ""([^""]*)""")]
        public void ISelectFolder____(string folderName)
        {
            CurrentPage = CurrentPage.As<BaseEDCPage>().SelectFolder(folderName);

        }

        /// <summary>
        /// Select a form on EDC page
        /// </summary>
        /// <param name="formName"></param>
        [StepDefinition(@"I select Form ""([^""]*)""")]
        [StepDefinition(@"I select form ""([^""]*)""")]
        public void ISelectForm____(string formName)
        {
            CurrentPage = CurrentPage.As<BaseEDCPage>().SelectForm(formName);
        }

        /// <summary>
        /// Fill the CRF
        /// This step will click modify button if it's not in edit view.
        /// </summary>
        /// <param name="table"></param>
        [StepDefinition(@"I enter data in CRF")]
        public void IEnterDataInCRF(Table table)
        {
            var page = CurrentPage.As<BaseEDCPage>();
            page.ClickModify();

            page.FillDataPoints(table.CreateSet<FieldModel>());
        }

        /// <summary>
        /// Fill the CRF on a log line in landscape mode
        /// This step will click modify button if it's not in edit view.
        /// </summary>
        /// <param name="line"></param>
        /// <param name="table"></param>
        [StepDefinition(@"I enter data in CRF on log line (\d+)")]
        public void IEnterDataInCRFOnLogLine____(int line, Table table)
        {
            var page = CurrentPage.As<BaseEDCPage>();
            page.ClickModify();

            page.FillDataPoints(table.CreateSet<FieldModel>(), line);
        }

        /// <summary>
        /// Verifies data exists in the datapa/record we are already in
        /// </summary>
        /// <param name="table"></param>
        [StepDefinition(@"I should see data on Fields in CRF")]
        public void IShouldSeeInCRF(Table table)
        {
            CRFPage page = CurrentPage.As<CRFPage>();
            var fields = table.CreateSet<FieldModel>();
            foreach (var field in fields)
            {
                bool dataExists = page.FindField(field.Field).HasDataEntered(field.Data);
                Assert.IsTrue(dataExists, "Data doesn't exist for field(s)");
            }
        }

        /// <summary>
        /// Verifies is requires verification checkbox is enabled/disabled
        /// </summary>
        /// <param name="table"></param>
        [StepDefinition(@"I should see verification required on Fields in CRF")]
        public void IShouldSeeVerificationRequiredOnFieldsInCRF(Table table)
        {
            CRFPage page = CurrentPage.As<CRFPage>();

            var fields = table.CreateSet<FieldModel>();
            foreach (var field in fields)
            {
                if (field.RequiresVerification.HasValue)
                {
                    bool verificationRequired = page.FindField(field.Field).IsVerificationRequired();

                    Assert.AreEqual(field.RequiresVerification.Value, verificationRequired, "Verification Required doesn't match on Fields in CRF");
                }
            }
        }

        /// <summary>
        /// A more generic implementation for EDC field verification
        /// This step definition will let user verify all the field
        /// steps from single method
        /// </summary>
        /// <param name="table"></param>
        [StepDefinition(@"I verify data on Fields in CRF")]
        public void IVerifyDataOnFieldsInCRF(Table table)
        {
            CRFPage page = CurrentPage.As<CRFPage>();

            IEnumerable<FieldModel> fields = table.CreateSet<FieldModel>();

            foreach (FieldModel field in fields)
            {
                IEDCFieldControl fieldControl = page.FindField(field.Field, record: field.Record);
                if (field.Data != null && field.Data.Length > 0)
                {
                    bool dataExists = fieldControl.HasDataEntered(field.Data);
                    Assert.IsTrue(dataExists, "Data doesn't exist for field(s)");
                }
                if (field.RequiresReview.HasValue)
                {
                    bool reviewRequired = fieldControl.IsReviewRequired();

                    Assert.AreEqual(field.RequiresReview.Value, reviewRequired,
                                    "Review Required doesn't match on Fields in CRF");
                }
                if (field.RequiresVerification.HasValue)
                {
                    bool verificationRequired = fieldControl.IsVerificationRequired();

                    Assert.AreEqual(field.RequiresVerification.Value, verificationRequired,
                                    "Verification Required doesn't match on Fields in CRF");
                }
                if (field.Inactive.HasValue)
                {
                    bool isInactive = fieldControl.IsInactive(field.Data);
                    Assert.AreEqual(field.Inactive.Value, isInactive, "Inactive doesn't match on Fields in CRF");
                }
                if (field.StatusIcon != null && field.StatusIcon.Length > 0)
                    Assert.AreNotEqual(0, fieldControl.StatusIconPathLookup(field.StatusIcon).Length,
                                       "Status Icon not found");
            }
        }

        /// <summary>
        /// Check or uncheck the checkboxes in the righthand side next to fields
        /// This is different than enter data in crf, since edit should not be clicked
        /// </summary>
        /// <param name="table">The checkboxes to check or not check</param>
        [StepDefinition(@"I edit checkboxes for fields")]
        public void WhenICheckCheckboxesForFields(Table table)
        {
            CRFPage page = CurrentPage.As<CRFPage>();

            IEnumerable<FieldModel> fields = table.CreateSet<FieldModel>();
            foreach (FieldModel field in fields)
            {
                IEDCFieldControl fieldControl = page.FindField(field.Field);
                if (field.Review.HasValue)
                    if(field.Review.Value)
                        fieldControl.CheckReview();
            }
        }

        /// <summary>
        /// A more generic implementation for verifying aspects of the current form
        /// </summary>
        /// <param name="table">The form model, which details information about the form to verify</param>
        [StepDefinition(@"I verify data on current CRF")]
        public void ThenIVerifyDataOnCurrentForm(Table table)
        {
            CRFPage page = CurrentPage.As<CRFPage>();
            List<FormModel> forms = table.CreateSet<FormModel>().ToList();

            if (forms.Count != 1)
                throw new Exception("Too many or too few forms to be just the current form");

            FormModel formInfo = forms.FirstOrDefault();
            FormHeaderControl headerControl = page.FindHeader();
            if (!String.IsNullOrEmpty(formInfo.StatusIcon) && formInfo.StatusIcon.Equals("Requires Review"))
            {
                bool reviewRequired = headerControl.IsReviewRequired();
                Assert.AreEqual(true, reviewRequired, "Review Required doesn't match on Form in CRF");
            }
        }

        /// <summary>
        /// No Clinical Significance for field displayed
        /// </summary>
        /// <param name="clinSignificance"></param> 
        /// <param name="field"></param> 
        [StepDefinition(@"I should not see Clinical Significance ""([^""]*)"" on Field ""([^""]*)""")]
        public void IShouldNotSeeClinicalSignificance____OnField____(string clinSignificance, string field)
        {
            CRFPage page = CurrentPage.As<CRFPage>();
            bool notFound = page.FieldWithClinSignificanceExists(clinSignificance, field);
            Assert.IsFalse(notFound, "Clinical Significance is visible.");
        }

        /// <summary>
        /// Clinical Significance for field displayed
        /// </summary>
        /// <param name="clinSignificance"></param> 
        /// <param name="field"></param> 
        [StepDefinition(@"I should see Clinical Significance ""([^""]*)"" on Field ""([^""]*)""")]
        public void IShouldSeeClinicalSignificance____OnField____(string clinSignificance, string field)
        {
            CRFPage page = CurrentPage.As<CRFPage>();
            bool isFound = page.FieldWithClinSignificanceExists(clinSignificance, field);
            Assert.IsTrue(isFound, "No Clinical Significance found.");
        }

        /// <summary>
        /// Fill CRF and save
        /// </summary>
        /// <param name="table"></param>
        [StepDefinition(@"I enter data in CRF and save")]
        public void IEnterDataInCRFAndSave(Table table)
        {
            IEnterDataInCRF(table);
            ISaveCRF();
        }

        /// <summary>
        /// Checking that data entry doesn't work
        /// </summary>
        /// <param name="table"></param>
        [StepDefinition(@"I cannot enter data in CRF and save")]
        public void ICannotEnterDataInCRFAndSave(Table table)
        {
            try
            {
                IEnterDataInCRFAndSave(table);
                Assert.IsTrue(false); // if we got here, data entry was successful, therefore method fails.
            }
            catch // if exception is caught, data entry wasn't successful, therefore method passes
            {
                Assert.IsTrue(true);
            }

        }


        /// <summary>
        /// Select Folder and Form
        /// </summary>
        /// <param name="formName"></param>
        /// <param name="folderName"></param>
        [StepDefinition(@"I select Form ""([^""]*)"" in Folder ""([^""]*)""")]
        public void ISelectForm____InFolder____(string formName, string folderName)
        {
            CurrentPage = CurrentPage.As<BaseEDCPage>().SelectFolder(folderName);
            CurrentPage = CurrentPage.As<BaseEDCPage>().SelectForm(formName);
        }


        /// <summary>
        /// Click save on CRF page
        /// </summary>
        [StepDefinition(@"I save the CRF page")]
        public void ISaveCRF()
        {
            if (CurrentPage.GetType().Name.Equals("PrimaryRecordPage"))
                CurrentPage = CurrentPage.As<PrimaryRecordPage>().SaveForm();
            else
                CurrentPage = CurrentPage.As<CRFPage>().SaveForm();
        }

        /// <summary>
        /// Click cancel on CRF page
        /// </summary>
        [StepDefinition(@"I cancel the ""[^""]*"" page")]
        [StepDefinition(@"I cancel the CRF page")]
        public void ICancelCRF()
        {
            CurrentPage = CurrentPage.As<CRFPage>().CancelForm();
        }

        /// <summary>
        /// From Home page ,this step will navigate through the path and land on a CRF page
        /// </summary>
        /// <param name="formName"></param>
        /// <param name="folderName"></param>
        /// <param name="subjectName"></param>
        /// <param name="siteName"></param>
        /// <param name="studyName"></param>
        [StepDefinition(@"I am on CRF page ""([^""]*)"" in Folder ""([^""]*)"" in Subject ""([^""]*)"" in Site ""([^""]*)"" in Study ""([^""]*)""")]
        public void IAmOnCRFPage____InFolder___InSubject____InSite____InStudy____(string formName, string folderName, string subjectName, string siteName, string studyName)
        {
            CurrentPage = CurrentPage.As<HomePage>()
                .SelectStudy(studyName)
                .SelectSite(siteName)
                .SelectSubject(subjectName)
                .SelectFolder(folderName)
                .SelectForm(formName);
        }

        /// <summary>
        /// Select primary record form
        /// </summary>
        [StepDefinition(@"I select primary record form")]
        public void ISelectPrimaryRecordForm()
        {
            CurrentPage = CurrentPage.As<SubjectPage>().ClickPrimaryRecordLink();
        }

        /// <summary>
        /// Click audit on the form level
        /// </summary>
        [StepDefinition(@"I click audit on form level")]
        public void IClickAuditOnFormLevel()
        {
            CurrentPage = CurrentPage.As<BaseEDCPage>().ClickAuditOnFormLevel();
        }

		/// <summary>
		/// Click audit icon on a field on CRF page
		/// </summary>
        /// <param name="fieldName">The name of the field to audit against</param>
		[StepDefinition(@"I click audit on Field ""([^""]*)""")]
        [StepDefinition(@"I go to Audits for Field ""([^""]*)""")]
		public void IClickAuditOnField____(string fieldName)
		{
			CurrentPage = CurrentPage.As<CRFPage>()
				.FindField(fieldName)
				.ClickAudit();
		}

        /// <summary>
        /// Verify audit exists
        /// </summary>
        /// <param name="table"></param>
        [StepDefinition(@"I verify exact Audit texts exist")]
        public void IVerifyExactAuditsExist(Table table)
        {
            var audits = table.CreateSet<AuditModel>();
            int position = 1;
            foreach (var a in audits)
            {
                bool exist = CurrentPage.As<AuditsPage>().ExactAuditExist(a, position);
                Assert.IsTrue(exist, string.Format("Audit {0} does not exist", a.Audit));
                position++;
            }
        }

        /// <summary>
        /// Click audit icon on a lab field on CRF page
        /// </summary>
        /// <param name="fieldName">The name of the field to audit against</param>
        /// <param name="logLine">The log line of the field to audit against</param>
        [StepDefinition(@"I click audit on Field ""([^""]*)"" log line ""([^""]*)""")]
        public void ThenIClickAuditOnField____LogLine____(string fieldName, int logLine)
        {
            CurrentPage = ((NonLabFieldControl)CurrentPage.As<CRFPage>().FindField(fieldName, record: logLine)).ClickAudit(true);
        }

		/// <summary>
		/// Verify audit exists
		/// </summary>
		/// <param name="table"></param>
		[StepDefinition(@"I verify Audits exist")]
		public void IVerifyAuditsExist(Table table)
		{
			var audits = table.CreateSet<AuditModel>();
            int position = 1;
			foreach (var a in audits)
			{
                bool exist = CurrentPage.As<AuditsPage>().AuditExist(a, position);
				Assert.IsTrue(exist, string.Format ("Audit {0} does not exist",a.AuditType));
                position++;
			}
		}

        /// <summary>
        /// Verify the last audit exists matches the table
        /// </summary>
        /// <param name="table"></param>
        [StepDefinition(@"I verify last audit exist")]
        public void IVerifyLastAuditExist(Table table)
        {
            var audits = table.CreateSet<AuditModel>();
            int position = 1;
            foreach (var a in audits)
            {
                bool exist = CurrentPage.As<AuditsPage>().AuditExist(a, null);
                Assert.IsTrue(exist, string.Format("Audit {0} does not exist", a.AuditType));
                position++;
            }
        }

        /// <summary>
        /// This step definition does not match the actual functionality of the step.
        /// Refactor in a further commit.
        /// </summary>
        /// <param name="logForm"></param>
        /// <param name="leftNav"></param>
        [StepDefinition(@"I select link ""([^""]*)"" located in ""([^""]*)""")]
        public void ISelectLink____LocatedIn____(string logForm, string leftNav)
        {
            if (logForm.Equals("Monitor Visits", StringComparison.InvariantCultureIgnoreCase))
                CurrentPage = CurrentPage.As<HomePage>().SelectForm(logForm);
            else if (logForm.Equals("Copy to Draft", StringComparison.InvariantCultureIgnoreCase))
                CurrentPage = CurrentPage.As<ArchitectCRFDraftPage>().ClickLink("Copy to Draft");
            else if (logForm.Equals("Propose Objects", StringComparison.InvariantCultureIgnoreCase))
                CurrentPage = CurrentPage.As<ArchitectCRFDraftPage>().ClickLink("Propose Objects");
            else if (logForm.Equals("Forms", StringComparison.InvariantCultureIgnoreCase))
                CurrentPage = CurrentPage.As<ArchitectCRFDraftPage>().ClickLink("Forms");
            else if (logForm.Equals("Matrices", StringComparison.InvariantCultureIgnoreCase))
                CurrentPage = CurrentPage.As<ArchitectCRFDraftPage>().ClickLink("Matrices");
            else
                CurrentPage.As<SubjectPage>().SelectForm(logForm);
        }

        /// <summary>
        /// Check that the cursor is or is not focused on the given element in a column
        /// </summary>
        /// <param name="not">If the word not is used, check that the cursor focus is not on the element specified</param>
        /// <param name="controlType">The control type of the element</param>
        /// <param name="fieldName">The name of the field</param>
        /// <param name="positionText">The position from left to right that the element is located, 1 indexed</param>
        /// <param name="rowText">The row from top to bottom that the element is located, 1 indexed</param>
        [StepDefinition(@"the cursor focus is ([^""]*)located on ""([^""]*)"" in the column labeled ""([^""]*)"" in the ""([^""]*)"" position in the ""([^""]*)"" row")]
        public void TheCursorFocusIs____LocatedOn____InTheColumnLabeled____InThe____RowAndThe____PositionInThatRow(string not, string controlType, string fieldName, string positionText, string rowText)
        {
            var type = EnumHelper.GetEnumByDescription<ControlType>(controlType);
            var row = Constants.GetNumberByWord(rowText);
            var position = Constants.GetZeroBasedIndexByWord(positionText);

            if (not.Trim().ToLower() != "not")
                Assert.IsTrue(CurrentPage.As<CRFPage>()
                    .FindLandscapeLogField(fieldName, row)
                    .IsElementFocused(type, position));
            else
                Assert.IsFalse(CurrentPage.As<CRFPage>()
                    .FindLandscapeLogField(fieldName, row)
                    .IsElementFocused(type, position));
        }

        /// <summary>
        /// Check that the cursor is or is not focused on the given element in a row
        /// </summary>
        /// <param name="not">If the word not is used, check that the cursor focus is not on the element specified</param>
        /// <param name="controlType">The control type of the element</param>
        /// <param name="fieldName">The name of the field</param>
        /// <param name="positionText">The position in the row from left to right that the element is located, 1 indexed</param>
        [StepDefinition(@"the cursor focus is ([^""]*)located on ""([^""]*)"" in the row labeled ""([^""]*)"" in the ""([^""]*)"" position in the row")]
        public void TheCursorFocusIs____LocatedOn____InTheRowLabeled____InThe____PositionInThatRow(string not, string controlType, string fieldName, string positionText)
        {
            var type = EnumHelper.GetEnumByDescription<ControlType>(controlType);
            var position = Constants.GetZeroBasedIndexByWord(positionText);

            if (not.Trim().ToLower() != "not")
                Assert.IsTrue(CurrentPage.As<CRFPage>()
                    .FindPortraitLogField(fieldName)
                    .IsElementFocused(type, position));
            else
                Assert.IsFalse(CurrentPage.As<CRFPage>()
                    .FindPortraitLogField(fieldName)
                    .IsElementFocused(type, position));
        }

        /// <summary>
        /// Check that the X offset of the page is non-zero (I.E. the browser window has moved right)
        /// </summary>
        [StepDefinition(@"the browser scrolls to the right")]
        public void TheBrowserScrollsToTheRight()
        {
			Assert.AreNotEqual(0, Browser.GetPageOffsetX());
        }

        /// <summary>
        /// Check that the Y offset of the page is non-zero (I.E. the browser window has moved down)
        /// </summary>
        [StepDefinition(@"the browser scrolls down")]
        public void TheBrowserScrollsDown()
        {
			Assert.AreNotEqual(0, Browser.GetPageOffsetY());
        }

        /// <summary>
        /// Move the cursor to the given element in a row
        /// </summary>
        /// <param name="controlType">The control type of the element</param>
        /// <param name="fieldName">The name of the field</param>
        /// <param name="positionText">The position from left to right that the element is located, 1 indexed</param>
        /// <param name="rowText">The row from top to bottom that the element is located, 1 indexed</param>
        [StepDefinition(@"move cursor focus to ""([^""]*)"" in the column labeled ""([^""]*)"" in the ""([^""]*)"" position in the ""([^""]*)"" row")]
        public void MoveCursorFocusTo____InTheColumnLabeled____InThe____RowAndThe____PositionInThatRow
            (string controlType, string fieldName, string positionText, string rowText)
        {
            var type = EnumHelper.GetEnumByDescription<ControlType>(controlType);
            var row = Constants.GetNumberByWord(rowText);
            var position = Constants.GetZeroBasedIndexByWord(positionText);

            CurrentPage.As<CRFPage>()
                .FindLandscapeLogField(fieldName, row)
                .FocusElement(type, position);
        }

        /// <summary>
        /// Move the cursor to the given element in a row. Whent there is only 1 row, so you do not need to specify row
        /// </summary>
        /// <param name="controlType">The control type of the element</param>
        /// <param name="fieldName">The name of the field</param>
        /// <param name="positionText">The position from left to right that the element is located, 1 indexed</param>
        [StepDefinition(@"move cursor focus to ""([^""]*)"" in the row labeled ""([^""]*)"" in the ""([^""]*)"" position in the row")]
        public void MoveCursorFocusTo____InTheRowLabeled____InThe____PositionInThatRow(string controlType, string fieldName, string positionText)
        {
            var type = EnumHelper.GetEnumByDescription<ControlType>(controlType);
            var position = Constants.GetZeroBasedIndexByWord(positionText);

            CurrentPage.As<CRFPage>()
                .FindPortraitLogField(fieldName)
                .FocusElement(type, position);
        }

        /// <summary>
        /// Check that the cursor focus is on an element of a specific control type and value
        /// </summary>
        /// <param name="controlTypeString">The control type of the element</param>
        /// <param name="value">The value of the element</param>
        [StepDefinition(@"the cursor focus is on ""([^""]*)"" labeled ""([^""]*)""")]
        public void IShouldSeeTheCursorFocusOn____Labeled____(string controlTypeString, string value)
        {
            var type = EnumHelper.GetEnumByDescription<ControlType>(controlTypeString.ToLower());
            Assert.IsTrue(CurrentPage.As<CRFPage>().IsElementFocused(type, value));
        }

        /// <summary>
        /// Verify lab ranges against the passed in table
        /// </summary>
        /// <param name="table">What the lab ranges should be</param>
        [StepDefinition(@"I verify lab ranges")]
        public void IVerifyLabRanges(Table table)
        {
            CRFPage page = CurrentPage.As<CRFPage>();
            Assert.IsTrue(page.VerifyLabDataPoints(table.CreateSet<LabRangeModel>()), "Lab Data points don't match");
        }

        /// <summary>
        /// Select units in a lab
        /// </summary>
        /// <param name="table">The units to select in a lab</param>
        [StepDefinition(@"I select Unit")]
        public void ISelectUnit(Table table)
        {
            CRFPage page = CurrentPage.As<CRFPage>();
            page.SelectUnitsForFields(table.CreateSet<LabRangeModel>());
        }

        /// <summary>
        /// Select the passed in lab
        /// </summary>
        /// <param name="labName">The name of the lab to select</param>
        [StepDefinition(@"I select Lab ""([^""]*)""")]
        public void ISelectLab_____(string labName)
        {
            CRFPage page = CurrentPage.As<CRFPage>();
            if (labName.ToUpper().Equals("UNITS ONLY")) //this is a setting, not a lab name, so this will never be seeded.
                page.SelectLabValue(labName);
            else
                page.SelectLabValue(SeedingContext.GetExistingFeatureObjectOrMakeNew<Lab>(labName, () => new Lab(labName)).UniqueName);
        }

        /// <summary>
        /// Sign the form with a username. Will also provide the matching password for that username.
        /// </summary>
        /// <param name="userName">The username to sign the form with.</param>
        [StepDefinition(@"I sign the form with username ""([^""]*)""")]
        public void ISignTheFormWithUsername____(string userName)
        {
            User user = SeedingContext.GetExistingFeatureObjectOrMakeNew(
                userName, () => new User(userName));
            new SignatureBox().Sign(user.UniqueName, user.Password);
        }

        /// <summary>
        /// Sign the subject with a username. Will also provide the matching password for that username.
        /// </summary>
        /// <param name="userName">The username to sign the form with.</param>
        [StepDefinition(@"I sign the subject with username ""([^""]*)""")]
        public void ISignTheSubjectWithUsername____(string userName)
        {
            ISignTheFormWithUsername____(userName);
        }

        /// <summary>
        /// Verify text on a page, replacing the username in the text with the unique version of that username exists.
        /// </summary>
        /// <param name="text">The text to verify</param>
        /// <param name="userName">The feature-level version of that username</param>
        [StepDefinition(@"I verify text ""([^""]*)"" with username ""([^""]*)"" exists")]
        public void IVerifyText____WithUsername____Exists(string text, string userName)
        {
            User user = SeedingContext.GetExistingFeatureObjectOrMakeNew(
                userName, () => new User(userName));
            text = text.Replace(userName, user.UniqueName);
            bool exist = CurrentPage.As<IVerifySomethingExists>().VerifySomethingExist(null, "text", text);
            Assert.IsTrue(exist, String.Format("Text does not exist :{0}", text));
        }

        /// <summary>
        /// Verify text on a page, replacing the username in the text with the unique version of that username does not exist.
        /// </summary>
        /// <param name="text">The text to verify</param>
        /// <param name="userName">The feature-level version of that username</param>
        [StepDefinition(@"I verify text ""([^""]*)"" with username ""([^""]*)"" does not exist")]
        public void IVerifyText____WithUsername____DoesNotExists(string text, string userName)
        {
            User user = SeedingContext.GetExistingFeatureObjectOrMakeNew(
                userName, () => new User(userName));
            text = text.Replace(userName, user.UniqueName);
            bool exist = CurrentPage.As<IVerifySomethingExists>().VerifySomethingExist(null, "text", text);
            Assert.IsFalse(exist, String.Format("Text exist :{0}", text));
        }

        /// <summary>
        /// Click drop button on a field on CRF page
        /// </summary>
        /// <param name="fieldName"></param>
        /// <param name="lineNum"></param>
        [StepDefinition(@"I click drop button on dynamic search list ""([^""]*)"" in log line ([^""]*)")]
        public void IClickDropButtonOnDynamicSearchList____InLogLine____(string fieldName, int lineNum)
        {
            var controlType = ControlType.DynamicSearchList;

            RavePageBase page = null;

            if (CurrentPage is CRFPage)
            {
                page = CurrentPage.As<CRFPage>();
            }
            else
            {
                throw new Exception(String.Format("Method IClickDropButtonOnDynamicSearchList____InLogLine____(string fieldName, int lineNum) is not implemented for page {0}", CurrentPage.GetType().Name));
            }

            IEDCFieldControl fieldControl = page.FindLandscapeLogField(fieldName, lineNum, controlType);
            fieldControl.Click();
        }

        /// <summary>
        /// Click drop button on a standard field on CRF page
        /// </summary>
        /// <param name="fieldName"></param>
        [StepDefinition(@"I click drop button on dynamic search list ""([^""]*)""")]
        public void IClickDropButtonOnDynamicSearchList____(string fieldName)
        {
            if (CurrentPage is DDEPage)
            {
                RavePageBase page = CurrentPage.As<DDEPage>();
                //IEDCFieldControl fieldControl = page.;
                //fieldControl.Click();
            }
            else if (CurrentPage is CRFPage)
            {
                CRFPage page = CurrentPage.As<CRFPage>();
                IEDCFieldControl fieldControl = page.FindField(fieldName);
                fieldControl.FieldControlContainer.TryFindElementBy(By.ClassName("SearchList_DropButton")).Click();
            }
            else
            {
                throw new Exception(String.Format("Method IClickDropButtonOnDynamicSearchList____(string fieldName) is not implemented for page {0}", CurrentPage.GetType().Name));
            }
        }

        /// <summary>
        /// Verifies that dynamic search list is open
        /// </summary>
        /// <param name="fieldName"></param>
        /// <param name="lineNum"></param>
        [Then(@"I should see dynamic search list ""([^""]*)"" in log line ([^""]*) open")]
        public void ThenIShouldSeeDynamicSearchList____InLogLine____Open(string fieldName, int lineNum)
        {
            bool result = false;
            var controlType = ControlType.DynamicSearchList;

            RavePageBase page = null;

            if (CurrentPage is CRFPage)
            {
                page = CurrentPage.As<CRFPage>();
            }
            else
            {
                throw new Exception(String.Format("Method ThenIShouldSeeDynamicSearchList____InLogLine____Open(string fieldName, int lineNum) is not implemented for page {0}", CurrentPage.GetType().Name));
            }

            IEDCFieldControl fieldControl = page.FindLandscapeLogField(fieldName, lineNum, controlType);

            result = fieldControl.IsDroppedDown();
            Assert.IsTrue(result, String.Format("The dynamic search list {0} in log line {1} has not been opened", fieldName, lineNum));
        }

        /// <summary>
        /// Verifies that dynamic search list is open on a standard field
        /// </summary>
        /// <param name="fieldName"></param>
        [Then(@"I should see dynamic search list ""([^""]*)"" open")]
        public void ThenIShouldSeeDynamicSearchList____Open(string fieldName)
        {
            bool result = false;

            if (CurrentPage is DDEPage)
            {
                RavePageBase page = CurrentPage.As<DDEPage>();
            }
            else if (CurrentPage is CRFPage)
            {
                CRFPage page = CurrentPage.As<CRFPage>();
                IEDCFieldControl fieldControl = page.FindField(fieldName);
                result = fieldControl.FieldControlContainer.TryFindElementBy(By.ClassName("SearchList_PickListBox")).Displayed;
            }
            else
            {
                throw new Exception(String.Format("Method ThenIShouldSeeDynamicSearchList____Open(string fieldName) is not implemented for page {0}", CurrentPage.GetType().Name));
            }
            Assert.IsTrue(result, String.Format("The dynamic search list {0} has not been opened", fieldName));
        }


        /// <summary>
        /// Enter data on dynamic search list in log line.
        /// </summary>
        /// <param name="data">The data.</param>
        /// <param name="fieldName">Name of the field.</param>
        /// <param name="lineNum">The line num.</param>
        [StepDefinition(@"I enter ""([^""]*)"" on dynamic search list ""([^""]*)"" in log line ([^""]*)")]
        public void WhenIEnter__OnDynamicSearchList__InLogLine__(string data, string fieldName, int lineNum)
        {
            var controlType = ControlType.DynamicSearchList;
            IEDCFieldControl fieldControl = CurrentPage.As<CRFPage>().FindLandscapeLogField(fieldName, lineNum, controlType);
            fieldControl.EnterData(data, controlType);
        }

        /// <summary>
        /// Enter data to dynamic search list on a standard field
        /// </summary>
        /// <param name="data">The data.</param>
        /// <param name="fieldName">Name of the field.</param>
        [StepDefinition(@"I enter ""([^""]*)"" on dynamic search list ""([^""]*)""")]
        public void WhenIEnter__OnDynamicSearchList__(string data, string fieldName)
        {
            var controlType = ControlType.DynamicSearchList;
            CRFPage page = CurrentPage.As<CRFPage>();
            IEDCFieldControl fieldControl = page.FindField(fieldName);
            fieldControl.EnterData(data, controlType);
        }

        /// <summary>
        /// Check that the field has the values in the order listed
        /// </summary>
        /// <param name="fieldName">The field to check for values order</param>
        /// <param name="table">The field values in the order they should be listed in</param>
        [StepDefinition(@"""([^""]*)"" has ""<Values>"" in order")]
        public void ____Has____InOrder(string fieldName, Table table)
        {
            List<string> values = table.Rows.Select(x => x.Values.FirstOrDefault()).ToList();
            Assert.IsTrue(CurrentPage.As<CRFPage>().FindFieldValuesInOrder(fieldName, values));
        }

        /// <summary>
        /// Verify that a form only appears the specified amount of times
        /// </summary>
        /// <param name="formCount">The amount of times the form must appear</param>
        /// <param name="formName">The name of the form</param>
		[StepDefinition(@"I verify only ""(.*)"" Form ""(.*)"" is displayed")]
		public void IVerifyOnly____Form____IsDisplayed(int formCount, string formName)
		{
			CurrentPage.As<CRFPage>().CheckFormCount(formName, formCount);
		}

        /// <summary>
        /// Verifies various controls are disabled
        /// </summary>
        /// <param name="table"></param>
        [StepDefinition(@"I verify EDC controls are disabled")]
        public void ThenIVerifyEDCControlsAreDisabled(Table table)
        {
            var models = table.CreateSet<ControlTypeModel>();
            IWebElement element;
            bool allDisabled = true;

            foreach (var model in models)
            {
                try
                {
                    element = FilterOutDisabledControls(CurrentPage.As<CRFPage>().GetElementByName(model.Name));
                }
                catch(NoSuchElementException) // exception in this case means element is not found, so that's "good"
                {
                    continue;
                }
                if (element != null && element.Enabled) // if it's null, still "good"
                {
                    allDisabled = false;  // we found an enabled control, so we are done, failing method
                    break;
                }
            }
            Assert.IsTrue(allDisabled);
        }

        /// <summary>
        /// Verifies various controls are enabled
        /// </summary>
        /// <param name="table"></param>
        [StepDefinition(@"I verify EDC controls are enabled")]
        public void ThenIVerifyEDCControlsAreEnabled(Table table)
        {
            var models = table.CreateSet<ControlTypeModel>();
            IWebElement element;
            bool allEnabled = true;

            foreach (var model in models)
            {
                try
                {
                    element = FilterOutDisabledControls(CurrentPage.As<CRFPage>().GetElementByName(model.Name));
                }
                catch(NoSuchElementException) // exception means control not found
                {
                    allEnabled = false;
                    break;
                }
                if (element != null && !element.Enabled) // null means control not found
                {
                    allEnabled = false;
                    break;
                }
                else if (element == null)
                {
                    allEnabled = false;
                    break;
                }
            }
            Assert.IsTrue(allEnabled);
        }


        private IWebElement FilterOutDisabledControls(IWebElement element)
        {
            if (element == null)
                return null;
            else if (element.GetDisabled() != null && element.GetDisabled().ToLower() == "true") // if disabled control, it's unusable, so return null
                return null;
            else
                return element;
         
        }
    }
}
