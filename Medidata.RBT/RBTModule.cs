using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Microsoft.Practices.Unity;
using Microsoft.Practices.Unity.Configuration;
using System.Configuration;

namespace Medidata.RBT
{
    /// <summary>
    /// RBT Module is the central place from where container can be accessed
    /// </summary>
    public sealed class RBTModule
    {
        private static readonly RBTModule m_instance = new RBTModule();
        IUnityContainer m_container;

        /// <summary>
        /// Static property to get singleton instance of RBT module
        /// </summary>
        public static RBTModule Instance
        {
            get
            {
                return m_instance;
            }
        }

        /// <summary>
        /// Proprety to access container of type IUnityContainer to resolve dependencies
        /// </summary>
        public IUnityContainer Container
        {
            get
            {
                return m_container;
            }
        }

        private RBTModule()
        {
            m_container = new UnityContainer();
            Initialize();
        }

        private void Initialize()
        {
            UnityConfigurationSection configSection =
                (UnityConfigurationSection)ConfigurationManager.GetSection("unity");

            configSection.Configure(m_container);
        }
    }
}
