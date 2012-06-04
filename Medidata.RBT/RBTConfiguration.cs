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


		[ConfigurationProperty("CDMUser", DefaultValue = "", IsRequired = true)]
		public String CDMUser
		{
			get { return (String)this["CDMUser"]; }
			set { this["CDMUser"] = value; }
		}


		[ConfigurationProperty("CDMUserPassword", DefaultValue = "", IsRequired = true)]
		public String CDMUserPassword
		{
			get { return (String)this["CDMUserPassword"]; }
			set { this["CDMUserPassword"] = value; }
		}


		[ConfigurationProperty("BrowserName", DefaultValue = "Firefox", IsRequired = false)]
		//[StringValidator( MinLength = 1, MaxLength = 60)]
		public String BrowserName
		{
			get { return (String)this["BrowserName"]; }
			set { this["BrowserName"] = value; }
		}


		[ConfigurationProperty("BrowserLocation", DefaultValue = "", IsRequired = false)]
		public String BrowserLocation
		{
			get { return (String)this["BrowserLocation"]; }
			set { this["BrowserLocation"] = value; }
		}

		[ConfigurationProperty("SqlScriptsLocation", DefaultValue = "", IsRequired = false)]
		public String SqlScriptsLocation
		{
			get { return (String)this["SqlScriptsLocation"]; }
			set { this["SqlScriptsLocation"] = value; }
		}

		[ConfigurationProperty("RaveURL", DefaultValue = "", IsRequired = true)]
		public String RaveURL
		{
			get { return (String)this["RaveURL"]; }
			set { this["RaveURL"] = value; }
		}
	}
}
