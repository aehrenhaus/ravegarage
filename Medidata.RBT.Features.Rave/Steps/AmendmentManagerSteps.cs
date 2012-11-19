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
    /// <summary>
    /// Step defs for amendment manager
    /// </summary>
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

        [Given(@"I go to Publish Checks for study ""(.*?)""")]
        public void IGoToPublishChecksForStudy____(string studyName)
        {
            new PublishChecksHomePage()
                .NavigateToStudy(studyName);
        }


        /// <summary>
        /// Selects the source crf version
        /// AM specific implementation and naming convention
        /// </summary>
        /// <param name="sourceCRFName">Feature defined source crfVersion name</param>
        [StepDefinition(@"I select Source CRF version ""([^""]*)""")]
        public void ISelectSourceCRFVersion____(string sourceCRFName)
        {
            TestContext.CurrentPage.As<AMMigrationHomePage>().SelectSourceCRF(sourceCRFName);
        }

        /// <summary>
        /// Selects the current crf version
        /// Publish Checks implementation and naming convention 
        /// - analogous to AM method ISelectSourceCRFVersion____(string sourceCRFName)
        /// </summary>
        /// <param name="currentCrfName"></param>
        [StepDefinition(@"I select Current CRF version ""(.*?)""")]
        public void ISelectCurrentCRFVersion___(string currentCrfName)
        {
            TestContext.CurrentPage.As<PublishChecksHomePage>()
                .SelectCurrentCRF(currentCrfName);
        }



        /// <summary>
        /// Select the target crf version
        /// AM specific implementation and naming convention
        /// </summary>
        /// <param name="targetCRFName">Feature defined target crfVersion name</param>
        [StepDefinition(@"I select Target CRF version ""([^""]*)""")]
        public void ISelectTargetCRFVersion____(string targetCRFName)
        {
            TestContext.CurrentPage.As<AMMigrationHomePage>().SelectTargetCRF(targetCRFName);
        }

        /// <summary>
        /// Selects the reference crf version
        /// Publish Checks implementation and naming convention 
        /// - analogous to AM method ISelectTargetCRFVersion____(string targetCRFName)
        /// </summary>
        /// <param name="referenceCrfName"></param>
        [StepDefinition(@"I select Reference CRF version ""(.*?)""")]
        public void ISelectReferenceCRFVersion___(string referenceCrfName)
        {
            TestContext.CurrentPage.As<PublishChecksHomePage>()
                .SelectReferenceCRF(referenceCrfName);
        }


        /// <summary>
        /// Selects the specified form from the Forms dropdown on Publish Checks page.
        /// It only applies to functionality exposed on Publish Checks page.
        /// </summary>
        /// <param name="form"></param>
        [StepDefinition(@"I select ""(.*?)"" from Forms in Edit Checks")]
        public void ISelect____FromFromsInEditChecks(string form)
        {
            TestContext.CurrentPage.As<PublishChecksHomePage>()
                .EditChecks
                .SelectForm(form);
        }

        /// <summary>
        /// Clicks on a button to search on the Publish Checks page.
        /// It only applies to functionality exposed on Publish Checks page.
        /// </summary>
        [StepDefinition(@"I select search icon in Edit Checks")]
        public void ISelectSearchIcon()
        {
            TestContext.CurrentPage.As<PublishChecksHomePage>()
                .EditChecks
                .Search();
        }

        [StepDefinition(@"I check ""(Publish|Run|Inactivate)"" for ""(.*?)"" in Edit Checks")]
        public void ICheck____For____InEditChecks(string action, string name)
        {
            var item = TestContext.CurrentPage.As<PublishChecksHomePage>()
                .EditChecks.FindEditChecksItemByName(name);

            switch (action)
            {
                case "Publish":
                    item.Publish = true;
                    break;
                case "Run":
                    item.Run = true;
                    break;
                case "Inactivate":
                    item.Inactivate = true;
                    break;
            }//End switch
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
