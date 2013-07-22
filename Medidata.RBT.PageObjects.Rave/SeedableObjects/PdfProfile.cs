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
    /// 
    /// </summary>
    public class PdfProfile : RaveUISeededObject, IRemoveableObject
    {
        /// <summary>
        /// Contructor for pdf profile object
        /// </summary>
        /// <param name="profileName">Name by which new pdf profile should be created</param>
        public PdfProfile(string profileName)
        {
            UniqueName = profileName;
        }

        /// <summary>
        /// Load the xml to upload. Replace the role name with a unique version of it with a TID at the end.
        /// </summary>
        protected override void MakeUnique()
        {
            string fileName;
            if (UniqueName.StartsWith("SUPER PDF PROFILE"))
                fileName = "SUPERPDFPROFILE.xml";
            else
                fileName = UniqueName + ".xml";

            FileLocation = RBTConfiguration.Default.UploadPath + @"\PdfProfile\" + fileName;

            using (ExcelWorkbook excel = new ExcelWorkbook(FileLocation))
            {
                ExcelTable pdfProfilesTable = excel.OpenTableForEdit("PDF Profiles");
                ExcelTable pdfSettingsTable = excel.OpenTableForEdit("PDF Settings");

                var name = pdfProfilesTable[1, "Profile Name"];
                UniqueName = name + TID;
                pdfProfilesTable[1, "Profile Name"] = UniqueName;

                for (int i = 1; i < pdfSettingsTable.RowsCount; i++)
                {
                    if (pdfSettingsTable[i, "Profile"].Equals("Profile"))
                        break;
                    pdfSettingsTable[i, "Profile"] = UniqueName;
                }

                //Create a unique version of the file to upload
                UniqueFileLocation = MakeFileLocationUnique(FileLocation);
                excel.SaveAs(UniqueFileLocation);
            }
        }

        /// <summary>
        /// Navigate to the "PDF Settings" page
        /// </summary>
        protected override void NavigateToSeedPage()
        {
            WebTestContext.CurrentPage = new ConfigurationLoaderPage().NavigateToSelf();
        }

        /// <summary>
        /// Created the new pdf profile using the UniqueName
        /// </summary>
        protected override void CreateObject()
        {
            WebTestContext.CurrentPage.As<ConfigurationLoaderPage>().UploadFile(UniqueFileLocation);
            Factory.FeatureObjectsForDeletion.Add(this);
        }

        /// <summary>
        /// Delete the unique pdf profile created by seeding
        /// </summary>
        public void DeleteSelf()
        {
            File.Delete(UniqueFileLocation);
        }
    }
}
