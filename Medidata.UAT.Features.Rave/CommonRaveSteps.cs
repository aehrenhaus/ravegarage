using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Medidata.UAT.Features;
using TechTalk.SpecFlow;
using Medidata.UAT.WebDrivers;
using Medidata.UAT.WebDrivers.Rave;
using System.IO;

namespace Medidata.UAT.Features.Rave
{
	[Binding]
	public class CommonRaveSteps : FeatureStepsUsingBrowser
	{
		[When(@"I run SQL Script ""([^""]*)""")]
		[Then(@"I run SQL Script ""([^""]*)""")]
		public void IRunSQLScript____(string scriptName)
		{
			DbHelper db = new DbHelper(UAT.UATConfiguration.Default.RaveDatabaseConnection);

			var sql = File.ReadAllText(Path.Combine(UATConfiguration.Default.SqlScriptsLocation, scriptName));
			var dataTable = db.ExecuteDataTable(db.GetSqlStringCommond(sql));
			
			SaveDataTable(dataTable);
			TestContext.SetContextValue(LastSqlResultTable, dataTable);
		}

		[When(@"I shoud see SQL result")]
		[Then(@"I shoud see SQL result")]
		public void IShoudSeeResult(Table table)
		{
			var dataTable = TestContext.GetContextValue<System.Data.DataTable>(LastSqlResultTable);
			AssertAreSameTable(dataTable, table);

		}

		[When(@"I shoud NOT see SQL result")]
		[Then(@"I shoud NOT see SQL result")]
		public void IShoudNOTSeeResult(Table table)
		{
			var dataTable = TestContext.GetContextValue<System.Data.DataTable>(LastSqlResultTable);
			AssertAreNOTSameTable(dataTable, table);
		}



		[When(@"I take screenshot")]
		[Then(@"I take screenshot")]
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
			File.WriteAllText(Path.Combine(resultPath,"a.txt"), DateTime.Now.ToString());
		}

		#endregion



	}
}
