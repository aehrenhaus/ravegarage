using System;
using TechTalk.SpecFlow;
using System.IO;

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
			Storage.SetScenarioLevelValue(LastSqlResultTable, dataTable);
		}



		[StepDefinition(@"I should see SQL result")]
		public void IShouldSeeResult(Table table)
		{
			var dataTable = Storage.GetScenarioLevelValue<System.Data.DataTable>(LastSqlResultTable);
			AssertAreSameTable(dataTable, table);

		}

		[StepDefinition(@"I should NOT see SQL result")]
		public void IShouldNOTSeeResult(Table table)
		{
			var dataTable = Storage.GetScenarioLevelValue<System.Data.DataTable>(LastSqlResultTable);
			AssertAreNOTSameTable(dataTable, table);
		}

        [StepDefinition(@"I verify the log message for query not opening event for Project ""([^""]*)"" and Site ""([^""]*)""")]
        public void IVerifyTheLogMessagesForQueryNotOpeningEventsForProjectEditCheckStudy3AndSiteEditCheckSite3(string projectName, string siteName)
        {
            var sql = "spVerifyQueryLog";
			var dataTable = DbHelper.ExecuteDataSet(sql, new object[] { projectName, siteName }).Tables[0];

            SaveDataTable(dataTable);
            Storage.SetScenarioLevelValue(LastSqlResultTable, dataTable);
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
