using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using System.Data;
using System.Data.SqlClient;
using Medidata.RBT.ConfigurationHandlers;


namespace Medidata.RBT
{
	/// <summary>
	/// Since it is decided to use Microsoft enterprise libary to operate the database,
	/// this class only does something that can not be done easily through enterprise library
	/// </summary>
    public static class DbHelper
    {

        private static string _sqlConnString = System.Configuration.ConfigurationManager.ConnectionStrings[RBTConfiguration.Default.DatabaseConnection].ConnectionString;

		public static void CreateSnapshot(string snapshotName=null)
		{
			if (snapshotName == null)
				snapshotName = RBTConfiguration.Default.SnapshotName;

			var builder = new System.Data.SqlClient.SqlConnectionStringBuilder();
			builder.ConnectionString = _sqlConnString;

			string fileName = null;
			using (SqlCommand cmdGetFileName = new SqlCommand(string.Format("select name from {0}..sysfiles", builder.InitialCatalog), new SqlConnection(builder.ToString())))
			{
				cmdGetFileName.Connection.Open();
				fileName = cmdGetFileName.ExecuteScalar() as string;
				cmdGetFileName.Connection.Close();
			}
			string path = "c:\\";
			var restoreQuery = String.Format(
@"

CREATE DATABASE {0}
ON ( NAME = N'{1}',  
FILENAME = N'{2}{0}.snap' )
AS SNAPSHOT OF {3};
",
								snapshotName, /*Snapshot name*/
								fileName,/*file name that create snapshot on*/
								path,/*path to store the snapshot file*/
								builder.InitialCatalog/*original database name*/);

			using (SqlCommand cmdCreateSS = new SqlCommand(restoreQuery, new SqlConnection(builder.ToString())))
			{
				cmdCreateSS.Connection.Open();
				cmdCreateSS.ExecuteNonQuery();
				cmdCreateSS.Connection.Close();
			}
			
		}

		public static void RestoreSnapshot(string snapshotName = null)
		{
			if (snapshotName == null)
				snapshotName = RBTConfiguration.Default.SnapshotName;

			
			var builder = new System.Data.SqlClient.SqlConnectionStringBuilder();
			builder.ConnectionString =System.Configuration.ConfigurationManager.ConnectionStrings[RBTConfiguration.Default.DatabaseConnection].ConnectionString;
			string catalog = builder.InitialCatalog;
			var restoreQuery = String.Format(
@"
alter database {0} set single_user with rollback immediate 
RESTORE DATABASE {0} from DATABASE_SNAPSHOT = '{1}' 
alter database {0} set multi_user with rollback immediate",
														 catalog, snapshotName);

			builder.InitialCatalog = "master";
			SqlCommand cmd = new SqlCommand(restoreQuery, new SqlConnection(builder.ToString()));
			cmd.Connection.Open();
			cmd.ExecuteNonQuery();
			cmd.Connection.Close();

		}

        public static void EnableDDEForSiteAndStudy(string site)
        {
            var builder = new System.Data.SqlClient.SqlConnectionStringBuilder();
            builder.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings[RBTConfiguration.Default.DatabaseConnection].ConnectionString;
            string catalog = builder.InitialCatalog;
            var DDESiteQuery = String.Format(
            @"
            update ss
            set ss.isDDE = 1
            from studySites ss
	            join studies st
		            on st.studyID = ss.studyID
	            join projects p
		            on p.projectID = st.projectID
	            join sites si
		            on si.siteID = ss.siteID
            where dbo.fnlocaldefault(siteNameID) = '{0}'",
                                                         site);

            SqlCommand cmd = new SqlCommand(DDESiteQuery, new SqlConnection(builder.ToString()));
            cmd.Connection.Open();
            cmd.ExecuteNonQuery();
            cmd.Connection.Close();
        }

        public static void EnableUnitsOnlyForSiteAndStudy(string site)
        {
            var builder = new System.Data.SqlClient.SqlConnectionStringBuilder();
            builder.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings[RBTConfiguration.Default.DatabaseConnection].ConnectionString;
            string catalog = builder.InitialCatalog;
            var UnitsOnlySiteQuery = String.Format(
            @"
            update ss
            set ss.AllowUnitsOnly = 1
            from studySites ss
	            join studies st
		            on st.studyID = ss.studyID
	            join projects p
		            on p.projectID = st.projectID
	            join sites si
		            on si.siteID = ss.siteID
            where dbo.fnlocaldefault(siteNameID) = '{0}'",
                                                         site);

            SqlCommand cmd = new SqlCommand(UnitsOnlySiteQuery, new SqlConnection(builder.ToString()));
            cmd.Connection.Open();
            cmd.ExecuteNonQuery();
            cmd.Connection.Close();
        }

