using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Configuration;

namespace Medidata.RBT.ConfigurationHandlers
{
	public class RaveConfiguration : ConfigurationElement
	{
		
        [ConfigurationProperty("Name", DefaultValue = "", IsRequired = true)]
        public String Name
        {
            get { return (String)this["Name"]; }
            set { this["Name"] = value; }
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

        [ConfigurationProperty("RWSAuthanticationFilePath", DefaultValue = "", IsRequired = false)]
        public String RWSAuthanticationFilePath
        {
            get { return (String)this["RWSAuthanticationFilePath"]; }
            set { this["RWSAuthanticationFilePath"] = value; }
        }


		[ConfigurationProperty("RaveURL", DefaultValue = "", IsRequired = true)]
		public String RaveURL
		{
			get { return (String)this["RaveURL"]; }
			set { this["RaveURL"] = value; }
		}

        [ConfigurationProperty("RWSURL", DefaultValue = "", IsRequired = true)]
        public String RWSURL
        {
            get { return (String)this["RWSURL"]; }
            set { this["RWSURL"] = value; }
        }



        [ConfigurationProperty("ReportURL", DefaultValue = "", IsRequired = true)]
        public String ReportURL
        {
            get { return (String)this["ReportURL"]; }
            set { this["ReportURL"] = value; }
        }
	}
}
