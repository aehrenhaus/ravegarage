using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Configuration;

namespace Medidata.RBT
{
	public class RBTConfiguration : ConfigurationSection
	{
		public static RBTConfiguration Default { get; private set; }

		static RBTConfiguration()
		{
			Default = (RBTConfiguration)System.Configuration.ConfigurationManager.GetSection(
			"RBTConfiguration");
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

		[ConfigurationProperty("TestResultPath", DefaultValue = "", IsRequired = false)]
		public String TestResultPath
		{
			get { return (String)this["TestResultPath"]; }
			set { this["TestResultPath"] = value; }
		}

		[ConfigurationProperty("AutoCloseBrowser", DefaultValue = true, IsRequired = false)]
		public bool AutoCloseBrowser
		{
	
			get {
				return (bool)this["AutoCloseBrowser"];
			}
			set { this["AutoCloseBrowser"] = value; }
		}

		[ConfigurationProperty("TakeScreenShots", DefaultValue = true, IsRequired = false)]
		public bool TakeScreenShots
		{

			get
			{
				return (bool)this["TakeScreenShots"];
			}
			set { this["TakeScreenShots"] = value; }
		}



		[ConfigurationProperty("BrowserName", DefaultValue = "Firefox", IsRequired = false)]
		public String BrowserName
		{
			get { return (String)this["BrowserName"]; }
			set { this["BrowserName"] = value; }
		}



		[ConfigurationProperty("WebDriverPath", DefaultValue = "", IsRequired = false)]
		public String WebDriverPath
		{
			get { return (String)this["WebDriverPath"]; }
			set { this["WebDriverPath"] = value; }
		}

		[ConfigurationProperty("GenerateReportAfterTest", DefaultValue = false, IsRequired = false)]
		public bool GenerateReportAfterTest
		{
			get { return (bool)this["GenerateReportAfterTest"]; }
			set { this["GenerateReportAfterTest"] = value; }
		}

		[ConfigurationProperty("BrowserPath", DefaultValue = "", IsRequired = false)]
		public String BrowserPath
		{
			get { return (String)this["BrowserPath"]; }
			set { this["BrowserPath"] = value; }
		}

		[ConfigurationProperty("FirefoxProfilePath", DefaultValue = "", IsRequired = false)]
		public String FirefoxProfilePath
		{
			get { return (String)this["FirefoxProfilePath"]; }
			set { this["FirefoxProfilePath"] = value; }
		}
		

		[ConfigurationProperty("SqlScriptsPath", DefaultValue = "", IsRequired = false)]
		public String SqlScriptsPath
		{
			get { return (String)this["SqlScriptsPath"]; }
			set { this["SqlScriptsPath"] = value; }
		}

		[ConfigurationProperty("ScenarioNamePrefix", DefaultValue = "", IsRequired = true)]
		public String ScenarioNamePrefix
		{
			get { return (String)this["ScenarioNamePrefix"]; }
			set { this["ScenarioNamePrefix"] = value; }
		}

		[ConfigurationProperty("ElementWaitTimeout", DefaultValue = 5, IsRequired = false)]
		public int ElementWaitTimeout
		{
			get { return (int)this["ElementWaitTimeout"]; }
			set { this["ElementWaitTimeout"] = value; }
		}
		
		
	}
}
