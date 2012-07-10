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
	public partial class EDCSteps
	{
		#region Verify with table



		//table, logline, not exist
		[StepDefinition(@"I verify Query is not displayed on log line (\d+)")]
		public void IVerifyQueryIsNotDisplayedOnLogline____(int logLine, Table table)
		{
			bool canFind =CurrentPage.As<CRFPage>().OpenLogline(logLine).CanFindQuery( table.CreateInstance<QuerySearchModel>());
			Assert.IsFalse(canFind, "Query exists");
		}

		//table, logline exist
		[StepDefinition(@"I verify Query is displayed on log line (\d+)")]
		public void IVerifyQueryIsDisplayedOnLogline____(int logLine, Table table)
		{
			bool canFind = CurrentPage.As<CRFPage>().OpenLogline(logLine).CanFindQuery( table.CreateInstance<QuerySearchModel>());
			Assert.IsTrue(canFind, "Query doesn't exist");
		}

		//table, not eixst
		[StepDefinition(@"I verify Query is not displayed")]
		public void IVerifyQueryIsNotDisplayed(Table table)
		{
			bool canFind = CurrentPage.As<CRFPage>().CanFindQuery( table.CreateInstance<QuerySearchModel>());
			Assert.IsFalse(canFind, "Query exists");
		}

		//table ,exist
		[StepDefinition(@"I verify Query is displayed")]
		public void IVerifyQueryIsDisplayed(Table table)
		{
			bool canFind = CurrentPage.As<CRFPage>().CanFindQuery( table.CreateInstance<QuerySearchModel>());
			Assert.IsTrue(canFind, "Query doesn't exist");
		}

		#endregion 

		#region No query at all


		//no query
		[StepDefinition(@"I verify Field ""([^""]*)"" has no Query")]
		public void IVerifyField____HasNoQuery(string fieldNames)
		{
			bool canFind = CurrentPage.As<CRFPage>().CanFindQuery(new QuerySearchModel {Field = fieldNames });
			Assert.IsFalse(canFind, "Queries found");
		}

		//no query, logline
		[StepDefinition(@"I verify Field ""([^""]*)"" has no Query on log line (\d+)")]
		public void IVerifyField____HasNoQuery(string fieldNames, int logline)
		{
			bool canFind = CurrentPage.As<CRFPage>().OpenLogline(logline).CanFindQuery(new QuerySearchModel { Field = fieldNames });
			Assert.IsFalse(canFind, "Queries found");
		}	

		#endregion

		#region Inline verification

		// not displayed , logline
		[StepDefinition(@"I verify Query with message ""([^""]*)"" is not displayed on Field ""([^""]*)"" on log line (\d+)")]
		public void IVerifyQueryWithMesage____IsNotDisplayedOnField____OnLogline____(string message, string fieldNames, int logLine)
		{
			bool canFind = CurrentPage.As<CRFPage>().OpenLogline(logLine).CanFindQuery(new QuerySearchModel { Field = fieldNames, Message = message });
			Assert.IsFalse(canFind, "Can find message");
		}

		// displayed , logline
		[StepDefinition(@"I verify Query with message ""([^""]*)"" is displayed on Field ""([^""]*)"" on log line (\d+)")]
		public void IVerifyQueryWithMesage____IsDisplayedOnField____OnLogline____(string message, string fieldNames, int logLine)
		{
			bool canFind = CurrentPage.As<CRFPage>().OpenLogline(logLine).CanFindQuery(new QuerySearchModel { Field = fieldNames, Message = message });
			Assert.IsTrue(canFind, "Can't find message");
		}

		//displayed
		[StepDefinition(@"I verify Query with message ""([^""]*)"" is displayed on Field ""([^""]*)""")]
		public void IVerifyQueryWithMessage____IsDisplayedOnField____(string message, string fieldNames)
		{
			var page = CurrentPage.As<CRFPage>();
			bool canFind = page.CanFindQuery(new QuerySearchModel { Field = fieldNames, Message = message });
			Assert.IsTrue(canFind, "Can't find message");
		}

		//not displayed
		[StepDefinition(@"I verify Query with message ""([^""]*)"" is not displayed on Field ""([^""]*)""")]
		public void IVerifyQueryWithMessage____IsNotDisplayedOnField____(string message, string fieldNames)
		{
			bool canFind = CurrentPage.As<CRFPage>().CanFindQuery(new QuerySearchModel { Field = fieldNames, Message = message });
			Assert.IsFalse(canFind, "Can find message");
		}

		//RR, displayed
		[StepDefinition(@"I verify Requires Response Query with message ""([^""]*)"" is displayed on Field ""([^""]*)""")]
		public void IVerifyRequiresResponseQueryWithMessage____IsDisplayedOnField____(string message, string fieldNames)
		{
			bool canFind = CurrentPage.As<CRFPage>().CanFindQuery(new QuerySearchModel { Field = fieldNames, Message = message, Response = true });
			Assert.IsTrue(canFind, "Can't find message");
		}

		//not RR, displayed
		[StepDefinition(@"I verify Not Requires Response Query with message ""([^""]*)"" is displayed on Field ""([^""]*)""")]
		public void IVerifyNotRequiresResponseQueryWithMessage____IsDisplayedOnField____(string message, string fieldNames)
        {
			bool canFind = CurrentPage.As<CRFPage>().CanFindQuery(new QuerySearchModel { Field = fieldNames, Message = message, Response = false });
            Assert.IsTrue(canFind, "Can't find message");
        }


		//closed, displayed
		[StepDefinition(@"I verify closed Query with message ""([^""]*)"" is displayed on Field ""([^""]*)""")]
		public void IVerifyClosedQueryWithMessage____IsDisplayedOnField____(string message, string fieldNames)
		{
			bool canFind = CurrentPage.As<CRFPage>().CanFindQuery(new QuerySearchModel { Field = fieldNames, Message = message, Closed =true });
			Assert.IsTrue(canFind, "Can't find message");
		}


		#endregion

		#region Close ,Cancel ,Answer

		//answer
		[StepDefinition(@"I answer the Query ""([^""]*)"" on Field ""([^""]*)"" with ""([^""]*)""")]
		public void IAnswerTheQueryOnField____With____(string message, string fieldName, string answer)
		{
			CRFPage page = CurrentPage.As<CRFPage>();
			page.AnswerQuery(message, fieldName, answer);

		}

		//answer with random text
		[StepDefinition(@"I answer the Query ""([^""]*)"" on Field ""([^""]*)""")]
		public void IAnswerTheQueryOn____(string message, string fieldNames)
		{
			CRFPage page = CurrentPage.As<CRFPage>();
			page.AnswerQuery(message, fieldNames, System.DateTime.Today.Ticks.ToString());
		}

		//answer the only query
		[StepDefinition(@"I answer the only Query on Field ""([^""]*)"" with ""([^""]*)""")]
		public void IAnswerTheOnlyQueryOnField____With____(string fieldName, string answer)
		{
			CRFPage page = CurrentPage.As<CRFPage>();
			page.AnswerQuery(null, fieldName, answer);

		}

		//answer the only query with random text
		[StepDefinition(@"I answer the only Query on Field ""([^""]*)""")]
		public void IAnswerTheOnlyQueryOn____(string fieldNames)
		{
			CRFPage page = CurrentPage.As<CRFPage>();
			page.AnswerQuery(null, fieldNames, System.DateTime.Today.Ticks.ToString());
		}

		[StepDefinition(@"I answer the Query")]
		public void IAnswerTheQuery(Table table)
		{
			CurrentPage.As<CRFPage>().AnswerQuery(table.CreateInstance<QuerySearchModel>());
	
		}

		//cancel
		[StepDefinition(@"I cancel the Query ""([^""]*)"" on Field ""([^""]*)""")]
		public void ICancelTheQueryOnField____With____(string message, string fieldName)
		{
            CRFPage page = CurrentPage.As<CRFPage>();
            page.CancelQuery(message, fieldName);
		}

		//cancel the only query
		[StepDefinition(@"I cancel the only Query on Field ""([^""]*)""")]
		public void ICancelTheQueryOnField____With____(string fieldName)
		{
			CRFPage page = CurrentPage.As<CRFPage>();
			page.CancelQuery(null, fieldName);
		}


		//close 
        [StepDefinition(@"I close the Query ""([^""]*)"" on Field ""([^""]*)""")]
        public void ICloseTheQuery____OnField____(string message, string fieldNames)
        {
            CRFPage page = CurrentPage.As<CRFPage>();
            page.CloseQuery(message, fieldNames);
        }

		//close the only  query
		[StepDefinition(@"I close the only Query on Field ""([^""]*)""")]
		public void ICloseTheQueryOnField____(string fieldNames)
		{
			CRFPage page = CurrentPage.As<CRFPage>();
			page.CloseQuery(null, fieldNames);
		}

		#endregion
	}
}
