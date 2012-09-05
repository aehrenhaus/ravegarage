using TechTalk.SpecFlow;

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
	}
}
