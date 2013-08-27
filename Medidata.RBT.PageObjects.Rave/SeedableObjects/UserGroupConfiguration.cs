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
using Medidata.RBT.ConfigurationHandlers;

namespace Medidata.RBT.PageObjects.Rave.SeedableObjects
{
    /// <summary>
    ///This is a rave specific UserGroup. It is seedable. 
    ///These sit in Uploads/UserGroups.
    ///</summary>
    public class UserGroupConfiguration : RaveUISeededObject, IRemoveableObject
    {
        /// <summary>
        /// The uploaded UserGroups constructor. This actually uploads configurations. 
        /// These configurations should be blank plus the UserGroup information.
        /// </summary>
        /// <param name="userGroupUploadName">The feature defined name of the UserGroup upload file</param>
        public UserGroupConfiguration(string userGroupUploadName)
        {
            UniqueName = userGroupUploadName;
        }

        /// <summary>
        /// Load the xml to upload. Replace the role name with a unique version of it with a TID at the end.
        /// </summary>
		protected override void MakeUnique()
        {
            FileLocation = RBTConfiguration.Default.UploadPath + @"\UserGroups\" + UniqueName;

			using (var excel = new ExcelWorkbook(FileLocation))
			{
                MakeUserGroupsUnique(excel);

				//Create a unique version of the file to upload
				UniqueFileLocation = MakeFileLocationUnique(FileLocation);
				excel.SaveAs(UniqueFileLocation);
			}
        }

        /// <summary>
        /// Replace each user group with the seedable object equivalents
        /// </summary>
        /// <param name="excel">The configuration workbook</param>
        private void MakeUserGroupsUnique(ExcelWorkbook excel)
        {
            ExcelTable userGroupsWorksheet = excel.OpenTableForEdit("User Groups");
            for (int row = 1; row <= userGroupsWorksheet.RowsCount; row++)
            {
                //Name
                string userGroupString = userGroupsWorksheet[row, "Name"] as string;
                if (!string.IsNullOrEmpty(userGroupString))
                {
                    UserGroup userGroup = SeedingContext.GetExistingFeatureObjectOrMakeNew<UserGroup>(userGroupString.Trim(),
                        () => new UserGroup(userGroupString.Trim()));
                    userGroupsWorksheet[row, "Name"] = userGroup.UniqueName.ToString();
                }
            }
        }

        /// <summary>
        /// Navigate to the configuration loader page.
        /// </summary>
		protected override void NavigateToSeedPage()
        {
            WebTestContext.CurrentPage = new ConfigurationLoaderPage().NavigateToSelf();
        }

        /// <summary>
        /// Upload the unique version of the Role. Mark it for deletion after scenario completion.
        /// </summary>
		protected override void CreateObject()
        {
            WebTestContext.CurrentPage.As<ConfigurationLoaderPage>().UploadFile(UniqueFileLocation);
            Factory.FeatureObjectsForDeletion.Add(this);
        }

        /// <summary>
        /// Delete the unique Role created by seeding
        /// </summary>
        public void DeleteSelf()
        {
            File.Delete(UniqueFileLocation);
        }
    }
}