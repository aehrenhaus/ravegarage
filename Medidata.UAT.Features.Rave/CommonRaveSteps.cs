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
		[When(@"I run SQL Script ""([^""]*)"" I shoud see result")]
		public void IRunSQLScript____IShoudSeeResult(string scriptName, Table table)
		{
			DbHelper db = new DbHelper(UAT.UATConfiguration.Default.RaveDatabaseConnection);

			var sql = File.ReadAllText(Path.Combine(UATConfiguration.Default.SqlScriptsLocation, scriptName));
			var dataTable = db.ExecuteDataTable(db.GetSqlStringCommond(sql));
			SaveDataTable(dataTable);
			AssertAreSameTable(dataTable, table);
		}

		private void AssertAreSameTable(System.Data.DataTable dataTable, Table table)
		{
		}

		private void AssertAreNOTSameTable(System.Data.DataTable dataTable, Table table)
		{
		}

		private void SaveDataTable(System.Data.DataTable dataTable)
		{
			string resultPath = TestContextSetup.GetTestResultPath();
			Directory.CreateDirectory(resultPath);
			File.WriteAllText(Path.Combine(resultPath,"a.txt"), DateTime.Now.ToString());
		}


		[When(@"I run SQL Script ""([^""]*)"" I shoud NOT see result")]
		public void IRunSQLScript____IShoudNOTSeeResult(string scriptName, Table table)
		{
			DbHelper db = new DbHelper(UAT.UATConfiguration.Default.RaveDatabaseConnection);

			var sql = File.ReadAllText(Path.Combine(UATConfiguration.Default.SqlScriptsLocation, scriptName));
			var dataTable = db.ExecuteDataTable(db.GetSqlStringCommond(sql));
			SaveDataTable(dataTable);
			AssertAreNOTSameTable(dataTable, table);
		}


	}
}
