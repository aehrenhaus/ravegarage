﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Medidata.RBT;
using TechTalk.SpecFlow;
using Medidata.RBT.SeleniumExtension;
using OpenQA.Selenium;
using System.Collections.ObjectModel;
using Medidata.RBT.Seeding;
using System.IO;
using System.Xml;
using Medidata.RBT.PageObjects.Rave.UserAdministrator;
using Medidata.RBT.PageObjects.Rave.Configuration;

namespace Medidata.RBT.PageObjects.Rave.SharedRaveObjects
{
    /// <summary>
    ///This is a rave specific Role. It is seedable. 
    ///These sit in Uploads/Roles.
    ///</summary>
    public class Role : SeedableObject, IRemoveableObject
    {
        /// <summary>
        /// The uploaded role constructor. This actually uploads configurations. 
        /// These configurations should be the template plus the role information/role actions.
        /// You may call this constuctor with "SUPER ROLE 'N'" where "N" is an integer.
        /// This will upload a unique version of the source controlled "SUPERROLE.xml" and tie it to that name.
        /// </summary>
        /// <param name="roleUploadName">The feature defined name of the role</param>
        /// <param name="seed">Bool determining whether you want to seed the object if it is not in the FeatureObjects dictionary</param>
        public Role(string roleUploadName, bool seed = false)
        {
            UID = Guid.NewGuid();
            Name = roleUploadName;

            if (FeatureObjects.Roles != null && FeatureObjects.Roles.ContainsKey(Name))
            {
                Role existingRole = FeatureObjects.Roles[Name];
                UID = existingRole.UID;
                Name = existingRole.Name;
                UniqueName = existingRole.UniqueName;
                FileLocation = existingRole.FileLocation;
                UniqueFileLocation = existingRole.UniqueFileLocation;
            }
            else if (seed)
            {
                //Get the instance of the role, so you can have multiple uploads of the same role
                string instanceString = roleUploadName.Substring(roleUploadName.LastIndexOf(" "), roleUploadName.Length - roleUploadName.LastIndexOf(" "));
                int instance;
                bool isInt = int.TryParse(instanceString, out instance);
                instance = isInt ? Convert.ToInt32(instanceString) : 0;

                string fileName;
                if (roleUploadName.StartsWith("SUPER ROLE"))
                    fileName = "SUPERROLE.xml";
                else
                    fileName = roleUploadName;

                FileLocation = TestContext.UploadPath + @"\Roles\" + fileName;
                Seed();
            }
        }

        /// <summary>
        /// Load the xml to upload. Replace the role name with a unique version of it with a TID at the end.
        /// </summary>
        public override void MakeUnique()
        {
            XmlDocument xmlDoc = new XmlDocument();
            xmlDoc.Load(FileLocation);
            List<XmlNode> worksheets = new List<XmlNode>(xmlDoc.GetElementsByTagName("Worksheet").Cast<XmlNode>());

            //Make the role name unique
            XmlNode userWorksheet = worksheets.Where(x => x.Attributes["ss:Name"].Value.ToLower() == "edc roles").FirstOrDefault();
            XmlNode table = (userWorksheet.ChildNodes.Cast<XmlNode>()).Where(x => x.Name.ToLower() == "table").FirstOrDefault();
            List<XmlNode> rows = (table.ChildNodes.Cast<XmlNode>()).Where(x => x.Name.ToLower() == "row").ToList();
            List<XmlNode> firstRowCells = new List<XmlNode>(rows[0].ChildNodes.Cast<XmlNode>());
            List<XmlNode> secondRowCells = new List<XmlNode>(rows[1].ChildNodes.Cast<XmlNode>());

            int roleCell = firstRowCells.FindIndex(x => x.InnerText.ToLower() == "name") + 1; //Add 1, because the index in the XML is 1 indexed, not 0 indexed
            List<XmlNode> secondRowCellsWithIndexAttr = secondRowCells.Where(x => x.Attributes["ss:Index"] != null).ToList();
            string oldRole = secondRowCellsWithIndexAttr.FirstOrDefault(x => x.Attributes["ss:Index"].Value == roleCell.ToString()).ChildNodes[0].InnerText;
            int secondRowRoleIndex = secondRowCells.FindIndex(x => x.ChildNodes[0].InnerText == oldRole);
            UniqueName = oldRole + TID;
            secondRowCells[secondRowRoleIndex].ChildNodes[0].InnerText = UniqueName;

            //Make the role actions name match the unique name
            XmlNode roleActionsWorksheet = worksheets.Where(x => x.Attributes["ss:Name"].Value.ToLower() == "role actions").FirstOrDefault();
            XmlNode roleActionsTable = (roleActionsWorksheet.ChildNodes.Cast<XmlNode>()).Where(x => x.Name.ToLower() == "table").FirstOrDefault();
            List<XmlNode> roleActionsRows = (roleActionsTable.ChildNodes.Cast<XmlNode>()).Where(x => x.Name.ToLower() == "row").ToList();
            List<XmlNode> roleActionsFirstRowCells = new List<XmlNode>(roleActionsRows[0].ChildNodes.Cast<XmlNode>());
            List<XmlNode> roleActionsSecondRowCells = new List<XmlNode>(roleActionsRows[1].ChildNodes.Cast<XmlNode>());
            //Make the role name in role actions unique
            int roleActionsSecondRowCellsRoleNameCell = roleActionsFirstRowCells
                .FindIndex(x => x.InnerText.ToLower() == "role") + 1; //Add 1, because the index in the XML is 1 indexed, not 0 indexed
            int roleActionSecondRowRoleIndex = roleActionsSecondRowCells.FindIndex(x => x.ChildNodes[0].InnerText == oldRole);
            roleActionsSecondRowCells[roleActionSecondRowRoleIndex].ChildNodes[0].InnerText = UniqueName;

            //Create a unique version of the file to upload
            UniqueFileLocation = FileLocation.Substring(0, FileLocation.LastIndexOf(".xml")) + UID + ".xml";
            xmlDoc.Save(UniqueFileLocation);
        }

        /// <summary>
        /// Navigate to the configuration loader page.
        /// </summary>
        public override void NavigateToSeedPage()
        {
            LoginPage.LoginUsingDefaultUserFromAnyPage();
            TestContext.CurrentPage = new ConfigurationLoaderPage().NavigateToSelf();
        }

        /// <summary>
        /// Upload the unique version of the Role. Mark it for deletion after scenario completion.
        /// </summary>
        public override void CreateObject()
        {
            TestContext.CurrentPage.As<ConfigurationLoaderPage>().UploadFile(UniqueFileLocation);
            FeatureObjects.Roles.Add(Name, this);
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