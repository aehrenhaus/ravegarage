﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Configuration;

namespace Medidata.UAT
{
	public class UATConfiguration : ConfigurationSection
	{
		public static UATConfiguration Default { get; private set; }

		static UATConfiguration()
		{
			Default = (UATConfiguration)System.Configuration.ConfigurationManager.GetSection(
			"UATConfiguration");
		}

		public  UATConfiguration()
		{
		}

		[ConfigurationProperty("ScreenShotPath", DefaultValue = "", IsRequired = false)]
		public String ScreenShotPath
		{
			get { return (String)this["ScreenShotPath"]; }
			set { this["ScreenShotPath"] = value; }
		}

		[ConfigurationProperty("AutoCloseBrowser", DefaultValue = true, IsRequired = false)]
		public bool AutoCloseBrowser
		{
	
			get {
				return (bool)this["AutoCloseBrowser"];
			}
			set { this["AutoCloseBrowser"] = value; }
		}


		[ConfigurationProperty("RaveDatabaseConnection", DefaultValue = "", IsRequired = true)]
		public String RaveDatabaseConnection
		{
			get { return (String)this["RaveDatabaseConnection"]; }
			set { this["RaveDatabaseConnection"] = value; }
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


		[ConfigurationProperty("RaveURL", DefaultValue = "", IsRequired = true)]
		public String RaveURL
		{
			get { return (String)this["RaveURL"]; }
			set { this["RaveURL"] = value; }
		}
	}
}
