using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Medidata.RBT;
using Medidata.RBT.SharedRaveObjects;
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
	public class Project : BaseRaveSeedableObject
    {
       
        public string Number { get; set; }
 

        /// <summary>
        /// Create a Project if it is not already in the dictionary of projects in FeatureObject
        /// </summary>
        /// <param name="projectName">Feature defined name of the project</param>
		public Project(string projectName)
        {
	        UniqueName = projectName;
        }

        /// <summary>
        /// Make the project id unique
        /// </summary>
        protected override void MakeUnique()
        {
            UniqueName = UniqueName + TID;
        }


    }
}
