﻿// ------------------------------------------------------------------------------
//  <auto-generated>
//      This code was generated by SpecFlow (http://www.specflow.org/).
//      SpecFlow Version:1.8.1.0
//      SpecFlow Generator Version:1.8.0.0
//      Runtime Version:2.0.50727.5446
// 
//      Changes to this file may cause incorrect behavior and will be lost if
//      the code is regenerated.
//  </auto-generated>
// ------------------------------------------------------------------------------
#region Designer generated code
#pragma warning disable
namespace Medidata.RBT.Features.Rave.Features.Configuration
{
    using TechTalk.SpecFlow;
    
    
    [System.CodeDom.Compiler.GeneratedCodeAttribute("TechTalk.SpecFlow", "1.8.1.0")]
    [System.Runtime.CompilerServices.CompilerGeneratedAttribute()]
    [Microsoft.VisualStudio.TestTools.UnitTesting.TestClassAttribute()]
    public partial class US13011_DT13976WhenTheConfigurationSettingsAreDownloadedTheyShouldIncludeCoderConfigurationDetails_Feature
    {
        
        private static TechTalk.SpecFlow.ITestRunner testRunner;
        
#line 1 "US13011_DT13976_AddCoderToConfigurationLoaderSpec.feature"
#line hidden
        
        [Microsoft.VisualStudio.TestTools.UnitTesting.ClassInitializeAttribute()]
        public static void FeatureSetup(Microsoft.VisualStudio.TestTools.UnitTesting.TestContext testContext)
        {
            testRunner = TechTalk.SpecFlow.TestRunnerManager.GetTestRunner();
            TechTalk.SpecFlow.FeatureInfo featureInfo = new TechTalk.SpecFlow.FeatureInfo(new System.Globalization.CultureInfo("en-US"), "US13011_DT13976: When the Configuration Settings are downloaded, they should incl" +
                    "ude Coder Configuration details.", "As a Rave Administrator\r\nWhen I am on the Configuration Loader page\r\nAnd I select" +
                    " Get File\r\nAnd the Core Configuration specification is downloaded and opened\r\nTh" +
                    "en the Core Configuration specification contains Coder Configuration details", ProgrammingLanguage.CSharp, ((string[])(null)));
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
                        && (TechTalk.SpecFlow.FeatureContext.Current.FeatureInfo.Title != "US13011_DT13976: When the Configuration Settings are downloaded, they should incl" +
                            "ude Coder Configuration details.")))
            {
                Medidata.RBT.Features.Rave.Features.Configuration.US13011_DT13976WhenTheConfigurationSettingsAreDownloadedTheyShouldIncludeCoderConfigurationDetails_Feature.FeatureSetup(null);
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
#line 10
 #line hidden
        }
        
        [Microsoft.VisualStudio.TestTools.UnitTesting.TestMethodAttribute()]
        [Microsoft.VisualStudio.TestTools.UnitTesting.DescriptionAttribute("Test")]
        [Microsoft.VisualStudio.TestTools.UnitTesting.TestPropertyAttribute("FeatureTitle", "US13011_DT13976: When the Configuration Settings are downloaded, they should incl" +
            "ude Coder Configuration details.")]
        [Microsoft.VisualStudio.TestTools.UnitTesting.TestCategoryAttribute("PB_US11101_01")]
        public virtual void Test()
        {
            TechTalk.SpecFlow.ScenarioInfo scenarioInfo = new TechTalk.SpecFlow.ScenarioInfo("Test", new string[] {
                        "PB_US11101_01"});
#line 26
this.ScenarioSetup(scenarioInfo);
#line 10
 this.FeatureBackground();
#line 27
 testRunner.Given("the \"Core Configuration Specification Template\" is downloaded");
#line hidden
            TechTalk.SpecFlow.Table table1 = new TechTalk.SpecFlow.Table(new string[] {
                        "Version",
                        "Coder Manual Queries",
                        "Setting",
                        "Instructions/Comments"});
            table1.AddRow(new string[] {
                        "",
                        "Review Marking Group",
                        "site from system",
                        ""});
            table1.AddRow(new string[] {
                        "",
                        "Requires Response",
                        "True",
                        ""});
            table1.AddRow(new string[] {
                        "",
                        "Requires Manual Close",
                        "True",
                        ""});
#line 28
 testRunner.Then("I verify spreadsheet data", ((string)(null)), table1);
#line hidden
            this.ScenarioCleanup();
        }
        
