﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using TechTalk.SpecFlow;
using Medidata.RBT.PageObjects;
using Medidata.RBT.PageObjects.Rave;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Medidata.RBT;

namespace Medidata.RBT.Features.Rave
{
	[Binding]
	public class ArchitectSteps : BrowserStepsBase
	{
		[StepDefinition(@"I publish and push CRF Version ""([^""]*)"" of Draft  to site ""([^""]*)"" in Study ""([^""]*)""")]
		public void IPublishAndPushCRFVersion____OfDraftToSite____InStudy____(string crfName, string siteName, string studyName)
		{

		}

		[StepDefinition(@"I create Draft ""([^""]*)"" from Project ""([^""]*)"" and Version ""([^""]*)""")]
		public void GivenICreateDraft____FromProject____AndVersion____(string draftName, string project, string version)
		{
			CurrentPage = CurrentPage.As<ArchitectLibraryPage>().CreateDraftFromProject(SpecialStringHelper.Replace( draftName),
				SpecialStringHelper.Replace(project),
				SpecialStringHelper.Replace(version));
		}



		[StepDefinition(@"I publish CRF Version ""([^""]*)""")]
		public void GivenIPublishCRFVersion____(string crfVersion)
		{
			CurrentPage.As<ArchitectCRFDraftPage>().PublishCRF(SpecialStringHelper.Replace(crfVersion));
			
		}

		[StepDefinition(@"I select ""Target\{RndNum\(3\)}"" from ""Target CRF""")]
		public void GivenISelectTargetRndNum3FromTargetCRF()
		{
			ScenarioContext.Current.Pending();
		}

		[StepDefinition(@"I select ""V1"" from ""Source CRF""")]
		public void GivenISelectV1FromSourceCRF()
		{
			ScenarioContext.Current.Pending();
		}

		[StepDefinition(@"I migrate all Subjects")]
		public void IMigrateAllSubjects()
		{
			CurrentPage = CurrentPage.As<AMMigrationExecutePage>().Migrate();
		}

		[Given(@"I select Migration Results and verify Job Status is set to Complete")]
		public void GivenISelectMigrationResultsAndVerifyJobStatusIsSetToComplete()
		{
			var isComplete = CurrentPage.As<AMMigrationExecutePage>().SeeIfComplete();
			Assert.IsTrue(isComplete, "Not complete");
		}


	}


}
