using TechTalk.SpecFlow;
using Medidata.RBT.PageObjects.Rave;
using TechTalk.SpecFlow.Assist;
using Medidata.RBT.PageObjects.Rave.SeedableObjects;

namespace Medidata.RBT.Features.Rave
{
    /// <summary>
    /// Steps pertaining to studies
    /// </summary>
	[Binding]
	public class StudySteps : BrowserStepsBase
	{
		/// <summary>
		/// Creates a blank seeded Project (Study)
		/// </summary>
		/// <param name="studyName">Project (Study) name to be created</param>
		[Given(@"study ""([^""]*)"" exists")]
		public void GivenStudy____Exists(string studyName)
		{
			SeedingContext.GetExistingFeatureObjectOrMakeNew(studyName, () => new Project(studyName, false));
		}

        /// <summary>
        /// XML draft is uploaded for seeding purposes.
        /// </summary>
        /// <param name="draftName">The name of the draft to be seeded</param>
        [StepDefinition(@"xml draft ""([^""]*)"" is Uploaded")]
        public void XmlDraft____IsUploaded(string draftName)
        {
            SeedingContext.GetExistingFeatureObjectOrMakeNew(draftName, () => new UploadedDraft(draftName));
        }

		/// <summary>
		/// XML draft is uploaded for seeding purposes.
		/// </summary>
		/// <param name="draftName">The name of the draft to be seeded</param>
		[StepDefinition(@"xml draft ""([^""]*)"" is Uploaded without redirecting")]
		public void XmlDraft____IsUploadedWithoutRedirecting(string draftName)
		{
			SeedingContext.GetExistingFeatureObjectOrMakeNew(draftName, () => new UploadedDraft(draftName, false));
		}

        /// <summary>
        /// XML draft is uploaded for seeding purposes.
        /// </summary>
        /// <param name="draftName"></param>
        /// <param name="envName"></param>
        [StepDefinition(@"xml draft ""([^""]*)"" is Uploaded with Environment name ""([^""]*)""")]
        public void XmlDraft____IsUploadedWithEnvironmentName____(string draftName,string envName)
        {
			using (var session = new LoginSession(WebTestContext))
			{
				UploadedDraft uploadedDraft = SeedingContext.GetExistingFeatureObjectOrMakeNew(draftName,
				                                                                            () => new UploadedDraft(draftName));

				WebTestContext.CurrentPage.As<HomePage>().ClickLink("Architect");
				WebTestContext.CurrentPage = new ArchitectPage();
				WebTestContext.CurrentPage.As<ArchitectPage>().ClickProject(uploadedDraft.Project.UniqueName);
				WebTestContext.CurrentPage.As<ArchitectLibraryPage>().ClickLink("Studies Environment Setup");
				WebTestContext.CurrentPage.As<ArchitectEnvironmentSetupPage>().AddNewEnvironment(envName);
				WebTestContext.CurrentPage = new HomePage().NavigateToSelf();

				session.RestoreOriginalUser = true;
			}
        }

        /// <summary>
        /// Upload an xml upload draft to multiple environments
        /// </summary>
        /// <param name="draftName">The draft to upload</param>
        /// <param name="tableEnvs">The environments to upload the drafts to</param>
		[StepDefinition(@"xml draft ""([^""]*)"" is Uploaded with Environments")]
		public void XmlDraft____IsUploadedWithEnvironmentName____(string draftName, Table tableEnvs)
		{
			using (var session = new LoginSession(WebTestContext))
			{
				UploadedDraft uploadedDraft = SeedingContext.GetExistingFeatureObjectOrMakeNew(draftName,
																							() => new UploadedDraft(draftName));

				WebTestContext.CurrentPage.As<HomePage>().ClickLink("Architect");
				WebTestContext.CurrentPage = new ArchitectPage();
				WebTestContext.CurrentPage.As<ArchitectPage>().ClickProject(uploadedDraft.Project.UniqueName);
				WebTestContext.CurrentPage.As<ArchitectLibraryPage>().ClickLink("Studies Environment Setup");

				foreach (var env in tableEnvs.CreateSet<NameObject>())
				{
					WebTestContext.CurrentPage.As<ArchitectEnvironmentSetupPage>().AddNewEnvironment(env.Name);
				}
				
				WebTestContext.CurrentPage = new HomePage().NavigateToSelf();

				session.RestoreOriginalUser = true;
			}
		}

