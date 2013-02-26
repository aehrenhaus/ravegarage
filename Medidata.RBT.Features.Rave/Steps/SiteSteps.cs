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
            SeedingContext.GetExistingFeatureObjectOrMakeNew(siteName, () => new Site(siteName, ""));
        }

        /// <summary>
        /// Turn on DDE for a site
        /// </summary>
        /// <param name="site">Site to turn on DDE for</param>
        [Given(@"Site ""([^""]*)"" is DDE-enabled")]
        public void GivenSiteForStudyIsDDEEnabled(string site)
        {
            var siteObject = SeedingContext.GetExistingFeatureObjectOrMakeNew(site, () => new Site(site));
            DbHelper.EnableDDEForSiteAndStudy(siteObject.UniqueName);
        }

        /// <summary>
        /// Turn on Units Only for a site
        /// </summary>
        /// <param name="site">Site to turn on Units Only for</param>
        [Given(@"Site ""([^""]*)"" is Units-Only-enabled")]
        public void GivenSiteForStudyIsUnitsOnlyEnabled(string site)
        {
            var siteObject = SeedingContext.GetExistingFeatureObjectOrMakeNew(site, () => new Site(site));
            DbHelper.EnableUnitsOnlyForSiteAndStudy(siteObject.UniqueName);
        }

        /// <summary>
        /// Create a site if none already exists.
        /// </summary>
        /// <param name="siteName">The name that the site is referred to as in the feature file</param>
        /// <param name="siteGroup">The name that the site group is referred to as in the feature file</param>
        [StepDefinition(@"Site ""([^""]*)"" with Site Group ""([^""]*)"" exists")]
        public void Site____WithSiteGroup____Exists(string siteName, string siteGroup)
        {
            SiteGroup sg = SeedingContext.GetExistingFeatureObjectOrMakeNew(siteGroup, () => new SiteGroup(siteGroup));
            var site = SeedingContext.GetExistingFeatureObjectOrMakeNew(siteName, () => new Site(siteName, sg.UniqueName));
        }

        /// <summary>
        /// Unused step
        /// </summary>
        /// <param name="siteName"></param>
        /// <param name="siteNumber"></param>
        /// <param name="siteGroup"></param>
		[StepDefinition(@"Site ""(.*)"" with number \((.*)\) and Site Group ""(.*)"" exists")]
		public void Site____WithNumber____AndSiteGroup____Exists(string siteName, string siteNumber, string siteGroup)
		{
			SiteGroup sg = SeedingContext.GetExistingFeatureObjectOrMakeNew(siteGroup, () => new SiteGroup(siteGroup));
			var site = SeedingContext.GetExistingFeatureObjectOrMakeNew(siteName, () => new Site(siteName, sg.UniqueName, siteNumber));
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
            Site site = SeedingContext.GetExistingFeatureObjectOrMakeNew(siteName, () => new Site(siteName));
			Project project = SeedingContext.GetExistingFeatureObjectOrMakeNew(studyName, () => new Project(studyName));

			if (!site.StudySites.Any(x=>x.ProjectName == project.UniqueName && x.Environment == studyEnvName))
            {
				site.StudySites.Add(new StudySite( project.UniqueName,site.UniqueName,  studyEnvName));

				
				var page = new SiteAdministrationHomePage();
				page.NavigateToSelf();
				page.SearchForSite(site.UniqueName);
				page.ClickSite(site.UniqueName);
		
                
                CurrentPage.As<SiteAdministrationDetailsPage>().LinkStudyWithSite( project.UniqueName, studyEnvName);
            }
        }

        /// <summary>
        /// Search for site.
        /// </summary>
        [StepDefinition(@"I search for site ""([^""]*)""")]
        public void ISearchForSite__(string siteName)
        {
            var currentPage  = CurrentPage.As<SiteAdministrationHomePage>();
            currentPage.SearchForSite(SeedingContext.GetExistingFeatureObjectOrMakeNew<Site>(siteName, () => new Site(siteName)).UniqueName);            
        }

        /// <summary>
        /// Open site details.
        /// </summary>
        [StepDefinition(@"I select Site Details for Site ""([^""]*)""")]
        public void ISelectSiteDetailsForSite__(string siteName)
        {
            var currentPage = CurrentPage.As<SiteAdministrationHomePage>();
            currentPage.ClickSite(SeedingContext.GetExistingFeatureObjectOrMakeNew<Site>(siteName, () => new Site(siteName)).UniqueName);
        }


        /// <summary>
        /// Select additional details for study.
        /// </summary>
        [StepDefinition(@"I select ""([^""]*)"" for Study ""([^""]*)"" in Environment ""([^""]*)""")]
        public void ISelect__ForStudy__inEnvironment__(string elementName, string studyName, string environment)
        {
            var currentPage = CurrentPage.As<SiteAdministrationDetailsPage>();
            currentPage.SelectElementInStudySite(elementName, SeedingContext.GetExistingFeatureObjectOrMakeNew<Project>(studyName, () => new Project(studyName)).UniqueName, environment);

        }

    }
}
