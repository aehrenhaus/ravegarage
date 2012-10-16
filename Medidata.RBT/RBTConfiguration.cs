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

		[ConfigurationProperty("TakeScreenShots", DefaultValue = true, IsRequired = true)]
        public bool TakeScreenShots
        {

            get
            {
                return (bool)this["TakeScreenShots"];
            }
            set { this["TakeScreenShots"] = value; }
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

		[ConfigurationProperty("FirefoxProfilePath", DefaultValue = "", IsRequired = true)]
        public String FirefoxProfilePath
        {
            get { return (String)this["FirefoxProfilePath"]; }
            set { this["FirefoxProfilePath"] = value; }
        }

 
        public String DownloadPath
        {
            get
            {
                return (new DirectoryInfo(Path.Combine(AppDomain.CurrentDomain.BaseDirectory, @"..\..\..\Downloads"))).FullName;
            }
        }
				
		[ConfigurationProperty("AutoSaveMimeTypes", DefaultValue = "application/zip;application/pdf;application/octet-stream", IsRequired = true)]
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

    }
}