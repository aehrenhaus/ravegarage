using System;
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
using Medidata.RBT.PageObjects.Rave.SiteAdministration;

namespace Medidata.RBT.PageObjects.Rave.SharedRaveObjects
{
    /// <summary>
    ///This is a rave specific Project.
    ///</summary>
    public class Project
    {
        public Guid UID { get; set; }
        public string Name { get; set; }
        public string UniqueName { get; set; }
        public string Number { get; set; }
        public string TID = TemporalID.GetTID();

        /// <summary>
        /// Create a Project if it is not already in the dictionary of projects in FeatureObject
        /// </summary>
        /// <param name="projectName">Feature defined name of the project</param>
        public Project(string projectName)
        {
            if (FeatureObjects.Projects != null && FeatureObjects.Projects.ContainsKey(projectName))
            {
                Project existingProject = FeatureObjects.Projects[projectName];
                UID = existingProject.UID;
                Name = existingProject.Name;
                UniqueName = existingProject.UniqueName;
                Number = existingProject.Number;
            }
            else
            {
                UID = Guid.NewGuid();
                Name = projectName;
                UniqueName = projectName + TID;
                FeatureObjects.Projects.Add(projectName, this);
            }
        }
    }
}
