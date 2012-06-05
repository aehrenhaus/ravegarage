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
namespace Medidata.RBT.Features.Rave.EDC
{
    using TechTalk.SpecFlow;
    
    
    [System.CodeDom.Compiler.GeneratedCodeAttribute("TechTalk.SpecFlow", "1.8.1.0")]
    [System.Runtime.CompilerServices.CompilerGeneratedAttribute()]
    [Microsoft.VisualStudio.TestTools.UnitTesting.TestClassAttribute()]
    public partial class _3Feature
    {
        
        private static TechTalk.SpecFlow.ITestRunner testRunner;
        
#line 1 "564QueryRefiringLogic3.feature"
#line hidden
        
        [Microsoft.VisualStudio.TestTools.UnitTesting.ClassInitializeAttribute()]
        public static void FeatureSetup(Microsoft.VisualStudio.TestTools.UnitTesting.TestContext testContext)
        {
            testRunner = TechTalk.SpecFlow.TestRunnerManager.GetTestRunner();
            TechTalk.SpecFlow.FeatureInfo featureInfo = new TechTalk.SpecFlow.FeatureInfo(new System.Globalization.CultureInfo("en-US"), "3", "", ProgrammingLanguage.CSharp, ((string[])(null)));
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
                        && (TechTalk.SpecFlow.FeatureContext.Current.FeatureInfo.Title != "3")))
            {
                Medidata.RBT.Features.Rave.EDC._3Feature.FeatureSetup(null);
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
    testRunner.Given("I am logged in to Rave with username \"cdm1\" and password \"password\"");
#line hidden
            TechTalk.SpecFlow.Table table1 = new TechTalk.SpecFlow.Table(new string[] {
                        "User",
                        "Study",
                        "Role",
                        "Site",
                        "Site Number"});
            table1.AddRow(new string[] {
                        "editcheck",
                        "Edit Check Study 1",
                        "CDM1",
                        "Edit Check Site 3",
                        "30001"});
#line 10
 testRunner.And("following Study assignments exist", ((string)(null)), table1);
#line 13
    testRunner.And("Role \"cdm1\" has Action \"Query\"");
#line hidden
            TechTalk.SpecFlow.Table table2 = new TechTalk.SpecFlow.Table(new string[] {
                        "Edit Check",
                        "Folder",
                        "Form",
                        "Field",
                        "Query Message"});
            table2.AddRow(new string[] {
                        "*Greater Than Log same form",
                        "Test B Single Derivation",
                        "Assessment Date Log2",
                        "Assessment Date 2",
                        "Date Field 1 can not be greater than Date Field 2."});
            table2.AddRow(new string[] {
                        "*Greater Than Open Query Cross Folder",
                        "Test B Single Derivation",
                        "Assessment Date Log2",
                        "Assessment Date 1",
                        "Date 1 can not be greater than."});
            table2.AddRow(new string[] {
                        "*Greater Than Open Query Log Cross Form",
                        "Test A Single Edit",
                        "Assessment Date Log2",
                        "Assessment Date 1",
                        "Informed Consent Date 1 is greater. Please revise."});
            table2.AddRow(new string[] {
                        "*Is Greater Than or Equal To Open Query Log Cross Form",
                        "Test A Single Edit",
                        "Assessment Date Log2",
                        "Numeric Field 1",
                        "Numeric Field is greater than or Equal to Numeric Field on Log."});
            table2.AddRow(new string[] {
                        "*Is Less Than Log same form",
                        "Test B Single Derivation",
                        "Assessment Date Log2",
                        "Numeric Field 2",
                        "Date is Less Than Date on first Number field."});
            table2.AddRow(new string[] {
                        "*Is Less Than Open Query Log Cross Form",
                        "Test A Single Edit",
                        "Assessment Date Log2",
                        "Assessment Date 2",
                        "Date is Less Than Date on the first log form."});
            table2.AddRow(new string[] {
                        "*Is Less Than To Open Query Log Cross Form",
                        "Test A Single Edit",
                        "Assessment Date Log2",
                        "Assessment Date 1",
                        "Date can not be less than."});
            table2.AddRow(new string[] {
                        "*Is Not Equal to Open Query Cross Folder",
                        "Test B Single Derivation",
                        "Assessment Date Log2",
                        "Numeric Field 2",
                        "Numeric Field 2 is not equal Numeric Field 2."});
            table2.AddRow(new string[] {
                        "*Is Not Equal To Open Query Log Cross Form",
                        "Test A Single Edit",
                        "Assessment Date Log2",
                        "Numeric Field 2",
                        "Numeric 2 can not equal each other."});
            table2.AddRow(new string[] {
                        "*Is Not Equal to Open Query Log Cross Form*",
                        "Test A Single Edit",
                        "Assessment Date Log2",
                        "Numeric Field 2",
                        "Informed Consent numeric field 2 is not equal to assessment numeric field 2"});
            table2.AddRow(new string[] {
                        "*Is Not Equal To Open Query Log Same form",
                        "Test B Single Derivation",
                        "Informed Consent Date Form 1",
                        "Numeric Field 2",
                        "Numeric fields are not equal."});
            table2.AddRow(new string[] {
                        "*Greater Than or Equal To Open Query Log same form",
                        "Test B Single Derivation",
                        "Informed Consent Date Form 1",
                        "Informed Consent Date 2",
                        "Dates are not equal."});
#line 14
 testRunner.And("Study \"Edit Check Study 1\" has Draft \"Draft 1\" includes Edit Checks from the tabl" +
                    "e below", ((string)(null)), table2);
#line 29
 testRunner.And("Draft \"Draft 1\" in Study \"Edit Check Study 1\" has been published to CRF Version \"" +
                    "<RANDOMNUMBER>\"");
#line 30
 testRunner.And("CRF Version \"<RANDOMNUMBER>\" in Study \"Edit Check Study 1\" has been pushed to Sit" +
                    "e \"Edit Check Site 1\" in Environment \"Prod\"");
#line hidden
        }
        
