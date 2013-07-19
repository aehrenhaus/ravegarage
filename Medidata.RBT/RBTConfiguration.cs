using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Configuration;
using System.IO;

namespace Medidata.RBT
{
    public class RBTConfiguration : ConfigurationSection
    {
        public static RBTConfiguration Default { get; private set; }

        static RBTConfiguration()
        {
            Default = (RBTConfiguration)System.Configuration.ConfigurationManager.GetSection("RBTConfiguration");
        }

        [ConfigurationProperty("DatabaseConnection", DefaultValue = "", IsRequired = true)]
        public String DatabaseConnection
        {
            get { return (String)this["DatabaseConnection"]; }
            set { this["DatabaseConnection"] = value; }
        }

        [ConfigurationProperty("SnapshotName", DefaultValue = "", IsRequired = true)]
        public String SnapshotName
        {
            get { return (String)this["SnapshotName"]; }
            set { this["SnapshotName"] = value; }
        }

		[ConfigurationProperty("TestResultPath", DefaultValue = "", IsRequired = true)]
        public String TestResultPath
        {
            get { return (String)this["TestResultPath"]; }
            set { this["TestResultPath"] = value; }
        }

		[ConfigurationProperty("AutoCloseBrowser", DefaultValue = true, IsRequired = true)]
        public bool AutoCloseBrowser
        {

            get
            {
                return (bool)this["AutoCloseBrowser"];
            }
            set { this["AutoCloseBrowser"] = value; }
        }

        [ConfigurationProperty("TakeScreenShotsEveryStep", DefaultValue = true, IsRequired = true)]
        public bool TakeScreenShotsEveryStep
        {

            get
            {
                return (bool)this["TakeScreenShotsEveryStep"];
            }
            set { this["TakeScreenShotsEveryStep"] = value; }
        }


        [ConfigurationProperty("EnableSeeding", DefaultValue = true, IsRequired = true)]
        public bool EnableSeeding
        {

            get
            {
                return (bool)this["EnableSeeding"];
            }
            set { this["EnableSeeding"] = value; }
        }

		[ConfigurationProperty("BrowserName", DefaultValue = "Firefox", IsRequired = true)]
        public String BrowserName
        {
            get { return (String)this["BrowserName"]; }
            set { this["BrowserName"] = value; }
        }



		[ConfigurationProperty("WebDriverPath", DefaultValue = "", IsRequired = true)]
        public String WebDriverPath
        {
            get { return (String)this["WebDriverPath"]; }
            set { this["WebDriverPath"] = value; }
        }

		[ConfigurationProperty("GenerateReportAfterTest", DefaultValue = false, IsRequired = true)]
        public bool GenerateReportAfterTest
        {
            get { return (bool)this["GenerateReportAfterTest"]; }
            set { this["GenerateReportAfterTest"] = value; }
        }

		[ConfigurationProperty("BrowserPath", DefaultValue = "", IsRequired = true)]
        public String BrowserPath
        {
            get { return (String)this["BrowserPath"]; }
            set { this["BrowserPath"] = value; }
        }
 
        public String DownloadPath
        {
            get
            {
                return (new DirectoryInfo(Path.Combine(AppDomain.CurrentDomain.BaseDirectory, @"..\..\..\Downloads"))).FullName;
            }
        }

        [ConfigurationProperty("AutoSaveMimeTypes", DefaultValue = "application/zip;application/pdf;application/octet-stream;text/xml", IsRequired = true)]
        public String AutoSaveMimeTypes
        {
            get { return (String)this["AutoSaveMimeTypes"]; }
            set { this["AutoSaveMimeTypes"] = value; }
        }
		

        public String UploadPath
        {
            get 
            {
                return (new DirectoryInfo(Path.Combine(AppDomain.CurrentDomain.BaseDirectory, @"..\..\..\Uploads"))).FullName;
            }
        }

		[ConfigurationProperty("SqlScriptsPath", DefaultValue = "", IsRequired = true)]
        public String SqlScriptsPath
        {
            get { return (String)this["SqlScriptsPath"]; }
            set { this["SqlScriptsPath"] = value; }
        }

		/// <summary>
		/// 
		/// </summary>
        [ConfigurationProperty("ScenarioNamePrefix", DefaultValue = "", IsRequired = true)]
        public String ScenarioNamePrefix
        {
            get { return (String)this["ScenarioNamePrefix"]; }
            set { this["ScenarioNamePrefix"] = value; }
        }


		[ConfigurationProperty("SeedFromBackendClasses", DefaultValue = "", IsRequired = false)]
		public String SeedFromBackendClasses
		{
			get { return (String)this["SeedFromBackendClasses"]; }
			set { this["SeedFromBackendClasses"] = value; }
		}

		[ConfigurationProperty("SuppressSeeding")]
		public String SuppressSeeding
		{
			get { return (String)this["SuppressSeeding"]; }
			set { this["SuppressSeeding"] = value; }
		}

		[ConfigurationProperty("POAssembly", DefaultValue = "Medidata.RBT.PageObjects.Rave.dll")]
		public String POAssembly
		{
			get { return (String)this["POAssembly"]; }
			set { this["POAssembly"] = value; }
		}


		[ConfigurationProperty("UploadTimeout", DefaultValue = 200)]
		public int UploadTimeout
		{
			get { return (int)this["UploadTimeout"]; }
			set { this["UploadTimeout"] = value; }
		}


		[ConfigurationProperty("DownloadTimeout", DefaultValue = 200)]
		public int DownloadTimeout
		{
			get { return (int)this["DownloadTimeout"]; }
			set { this["DownloadTimeout"] = value; }
		}

		[ConfigurationProperty("ImpersonationDomain", DefaultValue = "HDC")]
		public string ImpersonationDomain
		{
			get { return (string)this["ImpersonationDomain"]; }
			set { this["ImpersonationDomain"] = value; }
		}

		[ConfigurationProperty("ImpersonationUserName", DefaultValue = "anonymous")]
		public string ImpersonationUserName
		{
			get { return (string)this["ImpersonationUserName"]; }
			set { this["ImpersonationUserName"] = value; }
		}

		[ConfigurationProperty("ImpersonationPassword", DefaultValue = "password")]
		public string ImpersonationPassword
		{
			get { return (string)this["ImpersonationPassword"]; }
			set { this["ImpersonationPassword"] = value; }
		}

		[ConfigurationProperty("FtpServer", DefaultValue = "0.0.0.0")]
		public string FtpServer
		{
			get { return (string)this["FtpServer"]; }
			set { this["FtpServer"] = value; }
		}

		[ConfigurationProperty("FtpUserName", DefaultValue = "anonymous")]
		public string FtpUserName
		{
			get { return (string)this["FtpUserName"]; }
			set { this["FtpUserName"] = value; }
		}

		[ConfigurationProperty("FtpPassword", DefaultValue = "password")]
		public string FtpPassword
		{
			get { return (string)this["FtpPassword"]; }
			set { this["FtpPassword"] = value; }
		}

        [ConfigurationProperty("SeleniumServerUrl", DefaultValue = "")]
        public string SeleniumServerUrl
        {
            get { return (string)this["SeleniumServerUrl"];}
            set { this["SeleniumServerUrl"] = value;}
        }

    }
}