        [Microsoft.VisualStudio.TestTools.UnitTesting.TestMethodAttribute()]
        [Microsoft.VisualStudio.TestTools.UnitTesting.DescriptionAttribute("FIRST As a Data Manager, when I am on the Configuration Loader page, and I select" +
            " Get File, and the Core Configuration specification is downloaded, and I open it" +
            ", then I see Coder Configuration details.")]
        [Microsoft.VisualStudio.TestTools.UnitTesting.TestPropertyAttribute("FeatureTitle", "US13011_DT13976: When the Configuration Settings are downloaded, they should incl" +
            "ude Coder Configuration details.")]
        [Microsoft.VisualStudio.TestTools.UnitTesting.TestCategoryAttribute("PB_US11101_01")]
        public virtual void FIRSTAsADataManagerWhenIAmOnTheConfigurationLoaderPageAndISelectGetFileAndTheCoreConfigurationSpecificationIsDownloadedAndIOpenItThenISeeCoderConfigurationDetails_()
        {
            TechTalk.SpecFlow.ScenarioInfo scenarioInfo = new TechTalk.SpecFlow.ScenarioInfo("FIRST As a Data Manager, when I am on the Configuration Loader page, and I select" +
                    " Get File, and the Core Configuration specification is downloaded, and I open it" +
                    ", then I see Coder Configuration details.", new string[] {
                        "PB_US11101_01"});
#line 35
this.ScenarioSetup(scenarioInfo);
#line 10
 this.FeatureBackground();
#line 36
 testRunner.Given("I am logged in to Rave with username \"defuser\" and password \"password\"");
#line 37
 testRunner.When("I navigate to \"Configuration\" module");
#line 38
 testRunner.And("I navigate to \"Other Settings\"");
#line 39
 testRunner.And("I navigate to \"Coder Configuration\"");
#line hidden
            TechTalk.SpecFlow.Table table2 = new TechTalk.SpecFlow.Table(new string[] {
                        "Review Marking Group",
                        "Requires Response",
                        "Requires Manual Close"});
            table2.AddRow(new string[] {
                        "site from system",
                        "True",
                        "True"});
#line 40
 testRunner.And("I enter data in \"Coder Configuration\" and save", ((string)(null)), table2);
#line 43
 testRunner.And("I navigate to \"Configuration\" module");
#line 44
 testRunner.And("I navigate to \"Configuration Loader\"");
#line 45
 testRunner.And("I click \"Get File\"");
#line 46
 testRunner.And("the \"Core Configuration Specification Template\" is downloaded");
#line 48
 testRunner.Then("I verify \"Coder Configuration\" spreadsheet exists");
#line hidden
            TechTalk.SpecFlow.Table table3 = new TechTalk.SpecFlow.Table(new string[] {
                        "Version",
                        "Coder Manual Queries",
                        "Setting",
                        "Instructions/Comments"});
            table3.AddRow(new string[] {
                        "",
                        "Review Marking Group",
                        "site from system",
                        ""});
            table3.AddRow(new string[] {
                        "",
                        "Requires Response",
                        "True",
                        ""});
            table3.AddRow(new string[] {
                        "",
                        "Requires Manual Close",
                        "True",
                        ""});
#line 49
 testRunner.Then("I verify spreadsheet data", ((string)(null)), table3);
#line 55
 testRunner.And("I click the drop-down arrow for field \"Site from Sytem\"");
#line hidden
            TechTalk.SpecFlow.Table table4 = new TechTalk.SpecFlow.Table(new string[] {
                        "Setting"});
            table4.AddRow(new string[] {
                        "Site from System"});
            table4.AddRow(new string[] {
                        "Site from CRA"});
            table4.AddRow(new string[] {
                        "Site from DM"});
            table4.AddRow(new string[] {
                        "Monitor from Lead Monitor"});
            table4.AddRow(new string[] {
                        "Monitor from Sponsor"});
            table4.AddRow(new string[] {
                        "CRA from DM"});
#line 56
 testRunner.Then("I see data", ((string)(null)), table4);
#line 64
 testRunner.And("the cursor focus is located on \"Site from System\"");
#line 65
 testRunner.And("I take a screenshot");
#line 66
 testRunner.And("I click the drop-down arrow for field \"TRUE\" for \"Requires Response\"");
#line hidden
            TechTalk.SpecFlow.Table table5 = new TechTalk.SpecFlow.Table(new string[] {
                        "Setting"});
            table5.AddRow(new string[] {
                        "TRUE"});
            table5.AddRow(new string[] {
                        "FALSE"});
#line 67
 testRunner.Then("I see data", ((string)(null)), table5);
#line 71
 testRunner.And("the cursor focus is located on \"TRUE\"");
#line 72
 testRunner.And("I take a screenshot");
#line 73
 testRunner.And("I click the drop-down arrow for field \"TRUE\" for \"Requires Manual Close\"");
#line hidden
            TechTalk.SpecFlow.Table table6 = new TechTalk.SpecFlow.Table(new string[] {
                        "Setting"});
            table6.AddRow(new string[] {
                        "TRUE"});
            table6.AddRow(new string[] {
                        "FALSE"});
#line 74
 testRunner.Then("I see data", ((string)(null)), table6);
#line 78
 testRunner.And("the cursor focus is located on \"TRUE\"");
#line 79
 testRunner.And("I take a screenshot");
#line 80
 testRunner.And("I select module \"Configuration\"");
#line 81
 testRunner.And("I select Other Settings");
#line 82
 testRunner.And("I select Coder Configuration");
#line hidden
            TechTalk.SpecFlow.Table table7 = new TechTalk.SpecFlow.Table(new string[] {
                        "Review Marking Group",
                        "Requires Response",
                        "Requires Manual Close"});
            table7.AddRow(new string[] {
                        "Monitor from Sponsor",
                        "",
                        ""});
#line 83
 testRunner.And("I enter data", ((string)(null)), table7);
#line 86
 testRunner.And("I select module \"Configuration\"");
#line 87
 testRunner.And("I select Configuration Loader");
#line 88
 testRunner.And("I select \"Get File\"");
#line 89
 testRunner.And("the Core Configuration specification is downloaded");
#line 90
 testRunner.And("I open the Core Configuration specification");
#line 91
 testRunner.Then("I see Coder Configuration tab");
#line hidden
            TechTalk.SpecFlow.Table table8 = new TechTalk.SpecFlow.Table(new string[] {
                        "Version",
                        "Coder Manual Queries",
                        "Setting",
                        "Instructions/Comments"});
            table8.AddRow(new string[] {
                        "",
                        "Review Marking Group",
                        "Monitor from Sponsor",
                        ""});
            table8.AddRow(new string[] {
                        "",
                        "Requires Response",
                        "FALSE",
                        ""});
            table8.AddRow(new string[] {
                        "",
                        "Requires Manual Close",
                        "FALSE",
                        ""});
#line 92
 testRunner.Then("I see data", ((string)(null)), table8);
#line 97
 testRunner.And("I take a screenshot");
#line 98
 testRunner.And("I click the drop-down arrow for field \"Site from Sytem\"");
#line hidden
            TechTalk.SpecFlow.Table table9 = new TechTalk.SpecFlow.Table(new string[] {
                        "Review Marking Groups"});
            table9.AddRow(new string[] {
                        "Site from System"});
            table9.AddRow(new string[] {
                        "Site from CRA"});
            table9.AddRow(new string[] {
                        "Site from DM"});
            table9.AddRow(new string[] {
                        "Monitor from Lead Monitor"});
            table9.AddRow(new string[] {
                        "Monitor from Sponsor"});
            table9.AddRow(new string[] {
                        "CRA from DM"});
#line 99
 testRunner.Then("I see data", ((string)(null)), table9);
#line 107
 testRunner.And("the cursor focus is located on \"Monitor from Sponsor\"");
#line 108
 testRunner.And("I click the drop-down arrow for field \"FALSE\" for \"Requires Response\"");
#line hidden
            TechTalk.SpecFlow.Table table10 = new TechTalk.SpecFlow.Table(new string[] {
                        "Setting"});
            table10.AddRow(new string[] {
                        "TRUE"});
            table10.AddRow(new string[] {
                        "FALSE"});
#line 109
 testRunner.Then("I see data", ((string)(null)), table10);
#line 113
 testRunner.And("the cursor focus is located on \"FALSE\"");
#line 114
 testRunner.And("I take a screenshot");
#line 115
 testRunner.And("I click the drop-down arrow for field \"FALSE\" for \"Requires Manual Close\"");
#line hidden
            TechTalk.SpecFlow.Table table11 = new TechTalk.SpecFlow.Table(new string[] {
                        "Setting"});
            table11.AddRow(new string[] {
                        "TRUE"});
            table11.AddRow(new string[] {
                        "FALSE"});
#line 116
 testRunner.Then("I see data", ((string)(null)), table11);
#line 120
 testRunner.And("the cursor focus is located on \"FALSE\"");
#line 121
 testRunner.And("I take a screenshot");
#line hidden
            this.ScenarioCleanup();
        }
        
