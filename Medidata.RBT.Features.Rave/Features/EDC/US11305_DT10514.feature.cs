﻿// ------------------------------------------------------------------------------
//  <auto-generated>
//      This code was generated by SpecFlow (http://www.specflow.org/).
//      SpecFlow Version:1.8.1.0
//      SpecFlow Generator Version:1.8.0.0
//      Runtime Version:4.0.30319.269
// 
//      Changes to this file may cause incorrect behavior and will be lost if
//      the code is regenerated.
//  </auto-generated>
// ------------------------------------------------------------------------------
#region Designer generated code
#pragma warning disable
namespace Medidata.RBT.Features.Rave.Features.EDC
{
    using TechTalk.SpecFlow;
    
    
    [System.CodeDom.Compiler.GeneratedCodeAttribute("TechTalk.SpecFlow", "1.8.1.0")]
    [System.Runtime.CompilerServices.CompilerGeneratedAttribute()]
    [Microsoft.VisualStudio.TestTools.UnitTesting.TestClassAttribute()]
    public partial class US11305_DT10514DatapointsInSameLabDatapageMayAssociateAnalyteRangesOfDifferentLabs_Feature
    {
        
        private static TechTalk.SpecFlow.ITestRunner testRunner;
        
#line 1 "US11305_DT10514.feature"
#line hidden
        
        [Microsoft.VisualStudio.TestTools.UnitTesting.ClassInitializeAttribute()]
        public static void FeatureSetup(Microsoft.VisualStudio.TestTools.UnitTesting.TestContext testContext)
        {
            testRunner = TechTalk.SpecFlow.TestRunnerManager.GetTestRunner();
            TechTalk.SpecFlow.FeatureInfo featureInfo = new TechTalk.SpecFlow.FeatureInfo(new System.Globalization.CultureInfo("en-US"), "US11305_DT10514 Datapoints in same lab datapage may associate analyte ranges of d" +
                    "ifferent labs.", "As a Rave user\r\nWhen a lab form is partially locked\r\nAnd I change the selected la" +
                    "b\r\nThen I expect to see lab ranges from the new lab for the lab data\r\nSo that I " +
                    "can reference the applicable lab ranges", ProgrammingLanguage.CSharp, ((string[])(null)));
            testRunner.OnFeatureStart(featureInfo);
        }
        
        [Microsoft.VisualStudio.TestTools.UnitTesting.ClassCleanupAttribute()]
        public static void FeatureTearDown()
        {
            testRunner.OnFeatureEnd();
            testRunner = null;
        }
        
        [Microsoft.VisualStudio.TestTools.UnitTesting.TestInitializeAttribute()]
        public virtual void TestInitialize()
        {
            if (((TechTalk.SpecFlow.FeatureContext.Current != null) 
                        && (TechTalk.SpecFlow.FeatureContext.Current.FeatureInfo.Title != "US11305_DT10514 Datapoints in same lab datapage may associate analyte ranges of d" +
                            "ifferent labs.")))
            {
                Medidata.RBT.Features.Rave.Features.EDC.US11305_DT10514DatapointsInSameLabDatapageMayAssociateAnalyteRangesOfDifferentLabs_Feature.FeatureSetup(null);
            }
        }
        
        [Microsoft.VisualStudio.TestTools.UnitTesting.TestCleanupAttribute()]
        public virtual void ScenarioTearDown()
        {
            testRunner.OnScenarioEnd();
        }
        
        public virtual void ScenarioSetup(TechTalk.SpecFlow.ScenarioInfo scenarioInfo)
        {
            testRunner.OnScenarioStart(scenarioInfo);
        }
        
        public virtual void ScenarioCleanup()
        {
            testRunner.CollectScenarioErrors();
        }
        
        public virtual void FeatureBackground()
        {
#line 8
#line 9
    testRunner.Given("I am logged in to Rave with username \"defuser\" and password \"password\"");
#line 22
 testRunner.And("I select Study \"Mediflex\" and Site \"LabSite01\"");
#line hidden
        }
        
