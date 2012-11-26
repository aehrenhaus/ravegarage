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

namespace Medidata.RBT.Features.Rave
{
    [Binding]
    public partial class EDCSteps : BrowserStepsBase
    {
        /// <summary>
        /// Select study and site on Home page
        /// </summary>
        /// <param name="studyName"></param>
        /// <param name="siteName"></param>
        [StepDefinition(@"I select Study ""([^""]*)""")]
        public void ISelectStudy____AndSite____(string studyName)
        {
            CurrentPage = CurrentPage.As<HomePage>()
                .SelectStudy(TestContext.GetExistingFeatureObjectOrMakeNew(studyName, () => new Project(studyName)).UniqueName);
        }

        /// <summary>
        /// Select study and site on Home page
        /// </summary>
        /// <param name="studyName"></param>
        /// <param name="siteName"></param>
        [StepDefinition(@"I select Study ""([^""]*)"" and Site ""([^""]*)""")]
        public void ISelectStudy____AndSite____(string studyName, string siteName)
        {
            CurrentPage = CurrentPage.As<HomePage>()
                .SelectStudy(TestContext.GetExistingFeatureObjectOrMakeNew(studyName, () => new Project(studyName)).UniqueName)
                .SelectSite(TestContext.GetExistingFeatureObjectOrMakeNew(siteName, () => new Site(siteName)).UniqueName);
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

            // var subjectNameTemplate = String.Concat(subjectName, " {RndNum<num1>(5)}");
            for (int i = 0; i < subjectCount; i++)
            {
                var page = CurrentPage.As<HomePage>().SelectStudy(studyName).SelectSite(siteName);
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
                IEDCFieldControl fieldControl = page.FindField(field.Field);
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
                if (field.RequiresSignature.HasValue)
                {
                    bool signatureRequired = fieldControl.IsSignatureRequired();

                    Assert.AreEqual(field.RequiresSignature.Value, signatureRequired,
                                    "Signature Required doesn't match on Fields in CRF");
                }
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
            if (formInfo.RequiresReview.HasValue)
            {
                bool reviewRequired = headerControl.IsReviewRequired();

                Assert.AreEqual(formInfo.RequiresReview.Value, reviewRequired, "Review Required doesn't match on Form in CRF");
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

        [StepDefinition(@"I select primary record form")]
        public void ISelectPrimaryRecordForm()
        {
            CurrentPage = CurrentPage.As<SubjectPage>().ClickPrimaryRecordLink();
        }

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
        /// Click audit icon on a lab field on CRF page
        /// </summary>
        /// <param name="fieldName">The name of the field to audit against</param>
        /// <param name="logLine">The log line of the field to audit against</param>
        [StepDefinition(@"I click audit on Field ""([^""]*)"" log line ""([^""]*)""")]
        public void ThenIClickAuditOnField____LogLine____(string fieldName, int logLine)
        {
            CurrentPage = ((LabFieldControl)CurrentPage.As<CRFPage>().FindField(fieldName)).ClickAudit(logLine);
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
        /// Verify audit exists
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

        [StepDefinition(@"I select link ""([^""]*)"" located in ""([^""]*)""")]
        public void ISelectLink____LocatedIn____(string logForm, string leftNav)
        {
            if (logForm == "Monitor Visits")
                CurrentPage = CurrentPage.As<HomePage>().SelectForm(logForm);
            else
                CurrentPage.As<SubjectPage>().SelectForm(logForm);
        }

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

        [StepDefinition(@"the browser scrolls to the right")]
        public void TheBrowserScrollsToTheRight()
        {
			Assert.AreNotEqual(0, Browser.GetPageOffsetX());
        }

        [StepDefinition(@"the browser scrolls down")]
        public void TheBrowserScrollsDown()
        {
			Assert.AreNotEqual(0, Browser.GetPageOffsetY());
        }

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

        [StepDefinition(@"move cursor focus to ""([^""]*)"" in the row labeled ""([^""]*)"" in the ""([^""]*)"" position in the row")]
        public void MoveCursorFocusTo____InTheRowLabeled____InThe____PositionInThatRow(string controlType, string fieldName, string positionText)
        {
            var type = EnumHelper.GetEnumByDescription<ControlType>(controlType);
            var position = Constants.GetZeroBasedIndexByWord(positionText);

            CurrentPage.As<CRFPage>()
                .FindPortraitLogField(fieldName)
                .FocusElement(type, position);
        }

        [StepDefinition(@"the cursor focus is on ""([^""]*)"" labeled ""([^""]*)""")]
        public void IShouldSeeTheCursorFocusOn____Labeled____(string controlTypeString, string value)
        {
            var type = EnumHelper.GetEnumByDescription<ControlType>(controlTypeString.ToLower());
            Assert.IsTrue(CurrentPage.As<CRFPage>().IsElementFocused(type, value));
        }

        [StepDefinition(@"I verify lab ranges")]
        public void IVerifyLabRanges(Table table)
        {
            CRFPage page = CurrentPage.As<CRFPage>();
            Assert.IsTrue(page.VerifyLabDataPoints(table.CreateSet<LabRangeModel>()), "Lab Data points don't match");
        }

        [StepDefinition(@"I select Unit")]
        public void ISelectUnit(Table table)
        {
            CRFPage page = CurrentPage.As<CRFPage>();
            page.SelectUnitsForFields(table.CreateSet<LabRangeModel>());
        }


        //[StepDefinition(@"I verify ""([^""]*)"" is ""([^""]*)"" on ""([^""]*)""")]
        //public void IVerify____Is____(string checkBoxName, string checkStatus, string fieldName)
        //{
        //    bool result = false;
        //    CRFPage page = CurrentPage.As<CRFPage>();

        //    result = (page.FindField(fieldName) as LabFieldControl).VerifyCheck(checkBoxName, checkStatus);

        //    Assert.IsTrue(result, String.Format("The check {0} is not {1}", checkBoxName, checkStatus));
        //}

        [StepDefinition(@"I select Lab ""([^""]*)""")]
        public void ISelectLab_____(string labName)
        {
            CRFPage page = CurrentPage.As<CRFPage>();
            page.SelectLabValue(labName);
        }

        [StepDefinition(@"I sign the form with username ""([^""]*)"" and password ""([^""]*)""")]
        public void ISignTheFormWithUsername____AndPassword____(string username, string password)
        {
            new SignatureBox().Sign(username, password);
        }

        [StepDefinition(@"I sign the form with username ""([^""]*)""")]
        public void ISignTheFormWithUsername____(string userName)
        {
            User user = TestContext.GetExistingFeatureObjectOrMakeNew(
                userName, () => new User(userName));
            new SignatureBox().Sign(user.UniqueName, user.Password);
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

            if (CurrentPage is DDEPage)
            {
                page = CurrentPage.As<DDEPage>();
            }
            else if (CurrentPage is CRFPage)
            {
                page = CurrentPage.As<CRFPage>();
            }
            else
            {
                throw new Exception("Not supported other pages");
            }

            IEDCFieldControl fieldControl = page.FindLandscapeLogField(fieldName, lineNum, controlType);
            fieldControl.Click();
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

            if (CurrentPage is DDEPage)
            {
                page = CurrentPage.As<DDEPage>();
            }
            else if (CurrentPage is CRFPage)
            {
                page = CurrentPage.As<CRFPage>();
            }
            else
            {
                throw new Exception("Not supported other pages");
            }

            IEDCFieldControl fieldControl = page.FindLandscapeLogField(fieldName, lineNum, controlType);

            result = fieldControl.IsDroppedDown();
            Assert.IsTrue(result, String.Format("The dynamic search list {0} in log line {1} has not been opened", fieldName, lineNum));
        }


        /// <summary>
        /// Enter data on dynamic search list adverse event grade in log line.
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
        /// Expand a header in Task Summary area on Subject page.
        /// </summary>
        /// <param name="header"></param>
        [StepDefinition(@"I expand ""([^""]*)"" in Task Summary")]
        public void IExpand____InTaskSummary(string header)
        {
            CurrentPage.As<SubjectPage>().ExpandTask(header);
        }

		[StepDefinition(@"I verify only ""(.*)"" Form ""(.*)"" is displayed")]
		public void IVerifyOnly____Form____IsDisplayed(int formCount, string formName)
		{
			CurrentPage.As<CRFPage>().CheckFormCount(formName, formCount);
		}

    }
}
