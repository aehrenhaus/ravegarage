using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Medidata.RBT.SharedObjects;
using System.Collections;
using Medidata.MAuth;
using System.IO;
using System.Data;
using System.Data.SqlClient;
using Medidata.RBT.ConfigurationHandlers;

namespace Medidata.RBT
{
	public class MAuthContext
	{
        #region ConstantStrings
        private const string MAuthAppUUIDTag = "MAuthAppUUID";
        private const string MAuthBaseUrlTag = "MAuthBaseUrl";
        private const string m_MAuthPrivateKeyFile = @"..\..\..\Seeding\mAuth_rave_private";
        #endregion

        public static string MAuthPrivateKeyFile
        {
            get
            {
                return m_MAuthPrivateKeyFile;
            }
        }

        private static string m_MAuthAppUUID;
        public static string MAuthAppUUID
        {
            get
            {
                if (m_MAuthAppUUID == null)
                    SetupConfigurationStrings();
                return m_MAuthAppUUID;
            }
        }

        private static string m_MAuthBaseUrl;
        public static string MAuthBaseUrl 
        {
            get
            {
                if (m_MAuthBaseUrl == null)
                    SetupConfigurationStrings();
                return m_MAuthBaseUrl;
            }
        }

        private static IMAuthCommunicator m_MAuthCommunicator;
        private static IMAuthCommunicator MAuthCommunicator
        {
            get
            {
                if (m_MAuthCommunicator == null)
                    m_MAuthCommunicator = SetupMAuthCommunicator();
                return m_MAuthCommunicator;
            }
        }

        private static IAuthenticator m_MAuthAuthenticator;
        public static IAuthenticator MAuthAuthenticator
        {
            get
            {
                if (m_MAuthAuthenticator == null)
                    m_MAuthAuthenticator = new MAuth.Authenticator(new BouncyCastleEncryptionProvider(), MAuthCommunicator);
                return m_MAuthAuthenticator;
            }
        } 

        private static void SetupConfigurationStrings()
        {
            using (SqlConnection connection = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings[RBTConfiguration.Default.DatabaseConnection].ConnectionString))
			{
				connection.Open();

                StringBuilder sb = new StringBuilder();
                sb.Append(GenerateSelectTop1FromConfigCommand(MAuthAppUUIDTag));
                sb.Append(GenerateSelectTop1FromConfigCommand(MAuthBaseUrlTag));
                SqlCommand command = new SqlCommand(sb.ToString(), connection);
                command.CommandType = CommandType.Text;
                SqlDataReader reader = command.ExecuteReader();

                int totalResultTables = 2;
                for (int i = 0; i < totalResultTables; i++)
                {
                    reader.Read();
                    switch (i)
                    {
                        case 0:
                            m_MAuthAppUUID = (string)reader[0];
                            break;
                        case 1:
                            m_MAuthBaseUrl = (string)reader[0];
                            break;
                    }
                    if (i < (totalResultTables - 1))
                        reader.NextResult();
                }
            }
        }

        private static string GenerateSelectTop1FromConfigCommand(string tag)
        {
            return "select top 1 ConfigValue from Configuration where tag = '" + tag + "';";
        }

        private static IMAuthCommunicator SetupMAuthCommunicator()
        {
            string pemContents = File.ReadAllText(MAuthPrivateKeyFile);
            Guid appUuid = new Guid(MAuthAppUUID);
            Uri serviceUrl = new Uri(MAuthBaseUrl);
            IMAuthCommunicatorSettings settings = new MAuthCommunicatorSettings(pemContents, serviceUrl, appUuid);
            IMAuthCommunicator comm = new MAuthCommunicator();
            comm.Settings = settings;

            return comm;
        }

	}
}