        [Microsoft.VisualStudio.TestTools.UnitTesting.TestMethodAttribute()]
        [Microsoft.VisualStudio.TestTools.UnitTesting.DescriptionAttribute("As a Data Manager, when I am on the Configuration Loader page, and I select Templ" +
            "ate Only, and I select Get File, and the Core Configuration specification is dow" +
            "nloaded, and I open it, then I see Coder Configuration details.")]
        [Microsoft.VisualStudio.TestTools.UnitTesting.TestPropertyAttribute("FeatureTitle", "US13011_DT13976: When the Configuration Settings are downloaded, they should incl" +
            "ude Coder Configuration details.")]
        [Microsoft.VisualStudio.TestTools.UnitTesting.TestCategoryAttribute("PB_US11101_02")]
        public virtual void AsADataManagerWhenIAmOnTheConfigurationLoaderPageAndISelectTemplateOnlyAndISelectGetFileAndTheCoreConfigurationSpecificationIsDownloadedAndIOpenItThenISeeCoderConfigurationDetails_()
        {
            TechTalk.SpecFlow.ScenarioInfo scenarioInfo = new TechTalk.SpecFlow.ScenarioInfo("As a Data Manager, when I am on the Configuration Loader page, and I select Templ" +
                    "ate Only, and I select Get File, and the Core Configuration specification is dow" +
                    "nloaded, and I open it, then I see Coder Configuration details.", new string[] {
                        "PB_US11101_02"});
#line 124
this.ScenarioSetup(scenarioInfo);
#line 10
 this.FeatureBackground();
#line 125
 testRunner.Given("I am logged in to Rave with username \"defuser\" and password \"password\"");
#line 126
 testRunner.And("I select module \"Configuration\"");
#line 127
 testRunner.And("I select Configuration Loader");
#line 128
 testRunner.And("I select \"Template Only\"");
#line 129
 testRunner.And("I take a screenshot");
#line 130
 testRunner.And("I select \"Get File\"");
#line 131
 testRunner.And("the Core Configuration specification is downloaded");
#line 132
 testRunner.And("I open the Core Configuration specification");
#line 133
 testRunner.Then("I see Coder Configuration tab");
#line hidden
            TechTalk.SpecFlow.Table table12 = new TechTalk.SpecFlow.Table(new string[] {
                        "Version",
                        "Coder Manual Queries",
                        "Setting",
                        "Instructions/Comments"});
            table12.AddRow(new string[] {
                        "",
                        "Review Marking Group",
                        "[None]",
                        ""});
            table12.AddRow(new string[] {
                        "",
                        "Requires Response",
                        "FALSE",
                        ""});
            table12.AddRow(new string[] {
                        "",
                        "Requires Manual Close",
                        "FALSE",
                        ""});
#line 134
 testRunner.Then("I see data", ((string)(null)), table12);
#line 139
 testRunner.And("I take a screenshot");
#line 140
 testRunner.And("I click the drop-down arrow for field \"[None]\" in the Setting column for Coder Ma" +
                    "nual Queries \"Review Marking Group\"");
#line hidden
            TechTalk.SpecFlow.Table table13 = new TechTalk.SpecFlow.Table(new string[] {
                        "Setting"});
            table13.AddRow(new string[] {
                        "[None]"});
            table13.AddRow(new string[] {
                        "Marking Group 1"});
            table13.AddRow(new string[] {
                        "Marking Group 2"});
            table13.AddRow(new string[] {
                        "Marking Group 3"});
            table13.AddRow(new string[] {
                        "Marking Group 4"});
            table13.AddRow(new string[] {
                        "Marking Group 5"});
            table13.AddRow(new string[] {
                        "Marking Group 6"});
            table13.AddRow(new string[] {
                        "Marking Group 7"});
            table13.AddRow(new string[] {
                        "Marking Group 8"});
            table13.AddRow(new string[] {
                        "Marking Group 9"});
            table13.AddRow(new string[] {
                        "Marking Group 10"});
#line 141
 testRunner.Then("I see data", ((string)(null)), table13);
#line 154
 testRunner.And("the cursor focus is located on \"[None]\" for \"Review Marking Group\"");
#line 155
 testRunner.And("I take a screenshot");
#line 156
 testRunner.And("I click the drop-down arrow for field \"FALSE\" for \"Requires Response\"");
#line hidden
            TechTalk.SpecFlow.Table table14 = new TechTalk.SpecFlow.Table(new string[] {
                        "Setting"});
            table14.AddRow(new string[] {
                        "TRUE"});
            table14.AddRow(new string[] {
                        "FALSE"});
#line 157
 testRunner.Then("I see data", ((string)(null)), table14);
#line 161
 testRunner.And("the cursor focus is located on \"FALSE\" for \"Requires Response\"");
#line 162
 testRunner.And("I take a screenshot");
#line 163
 testRunner.And("I click the drop-down arrow for field \"FALSE\" for \"Requires Manual Close\"");
#line hidden
            TechTalk.SpecFlow.Table table15 = new TechTalk.SpecFlow.Table(new string[] {
                        "Setting"});
            table15.AddRow(new string[] {
                        "TRUE"});
            table15.AddRow(new string[] {
                        "FALSE"});
#line 164
 testRunner.Then("I see data", ((string)(null)), table15);
#line 168
 testRunner.And("the cursor focus is located on \"FALSE\" for \"Requires Manual Close\"");
#line 169
 testRunner.And("I take a screenshot");
#line hidden
            this.ScenarioCleanup();
        }
        
