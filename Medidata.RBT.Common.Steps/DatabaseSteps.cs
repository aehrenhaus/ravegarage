using System;
using TechTalk.SpecFlow;
using System.IO;

namespace Medidata.RBT.Common.Steps
{
    /// <summary>
    /// Steps that require direct contact with the DB
    /// </summary>
	[Binding]
	public class DatabaseSteps : BrowserStepsBase
	{
		private const string LastSqlResultTable = "LastSqlResultTable";

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
		/// Run a sql script by name
		/// </summary>
		/// <param name="scriptName">The name of the sql script to run</param>
		[StepDefinition(@"I run SQL Script ""([^""]*)""")]
		public void IRunSQLScript____(string scriptName)
		{
			var sql = File.ReadAllText(Path.Combine(RBTConfiguration.Default.SqlScriptsPath, scriptName));
			var dataTable = DbHelper.ExecuteDataSet(sql).Tables[0];

			SaveDataTable(dataTable);
		
			SpecflowContext.Storage[LastSqlResultTable] = dataTable;
		}


        /// <summary>
        /// Verify the result of a sql command
        /// </summary>
        /// <param name="table">The result you should see</param>
		[StepDefinition(@"I should see SQL result")]
		public void IShouldSeeResult(Table table)
		{
			var dataTable = SpecflowContext.Storage[LastSqlResultTable] as System.Data.DataTable;
			AssertAreSameTable(dataTable, table);

		}

        /// <summary>
        /// Verify the result of a sql command that you should not see
        /// </summary>
        /// <param name="table">The result you should not see</param>
		[StepDefinition(@"I should NOT see SQL result")]
		public void IShouldNOTSeeResult(Table table)
		{
			var dataTable = SpecflowContext.Storage[LastSqlResultTable] as System.Data.DataTable;
			AssertAreNOTSameTable(dataTable, table);
		}

		#region Private

		

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
			string resultPath = RBTConfiguration.Default.TestResultPath;
			Directory.CreateDirectory(resultPath);
			File.WriteAllText(Path.Combine(resultPath, "a.txt"), DateTime.Now.ToString());
		}

		#endregion

	}
}
