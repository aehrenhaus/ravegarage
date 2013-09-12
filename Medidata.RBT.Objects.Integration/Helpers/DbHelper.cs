using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Text;
using Medidata.Core.Common.Exceptions;
using Medidata.Core.Common.Utilities;
using Medidata.Core.Objects;
using Medidata.Data;
using Medidata.Data.Configuration;

namespace Medidata.RBT.Objects.Integration.Helpers
{
    //TODO: convert connection usage to using statements.
    //TODO: store one builder, create in constructor
    //TODO: make an instance class
    public static class DbHelper
    {
        private static string m_SnapshotName = null;

        static DbHelper()
        {
            SnapshotName = GetDefaultSnapshotName();
        }

        public static string SnapshotName { get; private set; }
        
        public static bool DoesDatabaseExist(string dbName)
        {
             var query = string.Format("IF db_id('{0}') IS NOT NULL BEGIN SELECT 1 END ELSE BEGIN SELECT 0 END", dbName);
            
            var builder = new SqlConnectionStringBuilder(DataSettings.Settings.ConnectionSettings.ResolveDataSourceHint(Agent.DefaultHint).ConnectionString);
            builder.InitialCatalog = "master";
            var cmd = new SqlCommand(query, new SqlConnection(builder.ToString()));
            try
            {
                cmd.Connection.Open();
                return Convert.ToBoolean((int)cmd.ExecuteScalar());
            }
            finally
            {
                cmd.Connection.Close();
            }
        }

        public static void RestoreDatabase()
        {
            var snapshot = ConfigurationManager.AppSettings["RaveBackupLocation"];

            var builder = new SqlConnectionStringBuilder(DataSettings.Settings.ConnectionSettings.ResolveDataSourceHint(Agent.DefaultHint).ConnectionString);
            var catalog = builder.InitialCatalog;
            var restoreQuery = new StringBuilder();
            if(DoesDatabaseExist(builder.InitialCatalog))
            {
                restoreQuery.AppendFormat("alter database {0} set single_user with rollback immediate", catalog);
                restoreQuery.AppendLine();
            }

            var dataPath = AppDomain.CurrentDomain.BaseDirectory + "\\data";
            var logPath = AppDomain.CurrentDomain.BaseDirectory + "\\log";

            // create directories for mdf and ldf files
            if (!Directory.Exists(dataPath))
            {
                DirectoryInfo di = Directory.CreateDirectory(dataPath);
            }

            if (!Directory.Exists(logPath))
            {
                DirectoryInfo di = Directory.CreateDirectory(logPath);
            }


            restoreQuery.AppendFormat(
@"
RESTORE DATABASE {0} FROM DISK = '{1}' 
WITH MOVE 'rave564gold' TO '{2}\{0}.mdf',
     MOVE 'rave564gold_log' TO '{3}\{0}_log.ldf',
     REPLACE
ALTER DATABASE {0} SET MULTI_USER WITH ROLLBACK IMMEDIATE",
                                                          catalog, snapshot, dataPath, logPath);

            builder.InitialCatalog = "master";
            var cmd = new SqlCommand(restoreQuery.ToString(), new SqlConnection(builder.ToString()));
            cmd.Connection.Open();
            cmd.ExecuteNonQuery();
            cmd.Connection.Close();

            RunDbMigration();
            UpdateConfigurationTable_AwsCredentials();
            UpdateConfigurationTable_ProjectCreatorDefaultRole();
            UpdateConfigurationTable_iMedidataBaseUrl();
        }


        public static string GetDefaultSnapshotName()
        {
            var builder = new System.Data.SqlClient.SqlConnectionStringBuilder();
            builder.ConnectionString = DataSettings.Settings.ConnectionSettings.ResolveDataSourceHint(Agent.DefaultHint).ConnectionString;

            return builder.InitialCatalog + "_snap";
        }

