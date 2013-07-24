using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Configuration;

namespace Medidata.RBT.ConfigurationHandlers
{
    [ConfigurationCollection(typeof(RaveConfiguration), AddItemName = "RaveConfiguration", CollectionType = ConfigurationElementCollectionType.BasicMap)]
    public class RaveConfigurations : ConfigurationElementCollection
    {
        #region indexer

        public RaveConfiguration this[int index]
        {
            get { return (RaveConfiguration)base.BaseGet(index); }
            set
            {
                if (base.BaseGet(index) != null)
                {
                    base.BaseRemoveAt(index);
                }

                base.BaseAdd(index, value);
            }
        }

        public RaveConfiguration this[string name]
        {
            get { return (RaveConfiguration)base.BaseGet(name); }
        }

        #endregion

        #region Overrides

        public override ConfigurationElementCollectionType CollectionType
        {
            get { return ConfigurationElementCollectionType.BasicMap; }
        }

        protected override string ElementName
        {
            get { return "RaveConfiguration"; }
        }

        protected override ConfigurationElement CreateNewElement()
        {
            return new RaveConfiguration();
        }

        protected override object GetElementKey(ConfigurationElement element)
        {
            return (element as RaveConfiguration).Name;
        }
        #endregion
    }
}
