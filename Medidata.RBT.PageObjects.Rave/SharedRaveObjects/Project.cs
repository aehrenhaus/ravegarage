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
using Medidata.RBT.PageObjects.Rave.SiteAdministration;
using Medidata.RBT.SharedObjects;

namespace Medidata.RBT.PageObjects.Rave.SharedRaveObjects
{
    /// <summary>
    ///This is a rave specific Project.
    ///</summary>
    public class Project : IFeatureObject
    {
        public Guid? UID { get; set; }
        public string Name { get; set; }
        private string m_UniqueName;
        public string UniqueName
        {
            get
            {
                if (RBTConfiguration.Default.EnableSeeding)
                    return m_UniqueName;
                else
                    return Name;
            }
            set { m_UniqueName= value; }
        }
        public string Number { get; set; }
        public string TID = TemporalID.GetNewTID();

        /// <summary>
        /// Create a Project if it is not already in the dictionary of projects in FeatureObject
        /// </summary>
        /// <param name="projectName">Feature defined name of the project</param>
        public Project(string projectName)
        {
            if(!UID.HasValue)
            {
                UID = Guid.NewGuid();
                Name = projectName;
                UniqueName = projectName + TID;
            }
            else
                DraftCounter.DecrementCounter();
        }
    }
}
