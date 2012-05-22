using System;
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
				//String str = this["AutoCloseBrowser"] as string;
				//return bool.Parse( str); 
				return (bool)this["AutoCloseBrowser"];
			}
			set { this["AutoCloseBrowser"] = value; }
		}
	}
}
