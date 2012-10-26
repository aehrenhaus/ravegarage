﻿using System;
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
            if (!UID.HasValue)
            {
                UID = Guid.NewGuid();
                Name = name;
            }
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
			FileLocation = RBTConfiguration.Default.UploadPath + @"\Drafts\" + Name;
            XmlDocument xmlDoc = new XmlDocument();
            xmlDoc.Load(FileLocation);
            List<XmlNode> worksheets = new List<XmlNode>(xmlDoc.GetElementsByTagName("Worksheet").Cast<XmlNode>());
            XmlNode crfDraftWorksheet = worksheets.Where(x => x.Attributes["ss:Name"].Value.ToLower() == "crfdraft").FirstOrDefault();
            XmlNode table = (crfDraftWorksheet.ChildNodes.Cast<XmlNode>()).Where(x => x.Name.ToLower() == "table").FirstOrDefault();
            List<XmlNode> rows = (table.ChildNodes.Cast<XmlNode>()).Where(x => x.Name.ToLower() == "row").ToList();
            List<XmlNode> firstRowCells = new List<XmlNode>(rows[0].ChildNodes.Cast<XmlNode>());
            List<XmlNode> secondRowCells = new List<XmlNode>(rows[1].ChildNodes.Cast<XmlNode>());

            //Make the project name unique
            int projectCell = firstRowCells.FindIndex(x => x.InnerText.ToLower() == "projectname");
            string oldProjectName = secondRowCells[projectCell].ChildNodes[0].InnerText;

            if (Project == null)
                Project = TestContext.GetExistingFeatureObjectOrMakeNew(oldProjectName, () => new Project(oldProjectName));

            secondRowCells[projectCell].ChildNodes[0].InnerText = Project.UniqueName;

            //Set Draft Name
            int draftCell = firstRowCells.FindIndex(x => x.InnerText.ToLower() == "draftname");
            string oldDraftName = secondRowCells[draftCell].ChildNodes[0].InnerText;
            Draft = TestContext.GetExistingFeatureObjectOrMakeNew(oldDraftName, () => new Draft(oldDraftName));

            CheckEntryRestrictionFields(worksheets.Where(x => x.Attributes["ss:Name"].Value.ToLower() == "fields").FirstOrDefault());

            //Create a unique version of the file to upload
            UniqueName = FileLocation.Substring(0, Name.LastIndexOf(".xml")) + UID + ".xml";
            UniqueFileLocation = MakeFileLocationUnique(FileLocation);

            xmlDoc.Save(UniqueFileLocation);
        }


        /// <summary>
        /// If there are entry restrictions for specifc roles, then create the roles for them and make the role names unique.
        /// </summary>
        /// <param name="worksheets">The worksheet that contains the fields</param>
        private void CheckEntryRestrictionFields(XmlNode fieldsWorksheet)
        {
            //Set field entry restrictions
            XmlNode table = (fieldsWorksheet.ChildNodes.Cast<XmlNode>()).Where(x => x.Name.ToLower() == "table").FirstOrDefault();
            List<XmlNode> rows = (table.ChildNodes.Cast<XmlNode>()).Where(x => x.Name.ToLower() == "row").ToList();
            List<XmlNode> firstRowCells = new List<XmlNode>(rows[0].ChildNodes.Cast<XmlNode>());

            //Find the index of the EntryRestriction cell. Add 1, because the index in the XML is 1 indexed, not 0 indexed
            int entryRestrictionCellIndex = firstRowCells.FindIndex(x => x.InnerText.ToLower() == "entryrestrictions") + 1; 

            foreach (XmlNode row in rows)
            {
                List<XmlNode> rowCellsWithIndexAttr = (row.ChildNodes.Cast<XmlNode>()).Where(x => x.Attributes["ss:Index"] != null).ToList();
                if (rowCellsWithIndexAttr.Count > 0)
                {
                    XmlNode entryRestrictionCell = rowCellsWithIndexAttr
                        .FirstOrDefault(x => x.Attributes["ss:Index"].Value == entryRestrictionCellIndex.ToString());
                    
                    if(entryRestrictionCell != null)
                    {
                        string entryRestrictionsCommaSeparated = entryRestrictionCell.ChildNodes[0].InnerText;
                        List<string> entryRestrictions = entryRestrictionsCommaSeparated.Split(',').ToList();
                        StringBuilder uniqueEntryRestrictions = new StringBuilder();
                        foreach (string entryRestriction in entryRestrictions)
                        {
                            Role role = TestContext.GetExistingFeatureObjectOrMakeNew(entryRestriction.Trim(), () => new Role(entryRestriction.Trim()));
                            uniqueEntryRestrictions.Append(role.UniqueName + ",");
                        }

                        entryRestrictionCell.ChildNodes[0].InnerText = uniqueEntryRestrictions.ToString().Substring(0, uniqueEntryRestrictions.Length - 1);
                    }
                }
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
