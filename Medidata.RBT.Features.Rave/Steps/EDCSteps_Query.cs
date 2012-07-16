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
			var filter = table.CreateInstance<QuerySearchModel>();
			bool canFind =CurrentPage.As<CRFPage>().OpenLogline(logLine).CanFindQuery( filter);
			Assert.IsFalse(canFind, "Query exists");
		}

		//table, logline exist
		[StepDefinition(@"I verify Query is displayed on log line (\d+)")]
		public void IVerifyQueryIsDisplayedOnLogline____(int logLine, Table table)
		{
			var filter = table.CreateInstance<QuerySearchModel>();
			bool canFind = CurrentPage.As<CRFPage>().OpenLogline(logLine).CanFindQuery(filter);
			Assert.IsTrue(canFind, "Query doesn't exist");
		}

		//table, not eixst
		[StepDefinition(@"I verify Query is not displayed")]
		public void IVerifyQueryIsNotDisplayed(Table table)
		{
			var filter = table.CreateInstance<QuerySearchModel>();
			bool canFind = CurrentPage.As<CRFPage>().CanFindQuery( filter);
			Assert.IsFalse(canFind, "Query exists");
		}

		//table ,exist
		[StepDefinition(@"I verify Query is displayed")]
		public void IVerifyQueryIsDisplayed(Table table)
		{
			var filter = table.CreateInstance<QuerySearchModel>();
			bool canFind = CurrentPage.As<CRFPage>().CanFindQuery(filter);
			Assert.IsTrue(canFind, "Query doesn't exist");
		}



		#endregion 

		#region No query at all


		//no query
		[StepDefinition(@"I verify Field ""([^""]*)"" has no Query")]
		public void IVerifyField____HasNoQuery(string fieldNames)
		{
			var filter = new QuerySearchModel { Field = fieldNames };
			bool canFind = CurrentPage.As<CRFPage>().CanFindQuery(filter);
			Assert.IsFalse(canFind, "Queries found");
		}

		//no query, logline
		[StepDefinition(@"I verify Field ""([^""]*)"" has no Query on log line (\d+)")]
		public void IVerifyField____HasNoQuery(string fieldNames, int logline)
		{
			var filter = new QuerySearchModel { Field = fieldNames };
			bool canFind = CurrentPage.As<CRFPage>().OpenLogline(logline).CanFindQuery(filter);
			Assert.IsFalse(canFind, "Queries found");
		}	

		#endregion

		#region Inline verification

		// not displayed , logline
		[StepDefinition(@"I verify Query with message ""([^""]*)"" is not displayed on Field ""([^""]*)"" on log line (\d+)")]
		public void IVerifyQueryWithMesage____IsNotDisplayedOnField____OnLogline____(string message, string fieldNames, int logLine)
		{
			var filter = new QuerySearchModel { Field = fieldNames, QueryMessage = message };
			bool canFind = CurrentPage.As<CRFPage>().OpenLogline(logLine).CanFindQuery(filter);
			Assert.IsFalse(canFind, "Can find query");
		}

		// displayed , logline
		[StepDefinition(@"I verify Query with message ""([^""]*)"" is displayed on Field ""([^""]*)"" on log line (\d+)")]
		public void IVerifyQueryWithMesage____IsDisplayedOnField____OnLogline____(string message, string fieldNames, int logLine)
		{
			var filter = new QuerySearchModel { Field = fieldNames, QueryMessage = message };
			bool canFind = CurrentPage.As<CRFPage>().OpenLogline(logLine).CanFindQuery(filter);
			Assert.IsTrue(canFind, "Can't find query");
		}

		//displayed
		[StepDefinition(@"I verify Query with message ""([^""]*)"" is displayed on Field ""([^""]*)""")]
		public void IVerifyQueryWithMessage____IsDisplayedOnField____(string message, string fieldNames)
		{
			var page = CurrentPage.As<CRFPage>();
			var filter = new QuerySearchModel { Field = fieldNames, QueryMessage = message };
			bool canFind = page.CanFindQuery(filter);
			Assert.IsTrue(canFind, "Can't find query");
		}

		//not displayed
		[StepDefinition(@"I verify Query with message ""([^""]*)"" is not displayed on Field ""([^""]*)""")]
		public void IVerifyQueryWithMessage____IsNotDisplayedOnField____(string message, string fieldNames)
		{
			var filter = new QuerySearchModel { Field = fieldNames, QueryMessage = message };
			bool canFind = CurrentPage.As<CRFPage>().CanFindQuery(filter);
			Assert.IsFalse(canFind, "Can find query");
		}

		//RR, displayed
		[StepDefinition(@"I verify Requires Response Query with message ""([^""]*)"" is displayed on Field ""([^""]*)""")]
		public void IVerifyRequiresResponseQueryWithMessage____IsDisplayedOnField____(string message, string fieldNames)
		{
			var filter = new QuerySearchModel { Field = fieldNames, QueryMessage = message,Response =true };
			bool canFind = CurrentPage.As<CRFPage>().CanFindQuery(filter);
			Assert.IsTrue(canFind, "Can't find Requres Response query");
		}

		//not RR, displayed
		[StepDefinition(@"I verify Not Requires Response Query with message ""([^""]*)"" is displayed on Field ""([^""]*)""")]
		public void IVerifyNotRequiresResponseQueryWithMessage____IsDisplayedOnField____(string message, string fieldNames)
        {
			var filter = new QuerySearchModel { Field = fieldNames, QueryMessage = message, Response = false };
			bool canFind = CurrentPage.As<CRFPage>().CanFindQuery(filter);
            Assert.IsTrue(canFind, "Can't find Not Requires Response query");
        }


		//closed, displayed
		[StepDefinition(@"I verify closed Query with message ""([^""]*)"" is displayed on Field ""([^""]*)""")]
		public void IVerifyClosedQueryWithMessage____IsDisplayedOnField____(string message, string fieldNames)
		{
			var filter = new QuerySearchModel { Field = fieldNames, QueryMessage = message ,Closed = true};
			bool canFind = CurrentPage.As<CRFPage>().CanFindQuery(filter);
			Assert.IsTrue(canFind, "Can't find closed query");
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
			var model = table.CreateInstance<QuerySearchModel>();
			CurrentPage.As<CRFPage>().AnswerQuery(model.QueryMessage, model.Field, model.Answer);
	
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
