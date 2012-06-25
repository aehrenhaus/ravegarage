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
	public partial class EDCSteps 
	{


		[StepDefinition(@"the Query with message ""([^""]*)"" is not displayed on Field ""([^""]*)"" on log line (\d+)")]
		public void ThenIVerifyTheQueriesAreNotDisplayedOnField____OnLogline____(string message, string fieldNames, int logLine)
		{
			bool canFind = CurrentPage.As<CRFPage>().OpenLogline(logLine).CanFindQueryMessage(fieldNames, message);
			Assert.IsFalse(canFind, "Can find message");
		}

		[StepDefinition(@"I verify Requires Response Query with message ""([^""]*)"" is displayed on Field ""([^""]*)""")]
		[StepDefinition(@"I verify Query with message ""([^""]*)"" with Requires Response is displayed on Field ""([^""]*)""")]
		public void TheRequiresResponseQueryWithMessageIsDisplayedOnField____(string message, string fieldNames)
		{
			bool canFind = CurrentPage.As<CRFPage>().CanFindQueryRequiringResponse(fieldNames, message);
			Assert.IsTrue(canFind, "Can't find message");
		}

        [StepDefinition(@"I verify Query with message ""([^""]*)"" without Requires Response is displayed on Field ""([^""]*)""")]
        public void QueryNotRequiringResponseIsDisplayedOnField____(string message, string fieldNames)
        {
            bool canFind = CurrentPage.As<CRFPage>().CanFindQueryNotRequiringResponse(fieldNames, message);
            Assert.IsTrue(canFind, "Can't find message");
        }

		[StepDefinition(@"I verify Requires Response Query with message ""([^""]*)"" is not displayed on Field ""([^""]*)""")]
		public void TheRequiresResponseQueryWithMessageIsNotDisplayedOnField____(string message, string fieldNames)
		{
			bool canFind = CurrentPage.As<CRFPage>().CanFindQueryRequiringResponse(fieldNames, message);
			Assert.IsFalse(canFind, "Can find message");
		}

		[StepDefinition(@"I verify Query with message ""([^""]*)"" is displayed on Field ""([^""]*)""")]
		public void TheQueryWithMessageIsDisplayedOnField____(string message, string fieldNames)
		{
			bool canFind = CurrentPage.As<CRFPage>().CanFindQueryMessage(fieldNames, message);
			Assert.IsTrue(canFind, "Can't find message");
		}


		[StepDefinition(@"I verify Query with message ""([^""]*)"" is not displayed on Field ""([^""]*)""")]
		public void TheQueryWithMessageIsNotDisplayedOnField____(string message, string fieldNames)
		{
			bool canFind = CurrentPage.As<CRFPage>().CanFindQueryMessage(fieldNames, message);
			Assert.IsFalse(canFind, "Can find message");
		}

		[StepDefinition(@"I answer the Query ""([^""]*)"" on Field ""([^""]*)"" with ""([^""]*)""")]
		public void IAnswerTheQueryOnField____With____(string message, string fieldName, string answer)
		{
			CRFPage page = CurrentPage.As<CRFPage>();
			page.AnswerQuery(message, fieldName, answer);

		}


		[StepDefinition(@"I cancel the Query ""([^""]*)"" on Field ""([^""]*)""")]
		public void ICancelTheQueryOnField____With____(string message, string fieldName)
		{
			//temp comment out
			//CRFPage page = CurrentPage.As<CRFPage>();
			//page.CancelQuery(message, fieldName, answer);

		}


		[StepDefinition(@"I answer the Query ""([^""]*)"" on Field ""([^""]*)""")]
		public void IAnswerTheQueryOn____(string message, string fieldNames)
		{
			CRFPage page = CurrentPage.As<CRFPage>();
			page.AnswerQuery(message, fieldNames, System.DateTime.Today.Ticks.ToString());
		}

		[StepDefinition(@"I close the Query ""([^""]*)"" on Field ""([^""]*)""")]
		public void ICloseTheQuery____OnField____(string message, string fieldNames)
		{

		}

		[StepDefinition(@"I close the Query on Field ""([^""]*)""")]
		public void ICloseTheQueryOnField____(string fieldNames)
		{

		}

		[StepDefinition(@"I verify Field ""([^""]*)"" has NO Query")]
		public void IVerifyField____HasNOQuery(string fieldNames)
		{
			bool canFind = CurrentPage.As<CRFPage>().QueryExistOnField(fieldNames);
			Assert.IsFalse(canFind, "Can find message");
		}



		[StepDefinition(@"closed Query with message ""([^""]*)"" exists on Field ""([^""]*)"" in Form ""([^""]*)"" in Folder ""([^""]*)"" in Subject ""([^""]*)"" in Site ""([^""]*)"" in Study ""([^""]*)""")]
		public void ClosedQueriesExistOnFields____InForm____InFolder___InSubject____InSite____InStudy____(string message, string fieldNames, string formName, string folderName, string subjectName, string siteName, string studyName)
		{

		}


		[StepDefinition(@"I verify the queries are not displayed on fields ""([^""]*)"" and ""([^""]*)"" on first logline")]
		public void IVerify_TheQueries_AreNotDisplayed_OnFields(string fields1, string fields2)
		{

		}		


	}
}
