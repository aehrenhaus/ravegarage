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
using Medidata.RBT.PageObjects.Rave.SharedRaveObjects;

namespace Medidata.RBT.PageObjects.Rave.SeedableObjects
{
    /// <summary>
    ///This is a rave specific Project.
    ///</summary>
    public class Project : RaveUISeededObject
    {
        public string Number { get; set; }
        public List<MatrixAssignment> MatrixAssignments { get; set; }
        public ExternalSystem ExternalSystem { get; set; } //External sytem associated with this project

        /// <summary>
        /// Create a Project if it is not already in the dictionary of projects in FeatureObject
        /// </summary>
        /// <param name="projectName">Feature defined name of the project</param>
        /// <param name="skipUpload">Skip upload portion of the seeding, so that you upload drafts don't </param>
        public Project(string projectName, bool uploadAfterMakingUnique = true)
            : base(uploadAfterMakingUnique)
        {
            UniqueName = projectName;
        }

        /// <summary>
        /// Navigate to the architect page to be able to seed the project
        /// This step is skipped when using uploaddraft so that you don't have the additional time of going to the page, 
        /// when upload draft will do it for you.
        /// </summary>
        protected override void NavigateToSeedPage()
        {
            WebTestContext.CurrentPage.As<HomePage>().ClickLink("Architect");
            WebTestContext.CurrentPage = new ArchitectPage();
        }

        /// <summary>
        /// Add a new project.
        /// This step is skipped when using uploaddraft so that you don't have the additional time of going to the page, 
        /// when upload draft will do it for you.
        /// </summary>
        protected override void  CreateObject()
        {
            WebTestContext.Browser.TryFindElementByPartialID("NewProjectName").EnhanceAs<Textbox>().SetText(UniqueName);
            WebTestContext.CurrentPage.ClickLink("Add Project");
            SetProjectID(UniqueName);
        }

        /// <summary>
        /// Assign an external system to this project and study in the DB
        /// </summary>
        /// <param name="externalSystem">The external system to associate</param>
        private void AssignExternalSystemToDB(ExternalSystem externalSystem)
        {
            string sql = string.Format(Project.ASSIGN_EXTERNAL_SYSTEM_PROJECT_SQL, externalSystem.ExternalSystemID, UniqueName, "eng");
            int projectID = (int)DbHelper.ExecuteDataSet(sql).GetFirstRow()["ProjectID"];
            sql = string.Format(Project.ASSIGN_EXTERNAL_SYSTEM_STUDY_SQL, externalSystem.ExternalSystemID, projectID);
            DbHelper.ExecuteDataSet(sql);
        }

        /// <summary>
        /// Assign an external system to this project and study both in the DB and by object reference
        /// </summary>
        /// <param name="externalSystem">The external system to associate</param>
        public void AssignExternalSystem(string externalSystemString)
        {
            if (externalSystemString != null && !externalSystemString.Trim().Equals(""))
            {
                ExternalSystem externalSystem = SeedingContext.GetExistingFeatureObjectOrMakeNew(externalSystemString,
                    () => new ExternalSystem(externalSystemString));

                AssignExternalSystemToDB(externalSystem);
                ExternalSystem = externalSystem;
            }
        }

        public void SetProjectID(string projectName)
        {
            string sql = string.Format(Project.GET_PROJECT_ID, UniqueName);
            this.Number =((int)DbHelper.ExecuteDataSet(sql).GetFirstRow()["projectid"]).ToString();
        }

        #region sqlStrings
        private const string ASSIGN_EXTERNAL_SYSTEM_PROJECT_SQL =
            @"
                declare @stringID int;
                set @stringID = (select StringID from LocalizedDataStrings where String = '{1}' and Locale = '{2}');
                update Projects set ExternalID = {0} where ProjectName = @stringID;
                select ProjectID from Projects where ProjectName = @stringID;
            ";
        private const string ASSIGN_EXTERNAL_SYSTEM_STUDY_SQL =
            @"
                update Studies set ExternalID = {0} where ProjectID = {1};
            ";
        private const string GET_PROJECT_ID =
            @"
                select projectid from projects where dbo.fnlocaldefault(projectname) = '{0}';
            ";
        #endregion
    }
}
