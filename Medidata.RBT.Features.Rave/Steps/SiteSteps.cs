using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using TechTalk.SpecFlow;
using Medidata.RBT.PageObjects.Rave.SharedRaveObjects;
using Medidata.RBT.PageObjects.Rave.SiteAdministration;

namespace Medidata.RBT.Features.Rave.Steps.Seeding
{
    /// <summary>
    /// Steps which create or manipulate sites.
    /// </summary>
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
            TestContext.GetExistingFeatureObjectOrMakeNew(siteName, () => new Site(siteName, true, ""));
        }

        /// <summary>
        /// Create a site if none already exists.
        /// </summary>
        /// <param name="siteName">The name that the site is referred to as in the feature file</param>
        /// <param name=siteGroup">The name that the site group is referred to as in the feature file</param>
        [StepDefinition(@"Site ""([^""]*)"" with Site Group ""([^""]*)"" exists")]
        public void Site____Exists(string siteName, string siteGroup)
        {
            SiteGroup sg = TestContext.GetExistingFeatureObjectOrMakeNew(siteGroup, () => new SiteGroup(siteGroup, true));
            TestContext.GetExistingFeatureObjectOrMakeNew(siteName, () => new Site(siteName, true, sg.UniqueName));
        }

        /// <summary>
        /// Asign a study to a site
        /// </summary>
        /// <param name="studyName">Study name which should match the name of the study in an uploaded draft</param>
        /// <param name="siteName">Site to assign the study to</param>
        [StepDefinition(@"study ""([^""]*)"" is assigned to Site ""([^""]*)""")]
        public void Study____IsAssignedToSite____(string studyName, string siteName)
        {
            Study____IsAssignedToSite____WithStudyEnvironment____(studyName, siteName, "");
        }

        /// <summary>
        /// Asign a study to a site
        /// </summary>
        /// <param name="studyName">Study name which should match the name of the study in an uploaded draft</param>
        /// <param name="siteName">Site to assign the study to</param>
        /// <param name="studyEnvName">Study environment name</param>
        [StepDefinition(@"study ""([^""]*)"" is assigned to Site ""([^""]*)"" with study environment ""([^""]*)""")]
        public void Study____IsAssignedToSite____WithStudyEnvironment____(string studyName, string siteName, string studyEnvName)
        {
            TestContext.CurrentPage = new SiteAdministrationHomePage().NavigateToSelf();
            Site site = TestContext.GetExistingFeatureObjectOrMakeNew(siteName, () => new Site(siteName, true));
            if (site.StudyUIDs == null || !site.StudyUIDs.Contains(site.UID.Value))
            {
                TestContext.CurrentPage = new SiteAdministrationHomePage().NavigateToSelf();
                CurrentPage.As<SiteAdministrationHomePage>().SearchForSite(site.UniqueName);
                CurrentPage.As<SiteAdministrationHomePage>().ClickSite(site.UniqueName);
                Project project = TestContext.GetExistingFeatureObjectOrMakeNew(studyName, () => new Project(studyName));
                CurrentPage.As<SiteAdministrationDetailsPage>().LinkStudyWithSite(site, project.UniqueName, studyEnvName);
            }
        }

        /// <summary>
        /// Search for site.
        /// </summary>
        [StepDefinition(@"I search for site ""([^""]*)""")]
        public void ISearchForSite__(string siteName)
        {
            var currentPage  = CurrentPage.As<SiteAdministrationHomePage>();
            currentPage.SearchForSite(siteName);            
        }

        /// <summary>
        /// Open site details.
        /// </summary>
        [StepDefinition(@"I select Site Details for Site ""([^""]*)""")]
        public void ISelectSiteDetailsForSite__(string siteName)
        {
            var currentPage = CurrentPage.As<SiteAdministrationHomePage>();
            currentPage.ClickSite(siteName);
        }


        /// <summary>
        /// Select additional details for study.
        /// </summary>
        [StepDefinition(@"I select ""([^""]*)"" for Study ""([^""]*)"" in Environment ""([^""]*)""")]
        public void ISelect__ForStudy__inEnvironment__(string elementName, string studyName, string environment)
        {
            var currentPage = CurrentPage.As<SiteAdministrationDetailsPage>();
            currentPage.SelectElementInStudySite(elementName, studyName, environment);

        }

    }
}
