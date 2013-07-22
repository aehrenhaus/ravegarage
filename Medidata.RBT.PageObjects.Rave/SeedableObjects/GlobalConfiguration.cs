using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Medidata.RBT;
using TechTalk.SpecFlow;
using Medidata.RBT.SeleniumExtension;
using OpenQA.Selenium;
using System.Collections.ObjectModel;
using Medidata.RBT.PageObjects.Rave.SiteAdministration;
using Medidata.RBT.PageObjects.Rave.Configuration;
using Medidata.RBT.PageObjects.Rave.PDF;
using Medidata.RBT.SharedObjects;
using System.IO;
using Medidata.RBT.ConfigurationHandlers;

namespace Medidata.RBT.PageObjects.Rave.SeedableObjects
{
    /// <summary>
    /// Class used to upload global configuration settings
    /// </summary>
    public class GlobalConfiguration : RaveUISeededObject, IRemoveableObject
    {
        private const string DEFAULT_CONFIGURATION = "DEFAULTCONFIGURATION";

        /// <summary>
        /// Contructor for global configuration object
        /// </summary>
        /// <param name="testContext">The current webTestContext</param>
        /// <param name="configurationName">Name by which new configuration should be created</param>
        public GlobalConfiguration(string configurationName)
        {
            UniqueName = configurationName;
        }

        /// <summary>
        /// Load the xml to upload. Replace the file name with a unique version of it with a TID at the end.
        /// </summary>
        protected override void MakeUnique()
        {
            string fileName;
            if (UniqueName.StartsWith("SUPER CONFIGURATION"))
                fileName = "SUPERGLOBALCONFIGURATION.xml";
            else
                fileName = UniqueName + ".xml";

            FileLocation = RBTConfiguration.Default.UploadPath + @"\GlobalConfiguration\" + fileName;

            using (ExcelWorkbook excel = new ExcelWorkbook(FileLocation))
            {
                //Create a unique version of the file to upload
                UniqueFileLocation = MakeFileLocationUnique(FileLocation);
                excel.SaveAs(UniqueFileLocation);
            }
        }

        /// <summary>
        /// Navigate to the "Configuration Loader" page
        /// </summary>
        protected override void NavigateToSeedPage()
        {
            WebTestContext.CurrentPage = new ConfigurationLoaderPage().NavigateToSelf();
        }

        /// <summary>
        /// Upload the new global configuration
        /// </summary>
        protected override void CreateObject()
        {
            WebTestContext.CurrentPage.As<ConfigurationLoaderPage>().UploadFile(UniqueFileLocation);
            if (!UniqueName.StartsWith(DEFAULT_CONFIGURATION))
                Factory.FeatureObjectsForDeletion.Add(this);
        }

        /// <summary>
        /// Delete the unique UploadDraft created by seeding
        /// </summary>
        public void DeleteSelf()
        {
            File.Delete(UniqueFileLocation);
            GlobalConfiguration clearedConfig = SeedingContext.TryGetExistingFeatureObject<GlobalConfiguration>(DEFAULT_CONFIGURATION);

            if (clearedConfig != null)
                File.Delete(clearedConfig.UniqueFileLocation);
        }
    }
}
