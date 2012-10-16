using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Medidata.RBT;
using TechTalk.SpecFlow;
using Medidata.RBT.SeleniumExtension;
using OpenQA.Selenium;
using System.Collections.ObjectModel;
using System.IO;
using System.Xml;
using Medidata.RBT.PageObjects.Rave.UserAdministrator;
using Medidata.RBT.PageObjects.Rave.Configuration;
using Medidata.RBT.SharedObjects;
using Medidata.RBT.SharedRaveObjects;
using Medidata.RBT.PageObjects.Rave.Lab;

namespace Medidata.RBT.PageObjects.Rave.SharedRaveObjects
{
    /// <summary>
    ///This is a rave specific LabConfiguration. It is seedable. 
    ///These sit in Uploads/LabConfigurations.
    ///</summary>
    public class LabConfiguration : SeedableObject, IRemoveableObject
    {
        /// <summary>
        /// The uploaded LabConfiguration constructor. This actually uploads configurations. 
        /// These configurations should be the template plus the LabConfiguration information/LabConfiguration actions.
        /// You may call this constuctor with "SUPER LabConfiguration 'N'" where "N" is an integer.
        /// This will upload a unique version of the source controlled "SUPERLabConfiguration.xml" and tie it to that name.
        /// </summary>
        /// <param name="LabConfigurationUploadName">The feature defined name of the LabConfiguration</param>
        /// <param name="seed">Bool determining whether you want to seed the object if it is not in the FeatureObjects dictionary</param>
        public LabConfiguration(string LabConfigurationUploadName, bool seed = false)
            : base(LabConfigurationUploadName)
        {
            if (!UID.HasValue)
            {
                UID = Guid.NewGuid();
                Name = LabConfigurationUploadName;

                if (seed)
                {
                    string fileName;
                    if (LabConfigurationUploadName.StartsWith("SUPER LabConfiguration"))
                        fileName = "SUPERLabConfiguration.xml";
                    else
                        fileName = LabConfigurationUploadName;

                    FileLocation = RBTConfiguration.Default.UploadPath + @"\LabConfigurations\" + fileName;
                    Upload();
                }
            }
        }

        public void Upload()
        {
            NavigateToSeedPage();

            UniqueFileLocation = FileLocation;
            CreateObject();     
        }
        /// <summary>
        /// Load the xml to upload. Replace the LabConfiguration name with a unique version of it with a TID at the end.
        /// </summary>
        public override void MakeUnique()
        {
            throw new NotImplementedException("MakeUnique() not implemented");
        }

        /// <summary>
        /// Navigate to the configuration loader page.
        /// </summary>
        public override void NavigateToSeedPage()
        {
            TestContext.CurrentPage = new LabLoaderPage().NavigateToSelf();
        }

        /// <summary>
        /// Upload LabConfiguration. 
        /// </summary>
        public override void CreateObject()
        {
            TestContext.CurrentPage.As<LabLoaderPage>().UploadFile(UniqueFileLocation);
        }

        /// <summary>
        /// Delete the unique LabConfiguration created by seeding
        /// </summary>
        public void DeleteSelf()
        {
            File.Delete(UniqueFileLocation);
        }


    }
}