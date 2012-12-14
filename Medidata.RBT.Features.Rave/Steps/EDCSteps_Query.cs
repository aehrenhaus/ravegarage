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
    /// <summary>
    /// Steps pertaining to EDC
    /// </summary>
	public partial class EDCSteps
    {
        #region Verify with table

        /// <summary>
        /// table, logline, not exist
        /// </summary>
        /// <param name="logLine"></param>
        /// <param name="table"></param>
		[StepDefinition(@"I verify Query is not displayed on log line (\d+)")]
		public void IVerifyQueryIsNotDisplayedOnLogline____(int logLine, Table table)
		{
			var filter = table.CreateInstance<QuerySearchModel>();
			bool canFind =CurrentPage.As<CRFPage>().OpenLogline(logLine).CanFindQuery( filter);
			Assert.IsFalse(canFind, "Query exists");
		}

        /// <summary>
        /// table, logline exist
        /// </summary>
        /// <param name="logLine"></param>
        /// <param name="table"></param>
		[StepDefinition(@"I verify Query is displayed on log line (\d+)")]
		public void IVerifyQueryIsDisplayedOnLogline____(int logLine, Table table)
		{
			var filter = table.CreateInstance<QuerySearchModel>();
			bool canFind = CurrentPage.As<CRFPage>().OpenLogline(logLine).CanFindQuery(filter);
			Assert.IsTrue(canFind, "Query doesn't exist");
		}

        /// <summary>
        /// table, not exist
        /// </summary>
        /// <param name="table"></param>
		[StepDefinition(@"I verify Query is not displayed")]
		public void IVerifyQueryIsNotDisplayed(Table table)
		{
            bool canFind = false;
            var filters = table.CreateSet<QuerySearchModel>();
            foreach (var filter in filters)
            {
                canFind = CurrentPage.As<CRFPage>().CanFindQuery(filter);
            }
            Assert.IsFalse(canFind, "One or More Queries exist");
		}

        /// <summary>
        /// table, exist
        /// </summary>
        /// <param name="table"></param>
		[StepDefinition(@"I verify Query is displayed")]
		public void IVerifyQueryIsDisplayed(Table table)
		{
            var filters = table.CreateSet<QuerySearchModel>();
            foreach (var filter in filters)
            {
                Assert.IsTrue(CurrentPage.As<CRFPage>().CanFindQuery(filter), 
                    "One or More Queries do not exist");
            }
		}
		#endregion 

		#region No query at all

        /// <summary>
        /// no query
        /// </summary>
        /// <param name="fieldNames"></param>
		[StepDefinition(@"I verify Field ""([^""]*)"" has no Query")]
		public void IVerifyField____HasNoQuery(string fieldNames)
		{
			var filter = new QuerySearchModel { Field = fieldNames };
			bool canFind = CurrentPage.As<CRFPage>().CanFindQuery(filter);
			Assert.IsFalse(canFind, "Queries found");
		}

        /// <summary>
        /// no query, logline
        /// </summary>
        /// <param name="fieldNames"></param>
        /// <param name="logline"></param>
		[StepDefinition(@"I verify Field ""([^""]*)"" has no Query on log line (\d+)")]
		public void IVerifyField____HasNoQuery(string fieldNames, int logline)
		{
			var filter = new QuerySearchModel { Field = fieldNames };
			bool canFind = CurrentPage.As<CRFPage>().OpenLogline(logline).CanFindQuery(filter);
			Assert.IsFalse(canFind, "Queries found");
		}	

		#endregion

		#region Inline verification

        /// <summary>
        /// not displayed, logline
        /// </summary>
        /// <param name="message"></param>
        /// <param name="fieldNames"></param>
        /// <param name="logLine"></param>
		[StepDefinition(@"I verify Query with message ""([^""]*)"" is not displayed on Field ""([^""]*)"" on log line (\d+)")]
		public void IVerifyQueryWithMesage____IsNotDisplayedOnField____OnLogline____(string message, string fieldNames, int logLine)
		{
			var filter = new QuerySearchModel { Field = fieldNames, QueryMessage = message };
			bool canFind = CurrentPage.As<CRFPage>().OpenLogline(logLine).CanFindQuery(filter);
			Assert.IsFalse(canFind, "Can find query");
		}

        /// <summary>
        /// displayed, logline
        /// </summary>
        /// <param name="message"></param>
        /// <param name="fieldNames"></param>
        /// <param name="logLine"></param>
		[StepDefinition(@"I verify Query with message ""([^""]*)"" is displayed on Field ""([^""]*)"" on log line (\d+)")]
		public void IVerifyQueryWithMesage____IsDisplayedOnField____OnLogline____(string message, string fieldNames, int logLine)
		{
			var filter = new QuerySearchModel { Field = fieldNames, QueryMessage = message };
			bool canFind = CurrentPage.As<CRFPage>().OpenLogline(logLine).CanFindQuery(filter);
			Assert.IsTrue(canFind, "Can't find query");
		}

        /// <summary>
        /// displayed
        /// </summary>
        /// <param name="message"></param>
        /// <param name="fieldNames"></param>
		[StepDefinition(@"I verify Query with message ""([^""]*)"" is displayed on Field ""([^""]*)""")]
		public void IVerifyQueryWithMessage____IsDisplayedOnField____(string message, string fieldNames)
		{
			var page = CurrentPage.As<CRFPage>();
			var filter = new QuerySearchModel { Field = fieldNames, QueryMessage = message };
			bool canFind = page.CanFindQuery(filter);
			Assert.IsTrue(canFind, "Can't find query");
		}

        /// <summary>
        /// not displayed
        /// </summary>
        /// <param name="message"></param>
        /// <param name="fieldNames"></param>
		[StepDefinition(@"I verify Query with message ""([^""]*)"" is not displayed on Field ""([^""]*)""")]
		public void IVerifyQueryWithMessage____IsNotDisplayedOnField____(string message, string fieldNames)
		{
			var filter = new QuerySearchModel { Field = fieldNames, QueryMessage = message };
			bool canFind = CurrentPage.As<CRFPage>().CanFindQuery(filter);
			Assert.IsFalse(canFind, "Can find query");
		}

        /// <summary>
        /// RR, displayed
        /// </summary>
        /// <param name="message"></param>
        /// <param name="fieldNames"></param>
		[StepDefinition(@"I verify Requires Response Query with message ""([^""]*)"" is displayed on Field ""([^""]*)""")]
		public void IVerifyRequiresResponseQueryWithMessage____IsDisplayedOnField____(string message, string fieldNames)
		{
			var filter = new QuerySearchModel { Field = fieldNames, QueryMessage = message,Response =true };
			bool canFind = CurrentPage.As<CRFPage>().CanFindQuery(filter);
			Assert.IsTrue(canFind, "Can't find Requres Response query");
		}

        /// <summary>
        /// not RR, displayed
        /// </summary>
        /// <param name="message"></param>
        /// <param name="fieldNames"></param>
		[StepDefinition(@"I verify Not Requires Response Query with message ""([^""]*)"" is displayed on Field ""([^""]*)""")]
		public void IVerifyNotRequiresResponseQueryWithMessage____IsDisplayedOnField____(string message, string fieldNames)
        {
			var filter = new QuerySearchModel { Field = fieldNames, QueryMessage = message, Response = false };
			bool canFind = CurrentPage.As<CRFPage>().CanFindQuery(filter);
            Assert.IsTrue(canFind, "Can't find Not Requires Response query");
        }

        /// <summary>
        /// closed, displayed
        /// </summary>
        /// <param name="message"></param>
        /// <param name="fieldNames"></param>
		[StepDefinition(@"I verify closed Query with message ""([^""]*)"" is displayed on Field ""([^""]*)""")]
		public void IVerifyClosedQueryWithMessage____IsDisplayedOnField____(string message, string fieldNames)
		{
			var filter = new QuerySearchModel { Field = fieldNames, QueryMessage = message ,Closed = true};
			bool canFind = CurrentPage.As<CRFPage>().CanFindQuery(filter);
			Assert.IsTrue(canFind, "Can't find closed query");
		}
		#endregion

		#region Close ,Cancel ,Answer

        /// <summary>
        /// answer
        /// </summary>
        /// <param name="message"></param>
        /// <param name="fieldName"></param>
        /// <param name="answer"></param>
		[StepDefinition(@"I answer the Query ""([^""]*)"" on Field ""([^""]*)"" with ""([^""]*)""")]
		public void IAnswerTheQueryOnField____With____(string message, string fieldName, string answer)
		{
			CRFPage page = CurrentPage.As<CRFPage>();
			page.AnswerQuery(message, fieldName, answer);
		}

        /// <summary>
        /// answer with random text
        /// </summary>
        /// <param name="message"></param>
        /// <param name="fieldNames"></param>
		[StepDefinition(@"I answer the Query ""([^""]*)"" on Field ""([^""]*)""")]
		public void IAnswerTheQueryOn____(string message, string fieldNames)
		{
			CRFPage page = CurrentPage.As<CRFPage>();
			page.AnswerQuery(message, fieldNames, System.DateTime.Today.Ticks.ToString());
		}

        /// <summary>
        /// answer the only query
        /// </summary>
        /// <param name="fieldName"></param>
        /// <param name="answer"></param>
		[StepDefinition(@"I answer the only Query on Field ""([^""]*)"" with ""([^""]*)""")]
		public void IAnswerTheOnlyQueryOnField____With____(string fieldName, string answer)
		{
			CRFPage page = CurrentPage.As<CRFPage>();
			page.AnswerQuery(null, fieldName, answer);
		}

        /// <summary>
        /// answer the only query with random text
        /// </summary>
        /// <param name="fieldNames"></param>
		[StepDefinition(@"I answer the only Query on Field ""([^""]*)""")]
		public void IAnswerTheOnlyQueryOn____(string fieldNames)
		{
			CRFPage page = CurrentPage.As<CRFPage>();
			page.AnswerQuery(null, fieldNames, System.DateTime.Today.Ticks.ToString());
		}

        /// <summary>
        /// Answer the query. Never used.
        /// </summary>
        /// <param name="table"></param>
		[StepDefinition(@"I answer the Query")]
		public void IAnswerTheQuery(Table table)
		{
			var model = table.CreateInstance<QuerySearchModel>();
			CurrentPage.As<CRFPage>().AnswerQuery(model.QueryMessage, model.Field, model.Answer);
		}

        /// <summary>
        /// cancel
        /// </summary>
        /// <param name="message"></param>
        /// <param name="fieldName"></param>
		[StepDefinition(@"I cancel the Query ""([^""]*)"" on Field ""([^""]*)""")]
		public void ICancelTheQueryOnField____With____(string message, string fieldName)
		{
            CRFPage page = CurrentPage.As<CRFPage>();
            page.CancelQuery(message, fieldName);
		}

        /// <summary>
        /// cancel the only query
        /// </summary>
        /// <param name="fieldName"></param>
		[StepDefinition(@"I cancel the only Query on Field ""([^""]*)""")]
		public void ICancelTheQueryOnField____With____(string fieldName)
		{
			CRFPage page = CurrentPage.As<CRFPage>();
			page.CancelQuery(null, fieldName);
		}

        /// <summary>
        /// close
        /// </summary>
        /// <param name="message"></param>
        /// <param name="fieldNames"></param>
        [StepDefinition(@"I close the Query ""([^""]*)"" on Field ""([^""]*)""")]
        public void ICloseTheQuery____OnField____(string message, string fieldNames)
        {
            CRFPage page = CurrentPage.As<CRFPage>();
            page.CloseQuery(message, fieldNames);
        }

        /// <summary>
        /// close the only query
        /// </summary>
        /// <param name="fieldNames"></param>
		[StepDefinition(@"I close the only Query on Field ""([^""]*)""")]
		public void ICloseTheQueryOnField____(string fieldNames)
		{
			CRFPage page = CurrentPage.As<CRFPage>();
			page.CloseQuery(null, fieldNames);
		}

		#endregion
	}
}
