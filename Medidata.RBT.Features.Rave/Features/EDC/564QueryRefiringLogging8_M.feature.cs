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
    public partial class _8_1Feature
    {
        
        private static TechTalk.SpecFlow.ITestRunner testRunner;
        
#line 1 "564QueryRefiringLogging8_M.feature"
#line hidden
        
        [Microsoft.VisualStudio.TestTools.UnitTesting.ClassInitializeAttribute()]
        public static void FeatureSetup(Microsoft.VisualStudio.TestTools.UnitTesting.TestContext testContext)
        {
            testRunner = TechTalk.SpecFlow.TestRunnerManager.GetTestRunner();
            TechTalk.SpecFlow.FeatureInfo featureInfo = new TechTalk.SpecFlow.FeatureInfo(new System.Globalization.CultureInfo("en-US"), "8.1", "As a Rave user\r\nI want to change data\r\nSo I can see refired queries", ProgrammingLanguage.CSharp, ((string[])(null)));
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
                        && (TechTalk.SpecFlow.FeatureContext.Current.FeatureInfo.Title != "8.1")))
            {
                Medidata.RBT.Features.Rave.Features.EDC._8_1Feature.FeatureSetup(null);
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
#line 18
#line 20
    testRunner.Given("I am logged in to Rave with username \"defuser\" and password \"password\"");
#line hidden
        }
        
        [Microsoft.VisualStudio.TestTools.UnitTesting.TestMethodAttribute()]
        [Microsoft.VisualStudio.TestTools.UnitTesting.DescriptionAttribute("PB_8.1.1.1 As an user, When I Generate Data PDFs and view Data PDF, then query re" +
            "lated data are displayed.")]
        [Microsoft.VisualStudio.TestTools.UnitTesting.TestPropertyAttribute("FeatureTitle", "8.1")]
        [Microsoft.VisualStudio.TestTools.UnitTesting.TestCategoryAttribute("release_564_Patch11")]
        [Microsoft.VisualStudio.TestTools.UnitTesting.TestCategoryAttribute("PB_8.1.1.1")]
        [Microsoft.VisualStudio.TestTools.UnitTesting.TestCategoryAttribute("Draft")]
        [Microsoft.VisualStudio.TestTools.UnitTesting.TestCategoryAttribute("Manual")]
        public virtual void PB_8_1_1_1AsAnUserWhenIGenerateDataPDFsAndViewDataPDFThenQueryRelatedDataAreDisplayed_()
        {
            TechTalk.SpecFlow.ScenarioInfo scenarioInfo = new TechTalk.SpecFlow.ScenarioInfo("PB_8.1.1.1 As an user, When I Generate Data PDFs and view Data PDF, then query re" +
                    "lated data are displayed.", new string[] {
                        "release_564_Patch11",
                        "PB_8.1.1.1",
                        "Draft",
                        "Manual"});
#line 45
this.ScenarioSetup(scenarioInfo);
#line 18
this.FeatureBackground();
#line 48
 testRunner.And("I navigate to \"PDF Generator\"");
#line hidden
            TechTalk.SpecFlow.Table table1 = new TechTalk.SpecFlow.Table(new string[] {
                        "Name",
                        "Profile",
                        "Study",
                        "Role",
                        "SiteGroup",
                        "Site",
                        "Subject"});
            table1.AddRow(new string[] {
                        "pdf{RndNum<num>(3)}",
                        "GLOBAL1",
                        "Edit Check Study 3 (Prod)",
                        "CDM1",
                        "World",
                        "Edit Check Site 8",
                        "sub{Var(num1)}"});
#line 49
 testRunner.And("I create Data PDF", ((string)(null)), table1);
#line 52
 testRunner.And("I generate Data PDF \"pdf{Var(num)}\"");
#line 53
 testRunner.And("I wait for PDF \"pdf{Var(num)}\" to complete");
#line 54
 testRunner.When("I View Data PDF \"pdf{Var(num)}\"");
#line 55
 testRunner.Then("I should see \"Query Data\" in Audits");
#line 56
 testRunner.And("I take a screenshot");
#line hidden
            this.ScenarioCleanup();
        }
        
        [Microsoft.VisualStudio.TestTools.UnitTesting.TestMethodAttribute()]
        [Microsoft.VisualStudio.TestTools.UnitTesting.DescriptionAttribute("PB_8.1.2.1 As an user, When I run the \'Audit Trail\' Report, then query related da" +
            "ta are displayed in the report.")]
        [Microsoft.VisualStudio.TestTools.UnitTesting.TestPropertyAttribute("FeatureTitle", "8.1")]
        [Microsoft.VisualStudio.TestTools.UnitTesting.TestCategoryAttribute("release_564_Patch11")]
        [Microsoft.VisualStudio.TestTools.UnitTesting.TestCategoryAttribute("PB_8.1.2.1")]
        [Microsoft.VisualStudio.TestTools.UnitTesting.TestCategoryAttribute("Draft")]
        [Microsoft.VisualStudio.TestTools.UnitTesting.TestCategoryAttribute("Manual")]
        public virtual void PB_8_1_2_1AsAnUserWhenIRunTheAuditTrailReportThenQueryRelatedDataAreDisplayedInTheReport_()
        {
            TechTalk.SpecFlow.ScenarioInfo scenarioInfo = new TechTalk.SpecFlow.ScenarioInfo("PB_8.1.2.1 As an user, When I run the \'Audit Trail\' Report, then query related da" +
                    "ta are displayed in the report.", new string[] {
                        "release_564_Patch11",
                        "PB_8.1.2.1",
                        "Draft",
                        "Manual"});
#line 63
this.ScenarioSetup(scenarioInfo);
#line 18
this.FeatureBackground();
#line 65
 testRunner.And("I navigate to \"Reporter\"");
#line 66
 testRunner.And("I select Report \"Audit Trail\"");
#line 67
 testRunner.And("I search report parameter \"Study\" with \"Edit Check Study 3\"");
#line hidden
            TechTalk.SpecFlow.Table table2 = new TechTalk.SpecFlow.Table(new string[] {
                        "Name",
                        "Environment"});
            table2.AddRow(new string[] {
                        "Edit Check Study 3",
                        "Prod"});
#line 68
 testRunner.And("I set report parameter \"Study\" with table", ((string)(null)), table2);
#line hidden
            TechTalk.SpecFlow.Table table3 = new TechTalk.SpecFlow.Table(new string[] {
                        "Name"});
            table3.AddRow(new string[] {
                        "Edit Check Site 8"});
#line 71
 testRunner.And("I set report parameter \"Sites\" with table", ((string)(null)), table3);
#line hidden
            TechTalk.SpecFlow.Table table4 = new TechTalk.SpecFlow.Table(new string[] {
                        "Name"});
            table4.AddRow(new string[] {
                        "sub{Var(num1)}"});
#line 74
 testRunner.And("I set report parameter \"Subjects\" with table", ((string)(null)), table4);
#line hidden
            TechTalk.SpecFlow.Table table5 = new TechTalk.SpecFlow.Table(new string[] {
                        "Name"});
            table5.AddRow(new string[] {
                        "Screening"});
#line 77
 testRunner.And("I set report parameter \"Folders\" with table", ((string)(null)), table5);
#line hidden
            TechTalk.SpecFlow.Table table6 = new TechTalk.SpecFlow.Table(new string[] {
                        "Name"});
            table6.AddRow(new string[] {
                        "Informed Consent"});
            table6.AddRow(new string[] {
                        "Concomitant Medications"});
#line 80
 testRunner.And("I set report parameter \"Forms\" with table", ((string)(null)), table6);
#line hidden
            TechTalk.SpecFlow.Table table7 = new TechTalk.SpecFlow.Table(new string[] {
                        "Name"});
            table7.AddRow(new string[] {
                        "CM_STRT_DT"});
            table7.AddRow(new string[] {
                        "CURR_AXIS_NUM"});
#line 84
 testRunner.And("I set report parameter \"Fields\" with table", ((string)(null)), table7);
#line 88
 testRunner.And("I set report parameter \"Start Date\" with \"{Date(0)}\"");
#line 89
 testRunner.And("I set report parameter \"End Date\" with \"{Date(0)}\"");
#line 90
 testRunner.And("I search report parameter \"Audit Type\" with \"Query\"");
#line hidden
            TechTalk.SpecFlow.Table table8 = new TechTalk.SpecFlow.Table(new string[] {
                        "SubCategory"});
            table8.AddRow(new string[] {
                        "QueryOpen"});
#line 91
 testRunner.And("I set report parameter \"Audit Type\" with table", ((string)(null)), table8);
#line 94
 testRunner.And("I search report parameter \"User\" with \"Default User, System\"");
#line hidden
            TechTalk.SpecFlow.Table table9 = new TechTalk.SpecFlow.Table(new string[] {
                        "Full Name"});
            table9.AddRow(new string[] {
                        "Default User"});
#line 95
 testRunner.And("I set report parameter \"User\" with table", ((string)(null)), table9);
#line 98
 testRunner.When("I click button \"Submit Report\"");
#line 99
 testRunner.And("I switch to \"ReportViewer\" window");
#line 100
 testRunner.Then("I should see queries on \"Start Date\" and \"Current Axis Number\" fields");
#line 101
 testRunner.And("I take a screenshot");
#line 102
 testRunner.And("I close report");
#line hidden
            this.ScenarioCleanup();
        }
        
        [Microsoft.VisualStudio.TestTools.UnitTesting.TestMethodAttribute()]
        [Microsoft.VisualStudio.TestTools.UnitTesting.DescriptionAttribute("PB_8.1.2.2 As an user, When I run the \'Query Detail\' Report, then query related d" +
            "ata are displayed in the report.")]
        [Microsoft.VisualStudio.TestTools.UnitTesting.TestPropertyAttribute("FeatureTitle", "8.1")]
        [Microsoft.VisualStudio.TestTools.UnitTesting.TestCategoryAttribute("release_564_Patch11")]
        [Microsoft.VisualStudio.TestTools.UnitTesting.TestCategoryAttribute("PB_8.1.2.2")]
        [Microsoft.VisualStudio.TestTools.UnitTesting.TestCategoryAttribute("Draft")]
        [Microsoft.VisualStudio.TestTools.UnitTesting.TestCategoryAttribute("Manual")]
        public virtual void PB_8_1_2_2AsAnUserWhenIRunTheQueryDetailReportThenQueryRelatedDataAreDisplayedInTheReport_()
        {
            TechTalk.SpecFlow.ScenarioInfo scenarioInfo = new TechTalk.SpecFlow.ScenarioInfo("PB_8.1.2.2 As an user, When I run the \'Query Detail\' Report, then query related d" +
                    "ata are displayed in the report.", new string[] {
                        "release_564_Patch11",
                        "PB_8.1.2.2",
                        "Draft",
                        "Manual"});
#line 110
this.ScenarioSetup(scenarioInfo);
#line 18
this.FeatureBackground();
#line 112
 testRunner.And("I navigate to \"Reporter\"");
#line 113
 testRunner.And("I select Report \"Query Detail\"");
#line hidden
            TechTalk.SpecFlow.Table table10 = new TechTalk.SpecFlow.Table(new string[] {
                        "Name",
                        "Environment"});
            table10.AddRow(new string[] {
                        "Edit Check Study 3",
                        "Prod"});
#line 114
 testRunner.And("I set report parameter \"Study\" with table", ((string)(null)), table10);
#line hidden
            TechTalk.SpecFlow.Table table11 = new TechTalk.SpecFlow.Table(new string[] {
                        "Name"});
            table11.AddRow(new string[] {
                        "Edit Check Site 8"});
#line 117
 testRunner.And("I set report parameter \"Sites\" with table", ((string)(null)), table11);
#line hidden
            TechTalk.SpecFlow.Table table12 = new TechTalk.SpecFlow.Table(new string[] {
                        "Name"});
            table12.AddRow(new string[] {
                        "sub{Var(num1)}"});
#line 120
 testRunner.And("I set report parameter \"Subjects\" with table", ((string)(null)), table12);
#line hidden
            TechTalk.SpecFlow.Table table13 = new TechTalk.SpecFlow.Table(new string[] {
                        "Name"});
            table13.AddRow(new string[] {
                        "Screening"});
#line 123
 testRunner.And("I set report parameter \"Folders\" with table", ((string)(null)), table13);
#line hidden
            TechTalk.SpecFlow.Table table14 = new TechTalk.SpecFlow.Table(new string[] {
                        "Name"});
            table14.AddRow(new string[] {
                        "Informed Consent"});
            table14.AddRow(new string[] {
                        "Concomitant Medications"});
#line 126
 testRunner.And("I set report parameter \"Forms\" with table", ((string)(null)), table14);
#line hidden
            TechTalk.SpecFlow.Table table15 = new TechTalk.SpecFlow.Table(new string[] {
                        "Name"});
            table15.AddRow(new string[] {
                        "CM_STRT_DT"});
            table15.AddRow(new string[] {
                        "CURR_AXIS_NUM"});
#line 130
 testRunner.And("I set report parameter \"Fields\" with table", ((string)(null)), table15);
#line hidden
            TechTalk.SpecFlow.Table table16 = new TechTalk.SpecFlow.Table(new string[] {
                        "Group Name"});
            table16.AddRow(new string[] {
                        "Site"});
            table16.AddRow(new string[] {
                        "Marking Group 1"});
#line 134
 testRunner.And("I set report parameter \"Marking Groups\" with table", ((string)(null)), table16);
#line hidden
            TechTalk.SpecFlow.Table table17 = new TechTalk.SpecFlow.Table(new string[] {
                        "Name"});
            table17.AddRow(new string[] {
                        "Open"});
#line 138
 testRunner.And("I set report parameter \"Query Status\" with table", ((string)(null)), table17);
#line 141
 testRunner.And("I set report parameter \"Start Date\" with \"{Date(0)}\"");
#line 142
 testRunner.And("I set report parameter \"End Date\" with \"{Date(0)}\"");
#line 143
 testRunner.When("I click button \"Submit Report\"");
#line 144
 testRunner.Then("I should see queries on \"Start Date\" and \"Current Axis Number\" fields");
#line 146
 testRunner.And("I take a screenshot");
#line 147
 testRunner.And("I close report");
#line hidden
            this.ScenarioCleanup();
        }
        
        [Microsoft.VisualStudio.TestTools.UnitTesting.TestMethodAttribute()]
        [Microsoft.VisualStudio.TestTools.UnitTesting.DescriptionAttribute("PB_8.1.2.3 As an user, When I run the \'Edit Check Log Report\' Report, then query " +
            "related data are displayed in the report.")]
        [Microsoft.VisualStudio.TestTools.UnitTesting.TestPropertyAttribute("FeatureTitle", "8.1")]
        [Microsoft.VisualStudio.TestTools.UnitTesting.TestCategoryAttribute("release_564_Patch11")]
        [Microsoft.VisualStudio.TestTools.UnitTesting.TestCategoryAttribute("PB_8.1.2.3")]
        [Microsoft.VisualStudio.TestTools.UnitTesting.TestCategoryAttribute("Draft")]
        [Microsoft.VisualStudio.TestTools.UnitTesting.TestCategoryAttribute("Manual")]
        public virtual void PB_8_1_2_3AsAnUserWhenIRunTheEditCheckLogReportReportThenQueryRelatedDataAreDisplayedInTheReport_()
        {
            TechTalk.SpecFlow.ScenarioInfo scenarioInfo = new TechTalk.SpecFlow.ScenarioInfo("PB_8.1.2.3 As an user, When I run the \'Edit Check Log Report\' Report, then query " +
                    "related data are displayed in the report.", new string[] {
                        "release_564_Patch11",
                        "PB_8.1.2.3",
                        "Draft",
                        "Manual"});
#line 154
this.ScenarioSetup(scenarioInfo);
#line 18
this.FeatureBackground();
#line 156
 testRunner.And("I navigate to \"Reporter\"");
#line 157
 testRunner.And("I select Report \"Edit Check Log Report\"");
#line hidden
            TechTalk.SpecFlow.Table table18 = new TechTalk.SpecFlow.Table(new string[] {
                        "Name",
                        "Environment"});
            table18.AddRow(new string[] {
                        "Edit Check Study 3",
                        "Prod"});
#line 158
 testRunner.And("I set report parameter \"Study\" with table", ((string)(null)), table18);
#line hidden
            TechTalk.SpecFlow.Table table19 = new TechTalk.SpecFlow.Table(new string[] {
                        "Form Name"});
            table19.AddRow(new string[] {
                        "Concomitant Medications"});
            table19.AddRow(new string[] {
                        "Informed Consent"});
#line 161
 testRunner.And("I set report parameter \"Forms\" with table", ((string)(null)), table19);
#line hidden
            TechTalk.SpecFlow.Table table20 = new TechTalk.SpecFlow.Table(new string[] {
                        "Check Type"});
            table20.AddRow(new string[] {
                        "Edit Check"});
#line 165
 testRunner.And("I set report parameter \"Check Type\" with table", ((string)(null)), table20);
#line hidden
            TechTalk.SpecFlow.Table table21 = new TechTalk.SpecFlow.Table(new string[] {
                        "Check Log Type"});
            table21.AddRow(new string[] {
                        "CheckExecution"});
#line 168
 testRunner.And("I set report parameter \"Check Log Type\" with table", ((string)(null)), table21);
#line 171
 testRunner.When("I click button \"Submit Report\"");
#line 172
 testRunner.Then("I should see fired editchecks");
#line 174
 testRunner.And("I take a screenshot");
#line 175
 testRunner.And("I close report");
#line hidden
            this.ScenarioCleanup();
        }
        
        [Microsoft.VisualStudio.TestTools.UnitTesting.TestMethodAttribute()]
        [Microsoft.VisualStudio.TestTools.UnitTesting.DescriptionAttribute("PB_8.1.2.4 As an user, When I run the \'Stream-Audit Trail\' Report, then query rel" +
            "ated data are displayed in the report.")]
        [Microsoft.VisualStudio.TestTools.UnitTesting.TestPropertyAttribute("FeatureTitle", "8.1")]
        [Microsoft.VisualStudio.TestTools.UnitTesting.TestCategoryAttribute("release_564_Patch11")]
        [Microsoft.VisualStudio.TestTools.UnitTesting.TestCategoryAttribute("PB_8.1.2.4")]
        [Microsoft.VisualStudio.TestTools.UnitTesting.TestCategoryAttribute("Draft")]
        [Microsoft.VisualStudio.TestTools.UnitTesting.TestCategoryAttribute("Manual")]
        public virtual void PB_8_1_2_4AsAnUserWhenIRunTheStream_AuditTrailReportThenQueryRelatedDataAreDisplayedInTheReport_()
        {
            TechTalk.SpecFlow.ScenarioInfo scenarioInfo = new TechTalk.SpecFlow.ScenarioInfo("PB_8.1.2.4 As an user, When I run the \'Stream-Audit Trail\' Report, then query rel" +
                    "ated data are displayed in the report.", new string[] {
                        "release_564_Patch11",
                        "PB_8.1.2.4",
                        "Draft",
                        "Manual"});
#line 182
this.ScenarioSetup(scenarioInfo);
#line 18
this.FeatureBackground();
#line 184
 testRunner.And("I navigate to \"Reporter\"");
#line 185
 testRunner.And("I select Report \"Stream-Audit Trail\"");
#line hidden
            TechTalk.SpecFlow.Table table22 = new TechTalk.SpecFlow.Table(new string[] {
                        "Name",
                        "Environment"});
            table22.AddRow(new string[] {
                        "Edit Check Study 3",
                        "Prod"});
#line 186
 testRunner.And("I set report parameter \"Study\" with table", ((string)(null)), table22);
#line hidden
            TechTalk.SpecFlow.Table table23 = new TechTalk.SpecFlow.Table(new string[] {
                        "Name"});
            table23.AddRow(new string[] {
                        "Edit Check Site 8"});
#line 189
 testRunner.And("I set report parameter \"Sites\" with table", ((string)(null)), table23);
#line hidden
            TechTalk.SpecFlow.Table table24 = new TechTalk.SpecFlow.Table(new string[] {
                        "Name"});
            table24.AddRow(new string[] {
                        "sub{Var(num1)}"});
#line 192
 testRunner.And("I set report parameter \"Subjects\" with table", ((string)(null)), table24);
#line hidden
            TechTalk.SpecFlow.Table table25 = new TechTalk.SpecFlow.Table(new string[] {
                        "Name"});
            table25.AddRow(new string[] {
                        "Screening"});
#line 195
 testRunner.And("I set report parameter \"Folders\" with table", ((string)(null)), table25);
#line hidden
            TechTalk.SpecFlow.Table table26 = new TechTalk.SpecFlow.Table(new string[] {
                        "Name"});
            table26.AddRow(new string[] {
                        "Concomitant Medications"});
#line 198
 testRunner.And("I set report parameter \"Forms\" with table", ((string)(null)), table26);
#line 201
 testRunner.And("I click button \"Submit Report\"");
#line 202
 testRunner.And("I switch to \"Stream Report\" window of type \"StreamReport\"");
#line 204
 testRunner.And("I type \".\" in \"Separator\"");
#line 205
 testRunner.And("I choose \".csv (text/plain)\" from \"File type\"");
#line 206
 testRunner.And("I choose \"attachment\" from \"Export type\"");
#line 207
 testRunner.And("I check \"Save as Unicode\"");
#line 208
 testRunner.And("I click button \"Download File\"");
#line 209
 testRunner.And("I take a screenshot 1 of 1");
#line 212
 testRunner.And("I open excel file");
#line 213
 testRunner.Then("I should see queries on \"Start Date\" and \"Current Axis Number\" fields");
#line 214
 testRunner.And("I take a screenshot 1 of 2");
#line 215
 testRunner.And("I close report");
#line hidden
            this.ScenarioCleanup();
        }
        
        [Microsoft.VisualStudio.TestTools.UnitTesting.TestMethodAttribute()]
        [Microsoft.VisualStudio.TestTools.UnitTesting.DescriptionAttribute("PB_8.1.2.5 As an user, When I run the \'Stream-Query Detail\' Report, then query re" +
            "lated data are displayed in the report.")]
        [Microsoft.VisualStudio.TestTools.UnitTesting.TestPropertyAttribute("FeatureTitle", "8.1")]
        [Microsoft.VisualStudio.TestTools.UnitTesting.TestCategoryAttribute("release_564_Patch11")]
        [Microsoft.VisualStudio.TestTools.UnitTesting.TestCategoryAttribute("PB_8.1.2.5")]
        [Microsoft.VisualStudio.TestTools.UnitTesting.TestCategoryAttribute("Draft")]
        [Microsoft.VisualStudio.TestTools.UnitTesting.TestCategoryAttribute("Manual")]
        public virtual void PB_8_1_2_5AsAnUserWhenIRunTheStream_QueryDetailReportThenQueryRelatedDataAreDisplayedInTheReport_()
        {
            TechTalk.SpecFlow.ScenarioInfo scenarioInfo = new TechTalk.SpecFlow.ScenarioInfo("PB_8.1.2.5 As an user, When I run the \'Stream-Query Detail\' Report, then query re" +
                    "lated data are displayed in the report.", new string[] {
                        "release_564_Patch11",
                        "PB_8.1.2.5",
                        "Draft",
                        "Manual"});
#line 222
this.ScenarioSetup(scenarioInfo);
#line 18
this.FeatureBackground();
#line 224
 testRunner.And("I navigate to \"Reporter\"");
#line 225
 testRunner.And("I select Report \"Stream-Query Detail\"");
#line hidden
            TechTalk.SpecFlow.Table table27 = new TechTalk.SpecFlow.Table(new string[] {
                        "Name",
                        "Environment"});
            table27.AddRow(new string[] {
                        "Edit Check Study 3",
                        "Prod"});
#line 226
 testRunner.And("I set report parameter \"Study\" with table", ((string)(null)), table27);
#line hidden
            TechTalk.SpecFlow.Table table28 = new TechTalk.SpecFlow.Table(new string[] {
                        "Name"});
            table28.AddRow(new string[] {
                        "Edit Check Site 8"});
#line 229
 testRunner.And("I set report parameter \"Sites\" with table", ((string)(null)), table28);
#line hidden
            TechTalk.SpecFlow.Table table29 = new TechTalk.SpecFlow.Table(new string[] {
                        "Name"});
            table29.AddRow(new string[] {
                        "sub{Var(num1)}"});
#line 232
 testRunner.And("I set report parameter \"Subjects\" with table", ((string)(null)), table29);
#line hidden
            TechTalk.SpecFlow.Table table30 = new TechTalk.SpecFlow.Table(new string[] {
                        "Name"});
            table30.AddRow(new string[] {
                        "Screening"});
#line 235
 testRunner.And("I set report parameter \"Folders\" with table", ((string)(null)), table30);
#line hidden
            TechTalk.SpecFlow.Table table31 = new TechTalk.SpecFlow.Table(new string[] {
                        "Name"});
            table31.AddRow(new string[] {
                        "Concomitant Medications"});
#line 238
 testRunner.And("I set report parameter \"Forms\" with table", ((string)(null)), table31);
#line 241
 testRunner.And("I click button \"Submit Report\"");
#line 242
 testRunner.And("I switch to \"Stream Report\" window of type \"StreamReport\"");
#line 244
 testRunner.And("I type \".\" in \"Separator\"");
#line 245
 testRunner.And("I choose \".csv (text/plain)\" from \"File type\"");
#line 246
 testRunner.And("I choose \"attachment\" from \"Export type\"");
#line 247
 testRunner.And("I uncheck \"Save as Unicode\"");
#line 248
 testRunner.And("I click button \"Download File\"");
#line 249
 testRunner.And("I take a screenshot");
#line 251
 testRunner.And("I open excel file");
#line 252
 testRunner.Then("I should see queries on \"Start Date\" and \"Current Axis Number\" fields");
#line 253
 testRunner.And("I take a screenshot");
#line 254
 testRunner.And("I close report");
#line hidden
            this.ScenarioCleanup();
        }
        
        [Microsoft.VisualStudio.TestTools.UnitTesting.TestMethodAttribute()]
        [Microsoft.VisualStudio.TestTools.UnitTesting.DescriptionAttribute("PB_8.1.2.6 As an user, When I run the \'Stream-Edit Check Log Report\' Report, then" +
            " query related data are displayed in the report.")]
        [Microsoft.VisualStudio.TestTools.UnitTesting.TestPropertyAttribute("FeatureTitle", "8.1")]
        [Microsoft.VisualStudio.TestTools.UnitTesting.TestCategoryAttribute("release_564_Patch11")]
        [Microsoft.VisualStudio.TestTools.UnitTesting.TestCategoryAttribute("PB_8.1.2.6")]
        [Microsoft.VisualStudio.TestTools.UnitTesting.TestCategoryAttribute("Draft")]
        [Microsoft.VisualStudio.TestTools.UnitTesting.TestCategoryAttribute("Manual")]
        public virtual void PB_8_1_2_6AsAnUserWhenIRunTheStream_EditCheckLogReportReportThenQueryRelatedDataAreDisplayedInTheReport_()
        {
            TechTalk.SpecFlow.ScenarioInfo scenarioInfo = new TechTalk.SpecFlow.ScenarioInfo("PB_8.1.2.6 As an user, When I run the \'Stream-Edit Check Log Report\' Report, then" +
                    " query related data are displayed in the report.", new string[] {
                        "release_564_Patch11",
                        "PB_8.1.2.6",
                        "Draft",
                        "Manual"});
#line 261
this.ScenarioSetup(scenarioInfo);
#line 18
this.FeatureBackground();
#line 263
 testRunner.And("I navigate to \"Reporter\"");
#line 264
 testRunner.And("I select Report \"Stream-Edit Check Log Report\"");
#line hidden
            TechTalk.SpecFlow.Table table32 = new TechTalk.SpecFlow.Table(new string[] {
                        "Name",
                        "Environment"});
            table32.AddRow(new string[] {
                        "Edit Check Study 3",
                        "Prod"});
#line 265
 testRunner.And("I set report parameter \"Study\" with table", ((string)(null)), table32);
#line hidden
            TechTalk.SpecFlow.Table table33 = new TechTalk.SpecFlow.Table(new string[] {
                        "Form Name"});
            table33.AddRow(new string[] {
                        "Concomitant Medications"});
#line 268
 testRunner.And("I set report parameter \"Forms\" with table", ((string)(null)), table33);
#line hidden
            TechTalk.SpecFlow.Table table34 = new TechTalk.SpecFlow.Table(new string[] {
                        "Check Type"});
            table34.AddRow(new string[] {
                        "Edit Check"});
#line 271
 testRunner.And("I set report parameter \"Check Type\" with table", ((string)(null)), table34);
#line hidden
            TechTalk.SpecFlow.Table table35 = new TechTalk.SpecFlow.Table(new string[] {
                        "Check Log Type"});
            table35.AddRow(new string[] {
                        "CheckExecution"});
#line 274
 testRunner.And("I set report parameter \"Check Log Type\" with table", ((string)(null)), table35);
#line 277
 testRunner.And("I click button \"Submit Report\"");
#line 278
 testRunner.And("I switch to \"Stream Report\" window of type \"StreamReport\"");
#line 279
 testRunner.And("Im on windows");
#line 280
 testRunner.And("I type \".\" in \"Separator\"");
#line 281
 testRunner.And("I choose \".csv (text/plain)\" from \"File type\"");
#line 282
 testRunner.And("I choose \"attachment\" from \"Export type\"");
#line 283
 testRunner.And("I uncheck \"Save as Unicode\"");
#line 284
 testRunner.When("I click button \"Download File\"");
#line 285
 testRunner.And("I take a screenshot");
#line 287
 testRunner.And("I open excel file");
#line 288
 testRunner.Then("I should see queries on \"Start Date\" and \"Current Axis Number\" fields");
#line 289
 testRunner.And("I take a screenshot");
#line 290
 testRunner.And("I close report");
#line hidden
            this.ScenarioCleanup();
        }
        
        [Microsoft.VisualStudio.TestTools.UnitTesting.TestMethodAttribute()]
        [Microsoft.VisualStudio.TestTools.UnitTesting.DescriptionAttribute("PB_8.1.2.7 As an user, When I run the \'J-Review\' Report, then query related data " +
            "are displayed in the report.")]
        [Microsoft.VisualStudio.TestTools.UnitTesting.TestPropertyAttribute("FeatureTitle", "8.1")]
        [Microsoft.VisualStudio.TestTools.UnitTesting.TestCategoryAttribute("release_564_Patch11")]
        [Microsoft.VisualStudio.TestTools.UnitTesting.TestCategoryAttribute("PB_8.1.2.7")]
        [Microsoft.VisualStudio.TestTools.UnitTesting.TestCategoryAttribute("Draft")]
        [Microsoft.VisualStudio.TestTools.UnitTesting.TestCategoryAttribute("Manual")]
        public virtual void PB_8_1_2_7AsAnUserWhenIRunTheJ_ReviewReportThenQueryRelatedDataAreDisplayedInTheReport_()
        {
            TechTalk.SpecFlow.ScenarioInfo scenarioInfo = new TechTalk.SpecFlow.ScenarioInfo("PB_8.1.2.7 As an user, When I run the \'J-Review\' Report, then query related data " +
                    "are displayed in the report.", new string[] {
                        "release_564_Patch11",
                        "PB_8.1.2.7",
                        "Draft",
                        "Manual"});
#line 297
this.ScenarioSetup(scenarioInfo);
#line 18
this.FeatureBackground();
#line 299
 testRunner.And("I navigate to \"Reporter\"");
#line 300
 testRunner.And("I select Report \"J-Review\"");
#line hidden
            TechTalk.SpecFlow.Table table36 = new TechTalk.SpecFlow.Table(new string[] {
                        "Name",
                        "Environment"});
            table36.AddRow(new string[] {
                        "Edit Check Study 3",
                        "Prod"});
#line 301
 testRunner.And("I set report parameter \"Study\" with table", ((string)(null)), table36);
#line 304
 testRunner.And("I click button \"Submit Report\"");
#line 305
 testRunner.And("I select \"Edit Check Study 3\" \"Prod\" from \"Studies\"");
#line 306
 testRunner.And("I click button \"Reports\"");
#line 307
 testRunner.And("I select \"Detail Data Listing\" report from \"Type\" in \"Report Browser\"");
#line 308
 testRunner.And("I select \"MetricViews\" from \"Panels\"");
#line 309
 testRunner.And("I select \"Queries\" from \"MetricViews\"");
#line 310
 testRunner.And("I select \"Project, Site, Subject, Datapage, Field, Record Position QueryText, Que" +
                    "ryStatus, Answered Data, Answer Text\"");
#line 311
 testRunner.When("I click button \"Create Report\"");
#line 312
 testRunner.Then("I should see \"sub{Var(num1)}\"");
#line 313
 testRunner.And("I should see \"Added Query\" in \"QueryText\"");
#line 314
 testRunner.And("I take a screenshot");
#line 315
 testRunner.And("I Close \"Detail Data Listing\"");
#line hidden
            this.ScenarioCleanup();
        }
        
        [Microsoft.VisualStudio.TestTools.UnitTesting.TestMethodAttribute()]
        [Microsoft.VisualStudio.TestTools.UnitTesting.DescriptionAttribute("PB_8.1.2.8 As an user, When I run the \'BOXI\' Report, then query related data are " +
            "displayed in the report.")]
        [Microsoft.VisualStudio.TestTools.UnitTesting.TestPropertyAttribute("FeatureTitle", "8.1")]
        [Microsoft.VisualStudio.TestTools.UnitTesting.TestCategoryAttribute("release_564_Patch11")]
        [Microsoft.VisualStudio.TestTools.UnitTesting.TestCategoryAttribute("PB_8.1.2.8")]
        [Microsoft.VisualStudio.TestTools.UnitTesting.TestCategoryAttribute("Draft")]
        [Microsoft.VisualStudio.TestTools.UnitTesting.TestCategoryAttribute("Manual")]
        public virtual void PB_8_1_2_8AsAnUserWhenIRunTheBOXIReportThenQueryRelatedDataAreDisplayedInTheReport_()
        {
            TechTalk.SpecFlow.ScenarioInfo scenarioInfo = new TechTalk.SpecFlow.ScenarioInfo("PB_8.1.2.8 As an user, When I run the \'BOXI\' Report, then query related data are " +
                    "displayed in the report.", new string[] {
                        "release_564_Patch11",
                        "PB_8.1.2.8",
                        "Draft",
                        "Manual"});
#line 323
this.ScenarioSetup(scenarioInfo);
#line 18
this.FeatureBackground();
#line 325
 testRunner.And("I navigate to \"Reporter\"");
#line 326
 testRunner.And("I select report \"Business Objects XI\"");
#line hidden
            TechTalk.SpecFlow.Table table37 = new TechTalk.SpecFlow.Table(new string[] {
                        "Name",
                        "Environment"});
            table37.AddRow(new string[] {
                        "Edit Check Study 3",
                        "Prod"});
#line 327
 testRunner.And("I set report parameter \"Study\" with table", ((string)(null)), table37);
#line 330
 testRunner.And("I click button \"Submit Report\"");
#line 331
 testRunner.And("I select dropdown \"New\"");
#line 332
 testRunner.And("I select \"Web Intelligence Document\"");
#line 333
 testRunner.And("I select \"Rave 5.6 Universe\"");
#line 334
 testRunner.And("I select \"Project Name, Site Name, Subject Name, Folder Name, Form Name, Query Te" +
                    "xt\" in \"Results Objects\"");
#line 335
 testRunner.And("I select \"Site Name, Subject Name, Folder Name, FormName\" in \"Query Filters\"");
#line 336
 testRunner.And("I select \"Equal To\" from \"In List\" in \"Query Filters\" for \"Site Name\"");
#line 337
 testRunner.And("Enter \"Value(s) from list\" \"Edit Check Site 8\" in \"Query Filters\" for \"Site Name\"" +
                    "");
#line 338
 testRunner.And("I select \"Equal To\" from \"In List\" in \"Query Filters\" for \"Subject Name\"");
#line 339
 testRunner.And("Enter \"Value(s) from list\" \"sub{Var(num1)}\" in \"Query Filters\" for \"Subject Name\"" +
                    "");
#line 340
 testRunner.And("I select \"Equal To\" from \"In List\" in \"Query Filters\" for \"Folder Name\"");
#line 341
 testRunner.And("Enter \"Value(s) from list\" \"Screening\" in \"Query Filters\" for \"Folder Name\"");
#line 342
 testRunner.And("I select \"Equal To\" from \"In List\" in \"Query Filters\" for \"Form Name\"");
#line 343
 testRunner.And("Enter \"Value(s) from list\" \"Concomitant Medications\" in \"Query Filters\" for \"Form" +
                    " Name\"");
#line 344
 testRunner.When("I click button \"Run Query\"");
#line 345
 testRunner.Then("I should see \"sub{Var(num1)}\"");
#line 346
 testRunner.And("I should see \"Added Query\" in \"QueryText\"");
#line 347
 testRunner.And("I take a screenshot");
#line 348
 testRunner.And("I Close \"BOXI Report\"");
#line hidden
            this.ScenarioCleanup();
        }
    }
}
#pragma warning restore
#endregion
