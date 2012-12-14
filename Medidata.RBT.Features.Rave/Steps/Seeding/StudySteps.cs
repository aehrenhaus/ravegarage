using TechTalk.SpecFlow;
using Medidata.RBT.PageObjects.Rave.SharedRaveObjects;
using Medidata.RBT.PageObjects.Rave;
using TechTalk.SpecFlow.Assist;

namespace Medidata.RBT.Features.Rave
{
    /// <summary>
    /// Steps pertaining to studies
    /// </summary>
	[Binding]
	public class StudySteps : BrowserStepsBase
	{
        /// <summary>
        /// This is an unused step definition
        /// </summary>
        /// <param name="crfName"></param>
        /// <param name="siteName"></param>
        /// <param name="studyName"></param>
        /// <param name="environmentName"></param>
		[StepDefinition(@"CRF Version ""([^""]*)"" in Study ""([^""]*)"" has been pushed to Site ""([^""]*)"" in Environment ""([^""]*)""")]
		public void CRF____IsPushedInSite____InStudy____InEnvironment____(string crfName, string siteName, string studyName,string environmentName)
		{

		}

        /// <summary>
        /// This is used only in the ignored DT12651.feature, consider removing or replacing usage with correct step
        /// </summary>
        /// <param name="studyName"></param>
        /// <param name="draftName"></param>
		[StepDefinition(@"Study ""([^""]*)"" has Draft ""([^""]*)""")]
		public void Study____HasDraft____(string studyName, string draftName)
		{

		}

        /// <summary>
        /// This is an unused step definition
        /// </summary>
        /// <param name="table"></param>
		[StepDefinition(@"Study ""[^""]*"" has Draft ""[^""]*"" includes Edit Checks from the table below")]
		public void Study____HasDraf____HasEditChecks(Table table)
		{

		}

        /// <summary>
        /// This is an unused step definition
        /// </summary>
        /// <param name="draftName"></param>
        /// <param name="studyName"></param>
        /// <param name="CRFVersion"></param>
		[StepDefinition(@"Draft ""([^""]*)"" in Study ""([^""]*)"" has been published to CRF Version ""([^""]*)""")]
		public void Draft____InStudy____HasBeenPublishedToCRFVersion____(string draftName,string studyName, string CRFVersion)
		{

		}

        /// <summary>
        /// This is used only in the ignored DT12651.feature and SpecFlowFeature1.feature, consider removing or replacing usage with correct step
        /// </summary>
        /// <param name="table"></param>
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
            TestContext.GetExistingFeatureObjectOrMakeNew(draftName, () => new UploadedDraft(draftName));
        }

        /// <summary>
        /// XML draft is uploaded for seeding purposes.
        /// </summary>
        /// <param name="draftName"></param>
        /// <param name="envName"></param>
        [StepDefinition(@"xml draft ""([^""]*)"" is Uploaded with Environment name ""([^""]*)""")]
        public void XmlDraft____IsUploadedWithEnvironmentName____(string draftName,string envName)
        {
			using (new LoginSession())
			{
				UploadedDraft uploadedDraft = TestContext.GetExistingFeatureObjectOrMakeNew(draftName,
				                                                                            () => new UploadedDraft(draftName));

				TestContext.CurrentPage.As<HomePage>().ClickLink("Architect");
				TestContext.CurrentPage = new ArchitectPage();
				TestContext.CurrentPage.As<ArchitectPage>().ClickProject(uploadedDraft.Project.UniqueName);
				TestContext.CurrentPage.As<ArchitectLibraryPage>().ClickLink("Studies Environment Setup");
				TestContext.CurrentPage.As<ArchitectEnvironmentSetupPage>().AddNewEnvironment(envName);
				TestContext.CurrentPage = new HomePage().NavigateToSelf();
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
			using (new LoginSession())
			{
				UploadedDraft uploadedDraft = TestContext.GetExistingFeatureObjectOrMakeNew(draftName,
																							() => new UploadedDraft(draftName));

				TestContext.CurrentPage.As<HomePage>().ClickLink("Architect");
				TestContext.CurrentPage = new ArchitectPage();
				TestContext.CurrentPage.As<ArchitectPage>().ClickProject(uploadedDraft.Project.UniqueName);
				TestContext.CurrentPage.As<ArchitectLibraryPage>().ClickLink("Studies Environment Setup");

				foreach (var env in tableEnvs.CreateSet<NameObject>())
				{
					TestContext.CurrentPage.As<ArchitectEnvironmentSetupPage>().AddNewEnvironment(env.Name);
				}
				
				TestContext.CurrentPage = new HomePage().NavigateToSelf();
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
			using (new LoginSession())
			{
				UploadedDraft uploadedDraft = TestContext.GetExistingFeatureObjectOrMakeNew
					(uploadName, () => new UploadedDraft(uploadName));
				CrfVersion crfVersion = TestContext.GetExistingFeatureObjectOrMakeNew
					(crfVersionName, () => new CrfVersion(uploadedDraft.UniqueName, crfVersionName));
				if (TestContext.CurrentUser == null)
					LoginPage.LoginToHomePageIfNotAlready();
				TestContext.CurrentPage = new ArchitectPage().NavigateToSelf();
				if (!(TestContext.CurrentPage is ArchitectPage))
					LoginPage.LoginToHomePageIfNotAlready();
				TestContext.CurrentPage.As<ArchitectPage>().ClickProject(crfVersion.UploadedDraft.Project.UniqueName);
				TestContext.CurrentPage.As<ArchitectLibraryPage>().PushVersion(crfVersion.UniqueName, studyEnvName, "All Sites");
				TestContext.CurrentPage = new HomePage().NavigateToSelf();
			}
        }
	}
}