        /// <summary>
        /// Creates snapshot for a database
        /// </summary>
        public static void CreateSnapshot()
        {
            //before creating a new snapshot for our tests, make sure no other snapshots exist.
            EnsureNoUnrelatedSnapshotsExist();

            var builder = new System.Data.SqlClient.SqlConnectionStringBuilder();
            builder.ConnectionString = DataSettings.Settings.ConnectionSettings.ResolveDataSourceHint(Agent.DefaultHint).ConnectionString;

            string fileName = null;
            string path = null;

            using (SqlCommand cmdGetFileName = new SqlCommand(string.Format("select name from {0}..sysfiles", builder.InitialCatalog), new SqlConnection(builder.ToString())))
            {
                cmdGetFileName.Connection.Open();
                fileName = cmdGetFileName.ExecuteScalar() as string;
                cmdGetFileName.Connection.Close();
            }

            using (SqlCommand cmdGetFileName = new SqlCommand("SELECT SUBSTRING(physical_name, 1, CHARINDEX(N'master.mdf', LOWER(physical_name)) - 1) FROM master.sys.master_files WHERE database_id = 1 AND file_id = 1", new SqlConnection(builder.ToString())))
            {
                cmdGetFileName.Connection.Open();
                path = cmdGetFileName.ExecuteScalar() as string;
                cmdGetFileName.Connection.Close();
            }

            var createQuery = String.Format(
                                                @"

                                                CREATE DATABASE {0}
                                                ON ( NAME = N'{1}',  
                                                FILENAME = N'{2}{0}.snap' )
                                                AS SNAPSHOT OF [{3}];
                                                ",
                                DbHelper.SnapshotName, /*Snapshot name*/
                                fileName,/*file name that create snapshot on*/
                                path,/*path to store the snapshot file*/
                                builder.InitialCatalog/*original database name*/);

            using (SqlCommand cmdCreateSS = new SqlCommand(createQuery, new SqlConnection(builder.ToString())))
            {
                cmdCreateSS.Connection.Open();
                cmdCreateSS.ExecuteNonQuery();
                cmdCreateSS.Connection.Close();
            }

        }

        /// <summary>
        /// Deletes a snapshot for a given name, or default name
        /// </summary>
        public static void DeleteSnapshot()
        {

            var builder = new System.Data.SqlClient.SqlConnectionStringBuilder();
            builder.ConnectionString = DataSettings.Settings.ConnectionSettings.ResolveDataSourceHint(Agent.DefaultHint).ConnectionString;

            var deleteSnapshotQuery = String.Format(
                @"DROP DATABASE [{0}]",
                                DbHelper.SnapshotName); /*Snapshot name*/


            using (SqlCommand cmdDropSS = new SqlCommand(deleteSnapshotQuery, new SqlConnection(builder.ToString())))
            {
                cmdDropSS.Connection.Open();
                cmdDropSS.ExecuteNonQuery();
                cmdDropSS.Connection.Close();
            }
        }

        public static bool DoesSnapshotExist()
        {
            bool result = false;

            var builder = new System.Data.SqlClient.SqlConnectionStringBuilder();
            builder.ConnectionString = DataSettings.Settings.ConnectionSettings.ResolveDataSourceHint(Agent.DefaultHint).ConnectionString;

            var selectSnapshotQuery = String.Format(
                @"SELECT database_id 
                    FROM sys.databases 
                    WHERE source_database_id IS NOT NULL 
                        AND name = '{0}'",
                DbHelper.SnapshotName); /*Snapshot name*/

            using (var cmdDropSS = new SqlCommand(selectSnapshotQuery, new SqlConnection(builder.ToString())))
            {
                cmdDropSS.Connection.Open();
                var databaseId = cmdDropSS.ExecuteScalar();

                //if we got nothing back, the snapshot doesn't exist
                result = (databaseId != null);

                cmdDropSS.Connection.Close();
            }

            return result;
        }
        
        /// <summary>
        /// SQL can only restore snapshots if only a single snapshot exists. Ensure that no unrelated snapshots are present.
        /// </summary>
        /// <exception cref="NotSupportedException">Thrown if any unrelated snapshots exist.</exception>
        public static void EnsureNoUnrelatedSnapshotsExist()
        {
            var builder = new System.Data.SqlClient.SqlConnectionStringBuilder();
            builder.ConnectionString = DataSettings.Settings.ConnectionSettings.ResolveDataSourceHint(Agent.DefaultHint).ConnectionString;

            var remainingSnapshotsQuery = String.Format(
                @"
                                                select count(*) 
                                                from sys.databases snap
	                                                join sys.databases db
		                                                on snap.source_database_id = db.database_id
                                                where db.name = '{0}'
                                                    AND snap.name <> '{1}'
                                                ",
                                builder.InitialCatalog, /*Database name*/
                                DbHelper.SnapshotName /*Our snapshot name...ignore it*/
                                ); 

            // check if there are other snapshots for the database.
            using (SqlCommand cmdOtherSnapshots = new SqlCommand(remainingSnapshotsQuery, new SqlConnection(builder.ToString())))
            {
                cmdOtherSnapshots.Connection.Open();
                var numSnapshots = Convert.ToInt32(cmdOtherSnapshots.ExecuteScalar().ToString());
                cmdOtherSnapshots.Connection.Close();
                if (numSnapshots > 0)
                    throw new NotSupportedException("Unable to proceed.  Please remove existing Database Snapshots.");
            }
        }

