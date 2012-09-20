using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using TechTalk.SpecFlow;
using Medidata.RBT.PageObjects.Rave.SharedRaveObjects;
using Medidata.RBT.PageObjects.Rave.SiteAdministration;

namespace Medidata.RBT.Features.Rave.Steps.Seeding
{
    [Binding]
    public class SiteSteps : BrowserStepsBase
    {
        /// <summary>
        /// Create a site if none already exists.
        /// </summary>
        /// <param name="siteName">The name that the site is referred to as in the feature file</param>
        [StepDefinition(@"Site ""([^""]*)"" exists")]
        public void Site____Exists(string siteName)
        {
            new Site(siteName, true);
        }

        /// <summary>
        /// Asign a study to a site
        /// </summary>
        /// <param name="studyName">Study name which should match the name of the study in an uploaded draft</param>
        /// <param name="siteName">Site to assign the study to</param>
        [StepDefinition(@"study ""([^""]*)"" is assigned to Site ""([^""]*)""")]
        public void Study____IsAssignedToSite____(string studyName, string siteName)
        {
            TestContext.CurrentPage = new SiteAdministrationHomePage().NavigateToSelf();
            Site site = new Site(siteName, true);
            TestContext.CurrentPage = new SiteAdministrationHomePage().NavigateToSelf();
            CurrentPage.As<SiteAdministrationHomePage>().SearchForSite(site.UniqueName);
            CurrentPage.As<SiteAdministrationHomePage>().ClickSite(site.UniqueName);
            Project project = new Project(studyName);
            CurrentPage.As<SiteAdministrationSiteDetailsPage>().LinkStudyWithSite(project.UniqueName);
        }
    }
}
