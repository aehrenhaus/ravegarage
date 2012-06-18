using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using TechTalk.SpecFlow;
using Medidata.RBT.PageObjects;
using Medidata.RBT.PageObjects.Rave;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Medidata.RBT;

namespace Medidata.RBT.Features.Rave
{
	[Binding]
	public class EDCSteps : BrowserStepsBase
	{

		[StepDefinition(@"I select Study ""([^""]*)"" and Site ""([^""]*)""")]
		public void ISelectStudy____AndSite____(string studyName,string siteName)
		{
			CurrentPage = CurrentPage.As<HomePage>()
				.SelectStudy(studyName)
				.SelectSite(siteName);
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
			SpecialStringHelper.ReplaceTableColumn(table, "Value");
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
			foreach (var row in table.Rows)
			{
				page.FillDataPoint(row[0], row[1]);
			}
		}

        
        [StepDefinition(@"the Query with message ""([^""]*)"" is not displayed on Field ""([^""]*)"" on log line (\d+)")]
		public void ThenIVerifyTheQueriesAreNotDisplayedOnField____OnLogline____(string message , string fieldNames, int logLine)
		{
            bool canFind = CurrentPage.As<CRFPage>().OpenLogLine(logLine).CanFindQueryMessage(fieldNames, message);
            Assert.IsFalse(canFind,"Can find message");
		}


		[StepDefinition(@"I verify Query with message ""([^""]*)"" with Requires Response is displayed on Field ""([^""]*)""")]
		public void TheRequiresResponseQueryWithMessageIsDisplayedOnField____(string message, string fieldNames)
		{
		}


		[StepDefinition(@"the Requires Response Query with message ""([^""]*)"" is not displayed on Field ""([^""]*)""")]
		public void TheRequiresResponseQueryWithMessageIsNotDisplayedOnField____(string message, string fieldNames)
		{
		}

		[StepDefinition(@"the Query with message ""([^""]*)"" is displayed on Field ""([^""]*)""")]
		public void TheQueryWithMessageIsDisplayedOnField____(string message, string fieldNames)
		{
		}


		[StepDefinition(@"the Query with message ""([^""]*)"" is not displayed on Field ""([^""]*)""")]
		public void TheQueryWithMessageIsNotDisplayedOnField____(string message, string fieldNames)
		{
		}

		[StepDefinition(@"I answer the Query ""([^""]*)"" on Field ""([^""]*)"" with ""([^""]*)""")]
		public void IAnswerTheQueryOnField____With____(string message, string fieldName, string answer)
		{

		}

		[StepDefinition(@"I answer the Query ""([^""]*)"" on Field ""([^""]*)""")]
		public void IAnswerTheQueryOn____(string message, string filedNames)
		{

		}

        [StepDefinition(@"I save the ""[^""]*"" page")]
		[StepDefinition(@"I save the CRF page")]
		public void ISaveCRF()
		{
			CurrentPage = CurrentPage.As<CRFPage>().SaveForm();
		}

		[StepDefinition(@"I close the Query on Field ""([^""]*)""")]
		public void ICloseTheQueryOnField____(string fieldNames)
		{
	
		}

		[StepDefinition(@"I verify Field ""([^""]*)"" has NO Query")]
		public void IVerifyField____HasNOQuery(string fieldNames)
		{
	
		}


		[StepDefinition(@"I select Form ""([^""]*)"" in Folder ""([^""]*)""")]
		public void ISelectForm____InFolder____(string formName,string folderName)
		{
			CurrentPage = CurrentPage.As<BaseEDCTreePage>().SelectFolder(folderName);
			CurrentPage = CurrentPage.As<BaseEDCTreePage>().SelectForm(formName);
		}



		[StepDefinition(@"I add a new log line")]
		public void IAddANewLogLine()
		{
			CurrentPage.As<CRFPage>().AddLogLine();
		}


		[StepDefinition(@"I open log line ([^""]*)")]
		public void IOpenLogLine____(int lineNum)
		{
			CurrentPage.As<CRFPage>().OpenLogLine(lineNum);
		}


		[StepDefinition(@"I open log line ([^""]*) for edit")]
		public void IOpenLogLine____ForEdit(int lineNum)
		{
			CurrentPage.As<CRFPage>().OpenLogLine(lineNum);
		}

		
        [StepDefinition(@"closed Query with message ""([^""]*)"" exists on Field ""([^""]*)"" in Form ""([^""]*)"" in Folder ""([^""]*)"" in Subject ""([^""]*)"" in Site ""([^""]*)"" in Study ""([^""]*)""")]
        public void ClosedQueriesExistOnFields____InForm____InFolder___InSubject____InSite____InStudy____(string message, string fieldNames, string formName, string folderName, string subjectName,string siteName,string studyName)
        {
            
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

        [StepDefinition(@"I verify the queries are not displayed on fields ""([^""]*)"" and ""([^""]*)"" on first logline")]
        public void IVerify_TheQueries_AreNotDisplayed_OnFields(string fields1, string fields2)
        {
            
        }
		
	}
}
