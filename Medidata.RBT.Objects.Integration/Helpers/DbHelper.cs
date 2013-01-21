using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Text;
using Medidata.Core.Common.Utilities;
using Medidata.Core.Objects;
using Medidata.Data;
using Medidata.Data.Configuration;

namespace Medidata.RBT.Objects.Integration.Helpers
{
    public static class DbHelper
    {
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

        public static void DropDatabase(string dbName)
        {
            
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
            restoreQuery.AppendFormat(
@"
RESTORE DATABASE {0} FROM DISK = '{1}' 
WITH MOVE 'rave564gold' TO 'C:\data\{0}.mdf',
     MOVE 'rave564gold_log' TO 'C:\log\{0}_log.ldf',
     REPLACE
ALTER DATABASE {0} SET MULTI_USER WITH ROLLBACK IMMEDIATE",
                                                          catalog, snapshot);

            builder.InitialCatalog = "master";
            var cmd = new SqlCommand(restoreQuery.ToString(), new SqlConnection(builder.ToString()));
            cmd.Connection.Open();
            cmd.ExecuteNonQuery();
            cmd.Connection.Close();

            RunDbMigration();
            UpdateConfigurationTable_AwsCredentials();
            UpdateConfigurationTable_ProjectCreatorDefaultRole();
        }

        public static void RunDbMigration()
        {
            var environmentVariables = Environment.GetEnvironmentVariables();
            var ravePath = environmentVariables["RAVE_PATH"].ToString();
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
    }
}
