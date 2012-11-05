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

			using (var excel = new ExcelWorkbook(FileLocation))
			{
				var draftTable = excel.OpenTableForEdit("CRFDraft");
				var fieldsTable = excel.OpenTableForEdit("Fields");


				//project 
				var projectName = draftTable[1, "ProjectName"].ToString();
				if (Project == null)
					Project = TestContext.GetExistingFeatureObjectOrMakeNew(projectName, () => new Project(projectName));
				draftTable[1, "ProjectName"] = Project.UniqueName;

				//draft
				var oldDraftName = draftTable[1, "DraftName"].ToString();
				Draft = TestContext.GetExistingFeatureObjectOrMakeNew(oldDraftName, () => new Draft(oldDraftName));

				//If there are entry restrictions for specifc roles, then create the roles for them and make the role names unique.
				for (int row = 1; row <= fieldsTable.RowsCount; row++)
				{
					var entryRestrictionsCommaSeparated = fieldsTable[row, "EntryRestrictions"] as string;

					if (entryRestrictionsCommaSeparated == null)
						continue;

					List<string> entryRestrictions = entryRestrictionsCommaSeparated.Split(',').ToList();
					StringBuilder uniqueEntryRestrictions = new StringBuilder();
					foreach (string entryRestriction in entryRestrictions)
					{
						Role role = TestContext.GetExistingFeatureObjectOrMakeNew(entryRestriction.Trim(), () => new Role(entryRestriction.Trim()));
						uniqueEntryRestrictions.Append(role.UniqueName + ",");
					}

					fieldsTable[row, "EntryRestrictions"] = uniqueEntryRestrictions.ToString().Substring(0, uniqueEntryRestrictions.Length - 1);
                   

				}
				

				//Create a unique version of the file to upload
				UniqueFileLocation = MakeFileLocationUnique(FileLocation);


				//Create a unique version of the file to upload
				
				UniqueFileLocation = MakeFileLocationUnique(FileLocation);

				excel.SaveAs(UniqueFileLocation);
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