        [Microsoft.VisualStudio.TestTools.UnitTesting.TestMethodAttribute()]
        [Microsoft.VisualStudio.TestTools.UnitTesting.DescriptionAttribute("As an EDC user, I have a partially locked lab form, and I change the selected lab" +
            ", then I should see the ranges update for all lab datapoints.")]
        [Microsoft.VisualStudio.TestTools.UnitTesting.TestPropertyAttribute("FeatureTitle", "US11305_DT10514 Datapoints in same lab datapage may associate analyte ranges of d" +
            "ifferent labs.")]
        [Microsoft.VisualStudio.TestTools.UnitTesting.TestCategoryAttribute("release_564_2012.1.0")]
        [Microsoft.VisualStudio.TestTools.UnitTesting.TestCategoryAttribute("PB-DT10514-01")]
        [Microsoft.VisualStudio.TestTools.UnitTesting.TestCategoryAttribute("Draft")]
        public virtual void AsAnEDCUserIHaveAPartiallyLockedLabFormAndIChangeTheSelectedLabThenIShouldSeeTheRangesUpdateForAllLabDatapoints_()
        {
            TechTalk.SpecFlow.ScenarioInfo scenarioInfo = new TechTalk.SpecFlow.ScenarioInfo("As an EDC user, I have a partially locked lab form, and I change the selected lab" +
                    ", then I should see the ranges update for all lab datapoints.", new string[] {
                        "release_564_2012.1.0",
                        "PB-DT10514-01",
                        "Draft"});
#line 28
this.ScenarioSetup(scenarioInfo);
#line 8
this.FeatureBackground();
#line hidden
            TechTalk.SpecFlow.Table table1 = new TechTalk.SpecFlow.Table(new string[] {
                        "Field",
                        "Data"});
            table1.AddRow(new string[] {
                        "Subject Number",
                        "{RndNum<num1>(5)}"});
            table1.AddRow(new string[] {
                        "Subject Initials",
                        "SUB"});
#line 30
 testRunner.When("I create a Subject", ((string)(null)), table1);
#line 35
 testRunner.And("I select Form \"Visit Date\" in Folder \"Visit 1\"");
#line hidden
            TechTalk.SpecFlow.Table table2 = new TechTalk.SpecFlow.Table(new string[] {
                        "Field",
                        "Data"});
            table2.AddRow(new string[] {
                        "Age",
                        "22"});
#line 36
 testRunner.And("I enter data in CRF and save", ((string)(null)), table2);
#line 40
 testRunner.And("I select Form \"Visit Date\" in Folder \"Visit 2\"");
#line hidden
            TechTalk.SpecFlow.Table table3 = new TechTalk.SpecFlow.Table(new string[] {
                        "Field",
                        "Data"});
            table3.AddRow(new string[] {
                        "Age",
                        "22"});
#line 41
 testRunner.And("I enter data in CRF and save", ((string)(null)), table3);
#line 45
 testRunner.And("I select Form \"Hematology\" in Folder \"Visit 2\"");
#line 58
 testRunner.And("I take a screenshot");
#line 59
 testRunner.And("I check \"Hard Lock\" on \"Lab Date\"");
#line 60
 testRunner.And("I check \"Hard Lock\" on \"WBC\"");
#line 61
 testRunner.And("I check \"Hard Lock\" on \"NEUTROPHILS\"");
#line 62
 testRunner.And("I save the CRF page");
#line 63
 testRunner.And("I take a screenshot");
#line 64
 testRunner.And("I uncheck \"Hard Lock\" on \"WBC\"");
#line 65
 testRunner.And("I save the CRF page");
#line 66
 testRunner.And("I take a screenshot");
#line 72
 testRunner.And("I take a screenshot");
#line 78
 testRunner.And("I take a screenshot");
#line hidden
            this.ScenarioCleanup();
        }
    }
}
#pragma warning restore
#endregion