        [Microsoft.VisualStudio.TestTools.UnitTesting.TestMethodAttribute()]
        [Microsoft.VisualStudio.TestTools.UnitTesting.DescriptionAttribute("PB_3.1.1")]
        [Microsoft.VisualStudio.TestTools.UnitTesting.TestPropertyAttribute("FeatureTitle", "3")]
        public virtual void PB_3_1_1()
        {
            TechTalk.SpecFlow.ScenarioInfo scenarioInfo = new TechTalk.SpecFlow.ScenarioInfo("PB_3.1.1", new string[] {
                        "release_564_Patch11",
                        "PB_3.1.1",
                        "Draft",
                        "Web"});
#line 37
this.ScenarioSetup(scenarioInfo);
#line 8
this.FeatureBackground();
#line 41
 testRunner.Given("closed Queries exist on Fields \"Assessment Date 1, Numeric Field 2\" in Form \"Asse" +
                    "ssment Date Log2\" in Folder \"Test A Single Edit\" in Subject \"SUB301\" in Site \"Ed" +
                    "it Check Site 3\" in Study \"Edit Check Study 3\"");
#line 42
 testRunner.And("I am on CRF page \"Assessment Date Log2\" in Folder \"Test A Single Edit\" in Subject" +
                    " \"SUB301\" in Site \"Edit Check Site 3\" in Study \"Edit Check Study 3\"");
#line hidden
            TechTalk.SpecFlow.Table table3 = new TechTalk.SpecFlow.Table(new string[] {
                        "Field",
                        "Data"});
            table3.AddRow(new string[] {
                        "Assessment Date 1",
                        "08 Jan 2000"});
            table3.AddRow(new string[] {
                        "Numeric Field 2",
                        "20"});
#line 43
 testRunner.When("I enter data in CRF", ((string)(null)), table3);
#line 47
 testRunner.And("I save CRF");
#line 48
    testRunner.Then("I verify the Queries are not displayed on Field \"Assessment Date 1\" on log line 1" +
                    "");
#line 49
 testRunner.Then("I verify the Queries are not displayed on Field \"Numeric Field 2\" on log line 1");
#line 50
 testRunner.And("I take a screenshot");
#line hidden
            this.ScenarioCleanup();
        }
    }
}
#pragma warning restore
#endregion
