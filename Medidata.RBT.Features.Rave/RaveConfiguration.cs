using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Configuration;

namespace Medidata.RBT.Features.Rave
{
	public class RaveConfiguration : ConfigurationSection
	{
		public static RaveConfiguration Default { get; private set; }

		static RaveConfiguration()
		{
			Default = (RaveConfiguration)System.Configuration.ConfigurationManager.GetSection(
			"RaveConfiguration");
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


		[ConfigurationProperty("RaveURL", DefaultValue = "", IsRequired = true)]
		public String RaveURL
		{
			get { return (String)this["RaveURL"]; }
			set { this["RaveURL"] = value; }
		}
	}
}