        /// <summary>
        /// Publish and push a UploadDraft to a crf version. This will create a CRFVersion with that name if none already exists.
        /// Since UploadDraft contains both project and draft, you do not need to specify these.
        /// </summary>
        /// <param name="uploadName">UploadDraft name, should have been created prior in the feature file</param>
        /// <param name="crfVersionName">The name that the crfVersion is referred to as in the feature file</param>
        [StepDefinition(@"I publish and push eCRF ""([^""]*)"" to ""([^""]*)""")]
        public void IPublishAndPushECRF____To____(string uploadName, string crfVersionName)
        {
            IPublishAndPushECRF____To____WithStudyEnvironment____(uploadName, crfVersionName, "Prod");
        }

        /// <summary>
        /// Publish and push a UploadDraft to a crf version. This will create a CRFVersion with that name if none already exists.
        /// Since UploadDraft contains both project and draft, you do not need to specify these.
        /// </summary>
        /// <param name="uploadName">UploadDraft name, should have been created prior in the feature file</param>
        /// <param name="crfVersionName">The name that the crfVersion is referred to as in the feature file</param>
        /// <param name="studyEnvName">Environment name</param>
        [StepDefinition(@"I publish and push eCRF ""([^""]*)"" to ""([^""]*)"" with study environment ""([^""]*)""")]
        public void IPublishAndPushECRF____To____WithStudyEnvironment____(string uploadName, string crfVersionName, string studyEnvName)
        {
            IPublishAndPushECRF____To____WithStudyEnvironment____ForSite____(uploadName, crfVersionName, studyEnvName, "All Sites");
        }

        /// <summary>
        /// Publish and push a UploadDraft to a crf version. This will create a CRFVersion with that name if none already exists.
        /// Since UploadDraft contains both project and draft, you do not need to specify these.
        /// </summary>
        /// <param name="uploadName">UploadDraft name, should have been created prior in the feature file</param>
        /// <param name="crfVersionName">The name that the crfVersion is referred to as in the feature file</param>
        /// <param name="studyEnvName">Environment name</param>
        /// <param name="siteSelection">Site selection</param>
        [StepDefinition(@"I publish and push eCRF ""([^""]*)"" to ""([^""]*)"" with study environment ""([^""]*)"" for site ""([^""]*)""")]
        public void IPublishAndPushECRF____To____WithStudyEnvironment____ForSite____(string uploadName, string crfVersionName, string studyEnvName, string siteSelection)
        {
			using (var session = new LoginSession(WebTestContext))
            {
                UploadedDraft uploadedDraft = SeedingContext.GetExistingFeatureObjectOrMakeNew
                        (uploadName, () => new UploadedDraft(uploadName));
                CrfVersion crfVersion = SeedingContext.GetExistingFeatureObjectOrMakeNew
                        (crfVersionName, () => new CrfVersion(uploadedDraft.UniqueName, crfVersionName));
                if (WebTestContext.CurrentUser == null)
                    LoginPage.LoginToHomePageIfNotAlready(WebTestContext);
                WebTestContext.CurrentPage = new ArchitectPage().NavigateToSelf();
                if (!(WebTestContext.CurrentPage is ArchitectPage))
					LoginPage.LoginToHomePageIfNotAlready(WebTestContext);
                WebTestContext.CurrentPage.As<ArchitectPage>().ClickProject(crfVersion.UploadedDraft.Project.UniqueName);
                string siteName;
                if (siteSelection == "All Sites")
                {
                    siteName = siteSelection;
                }
                else
                {
                    siteName = SeedingContext.GetExistingFeatureObjectOrMakeNew(siteSelection, () => new Site(siteSelection)).UniqueName;
                }
                WebTestContext.CurrentPage.As<ArchitectLibraryPage>().PushVersion(crfVersion.UniqueName, studyEnvName, siteName);
                WebTestContext.CurrentPage = new HomePage().NavigateToSelf();

				session.RestoreOriginalUser = true;
            }
        }

    }
}
