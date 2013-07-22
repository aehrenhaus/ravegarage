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
using System.Text.RegularExpressions;

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
		public UploadedDraft(string name, bool redirectAfterSeed = true)
        {
			UniqueName = name;
			this.RedirectAfterSeed = redirectAfterSeed;
        }


        /// <summary>
        /// Navigate to the upload draft page.
        /// </summary>
		protected override void NavigateToSeedPage()
        {
            WebTestContext.CurrentPage.As<HomePage>().ClickLink("Architect");
            WebTestContext.Browser.WaitForPageToBeReady();
            WebTestContext.CurrentPage.As<ArchitectPage>().ClickLink("Upload Draft");
            WebTestContext.Browser.WaitForPageToBeReady();
        }

        /// <summary>
        /// Upload the unique version of the UploadDraft. Mark it for deletion after scenario completion.
        /// </summary>
		protected override void CreateObject()
        {
            WebTestContext.CurrentPage.As<UploadDraftPage>().UploadFile(UniqueFileLocation);
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
                ExcelTable formsTable = excel.OpenTableForEdit("Forms");

				//project 
				var projectName = draftTable[1, "ProjectName"].ToString();
                if (Project == null)
					Project = SeedingContext.GetExistingFeatureObjectOrMakeNew(projectName, () => new Project(projectName, true));

				draftTable[1, "ProjectName"] = Project.UniqueName;

                MakeLabStandardGroupUnique(draftTable);
                MakeReferenceLabUnique(draftTable);
                MakeAlertLabUnique(draftTable);

				//draft
				var oldDraftName = draftTable[1, "DraftName"].ToString();
				Draft = SeedingContext.GetExistingFeatureObjectOrMakeNew(oldDraftName, () => new Draft(oldDraftName));

				for (int row = 1; row <= fieldsTable.RowsCount; row++)
				{
                    //Entry restrictions
                    ReplaceEntryAndViewRestrictionsWithUniqueRoles(fieldsTable, row);

                    //Analytes
                    ReplaceAnalytesWithUniqueAnalytes(fieldsTable, row);

					//Coding Dictionaries
					ReplaceCodingDictionariesWithUniqueCodingDictionaries(fieldsTable, row);
				}


			    for (int row = 1; row <= formsTable.RowsCount; row++)
			    {
                    ReplaceEntryAndViewRestrictionsWithUniqueRolesOnFormLevel(formsTable, row);
			    }

                MakeGlobalVariablesUnique(excel);

			    //Create a unique version of the file to upload
				UniqueFileLocation = MakeFileLocationUnique(FileLocation);

				excel.SaveAs(UniqueFileLocation);
			}
        }

        /// <summary>
        /// Replace reference lab with the seedable object equivalent.
        /// </summary>
        /// <param name="draftTable">The draft table</param>
        private void MakeLabStandardGroupUnique(ExcelTable draftTable)
        {
            string labStandardGroupString = (string)draftTable[1, "LabStandardGroup"];
            if (labStandardGroupString == null)
                return;

            string labStandardGroupName = labStandardGroupString.ToString();

            if (!string.IsNullOrEmpty(labStandardGroupName))
            {
                StandardGroup labStandardGroup = SeedingContext.GetExistingFeatureObjectOrMakeNew(labStandardGroupName, () => new StandardGroup(labStandardGroupName));
                draftTable[1, "LabStandardGroup"] = labStandardGroup.UniqueName;
            }
        }

        /// <summary>
        /// Replace reference lab with the seedable object equivalent.
        /// </summary>
        /// <param name="draftTable">The draft table</param>
        private void MakeReferenceLabUnique(ExcelTable draftTable)
        {
            string referenceLabString = (string)draftTable[1, "ReferenceLabs"];
            if (referenceLabString == null)
                return;

            string referenceLabName = referenceLabString.ToString();

            if (!string.IsNullOrEmpty(referenceLabName))
            {
                Lab referenceLabsGroup = SeedingContext.GetExistingFeatureObjectOrMakeNew(referenceLabName, () => new Lab(referenceLabName));
                draftTable[1, "ReferenceLabs"] = referenceLabsGroup.UniqueName;
            }
        }

        /// <summary>
        /// Replace alert lab with the seedable object equivalent.
        /// </summary>
        /// <param name="draftTable">The draft table</param>
        private void MakeAlertLabUnique(ExcelTable draftTable)
        {
            string alertLabString = (string)draftTable[1, "AlertLabs"];
            if (alertLabString == null)
                return;

            string alertLabName = alertLabString.ToString();

            if (!string.IsNullOrEmpty(alertLabName))
            {
                Lab alertLabsGroup = SeedingContext.GetExistingFeatureObjectOrMakeNew(alertLabName, () => new Lab(alertLabName));
                draftTable[1, "AlertLabs"] = alertLabsGroup.UniqueName;
            }
        }

        /// <summary>
        /// Replace global variables with the seedable object equivalents.
        /// </summary>
        /// <param name="excel">The lab configuration workbook</param>
        private void MakeGlobalVariablesUnique(ExcelWorkbook excel)
        {
            ExcelTable globalVariableTable = excel.OpenTableForEdit("LabVariableMappings");
            for (int row = 1; row <= globalVariableTable.RowsCount; row++)
            {
                //Name
                string globalVariableString = globalVariableTable[row, "GlobalVariableOID"] as string;
                if (!string.IsNullOrEmpty(globalVariableString))
                {
                    GlobalVariable globalVariable = SeedingContext.GetExistingFeatureObjectOrMakeNew<GlobalVariable>(globalVariableString.Trim(),
                        () => new GlobalVariable(globalVariableString.Trim()));
                    globalVariableTable[row, "GlobalVariableOID"] = globalVariable.UniqueName.ToString();
                }
            }
        }

        /// <summary>
        /// If there are entry restrictions for specifc roles, then create the roles for them and make the role names unique.
        /// </summary>
        /// <param name="fieldsTable">The excel table containing the fields</param>
        /// <param name="currentRow">The current row in the fields table</param>
        private void ReplaceEntryAndViewRestrictionsWithUniqueRoles(ExcelTable fieldsTable, int currentRow)
        {
            string rolesCommaSeparated = fieldsTable[currentRow, "EntryRestrictions"] as string;

            if (rolesCommaSeparated != null)
            {
                List<string> entryRestrictions = rolesCommaSeparated.Split(',').ToList();
                StringBuilder uniqueEntryRestrictions = new StringBuilder();
                foreach (string entryRestriction in entryRestrictions)
                {
					Role role = SeedingContext.GetExistingFeatureObjectOrMakeNew<Role>(entryRestriction.Trim(), () => new Role(entryRestriction.Trim()));
                    uniqueEntryRestrictions.Append(role.UniqueName + ",");
                }

                fieldsTable[currentRow, "EntryRestrictions"] = uniqueEntryRestrictions.ToString().Substring(0, uniqueEntryRestrictions.Length - 1);
            }

            rolesCommaSeparated = fieldsTable[currentRow, "ViewRestrictions"] as string;

            if (rolesCommaSeparated != null)
            {
                List<string> entryRestrictions = rolesCommaSeparated.Split(',').ToList();
                StringBuilder uniqueEntryRestrictions = new StringBuilder();
                foreach (string entryRestriction in entryRestrictions)
                {
                    Role role = SeedingContext.GetExistingFeatureObjectOrMakeNew<Role>(entryRestriction.Trim(), () => new Role(entryRestriction.Trim()));
                    uniqueEntryRestrictions.Append(role.UniqueName + ",");
                }

                fieldsTable[currentRow, "ViewRestrictions"] = uniqueEntryRestrictions.ToString().Substring(0, uniqueEntryRestrictions.Length - 1);
            }
        }


        private void ReplaceEntryAndViewRestrictionsWithUniqueRolesOnFormLevel(ExcelTable formsTable, int currentRow)
        {
            string rolesCommaSeparated = formsTable[currentRow, "ViewRestrictions"] as string;

            if (rolesCommaSeparated != null)
            {
                List<string> viewRestrictions = rolesCommaSeparated.Split(',').ToList();
                StringBuilder uniqueViewRestrictions = new StringBuilder();
                foreach (string viewRestriction in viewRestrictions)
                {
                    Role role = SeedingContext.GetExistingFeatureObjectOrMakeNew<Role>(viewRestriction.Trim(), () => new Role(viewRestriction.Trim()));
                    uniqueViewRestrictions.Append(role.UniqueName + ",");
                }

                formsTable[currentRow, "ViewRestrictions"] = uniqueViewRestrictions.ToString().Substring(0, uniqueViewRestrictions.Length - 1);
            }

            rolesCommaSeparated = formsTable[currentRow, "EntryRestrictions"] as string;

            if (rolesCommaSeparated != null)
            {
                List<string> viewRestrictions = rolesCommaSeparated.Split(',').ToList();
                StringBuilder uniqueViewRestrictions = new StringBuilder();
                foreach (string viewRestriction in viewRestrictions)
                {
                    Role role = SeedingContext.GetExistingFeatureObjectOrMakeNew<Role>(viewRestriction.Trim(), () => new Role(viewRestriction.Trim()));
                    uniqueViewRestrictions.Append(role.UniqueName + ",");
                }

                formsTable[currentRow, "EntryRestrictions"] = uniqueViewRestrictions.ToString().Substring(0, uniqueViewRestrictions.Length - 1);
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
				Analyte analyte = SeedingContext.GetExistingFeatureObjectOrMakeNew<Analyte>(analyteString.Trim(), () => new Analyte(analyteString));
                fieldsTable[currentRow, "AnalyteName"] = analyte.UniqueName.ToString();
            }
        }

		/// <summary>
		/// Replaces any coding dictionary assignments with seeded coding dictionaries.
		/// The coding dictionary mus have already been seeded othervise an exception is thrown.
		/// The version component will be replaced by the seeded version if the two versions don't match.
		/// </summary>
		/// <param name="fieldsTable">The excel table containing the fields</param>
		/// <param name="currentRow">The current row in the fields table</param>
		private void ReplaceCodingDictionariesWithUniqueCodingDictionaries(ExcelTable fieldsTable, int currentRow)
		{
			string codingDictionaryString = fieldsTable[currentRow, "CodingDictionary"] as string;

			if (!string.IsNullOrEmpty(codingDictionaryString))
			{
				var match = Regex.Match(codingDictionaryString, @"(?<VERSION>\(.*?\))");
				var version = match.Groups["VERSION"].Value;

				codingDictionaryString = codingDictionaryString
					.Replace(version, string.Empty).Trim();

                BaseCodingDictionary cd = SeedingContext.GetExistingFeatureObjectOrMakeNew<BaseCodingDictionary>(codingDictionaryString,
                        () => { throw new Exception(string.Format("Coding Dictionary [{0}] not found", codingDictionaryString)); });
              

				codingDictionaryString = string.Format("{0} {1}", 
					cd.UniqueName,
                    version);	//Keep the version that is part of the draft (version is not seeded, the registered version if not same as draft should result in error)
				fieldsTable[currentRow, "CodingDictionary"] = codingDictionaryString;
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