        [Microsoft.VisualStudio.TestTools.UnitTesting.TestMethodAttribute()]
        [Microsoft.VisualStudio.TestTools.UnitTesting.DescriptionAttribute("As a Data Manager, when I am on the Configuration Loader page, and Coder is not e" +
            "nabled, and I select Get File, and the Core Configuration specification is downl" +
            "oaded, and I open it, then I do not see Coder Configuration details.")]
        [Microsoft.VisualStudio.TestTools.UnitTesting.TestPropertyAttribute("FeatureTitle", "US13011_DT13976: When the Configuration Settings are downloaded, they should incl" +
            "ude Coder Configuration details.")]
        [Microsoft.VisualStudio.TestTools.UnitTesting.TestCategoryAttribute("PB_US11101_03")]
        public virtual void AsADataManagerWhenIAmOnTheConfigurationLoaderPageAndCoderIsNotEnabledAndISelectGetFileAndTheCoreConfigurationSpecificationIsDownloadedAndIOpenItThenIDoNotSeeCoderConfigurationDetails_()
        {
            TechTalk.SpecFlow.ScenarioInfo scenarioInfo = new TechTalk.SpecFlow.ScenarioInfo("As a Data Manager, when I am on the Configuration Loader page, and Coder is not e" +
                    "nabled, and I select Get File, and the Core Configuration specification is downl" +
                    "oaded, and I open it, then I do not see Coder Configuration details.", new string[] {
                        "PB_US11101_03"});
#line 172
this.ScenarioSetup(scenarioInfo);
#line 10
 this.FeatureBackground();
#line 173
 testRunner.Given("I am logged in to Rave with username \"defuser\" and password \"password\"");
#line 174
 testRunner.And("I select module \"Configuration\"");
#line 175
 testRunner.And("I select Configuration Loader");
#line 176
 testRunner.And("I select \"Get File\"");
#line 177
 testRunner.And("the Core Configuration specification is downloaded");
#line 178
 testRunner.And("I open the Core Configuration specification");
#line 179
 testRunner.Then("I do not see Coder Configuration tab");
#line 180
 testRunner.And("I take a screenshot");
#line hidden
            this.ScenarioCleanup();
        }
    }
}
#pragma warning restore
#endregion
