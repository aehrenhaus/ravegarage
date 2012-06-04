using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Medidata.RBT.Features;
using TechTalk.SpecFlow;
using Medidata.RBT.WebDriver;
using Medidata.RBT.WebDriver.Rave;
using System.IO;

namespace Medidata.RBT.Features.Rave
{
	[Binding]
	public class CommonRaveSteps : FeatureStepsUsingBrowser
	{

        [StepDefinition(@"I restore to snapshot")]
        public void IRestoreToSnapshot____()
        {
            var builder = new System.Data.SqlClient.SqlConnectionStringBuilder();
            builder.ConnectionString = RBTConfiguration.Default.RaveDatabaseConnection;
            var restoreQuery = String.Format("alter database {0} set single_user with rollback immediate RESTORE DATABASE {0} from DATABASE_SNAPSHOT = '{1}' alter database {0} set multi_user with rollback immediate", builder.InitialCatalog, RBTConfiguration.Default.SnapshotName);

            builder.InitialCatalog = "master";
            DbHelper db = new DbHelper(builder.ConnectionString); //obtain conn string to "master" database

            db.ExecuteNonQuery(db.GetSqlStringCommand(restoreQuery));
        }


        [StepDefinition(@"I run SQL Script ""([^""]*)""")]
		public void IRunSQLScript____(string scriptName)
		{
			DbHelper db = new DbHelper(RBTConfiguration.Default.RaveDatabaseConnection);

			var sql = File.ReadAllText(Path.Combine(RBTConfiguration.Default.SqlScriptsLocation, scriptName));
			var dataTable = db.ExecuteDataTable(db.GetSqlStringCommand(sql));
			
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


        [StepDefinition(@"I login to Rave with username ""([^""]*)"" and password ""([^""]*)""")]
		public void ILoginToRaveWithUsername____AndPassword____(string username, string passowrd)
		{
			LoginPage page = new LoginPage().OpenNew<LoginPage>();
			CurrentPage = page.Login(username, passowrd);
		}


        [StepDefinition(@"I login to Rave with user ""([^""]*)""")]
		public void ILoginToRaveWithUser(string user)
		{
			string username,password =null;
			username = RBTConfiguration.Default.DefaultUser;
			password = RBTConfiguration.Default.DefaultUserPassword;

			LoginPage page = new LoginPage().OpenNew<LoginPage>();
			CurrentPage = page.Login(username, password);
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
			File.WriteAllText(Path.Combine(resultPath,"a.txt"), DateTime.Now.ToString());
		}

		#endregion



	}
}
