using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using TechTalk.SpecFlow;
using System.Data;
using System.IO;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Medidata.RBT.DBScripts;

namespace Medidata.RBT.Common.Steps
{
	[Binding]
	public class DatabaseSteps : BrowserStepsBase
	{

		//[StepDefinition(@"I restore to snapshot ""([^""]*)""")]
		//public void IRestoreToSnapshot____(string snapshotName)
		//{
		//    DbHelper.RestoreSnapshot(snapshotName);
		//}

		//[StepDefinition(@"I restore to snapshot")]
		//public void IRestoreToSnapshot()
		//{
		//    DbHelper.CreateSnapshot();
		//    DbHelper.RestoreSnapshot();
		//}

		/// <summary>
		/// test
		/// </summary>
		/// <param name="scriptName"></param>
		[StepDefinition(@"I run SQL Script ""([^""]*)""")]
		public void IRunSQLScript____(string scriptName)
		{
			var sql = File.ReadAllText(Path.Combine(RBTConfiguration.Default.SqlScriptsPath, scriptName));
			var dataTable = DbHelper.ExecuteDataSet(sql).Tables[0];

			SaveDataTable(dataTable);
			TestContext.SetContextValue(LastSqlResultTable, dataTable);
		}

        /// <summary>
        /// Based on the column name, we call an appropriate method and assert true/false whether or not column in table datapoints propagates
        /// </summary>
        /// <param name="columnName"></param>
        [StepDefinition(@"""([^""]*)"" propagates correctly")]
        public void IVerifyDatapointColumnPropagates____(string columnName)
        {
            Uri tempUri = new Uri(Browser.Url);
            var sql = PropagationVerificationSQLScripts.GenerateSQLQueryForColumnName(columnName, int.Parse(tempUri.Query.Replace("?DP=", "")));

			var dataTable = DbHelper.ExecuteDataSet(sql).Tables[0];
            Assert.IsTrue((int)dataTable.Rows[0][0] == 0, "Data doesn't propagate correctly");
        }

		[StepDefinition(@"I should see SQL result")]
		public void IShouldSeeResult(Table table)
		{
			var dataTable = TestContext.GetContextValue<System.Data.DataTable>(LastSqlResultTable);
			AssertAreSameTable(dataTable, table);

		}

		[StepDefinition(@"I should NOT see SQL result")]
		public void IShouldNOTSeeResult(Table table)
		{
			var dataTable = TestContext.GetContextValue<System.Data.DataTable>(LastSqlResultTable);
			AssertAreNOTSameTable(dataTable, table);
		}

        [When(@"I verify the log message for query not opening event for Project ""([^""]*)"" and Site ""([^""]*)""")]
        public void WhenIVerifyTheLogMessagesForQueryNotOpeningEventsForProjectEditCheckStudy3AndSiteEditCheckSite3(string projectName, string siteName)
        {
            var sql = "spVerifyQueryLog";
			var dataTable = DbHelper.ExecuteDataSet(sql, new object[] { projectName, siteName }).Tables[0];

            SaveDataTable(dataTable);
            TestContext.SetContextValue(LastSqlResultTable, dataTable);
        }


		#region Private

		private const string LastSqlResultTable = "LastSqlResultTable";

		private void AssertAreSameTable(System.Data.DataTable dataTable, Table table)
		{
            //foreach (var columnheader in table.Header)
            //{
            //    Assert.IsTrue(dataTable.Columns.Contains(columnheader));
            //}

            //foreach (var row in table.Rows)
            //{
            //    bool matchFound = false;
            //    foreach (DataRow dataRow in dataTable.Rows)
            //    {
            //        try
            //        {
            //            CollectionAssert.IsSubsetOf(row.Values.ToArray(), dataRow.ItemArray);
            //            matchFound = true;
            //            break;
            //        }
            //        catch 
            //        { 
            //            //intentionally swallowing the exception if collection not the same
            //        }
            //    }

            //    Assert.IsTrue(matchFound);

            
            //}
		}

		private void AssertAreNOTSameTable(System.Data.DataTable dataTable, Table table)
		{
            throw new Exception("method not implemented");
		}

		private void SaveDataTable(System.Data.DataTable dataTable)
		{
			string resultPath = TestContext.GetTestResultPath();
			Directory.CreateDirectory(resultPath);
			File.WriteAllText(Path.Combine(resultPath, "a.txt"), DateTime.Now.ToString());
		}

		#endregion

	}
}
