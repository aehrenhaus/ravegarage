using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using TechTalk.SpecFlow;
using Medidata.RBT.WebDriver;
using Medidata.RBT.WebDriver.Rave;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Medidata.RBT;

namespace Medidata.RBT.Features.Rave
{
	[Binding]
	public class CommonEDCSteps : FeatureStepsUsingBrowser
	{
		#region Seeding


		[StepDefinition(@"following Study assignments exist")]
		public void FollowingStudyAssignmentsExist(Table table)
		{
	
		}




		#endregion

		#region Non seeding

		[StepDefinition(@"I publish and push CRF Version ""([^""]*)"" of Draft  to site ""([^""]*)"" in Study ""([^""]*)""")]
		public void IPublishAndPushCRFVersion____OfDraftToSite____InStudy____(string crfName, string siteName, string studyName)
		{

		}
               

		[StepDefinition(@"I select Study ""([^""]*)"" and Site ""([^""]*)""")]
		public void ISelectStudy____AndSite____(string studyName,string siteName)
		{
			CurrentPage = CurrentPage.As<HomePage>()
				.SelectStudy(studyName)
				.SelectSite(siteName);
		}


		[StepDefinition(@"I create a Subject ""([^""]*)""")]
		public void ICreateASubject____(string subjectName)
		{
			CurrentPage = CurrentPage.As<HomePage>().CreateSubject(subjectName);
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

		//[StepDefinition(@"I enter <> in <>")]
		//public void IEnterDataInCRF(string data,string form)
		//{
		//    CRFPage page = CurrentPage.As<CRFPage>();
		//    page.ClickModify();
		//    page.FillDataPoint(form,data);
		//}

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

		[StepDefinition(@"I verify the Queries are not displayed on Field ""([^""]*)"" on log line (\d+)")]
		public void ThenIVerifyTheQueriesAreNotDisplayedOnField____OnLogline____(string fieldNames, int logLine)
		{
			
		}


		[StepDefinition(@"I verify Field ""([^""]*)"" displays Query with Requires Response")]
		public void IVerifyField____DisplaysQueryWithRequiresResponse(string fieldNames)
		{
			///Rave564/Img/i_query.gif
			////Rave564/Img/i_response.gif
			// label Cancel
		}


		[StepDefinition(@"I verify Field ""([^""]*)"" displays Query without Requires Response")]
		public void IVerifyField____DisplaysQueryWithoutRequiresResponse(string fieldNames)
		{
			///Rave564/Img/i_query.gif
			////Rave564/Img/i_response.gif
			// label Cancel
		}


		[StepDefinition(@"I verify Field ""([^""]*)"" displays Query")]
		public void IVerifyField____DisplaysQuery(string fieldNames)
		{
			///Rave564/Img/i_query.gif
			////Rave564/Img/i_response.gif
			// label Cancel
		}


		[StepDefinition(@"I answer the Query on Field ""([^""]*)"" with ""([^""]*)""")]
		public void IAnswerTheQueryOnField____With____(string fieldName, string answer)
		{

		}

		[StepDefinition(@"I answer the Query on Field ""([^""]*)""")]
		public void IAnswerTheQueryOn____(string filedNames)
		{

		}

        [StepDefinition(@"I save form ""[^""]*""")]
		[StepDefinition(@"I save CRF")]
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



		[StepDefinition(@"I add a new Log Line")]
		public void IAddANewLogLine()
		{
			CurrentPage.As<CRFPage>().AddLogLine();
		}


		[StepDefinition(@"I open Log Line ([^""]*)")]
		public void IOpenLogLine____(int lineNum)
		{
			CurrentPage.As<CRFPage>().OpenLogLine(lineNum);
		}


		[StepDefinition(@"closed Queries exist on Fields ""([^""]*)"" in Form ""([^""]*)"" in Folder ""([^""]*)"" in Subject ""([^""]*)"" in Site ""([^""]*)"" in Study ""([^""]*)""")]
        public void ClosedQueriesExistOnFields____InForm____InFolder___InSubject____InSite____InStudy____(string fieldNames, string formName, string folderName, string subjectName,string siteName,string studyName)
        {
            CurrentPage = CurrentPage.As<HomePage>().SelectSubject(subjectName).SelectFolder(folderName).SelectForm(formName);
        }

		[StepDefinition(@"I am on CRF page ""([^""]*)"" in Folder ""([^""]*)"" in Subject ""([^""]*)"" in Site ""([^""]*)"" in Study ""([^""]*)""")]
		public void IAmOnCRFPage____InFolder___InSubject____InSite____InStudy____(string formName, string folderName, string subjectName, string siteName, string studyName)
		{
			
		}

        [StepDefinition(@"I verify the queries are not displayed on fields ""([^""]*)"" and ""([^""]*)"" on first logline")]
        public void IVerify_TheQueries_AreNotDisplayed_OnFields(string fields1, string fields2)
        {
            
        }
        [StepDefinition(@"I enter data from the table below:")]
        public void WhenIEnterDataFromTheTableBelow(Table table)
        {
           
        }

		#endregion

	}
}
