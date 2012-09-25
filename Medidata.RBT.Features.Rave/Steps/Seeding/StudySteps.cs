using TechTalk.SpecFlow;
using Medidata.RBT.PageObjects.Rave.SharedRaveObjects;
using Medidata.RBT.PageObjects.Rave;

namespace Medidata.RBT.Features.Rave
{
	[Binding]
	public class StudySteps : BrowserStepsBase
	{

		[StepDefinition(@"CRF Version ""([^""]*)"" in Study ""([^""]*)"" has been pushed to Site ""([^""]*)"" in Environment ""([^""]*)""")]
		public void CRF____IsPushedInSite____InStudy____InEnvironment____(string crfName, string siteName, string studyName,string environmentName)
		{

		}


		[StepDefinition(@"Study ""([^""]*)"" has Draft ""([^""]*)""")]
		public void Study____HasDraft____(string studyName, string draftName)
		{

		}

		[StepDefinition(@"Study ""[^""]*"" has Draft ""[^""]*"" includes Edit Checks from the table below")]
		public void Study____HasDraf____HasEditChecks(Table table)
		{

		}

		[StepDefinition(@"Draft ""([^""]*)"" in Study ""([^""]*)"" has been published to CRF Version ""([^""]*)""")]
		public void Draft____InStudy____HasBeenPublishedToCRFVersion____(string draftName,string studyName, string CRFVersion)
		{

		}


		[StepDefinition(@"following Study assignments exist")]
		public void FollowingStudyAssignmentsExist(Table table)
		{

		}
        /// <summary>
        /// XML draft is uploaded for seeding purposes.
        /// </summary>
        /// <param name="draftName">The name of the draft to be seeded</param>
        [StepDefinition(@"xml draft ""([^""]*)"" is Uploaded")]
        public void XmlDraft____IsUploaded(string draftName)
        {
            TestContext.GetExistingFeatureObjectOrMakeNew(draftName, () => new UploadedDraft(draftName, true));
        }

        /// <summary>
        /// XML draft is uploaded for seeding purposes.
        /// </summary>
        /// <param name="draft">The name of the draft to be seeded</param>
        [StepDefinition(@"xml draft ""([^""]*)"" is Uploaded with Environment name ""([^""]*)""")]
        public void XmlDraft____IsUploadedWithEnvironmentName____(string draftName,string envName)
        {
            UploadedDraft uploadedDraft = new UploadedDraft(draftName, true);

            TestContext.CurrentPage.As<HomePage>().ClickLink("Architect");
            TestContext.CurrentPage.As<ArchitectPage>().ClickProject(uploadedDraft.Project.UniqueName);
            TestContext.CurrentPage.As<ArchitectLibraryPage>().ClickLink("Studies Environment Setup");
            TestContext.CurrentPage.As<ArchitectEnvironmentSetupPage>().AddNewEnvironment(envName);
            TestContext.CurrentPage = new HomePage().NavigateToSelf();
            
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
            UploadedDraft uploadedDraft = TestContext.GetExistingFeatureObjectOrMakeNew
                    (uploadName, () => new UploadedDraft(uploadName, true));
            CrfVersion crfVersion = TestContext.GetExistingFeatureObjectOrMakeNew
                    (crfVersionName, () => new CrfVersion(uploadedDraft.Name, crfVersionName, true));
            if(TestContext.CurrentUser == null)
                LoginPage.LoginUsingDefaultUserFromAnyPage();
            TestContext.CurrentPage = new ArchitectPage().NavigateToSelf();
            if (!(TestContext.CurrentPage is ArchitectPage))
                LoginPage.LoginUsingDefaultUserFromAnyPage();
            TestContext.CurrentPage.As<ArchitectPage>().ClickProject(crfVersion.UploadedDraft.Project.UniqueName);
            TestContext.CurrentPage.As<ArchitectLibraryPage>().PushVersion(crfVersion.UniqueName, "Prod", "All Sites");
            TestContext.CurrentPage = new HomePage().NavigateToSelf();
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
            UploadedDraft uploadedDraft = new UploadedDraft(uploadName, true);
            CrfVersion crfVersion = new CrfVersion(uploadedDraft.Name, crfVersionName, true);
            TestContext.CurrentPage = new ArchitectPage().NavigateToSelf();
            TestContext.CurrentPage.As<ArchitectPage>().ClickProject(crfVersion.UploadedDraft.Project.UniqueName);
            TestContext.CurrentPage.As<ArchitectLibraryPage>().PushVersion(crfVersion.UniqueName, studyEnvName, "All Sites");
        }
	}
}