        /// <summary>
        /// Restores Database from a snapshot
        /// </summary>
        public static void RestoreSnapshot()
        {
            var builder = new System.Data.SqlClient.SqlConnectionStringBuilder();
            builder.ConnectionString = DataSettings.Settings.ConnectionSettings.ResolveDataSourceHint(Agent.DefaultHint).ConnectionString;
            string catalog = builder.InitialCatalog;
            
            var restoreQuery = String.Format(
            @"
                                                alter database {0} set single_user with rollback immediate 
                                                RESTORE DATABASE {0} from DATABASE_SNAPSHOT = '{1}' 
                                                alter database {0} set multi_user with rollback immediate",
                                                                     catalog, DbHelper.SnapshotName);

            builder.InitialCatalog = "master";
            SqlCommand cmd = new SqlCommand(restoreQuery, new SqlConnection(builder.ToString()));
            cmd.Connection.Open();
            cmd.ExecuteNonQuery();
            cmd.Connection.Close();

        }


        public static void RunDbMigration()
        {
            var ravePath = ConfigurationManager.AppSettings["RavePath"];
            var dbScriptsPath = Path.Combine(new[] { ravePath, "Medidata 5 RAVE Database Project", "Rave_Viper_Lucy_Merged_DB_Scripts", "Developer Helper scripts" });

            var builder = new SqlConnectionStringBuilder(DataSettings.Settings.ConnectionSettings.ResolveDataSourceHint(Agent.DefaultHint).ConnectionString);

            var dailyChangeRunner = new Process
                                        {
                                            StartInfo =
                                                {
                                                    FileName = @".\pre_install_database.bat",
                                                    Arguments =
                                                        string.Format("{0} {1} {2} {3}", builder.DataSource,
                                                                      builder.InitialCatalog, builder.UserID,
                                                                      builder.Password),
                                                    WorkingDirectory = dbScriptsPath
                                                }
                                        };
            dailyChangeRunner.Start();
            dailyChangeRunner.WaitForExit();
        }

        public static void UpdateConfigurationTable_AwsCredentials()
        {
            var builder = new SqlConnectionStringBuilder(DataSettings.Settings.ConnectionSettings.ResolveDataSourceHint(Agent.DefaultHint).ConnectionString);
            var updateConfigQuery = String.Format(
            @"
            exec spConfigurationUpsert '{0}', '{1}', -1, 0",
                                                         ConfigTags.AWSConfigXmlFilePath, ConfigurationManager.AppSettings["AwsConfigXmlFilePath"]);

            var cmd = new SqlCommand(updateConfigQuery, new SqlConnection(builder.ToString()));
            cmd.Connection.Open();
            cmd.ExecuteNonQuery();
            cmd.Connection.Close();
        }

        public static void UpdateConfigurationTable_ProjectCreatorDefaultRole()
        {
            var builder = new SqlConnectionStringBuilder(DataSettings.Settings.ConnectionSettings.ResolveDataSourceHint(Agent.DefaultHint).ConnectionString);
            var updateConfigQuery = String.Format(
            @"
            exec spConfigurationUpsert '{0}', '{1}', -1, 0",
                                                         ConfigTags.ProjectCreatorDefaultRole, 2);

            var cmd = new SqlCommand(updateConfigQuery, new SqlConnection(builder.ToString()));
            cmd.Connection.Open();
            cmd.ExecuteNonQuery();
            cmd.Connection.Close();
        }

        public static void UpdateConfigurationTable_iMedidataBaseUrl()
        {
            var builder = new SqlConnectionStringBuilder(DataSettings.Settings.ConnectionSettings.ResolveDataSourceHint(Agent.DefaultHint).ConnectionString);
            var updateConfigQuery = String.Format(
            @"
            exec spConfigurationUpsert '{0}', '{1}', -1, 0",
                                                         ConfigTags.iMedidataBaseUrl, "http://localhost:3000");

            var cmd = new SqlCommand(updateConfigQuery, new SqlConnection(builder.ToString()));
            cmd.Connection.Open();
            cmd.ExecuteNonQuery();
            cmd.Connection.Close();
        }
    }
}
