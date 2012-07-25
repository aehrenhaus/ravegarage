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

		[StepDefinition(@"I check ""([^""]*)"" on ""([^""]*)""")]
		public void ICheck____OnLog____(string chkName, string fieldName)
		{
			CurrentPage.As<CRFPage>().FindField(fieldName).Check(chkName);
		}


		[StepDefinition(@"I uncheck ""([^""]*)"" on ""([^""]*)""")]
		public void IUncheck____OnLog____(string chkName, string fieldName)
		{
			CurrentPage.As<CRFPage>().FindField(fieldName).Uncheck(chkName);
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


		[StepDefinition(@"I sign CRF with ""([^""]*)"" and ""([^""]*)""")]
		public void ISignCRFWith____And____(string username , string password)
		{
			CurrentPage.As<BaseEDCTreePage>().SignForm(username, password);
		}


	}
}
