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
    public class UploadedDraft : SeedableObject, IRemoveableObject
    {
        public Project Project { get; set; }
        public Draft Draft { get; set; }

        /// <summary>
        ///The uploaded draft constructor
        ///</summary>
        ///<param name="name">The feature defined name of the UploadedDraft</param>
        ///<param name="seed">Bool determining whether you want to seed the object if it is not in the FeatureObjects dictionary</param>
        public UploadedDraft(string name, bool seed = false)
            : base(name)
        {
            if (!UID.HasValue)
            {
                UID = Guid.NewGuid();
                Name = name;
                if (seed)
                {
                    FileLocation = TestContext.UploadPath + @"\Drafts\" + name;
                    Seed();
                }
            }
        }

        /// <summary>
        /// Navigate to the upload draft page.
        /// </summary>
        public override void NavigateToSeedPage()
        {
            LoginPage.LoginUsingDefaultUserFromAnyPage();
            TestContext.CurrentPage.As<HomePage>().ClickLink("Architect");
            TestContext.CurrentPage.As<ArchitectPage>().ClickLink("Upload Draft");
        }

        /// <summary>
        /// Upload the unique version of the UploadDraft. Mark it for deletion after scenario completion.
        /// </summary>
        public override void CreateObject()
        {
            TestContext.CurrentPage.As<UploadDraftPage>().UploadFile(UniqueFileLocation);
            TestContext.FeatureObjects.Add(Name, this);
            Factory.FeatureObjectsForDeletion.Add(this);
        }

        /// <summary>
        /// Load the xml to upload. Replace the project name with a unique version of it with a TID at the end.
        /// Use the draft name to create a draft object, but do NOT make the draft unique.
        /// </summary>
        public override void MakeUnique()
        {
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
                Project = new Project(oldProjectName);

            secondRowCells[projectCell].ChildNodes[0].InnerText = Project.UniqueName;

            //Set Draft Name
            int draftCell = firstRowCells.FindIndex(x => x.InnerText.ToLower() == "draftname");
            string oldDraftName = secondRowCells[draftCell].ChildNodes[0].InnerText;
            Draft = new Draft(oldDraftName);

            //Create a unique version of the file to upload
            UniqueName = FileLocation.Substring(0, Name.LastIndexOf(".xml")) + UID + ".xml";
            UniqueFileLocation = FileLocation.Substring(0, FileLocation.LastIndexOf(".xml")) + UID + ".xml";

            xmlDoc.Save(UniqueFileLocation);
        }

        /// <summary>
        /// Delete the unique UploadDraft created by seeding
        /// </summary>
        public void DeleteSelf()
        {
            File.Delete(UniqueFileLocation);
        }
    }
}
