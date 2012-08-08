using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using TechTalk.SpecFlow;
using Medidata.RBT.PageObjects;
using Medidata.RBT.PageObjects.Rave;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Medidata.RBT;
using TechTalk.SpecFlow.Assist;

namespace Medidata.RBT.Features.Rave
{
	[Binding]
	public partial class EDCSteps : BrowserStepsBase
	{
		[StepDefinition(@"I select Study ""([^""]*)"" and Site ""([^""]*)""")]
		public void ISelectStudy____AndSite____(string studyName, string siteName)
		{
			CurrentPage = CurrentPage.As<HomePage>()
				.SelectStudy(studyName)
				.SelectSite(siteName);
		}

        [StepDefinition(@"I create ([^""]*) random Subjects with name ""([^""]*)"" in Study ""([^""]*)"" in Site ""([^""]*)""")]
        public void WhenICreate____RandomSubjectsWithName____inStudy____inSite____(int subjectCount, string subjectName, string studyName, string siteName)
        {
           
           // var subjectNameTemplate = String.Concat(subjectName, " {RndNum<num1>(5)}");
            for (int i = 0; i < subjectCount; i++)
            {
                var page = CurrentPage.As<HomePage>().SelectStudy(studyName).SelectSite(siteName);
                var randomSubjectNumber = SpecialStringHelper.Replace("{RndNum<num1>(5)}");
                Table table = new Table("Data", "Field");                
                table.AddRow(randomSubjectNumber, "Subject Number");
                table.AddRow(subjectName, "Subject Initials");
                page.CreateSubject(table);
                page.NavigateTo("Home");
            }
        }


        /// <summary>
        /// subjectName accepts replacements
        /// </summary>
        [StepDefinition(@"I select a Subject ""([^""]*)""")]
		public void ISelectASubject____(string subjectName)
		{
			CurrentPage = CurrentPage.As<HomePage>().SelectSubject(SpecialStringHelper.Replace(subjectName));
		}

		/// <summary>
		/// value column accepts replacements
		/// </summary>
		/// <param name="table"></param>
		[StepDefinition(@"I create a Subject")]
		public void ICreateASubject____(Table table)
		{
			SpecialStringHelper.ReplaceTableColumn(table, "Data");
			CurrentPage = CurrentPage.As<HomePage>().CreateSubject(table);
		}

		/// <summary>
		/// 
		/// </summary>
		/// <param name="folderName"></param>
		[StepDefinition(@"I select Folder ""([^""]*)""")]
		public void ISelectFolder____(string folderName)
		{
			CurrentPage = CurrentPage.As<BaseEDCTreePage>().SelectFolder(folderName);

		}

		[StepDefinition(@"I select Form ""([^""]*)""")]
		public void ISelectForm____(string formName)
		{
			CurrentPage = CurrentPage.As<BaseEDCTreePage>().SelectForm(formName);
		}


		[StepDefinition(@"I enter data in CRF")]
		public void IEnterDataInCRF(Table table)
		{
			CRFPage page = CurrentPage.As<CRFPage>();
			page.ClickModify();
			
			page.FillDataPoints(table.CreateSet<FieldModel>());
		}

		[StepDefinition(@"I enter data in CRF and save")]
		public void IEnterDataInCRFAndSave(Table table)
		{
			IEnterDataInCRF(table);
			ISaveCRF();
		}

		[StepDefinition(@"I select Form ""([^""]*)"" in Folder ""([^""]*)""")]
		public void ISelectForm____InFolder____(string formName, string folderName)
		{
			CurrentPage = CurrentPage.As<BaseEDCTreePage>().SelectFolder(folderName);
			CurrentPage = CurrentPage.As<BaseEDCTreePage>().SelectForm(formName);
		}


		//[StepDefinition(@"I save the ""[^""]*"" page")]
		[StepDefinition(@"I save the CRF page")]
		public void ISaveCRF()
		{
			CurrentPage = CurrentPage.As<CRFPage>().SaveForm();
		}

		[StepDefinition(@"I cancel the ""[^""]*"" page")]
		[StepDefinition(@"I cancel the CRF page")]
		public void ICancelCRF()
		{
			CurrentPage = CurrentPage.As<CRFPage>().CancelForm();
		}
		

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

		[StepDefinition(@"I expand ""([^""]*)"" in Task Summary")]
		public void GivenIExpand____InTaskSummary(string header)
		{
			CurrentPage.As<SubjectPage>().ExpandTask(header);
		}

		
		[StepDefinition(@"I click audit on Field ""([^""]*)""")]
		public void IClickAuditOnField____(string fieldName)
		{
			CurrentPage = CurrentPage.As<CRFPage>().FindField(fieldName).ClickAudit();
		}

		[StepDefinition(@"I verify Audits exist")]
		public void IVerifyAuditsExist(Table table)
		{
			var audits = table.CreateSet<AuditModel>();
			foreach (var a in audits)
			{
				bool exist = CurrentPage.As<AuditsPage>().AuditExist(a);
				Assert.IsTrue(exist, "Audit does not exist");
			}
		}

		[StepDefinition(@"I select link ""([^""]*)"" located in ""([^""]*)""")]        public void WhenISelectLink____LocatedIn____(string logForm, string leftNav)        {
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
	}
}
