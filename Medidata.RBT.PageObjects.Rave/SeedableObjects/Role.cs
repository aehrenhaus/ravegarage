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
using Medidata.RBT.PageObjects.Rave.SharedRaveObjects;
using Medidata.RBT.ConfigurationHandlers;

namespace Medidata.RBT.PageObjects.Rave.SeedableObjects
{
    /// <summary>
    ///This is a rave specific Role. It is seedable. 
    ///These sit in Uploads/Roles.
    ///</summary>
    public class Role : RaveUISeededObject, IRemoveableObject
    {
        public List<ReportAssignment> ReportAssignments { get; set; }

        /// <summary>
        /// The uploaded role constructor. This actually uploads configurations. 
        /// These configurations should be the template plus the role information/role actions.
        /// You may call this constuctor with "SUPER ROLE 'N'" where "N" is an integer.
        /// This will upload a unique version of the source controlled "SUPERROLE.xml" and tie it to that name.
        /// </summary>
        /// <param name="roleUploadName">The feature defined name of the role</param>
        public Role(string roleUploadName)
        {
			UniqueName = roleUploadName;
        }

        /// <summary>
        /// Load the xml to upload. Replace the role name with a unique version of it with a TID at the end.
        /// </summary>
		protected override void MakeUnique()
        {
			string fileName;
			if (UniqueName.StartsWith("SUPER ROLE"))
				fileName = "SUPERROLE.xml";
			else
				fileName = UniqueName + ".xml";

			FileLocation = RBTConfiguration.Default.UploadPath + @"\Roles\" + fileName;


			using (var excel = new ExcelWorkbook(FileLocation))
			{
	
				var rolesTable = excel.OpenTableForEdit("EDC Roles");
				var actionsTable = excel.OpenTableForEdit("Role Actions");
                var missingcodesTable = excel.OpenTableForEdit("Missing Codes");
				
				var name = rolesTable[1, "Name"];
				UniqueName = name + TID;
				rolesTable[1, "Name"] = UniqueName;

				actionsTable[1, "Role"] = UniqueName;
                if (missingcodesTable[1, "Role"] != null)
                    missingcodesTable[1, "Role"] = UniqueName;

				//Create a unique version of the file to upload
				UniqueFileLocation = MakeFileLocationUnique(FileLocation);
				excel.SaveAs(UniqueFileLocation);
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

        /// <summary>
        /// Check if thre is a report assignment for this role
        /// </summary>
        /// <param name="reportName">name of the report</param>
        /// <returns>True if the report assignment exists, false if not</returns>
        public bool ReportAssignmentsExists(string reportName)
        {
            if (ReportAssignments != null && ReportAssignments.Exists(p => p.ReportName.Equals(reportName)))
                return true;
            return false;
        }
    }
}