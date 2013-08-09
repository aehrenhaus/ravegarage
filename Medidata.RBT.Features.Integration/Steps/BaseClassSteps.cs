using System;
using System.Configuration;
using TechTalk.SpecFlow;
using System.IO;
using System.Reflection;
using Medidata.MEF.PluginFramework;

namespace Medidata.RBT.Features.Integration.Steps
{
    [Binding]
    public class BaseClassSteps
    {
        static bool initializedPluginFramework;
        private object lockerObject = new object();

        /// <summary>
        /// Set up plugins when instantiating the object.  
        /// </summary>
        public BaseClassSteps() 
        {
            InitializePluginFramework();
        }


        /// <summary>
        /// Get plugins first time this is run only
        /// </summary>
        public void InitializePluginFramework()
        {
            try
            {
                lock (lockerObject)
                {
                    if (!initializedPluginFramework) // get plugins since they don't exist at first
                    {
                        string pluginDir = ConfigurationManager.AppSettings["PluginDirectory"];
                        if (!Path.IsPathRooted(pluginDir))
                        {
                            pluginDir = Path.Combine(Path.GetDirectoryName(Assembly.GetAssembly(this.GetType()).Location), pluginDir);
                        }
                        ServiceManager.InitializeServiceManager(new PluginEnvironment(pluginDir));
                        initializedPluginFramework = true;
                    }
                }
            }
            catch
            {
                throw new Exception("Failed to initialize Plugin Framework!");
            }
        }

    }
}
