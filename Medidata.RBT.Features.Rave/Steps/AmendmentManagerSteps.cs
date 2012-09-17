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
using TechTalk.SpecFlow.Assist;

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
            TestContext.CurrentPage = new AMMigrationHomePage();
            TestContext.CurrentPage.As<AMMigrationHomePage>().NavigateToStudy(studyName);
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
            TestContext.CurrentPage.As<AMMigrationBasePage>().ClickLink("Execute Plan");
            TestContext.CurrentPage.As<AMMigrationExecutePage>().Migrate(SpecialStringHelper.Replace(subjectSearchString));
        }

        /// <summary>
        /// Set object mappings in amendment manager
        /// </summary>
        /// <param name="typeToMap">Type of object to map</param>
        /// <param name="table">Objects to map</param>
        [StepDefinition(@"I set up a ""([^""]*)"" object mapping")]
        public void ISetUpA____ObjectMapping(string typeToMap, Table table)
        {
            TestContext.CurrentPage.As<AMMigrationHomePage>().ClickLink("Object Mapping");
            string linkToClick;
            if (typeToMap.ToLower().Equals("data dictionary"))
                linkToClick = "Data Dictionary";
            else
                linkToClick = typeToMap;

            TestContext.CurrentPage.As<AMMigrationObjectMappingPage>().ClickLink(linkToClick);
            List<MigrationModel> migration = table.CreateSet<MigrationModel>().ToList();
            TestContext.CurrentPage.As<AMMigrationObjectMappingPage>().SetMapping(migration);
            Browser.FindElementById("_ctl0_Content_MigrationStepManagePlan1_buttonBar_buttonSave_lb_buttonSave").Click(); //Click save at the bottom of the page
        }

        /// <summary>
        /// Set up a child mapping
        /// </summary>
        /// <param name="typeToMap">Type of object to map</param>
        /// <param name="source">The parent of the child to map</param>
        /// <param name="table">Objects to map</param>
        [StepDefinition(@"I set up a mapping for source ""([^""]*)"" ""([^""]*)""")]
        public void ISetUpAMappingForSource________(string typeToMap, string source, Table table)
        {
            string linkToClick;
            if (typeToMap.ToLower().Equals("data dictionary"))
                linkToClick = "Data Dictionary";
            else
                linkToClick = typeToMap;

            TestContext.CurrentPage.As<AMMigrationObjectMappingPage>().ClickLink(linkToClick);
            List<MigrationModel> migration = table.CreateSet<MigrationModel>().ToList();
            TestContext.CurrentPage.As<AMMigrationObjectMappingPage>().EditMapping(source);
            TestContext.CurrentPage.As<AMMigrationObjectMappingPage>().SetChildMapping(migration);
            Browser.FindElementById("_ctl0_Content_MigrationStepManagePlan1_buttonBar_buttonSave_lb_buttonSave").Click(); //Click save at the bottom of the page
        }
	}
}
