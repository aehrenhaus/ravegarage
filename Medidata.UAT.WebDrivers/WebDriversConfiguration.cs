using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Configuration;

namespace Medidata.UAT
{
	public class WebDriversConfiguration : ConfigurationSection
	{
		public static WebDriversConfiguration Default { get; private set; }

		static WebDriversConfiguration()
		{
			Default = (WebDriversConfiguration)System.Configuration.ConfigurationManager.GetSection(
			"WebDriversConfiguration");
		}

		public WebDriversConfiguration()
		{
		}


		[ConfigurationProperty("BrowserName", DefaultValue = "Firefox", IsRequired = false)]
		//[StringValidator( MinLength = 1, MaxLength = 60)]
		public String BrowserName
		{
			get{ return (String)this["BrowserName"]; }
			set	{ this["BrowserName"] = value; }
		}


		[ConfigurationProperty("BrowserLocation", DefaultValue = "", IsRequired = false)]
		public String BrowserLocation
		{
			get{ return (String)this["BrowserLocation"]; }
			set{ this["BrowserLocation"] = value; }
		}
	}
}
