using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Medidata.RBT.Features;
using TechTalk.SpecFlow;
using Medidata.RBT.PageObjects;
using Medidata.RBT.PageObjects.Rave;
using System.IO;

using System.Data;
using Medidata.RBT.PageObjects.Rave.SharedRaveObjects;
using Medidata.RBT.PageObjects.Rave.AmendmentManager;

namespace Medidata.RBT.Features.Rave
{
	[Binding]
    public class AmendmentManagerSteps : BrowserStepsBase
	{
        /// <summary>
        /// Go to amendment manager for a study
        /// </summary>
        /// <param name="studyName">The feature defined name of the study</param>
        [StepDefinition(@"I go to Amendment Manager for study ""([^""]*)""")]
        public void IGoToAmendmentManagerForStudy____(string studyName)
        {
            TestContext.CurrentPage = new AmendmentManagerHomePage();
            TestContext.CurrentPage.As<AmendmentManagerHomePage>().NavigateToStudy(studyName);
        }

        /// <summary>
        /// Select the source crf version
        /// </summary>
        /// <param name="sourceCRFName">Feature defined source crfVersion name</param>
        [StepDefinition(@"I select Source CRF version ""([^""]*)""")]
        public void ISelectSourceCRFVersion____(string sourceCRFName)
        {
            TestContext.CurrentPage.As<AMMigrationHomePage>().SelectSourceCRF(sourceCRFName);
        }

        /// <summary>
        /// Select the target crf version
        /// </summary>
        /// <param name="sourceCRFName">Feature defined target crfVersion name</param>
        [StepDefinition(@"I select Target CRF version ""([^""]*)""")]
        public void ISelectTargetCRFVersion____(string targetCRFName)
        {
            TestContext.CurrentPage.As<AMMigrationHomePage>().SelectTargetCRF(targetCRFName);
        }

        /// <summary>
        /// Create the migration plan
        /// </summary>
        [StepDefinition(@"I create migration plan")]
        public void ICreateMigrationPlan()
        {
            TestContext.CurrentPage.As<AMMigrationHomePage>().ClickButton("Create Plan");
        }

        /// <summary>
        /// Execute the migration plan for the subject
        /// </summary>
        /// <param name="subjectSearchString">Feature defined subject name</param>
        [StepDefinition(@"I Execute plan for subject ""([^""]*)""")]
        [StepDefinition(@"I execute plan for subject ""([^""]*)""")]
        public void IExecutePlanForSubject____(string subjectSearchString)
        {
            TestContext.CurrentPage.As<AMMigrationHomePage>().ClickLink("Execute Plan");
            TestContext.CurrentPage.As<AMMigrationExecutePage>().Migrate(SpecialStringHelper.Replace(subjectSearchString));
        }
	}
}
