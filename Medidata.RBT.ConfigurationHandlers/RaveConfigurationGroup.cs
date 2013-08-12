using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Configuration;

namespace Medidata.RBT.ConfigurationHandlers
{
    public class RaveConfigurationGroup : ConfigurationSection
    {
        public static RaveConfiguration Default { get; private set; }

        static RaveConfigurationGroup()
		{
            Default = (RaveConfiguration)(ConfigurationManager.GetSection(
            "RaveConfigurationGroup") as RaveConfigurationGroup)
            .RaveConfigs[RBTConfiguration.Default.RaveConfigurationName];
		}

        [ConfigurationProperty("RaveConfigurations", IsRequired=true)]
        [ConfigurationCollection(typeof(RaveConfigurations), AddItemName = "RaveConfiguration")]
        public RaveConfigurations RaveConfigs
        {
            get { return (RaveConfigurations)this["RaveConfigurations"]; }
        }
    }
}
