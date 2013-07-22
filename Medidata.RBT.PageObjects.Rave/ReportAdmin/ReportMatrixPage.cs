using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium.Support.PageObjects;
using OpenQA.Selenium;
using OpenQA.Selenium.Remote;
using System.Collections.Specialized;
using Medidata.RBT.SeleniumExtension;
using System.Collections.ObjectModel;
using TechTalk.SpecFlow;
using Medidata.RBT.PageObjects.Rave.SeedableObjects;
using Medidata.RBT.PageObjects.Rave.SharedRaveObjects;

namespace Medidata.RBT.PageObjects.Rave
{
	public class ReportMatrixPage : RavePageBase
    {
        public override string URL
        {
            get
            {
                return "Modules/ReportAdmin/ReportMatrix.aspx";
            }
        }

        //This represents the matrix assigments already against the projects we are manipulating.
        public Dictionary<Project, List<MatrixAssignment>> OriginalMatrixAssigments { get; set; }

        /// <summary>
        /// Assign report matrices if they have changed for the project.
        /// </summary>
        /// <param name="reportMatrixAssignmentModels">The reportMatrixAssignment passed down which include the project and its matrix assignments</param>
        public void AssignReportMatrices(List<ReportMatrixAssignmentModel> reportMatrixAssignmentModels)
        {
            //This gets us the unique projects in the list
            HashSet<string> hashProject = new HashSet<string>();
            reportMatrixAssignmentModels.ForEach(reportMatrixAssignmentModel => hashProject.Add(reportMatrixAssignmentModel.Project));
            OriginalMatrixAssigments = new Dictionary<Project, List<MatrixAssignment>>();

            foreach (string projectString in hashProject)
            {
                Project project = SeedingContext.GetExistingFeatureObjectOrMakeNew<Project>(projectString, () => new Project(projectString));
                OriginalMatrixAssigments.Add(project, project.MatrixAssignments);
                List<ReportMatrixAssignmentModel> reportMatrixAssignmentModelsForProject = reportMatrixAssignmentModels
                    .Where(x => x.Project == projectString).ToList();
                foreach(ReportMatrixAssignmentModel reportMatrixAssignmentModelForProject in reportMatrixAssignmentModelsForProject)
                {
                    if (project.MatrixAssignments == null)
                        project.MatrixAssignments = new List<MatrixAssignment>();

                    project.MatrixAssignments.Add(new MatrixAssignment()
                    {
                        Report = reportMatrixAssignmentModelForProject.Report,
                        Site = reportMatrixAssignmentModelForProject.Site,
                        Study = reportMatrixAssignmentModelForProject.Study,
                        Subject = reportMatrixAssignmentModelForProject.Subject
                    });
                }

                AssignReportMatricesForProject(project);
            }

        }

        /// <summary>
        /// Assign the report matrices for a single project
        /// </summary>
        /// <param name="project">The project to assign the report matrices of</param>
        public void AssignReportMatricesForProject(Project project)
        {
            //Only edit if the matrix assignments for the project has changed
            if (OriginalMatrixAssigments[project] == null 
                || OriginalMatrixAssigments[project].Intersect(project.MatrixAssignments).Count() != OriginalMatrixAssigments.Count)
            {
                ChooseFromDropdown("_ctl0_Content_ProjectDDL", project.UniqueName);
                ClickLink("edit");

                foreach (MatrixAssignment ma in project.MatrixAssignments)
                    EditReportMatrix(ma.Report, ma.Study, ma.Site, ma.Subject);

                ClickLink("save");
            }
        }

        /// <summary>
        /// Edit a single report matrix
        /// </summary>
        /// <param name="report">The name of the report to edit</param>
        /// <param name="study">whether or not study box is checked, any text here will check the box</param>
        /// <param name="site">whether or not site box is checked, any text here will check the box</param>
        /// <param name="subject">whether or not subject box is checked, any text here will check the box</param>
        public void EditReportMatrix(string report, string study, string site, string subject)
        {
            IWebElement reportLink = Browser.TryFindElementByLinkText(" " + report);
            IWebElement reportRow = reportLink.Parent().Parent();
            
            if(!String.IsNullOrEmpty(study))
            {
                Checkbox studyCheckbox = reportRow.TryFindElementByXPath("td[position()=2]/input").EnhanceAs<Checkbox>();
                if (studyCheckbox == null)
                    throw (new Exception("Attempting to click a box which does not exist on the page."));
                if (String.IsNullOrEmpty(studyCheckbox.GetAttribute("checked")))    
                    studyCheckbox.Click();
            }

            if (!String.IsNullOrEmpty(site))
            {
                Checkbox siteCheckbox = reportRow.TryFindElementByXPath("td[position()=3]/input").EnhanceAs<Checkbox>();
                if (siteCheckbox == null)
                    throw (new Exception("Attempting to click a box which does not exist on the page."));
                if(String.IsNullOrEmpty(siteCheckbox.GetAttribute("checked")))
                    siteCheckbox.Click();
            }

            if (!String.IsNullOrEmpty(subject))
            {
                Checkbox subjectCheckbox = reportRow.TryFindElementByXPath("td[position()=4]/input").EnhanceAs<Checkbox>();
                if (subjectCheckbox == null)
                    throw (new Exception("Attempting to click a box which does not exist on the page."));
                if (String.IsNullOrEmpty(subjectCheckbox.GetAttribute("checked")))
                    subjectCheckbox.Click();
            }
        }
    }
}
