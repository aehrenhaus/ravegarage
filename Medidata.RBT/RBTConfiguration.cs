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

		[ConfigurationProperty("RaveDatabaseConnection", DefaultValue = "", IsRequired = true)]
		public String RaveDatabaseConnection
		{
			get { return (String)this["RaveDatabaseConnection"]; }
			set { this["RaveDatabaseConnection"] = value; }
		}


		[ConfigurationProperty("DefaultUser", DefaultValue = "", IsRequired = true)]
		public String DefaultUser
		{
			get { return (String)this["DefaultUser"]; }
			set { this["DefaultUser"] = value; }
		}


		[ConfigurationProperty("DefaultUserPassword", DefaultValue = "", IsRequired = true)]
		public String DefaultUserPassword
		{
			get { return (String)this["DefaultUserPassword"]; }
			set { this["DefaultUserPassword"] = value; }
		}



		[ConfigurationProperty("BrowserName", DefaultValue = "Firefox", IsRequired = false)]
		public String BrowserName
		{
			get { return (String)this["BrowserName"]; }
			set { this["BrowserName"] = value; }
		}



		[ConfigurationProperty("ChromeDriverPath", DefaultValue = "", IsRequired = false)]
		public String ChromeDriverPath
		{
			get { return (String)this["ChromeDriverPath"]; }
			set { this["ChromeDriverPath"] = value; }
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

		[ConfigurationProperty("RaveURL", DefaultValue = "", IsRequired = true)]
		public String RaveURL
		{
			get { return (String)this["RaveURL"]; }
			set { this["RaveURL"] = value; }
		}
	}
}
