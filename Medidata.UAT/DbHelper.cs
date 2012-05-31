using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.Common;
using System.Data.SqlClient;
using System.Configuration;
namespace Medidata.UAT
{


	public class DbHelper
	{
		private static string dbProviderName = "System.Data.SqlClient";

		private DbConnection connection;

		public DbHelper(string connectionString)
		{
			this.connection = CreateConnection(connectionString);
		}


		public static DbConnection CreateConnection(string connectionString)
		{
			DbProviderFactory dbfactory = DbProviderFactories.GetFactory(DbHelper.dbProviderName);
			DbConnection dbconn = dbfactory.CreateConnection();
			dbconn.ConnectionString = connectionString;
			return dbconn;
		}


		public DbCommand GetStoredProcCommond(string storedProcedure)
		{
			DbCommand dbCommand = connection.CreateCommand();
			dbCommand.CommandText = storedProcedure;
			dbCommand.CommandType = CommandType.StoredProcedure;
			return dbCommand;
		}

		public DbCommand GetSqlStringCommand(string sqlQuery)
		{
			DbCommand dbCommand = connection.CreateCommand();
			dbCommand.CommandText = sqlQuery;
			dbCommand.CommandType = CommandType.Text;
			return dbCommand;
		}



		public DataTable ExecuteDataTable(DbCommand cmd)
		{
			DbProviderFactory dbfactory = DbProviderFactories.GetFactory(DbHelper.dbProviderName);
			DbDataAdapter dbDataAdapter = dbfactory.CreateDataAdapter();

			dbDataAdapter.SelectCommand = cmd;
			DataTable dataTable = new DataTable();
			dbDataAdapter.Fill(dataTable);
			return dataTable;
		}


		public int ExecuteNonQuery(DbCommand cmd)
		{

			cmd.Connection.Open();
			int ret = cmd.ExecuteNonQuery();
			cmd.Connection.Close();
			return ret;
		}

		public object ExecuteScalar(DbCommand cmd)
		{

			cmd.Connection.Open();
			object ret = cmd.ExecuteScalar();
			cmd.Connection.Close();
			return ret;
		}
	}


}
