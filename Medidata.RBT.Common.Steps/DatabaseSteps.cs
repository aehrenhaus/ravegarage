using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using TechTalk.SpecFlow;
using Microsoft.Practices.EnterpriseLibrary.Data;
using System.Data;
using System.IO;

namespace Medidata.RBT.Common.Steps
{
	[Binding]
	public class DatabaseSteps : BrowserStepsBase
	{

		[StepDefinition(@"I restore to snapshot")]
		public void IRestoreToSnapshot____()
		{
			Database database = DatabaseFactory.CreateDatabase(RBTConfiguration.Default.RaveDatabaseConnection);

			var builder = new System.Data.SqlClient.SqlConnectionStringBuilder();
			builder.ConnectionString = database.ConnectionString;
			var restoreQuery = String.Format("alter database {0} set single_user with rollback immediate RESTORE DATABASE {0} from DATABASE_SNAPSHOT = '{1}' alter database {0} set multi_user with rollback immediate", builder.InitialCatalog, RBTConfiguration.Default.SnapshotName);

			//TODO: shall it execut agains master database? 
			database = DatabaseFactory.CreateDatabase(RBTConfiguration.Default.RaveDatabaseConnection + "Master");
			database.ExecuteDataSet(CommandType.Text, restoreQuery);
		}


		[StepDefinition(@"I run SQL Script ""([^""]*)""")]
		public void IRunSQLScript____(string scriptName)
		{
			Database database = DatabaseFactory.CreateDatabase(RBTConfiguration.Default.RaveDatabaseConnection);

			var sql = File.ReadAllText(Path.Combine(RBTConfiguration.Default.SqlScriptsPath, scriptName));
			var dataTable = database.ExecuteDataSet(sql).Tables[0];

			SaveDataTable(dataTable);
			TestContext.SetContextValue(LastSqlResultTable, dataTable);
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



		[StepDefinition(@"I take a screenshot")]
		public void ITakeScreenshot()
		{
			TestContext.TrySaveScreenShot();
		}


		#region Private

		private const string LastSqlResultTable = "LastSqlResultTable";

		private void AssertAreSameTable(System.Data.DataTable dataTable, Table table)
		{
		}

		private void AssertAreNOTSameTable(System.Data.DataTable dataTable, Table table)
		{
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
