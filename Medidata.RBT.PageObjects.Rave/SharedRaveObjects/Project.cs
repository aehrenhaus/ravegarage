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
        public bool SkipUpload { get; set; }
        public List<MatrixAssignment> MatrixAssignments { get; set; }

        /// <summary>
        /// Create a Project if it is not already in the dictionary of projects in FeatureObject
        /// </summary>
        /// <param name="projectName">Feature defined name of the project</param>
        /// <param name="skipUpload">Skip upload portion of the seeding, so that you upload drafts don't </param>
        public Project(string projectName, bool skipUpload = false)
        {
            UniqueName = projectName;
            SkipUpload = skipUpload;
        }

        /// <summary>
        /// Make the project id unique
        /// </summary>
        protected override void MakeUnique()
        {
            UniqueName = UniqueName + TID;
        }

        /// <summary>
        /// Navigate to the architect page to be able to seed the project
        /// This step is skipped when using uploaddraft so that you don't have the additional time of going to the page, 
        /// when upload draft will do it for you.
        /// </summary>
        protected override void NavigateToSeedPage()
        {
            if (!SkipUpload)
            {
                WebTestContext.CurrentPage.As<HomePage>().ClickLink("Architect");
                WebTestContext.CurrentPage = new ArchitectPage();
            }
        }

        /// <summary>
        /// Add a new project.
        /// This step is skipped when using uploaddraft so that you don't have the additional time of going to the page, 
        /// when upload draft will do it for you.
        /// </summary>
        protected override void  CreateObject()
        {
            if (!SkipUpload)
            {
                WebTestContext.Browser.TryFindElementByPartialID("NewProjectName").EnhanceAs<Textbox>().SetText(UniqueName);
                WebTestContext.CurrentPage.ClickLink("Add Project");
            }
        }
    }
}