        public static void SetDatabaseToOffline()
        {
            var builder = new System.Data.SqlClient.SqlConnectionStringBuilder();
            builder.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings[RBTConfiguration.Default.DatabaseConnection].ConnectionString;
            string catalog = builder.InitialCatalog;
            var offlineQuery = String.Format(
@"
ALTER DATABASE {0} SET SINGLE_USER WITH ROLLBACK IMMEDIATE
ALTER DATABASE {0} SET OFFLINE WITH ROLLBACK IMMEDIATE ",
                                                         catalog);

            builder.InitialCatalog = "master";
            SqlCommand cmd = new SqlCommand(offlineQuery, new SqlConnection(builder.ToString()));
            cmd.Connection.Open();
            cmd.ExecuteNonQuery();
            cmd.Connection.Close();
        }


        public static void SetDatabaseToOnline()
        {
            var builder = new System.Data.SqlClient.SqlConnectionStringBuilder();
            builder.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings[RBTConfiguration.Default.DatabaseConnection].ConnectionString;
            string catalog = builder.InitialCatalog;
            var onlineQuery = String.Format(
@"
ALTER DATABASE {0} SET MULTI_USER
ALTER DATABASE {0} SET ONLINE WITH ROLLBACK IMMEDIATE ",
                                                         catalog);

            builder.InitialCatalog = "master";
            SqlCommand cmd = new SqlCommand(onlineQuery, new SqlConnection(builder.ToString()));
            cmd.Connection.Open();
            cmd.ExecuteNonQuery();
            cmd.Connection.Close();
        }

        public static DataSet ExecuteDataSet(string sql, object[] args = null)
        {
		
            SqlCommand cmd = new SqlCommand(sql, new SqlConnection(_sqlConnString));
            if (args != null)
                cmd.Parameters.AddRange(args);
            IDataAdapter adp = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            adp.Fill(ds);
            return ds;
        }

        public static bool ExecuteStoredProcedureRetBool(string spName, IDictionary<string, object> args = null)
        {
            object obj = ExecuteScalarStoredProcedure(spName, args);
            string objString;
            switch (obj.ToString())
            {
                case "1": objString = "True";
                    break;
                case "0": objString = "False";
                    break;
                default: objString = obj.ToString();
                    break;
            }

            bool returnResult;
            bool result = bool.TryParse(objString, out returnResult);
            return returnResult;
        }

		public static object ExecuteScalarStoredProcedure(string spName, IDictionary<string, object> args = null)
        {
            return ExecuteScalar(spName, CommandType.StoredProcedure, args);
        }

		public static object ExecuteScalar(string sqlString, CommandType commandType, IDictionary<string, object> args = null)
        {
			using (var conn = new SqlConnection(_sqlConnString))
			{
				conn.Open();
				SqlCommand comm = new SqlCommand(sqlString, conn);
                comm.CommandType = commandType;
				
				if(args != null && args.Any())
					foreach(var kvp in args)
						comm.Parameters.Add(new SqlParameter(kvp.Key, kvp.Value));

                object returnObject = comm.ExecuteScalar();
            
                return returnObject;
            }
        }

		/// <summary>
		/// Helper method that returns the first DataRow in the first DataTable of a given DataSet.
		/// Will return null if
		///		1.	There are 0 DataTables in given DataSet
		///		2.	There are 0 DataRows in the first DataTable
		/// </summary>
		/// <param name="set">DataSet instance for which to return the first DataRow</param>
		/// <returns>The first DataRow of the parameter DataSet 'set'</returns>
		public static DataRow GetFirstRow(this DataSet set)
		{
			var result = set.Tables.Count > 0 && set.Tables[0].Rows.Count > 0
				? set.Tables[0].Rows[0]
				: null;
			return result;
		}

		public static string GetSqlString(string val)
		{
			return val == null
				? "null"
				: string.Format("'{0}'", val);
		}
	}
}
