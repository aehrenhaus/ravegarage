using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Configuration;

namespace Medidata.RBT.SeleniumExtension
{
	public class SeleniumConfiguration : ConfigurationSection
	{
		public static SeleniumConfiguration Default { get; private set; }

		static SeleniumConfiguration()
		{
			Default = (SeleniumConfiguration)System.Configuration.ConfigurationManager.GetSection(
			"SeleniumConfiguration");
		}


		[ConfigurationProperty("WaitElementTimeout", DefaultValue = 10, IsRequired = true)]
        public int WaitElementTimeout
        {
			get { return (int)this["WaitElementTimeout"]; }
			set { this["WaitElementTimeout"] = value; }
        }


		[ConfigurationProperty("WaitByDefault", DefaultValue = true, IsRequired = false)]
		public bool WaitByDefault
		{
			get { return (bool)this["WaitByDefault"]; }
			set { this["WaitByDefault"] = value; }
		}
	

	}
}
