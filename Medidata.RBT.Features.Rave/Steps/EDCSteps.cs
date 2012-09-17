﻿using System;
using System.Collections.Generic;
using TechTalk.SpecFlow;
using Medidata.RBT.PageObjects.Rave;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using TechTalk.SpecFlow.Assist;

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
				.SelectStudy(studyName);
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
				.SelectStudy(studyName)
				.SelectSite(siteName);
		}


		/// <summary>
		/// As it's name
		/// </summary>
		/// <param name="subjectCount"></param>
		/// <param name="subjectName"></param>
		/// <param name="studyName"></param>
		/// <param name="siteName"></param>
        [StepDefinition(@"I create ([^""]*) random Subjects with name ""([^""]*)"" in Study ""([^""]*)"" in Site ""([^""]*)""")]
        public void WhenICreate____RandomSubjectsWithName____inStudy____inSite____(int subjectCount, string subjectName, string studyName, string siteName)
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
		public void ISelectASubject____(string subjectName)
		{
			CurrentPage = CurrentPage.As<HomePage>().SelectSubject(SpecialStringHelper.Replace(subjectName));
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
        public void ThenIShouldSeeInCRF(Table table)
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

		/// <summary>
		/// Expand a header in Task Summary area on Subject page.
		/// </summary>
		/// <param name="header"></param>
		[StepDefinition(@"I expand ""([^""]*)"" in Task Summary")]
		public void IExpand____InTaskSummary(string header)
		{
			CurrentPage.As<SubjectPage>().ExpandTask(header);
		}

		/// <summary>
		/// Click audit icon on a field on CRF page
		/// </summary>
		/// <param name="fieldName"></param>
		[StepDefinition(@"I click audit on Field ""([^""]*)""")]
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
		[StepDefinition(@"I verify Audits exist")]
		public void IVerifyAuditsExist(Table table)
		{
			var audits = table.CreateSet<AuditModel>();
			foreach (var a in audits)
			{
				bool exist = CurrentPage.As<AuditsPage>().AuditExist(a);
				Assert.IsTrue(exist, string.Format ("Audit {0} does not exist",a.AuditType));
			}
		}

		[StepDefinition(@"I select link ""([^""]*)"" located in ""([^""]*)""")]        
        public void WhenISelectLink____LocatedIn____(string logForm, string leftNav)        {
            if(logForm == "Monitor Visits")
                CurrentPage = CurrentPage.As<HomePage>().SelectForm(logForm);
            else
                CurrentPage = CurrentPage.As<SubjectPage>().SelectForm(logForm);
        }

        [Then(@"the cursor focus is ([^""]*)located on ""([^""]*)"" in the column labeled ""([^""]*)"" in the ""([^""]*)"" position in the ""([^""]*)"" row")]
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

        [Then(@"the cursor focus is ([^""]*)located on ""([^""]*)"" in the row labeled ""([^""]*)"" in the ""([^""]*)"" position in the row")]
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

        [Then(@"the browser scrolls to the right")]
        public void TheBrowserScrollsToTheRight()
        {
            Assert.AreNotEqual(0, CurrentPage.As<CRFPage>().GetPageOffsetX());
        }

        [Then(@"the browser scrolls down")]
        public void TheBrowserScrollsDown()
        {
            Assert.AreNotEqual(0, CurrentPage.As<CRFPage>().GetPageOffsetY());
        }

        [Given(@"move cursor focus to ""([^""]*)"" in the column labeled ""([^""]*)"" in the ""([^""]*)"" position in the ""([^""]*)"" row")]
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

        [Given(@"move cursor focus to ""([^""]*)"" in the row labeled ""([^""]*)"" in the ""([^""]*)"" position in the row")]
        public void MoveCursorFocusTo____InTheRowLabeled____InThe____PositionInThatRow(string controlType, string fieldName, string positionText)
        {
            var type = EnumHelper.GetEnumByDescription<ControlType>(controlType);
            var position = Constants.GetZeroBasedIndexByWord(positionText);

            CurrentPage.As<CRFPage>()
                .FindPortraitLogField(fieldName)
                .FocusElement(type, position);
        }

        [Then(@"the cursor focus is on ""([^""]*)"" labeled ""([^""]*)""")]
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

        /// <summary>
        /// Click drop button on a field on CRF page
        /// </summary>
        /// <param name="fieldName"></param>
        /// <param name="lineNum"></param>
        [StepDefinition(@"I click drop button on dynamic search list ""([^""]*)"" in log line ([^""]*)")]
        public void IClickDropButtonOnDynamicSearchList____InLogLine____(string fieldName, int lineNum)
        {
            var controlType = ControlType.DynamicSearchList;

            var page = new RavePageBase();

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

            var page = new RavePageBase();

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


    }
}
