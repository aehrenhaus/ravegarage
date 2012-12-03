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
using System.Reflection;
using Medidata.RBT.SharedObjects;
using Medidata.RBT.SharedRaveObjects;

namespace Medidata.RBT.PageObjects.Rave.SharedRaveObjects
{
    /// <summary>
    ///This is a rave specific UploadedDraft. It is seedable. 
    ///It contains both a Project and a Draft, and anything else that is part of an uploaded draft.
    ///These sit in Uploads/Drafts.
    ///</summary>
    public class UploadedDraft : BaseRaveSeedableObject, IRemoveableObject
    {
        public Project Project { get; set; }
        public Draft Draft { get; set; }

        /// <summary>
        ///The uploaded draft constructor
        ///</summary>
        ///<param name="name">The feature defined name of the UploadedDraft</param>
		public UploadedDraft(string name)
        {
			UniqueName = name;
        }

        /// <summary>
        /// Navigate to the upload draft page.
        /// </summary>
		protected override void NavigateToSeedPage()
        {
            TestContext.CurrentPage.As<HomePage>().ClickLink("Architect");
            TestContext.CurrentPage.As<ArchitectPage>().ClickLink("Upload Draft");
        }

        /// <summary>
        /// Upload the unique version of the UploadDraft. Mark it for deletion after scenario completion.
        /// </summary>
		protected override void CreateObject()
        {
            TestContext.CurrentPage.As<UploadDraftPage>().UploadFile(UniqueFileLocation);
            Factory.FeatureObjectsForDeletion.Add(this);
        }

        /// <summary>
        /// Load the xml to upload. Replace the project name with a unique version of it with a TID at the end.
        /// Use the draft name to create a draft object, but do NOT make the draft unique.
        /// </summary>
		protected override void MakeUnique()
		{
			FileLocation = RBTConfiguration.Default.UploadPath + @"\Drafts\" + UniqueName;

			UniqueName = UniqueName + TID;

            using (ExcelWorkbook excel = new ExcelWorkbook(FileLocation))
			{
				ExcelTable draftTable = excel.OpenTableForEdit("CRFDraft");
				ExcelTable fieldsTable = excel.OpenTableForEdit("Fields");


				//project 
				var projectName = draftTable[1, "ProjectName"].ToString();
                if (Project == null)
                    Project = TestContext.GetExistingFeatureObjectOrMakeNew(projectName, () => new Project(projectName, true));

				draftTable[1, "ProjectName"] = Project.UniqueName;

                //Lab standard group
                string labStandardGroupName = draftTable[1, "LabStandardGroup"].ToString();

                StandardGroup labStandardGroup = TestContext.GetExistingFeatureObjectOrMakeNew(labStandardGroupName, () => new StandardGroup(labStandardGroupName));
                draftTable[1, "LabStandardGroup"] = labStandardGroup.UniqueName;

				//draft
				var oldDraftName = draftTable[1, "DraftName"].ToString();
				Draft = TestContext.GetExistingFeatureObjectOrMakeNew(oldDraftName, () => new Draft(oldDraftName));

				for (int row = 1; row <= fieldsTable.RowsCount; row++)
				{
                    //Entry restrictions
                    ReplaceEntryRestrictionsWithUniqueRoles(fieldsTable, row);

                    //Analytes
                    ReplaceAnalytesWithUniqueAnalytes(fieldsTable, row);
				}

				//Create a unique version of the file to upload
				UniqueFileLocation = MakeFileLocationUnique(FileLocation);

				excel.SaveAs(UniqueFileLocation);
			}
        }

        /// <summary>
        /// If there are entry restrictions for specifc roles, then create the roles for them and make the role names unique.
        /// </summary>
        /// <param name="fieldsTable">The excel table containing the fields</param>
        /// <param name="currentRow">The current row in the fields table</param>
        private void ReplaceEntryRestrictionsWithUniqueRoles(ExcelTable fieldsTable, int currentRow)
        {
            string entryRestrictionsCommaSeparated = fieldsTable[currentRow, "EntryRestrictions"] as string;

            if (entryRestrictionsCommaSeparated != null)
            {
                List<string> entryRestrictions = entryRestrictionsCommaSeparated.Split(',').ToList();
                StringBuilder uniqueEntryRestrictions = new StringBuilder();
                foreach (string entryRestriction in entryRestrictions)
                {
                    Role role = TestContext.GetExistingFeatureObjectOrMakeNew<Role>(entryRestriction.Trim(), () => new Role(entryRestriction.Trim()));
                    uniqueEntryRestrictions.Append(role.UniqueName + ",");
                }

                fieldsTable[currentRow, "EntryRestrictions"] = uniqueEntryRestrictions.ToString().Substring(0, uniqueEntryRestrictions.Length - 1);
            }
        }

        /// <summary>
        /// If there are lab analytes used for specifc roles, use analytes that were created in a previous step def
        /// </summary>
        /// <param name="fieldsTable">The excel table containing the fields</param>
        /// <param name="currentRow">The current row in the fields table</param>
        private void ReplaceAnalytesWithUniqueAnalytes(ExcelTable fieldsTable, int currentRow)
        {
            string analyteString = fieldsTable[currentRow, "AnalyteName"] as string;

            if (!String.IsNullOrEmpty(analyteString))
            {
                Analyte analyte = TestContext.GetExistingFeatureObjectOrMakeNew<Analyte>(analyteString.Trim(), () => new Analyte(analyteString));
                fieldsTable[currentRow, "AnalyteName"] = analyte.UniqueName.ToString();
            }
        }


        /// <summary>
        /// Delete the unique UploadDraft created by seeding
        /// </summary>
        public void DeleteSelf()
        {
            File.Delete(UniqueFileLocation);
        }

		protected override void SeedFromBackend()
		{
			//
		}
    }
}
