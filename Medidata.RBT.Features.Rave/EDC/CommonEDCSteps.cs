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


		[StepDefinition(@"Rave has user-study-site assignments from the table below:")]
		public void RaveHasUser_Study_SiteAssignmentsFromTheTableBelow(Table table)
		{
	
		}

		[StepDefinition(@"Role ""([^""]*)"" has ""([^""]*)"" Action")]
		public void Role____Has____Action(string roleName,string actionNames)
		{
	
		}

		[StepDefinition(@"Study  ""([^""]*)"" has Draft ""([^""]*)""")]
		public void Study____HasDraft____(string studyName, string draftName)
		{
			
		}

		[StepDefinition(@"Study ""[^""]*"" has Draft ""[^""]*"" has ""[^""]*""")]
        public void Study____HasDraf____HasEditCheck(Table table)
        {
            
        }


		[StepDefinition(@"CRF ""([^""]*)"" is pushed in Site ""([^""]*)""")]
        [StepDefinition(@"I publish and push CRF Version ""([^""]*)"" to site ""([^""]*)""")]
		public void CRF____IsPushedInSite____(string crfName,string siteName)
		{
			
		}

        [StepDefinition(@"user ""[^""]*""  has study ""[^""]*"" has role ""[^""]*"" has site ""[^""]*"" from the table below:")]
        public void UserHas_Study_Role_Site(Table table)
        {
           
        }
               

		#endregion

		#region Non seeding



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


		[StepDefinition(@"I enter data in CRF")]
		public void IEnterDataInCRF(Table table)
		{
			CRFPage page = CurrentPage.As <CRFPage>();
			page.ClickModify();
			foreach (var row in table.Rows)
			{
				page.FillDataPoint(row[0], row[1]);
			}
		}

		[StepDefinition(@"I verify the Queries are NOT displayed on Field ""([^""]*)"" on logline (\d+)")]
		public void ThenIVerifyTheQueriesAreNOTDisplayedOnField____OnLogline1(string fieldNames, int logLine)
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
