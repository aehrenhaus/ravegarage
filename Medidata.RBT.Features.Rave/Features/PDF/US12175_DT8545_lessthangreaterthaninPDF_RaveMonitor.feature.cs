﻿// ------------------------------------------------------------------------------
//  <auto-generated>
//      This code was generated by SpecFlow (http://www.specflow.org/).
//      SpecFlow Version:1.8.1.0
//      SpecFlow Generator Version:1.8.0.0
//      Runtime Version:4.0.30319.1
// 
//      Changes to this file may cause incorrect behavior and will be lost if
//      the code is regenerated.
//  </auto-generated>
// ------------------------------------------------------------------------------
#region Designer generated code
#pragma warning disable
namespace Medidata.RBT.Features.Rave.Features.PDF
{
    using TechTalk.SpecFlow;
    
    
    [System.CodeDom.Compiler.GeneratedCodeAttribute("TechTalk.SpecFlow", "1.8.1.0")]
    [System.Runtime.CompilerServices.CompilerGeneratedAttribute()]
    [Microsoft.VisualStudio.TestTools.UnitTesting.TestClassAttribute()]
    public partial class WhenAnEDCFormContainsSpecialCharactersSuchAsThePDFFileShouldDisplayTheSpecialCharactersAppropriately_Feature1
    {
        
        private static TechTalk.SpecFlow.ITestRunner testRunner;
        
#line 1 "US12175_DT8545_lessthangreaterthaninPDF_RaveMonitor.feature"
#line hidden
        
        [Microsoft.VisualStudio.TestTools.UnitTesting.ClassInitializeAttribute()]
        public static void FeatureSetup(Microsoft.VisualStudio.TestTools.UnitTesting.TestContext testContext)
        {
            testRunner = TechTalk.SpecFlow.TestRunnerManager.GetTestRunner();
            TechTalk.SpecFlow.FeatureInfo featureInfo = new TechTalk.SpecFlow.FeatureInfo(new System.Globalization.CultureInfo("en-US"), "When an EDC form contains special characters such as \"<\" \">\" \"<=\" \">=\" the PDF fi" +
                    "le should display the special characters appropriately.", "Rave architect allows for characters that the PDF generator does support. The PDF" +
                    " generator should convert the special characters so that they are displayed appr" +
                    "opriately as follows:\r\n|Rave Architect\t \t\t|PDF Interpretation |Symbol in PDF    " +
                    "             |\r\n|&lt \t\t\t\t\t|&lt;               |<                             |\r\n" +
                    "|&gt\t\t\t\t\t|&gt;               |>                             |\r\n|&ge\t\t\t\t\t|<u>&gt;" +
                    "</u>        |>(underlined)                 |\r\n|&ge;\t\t\t\t\t|<u>&gt;</u>        |>(u" +
                    "nderlined)                 |\r\n|&le\t\t\t\t\t|<u>&lt;</u>        |<(underlined)       " +
                    "          |\r\n|&le;\t\t\t\t\t|<u>&lt;</u>        |<(underlined)                 |\r\n|bu" +
                    "llet points <li>\t\t|<br/> •            |(Line Break/carriage return) •|\r\n|(user h" +
                    "itting \"enter\")\t|<br/>              |(Line Break/carriage return)  |\r\n\r\nNOTE: An" +
                    " underlined \">\" will display instead of \">=\" which is represented by \">(underlin" +
                    "ed)\" in this feature file as text editors do not allow underlines.\r\n     An unde" +
                    "rlined \"<\" will display instead of \"<=\" which is represented by \"<(underlined)\" " +
                    "in this feature file as text editors do not allow underlines.\r\nNOTE: user hittin" +
                    "g \"enter\" was previously interpreted as \" \" but should be interpreted as a new l" +
                    "ine. In certain Japanese fonts it had been\r\ninterpreted as \"=\"\r\n\r\n  This renderi" +
                    "ng should be implemented for blank PDFs, annotated PDFs, data populated PDFs, Ra" +
                    "ve Monitor Trip Report PDFs. \r\nThis rendering should be implemented for:\r\ntransl" +
                    "ations\r\nfield pretext\r\ndata dictionaries on the CRF but NOT in the audit trail\r\n" +
                    "unit dictionaries on the CRF but NOT in the audit trail\r\ncoding dictionaries on " +
                    "the CRF but NOT in the audit trail\r\nlab units on the CRF but NOT in the audit tr" +
                    "ail (does not apply to Rave Monitor Trip Report PDFs)\r\nlab ranges on the CRF but" +
                    " NOT in the audit trail (does not apply to Rave Monitor Trip Report PDFs)\r\nThis " +
                    "rendering will NOT be implented for:\r\nbookmarks\r\nlab names\r\nForm names", ProgrammingLanguage.CSharp, ((string[])(null)));
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
                        && (TechTalk.SpecFlow.FeatureContext.Current.FeatureInfo.Title != "When an EDC form contains special characters such as \"<\" \">\" \"<=\" \">=\" the PDF fi" +
                            "le should display the special characters appropriately.")))
            {
                Medidata.RBT.Features.Rave.Features.PDF.WhenAnEDCFormContainsSpecialCharactersSuchAsThePDFFileShouldDisplayTheSpecialCharactersAppropriately_Feature.FeatureSetup(null);
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
#line 34
#line 35
    testRunner.Given("I am logged in to Rave with username \"defuser\" and password \"password\"");
#line 36
 testRunner.And("Study \"Site Monitor\" exist in \"Architect\"");
#line 37
 testRunner.And("Study \"Mediflex_Monitor\" exist in \"EDC\"");
#line 38
 testRunner.And("role \"RM Lead Monitor\" exist in \"Configuration\"");
#line 39
 testRunner.And("PDF Configuration Profile \"Monitor Trip Report\" exist");
#line 40
 testRunner.And("study \"Site Monitor\" is assigned to user \"defuser\" and role \"RM Lead Monitor\"");
#line 41
 testRunner.And("study \"Mediflex_Monitor\" is assigned to user \"defuser\" and role \"CDM1B144V1\"");
#line 42
 testRunner.And("I select Study \"Site Monitor\" in \"Architect\"");
#line 43
 testRunner.And("I select draft \"Draft 1.0\"");
#line 44
 testRunner.And("draft \"Draft 1.0\" has \"Signature Prompt\" with message \"Please review and sign&lt&" +
                    "gt&ge&ge;&le&le;bullet points&lt;li&gt;&lt;br/&gt;break\"");
#line 45
 testRunner.And("I select link \"Forms\"");
#line 46
 testRunner.And("I select icon \"Fields\" for standard form \"CRF and Source Documentation\"");
#line 47
 testRunner.And("I select pencil icon \"Edit\" for field label \"Date of Visit\"");
#line 48
 testRunner.And("I enter and save the field label \"Date of Visit&lt&gt&ge&ge;&le&le;bullet points&" +
                    "lt;li&gt;&lt;br/&gt;break\"");
#line 49
 testRunner.And("I select link \"Forms\"");
#line 50
 testRunner.And("I select icon \"Fields\" for log form \"Issues Log\"");
#line 51
 testRunner.And("I select pencil icon \"Edit\" for field label \"Status\"");
#line 52
 testRunner.And("I enter and save the field label \"&lt&gt&ge&ge;&le&le;bullet points&lt;li&gt;&lt;" +
                    "br/&gt;breakStatus\"");
#line 53
 testRunner.And("I select link \"Forms\"");
#line 54
 testRunner.And("I select icon \"Fields\" for mixed form \"Visit Information and Comments\"");
#line 55
 testRunner.And("I select pencil icon \"Edit\" for field label \"Visit Start Date\"");
#line 56
 testRunner.And("I enter and save the field label \"Visit Start Date&lt&gt&ge&ge;&le&le;bullet poin" +
                    "ts&lt;li&gt;&lt;br/&gt;break\"");
#line 57
    testRunner.And("I select pencil icon \"Edit\" for field label \"Representative\"");
#line 58
 testRunner.And("I enter and save the field label \"&lt&gt&ge&ge;&le&le;bullet points&lt;li&gt;&lt;" +
                    "br/&gt;breakRepresentative\"");
#line 59
    testRunner.And("I select draft \"Draft 1.0\"");
#line 60
 testRunner.And("I publish and push CRF Version \"CRF Version<RANDOMNUMBER>\" of Draft \"<Draft 1.0>\"" +
                    " to site \"SiteABC\" in Study \"Site Monitor\"");
#line hidden
        }
        
        [Microsoft.VisualStudio.TestTools.UnitTesting.TestMethodAttribute()]
        [Microsoft.VisualStudio.TestTools.UnitTesting.DescriptionAttribute("@US11043K A blank-populated PDF that is generated should properly display special" +
            " characters")]
        [Microsoft.VisualStudio.TestTools.UnitTesting.TestPropertyAttribute("FeatureTitle", "When an EDC form contains special characters such as \"<\" \">\" \"<=\" \">=\" the PDF fi" +
            "le should display the special characters appropriately.")]
        [Microsoft.VisualStudio.TestTools.UnitTesting.TestCategoryAttribute("release_2012.1.0")]
        [Microsoft.VisualStudio.TestTools.UnitTesting.TestCategoryAttribute("US11043K")]
        [Microsoft.VisualStudio.TestTools.UnitTesting.TestCategoryAttribute("Draft")]
        public virtual void US11043KABlank_PopulatedPDFThatIsGeneratedShouldProperlyDisplaySpecialCharacters()
        {
            TechTalk.SpecFlow.ScenarioInfo scenarioInfo = new TechTalk.SpecFlow.ScenarioInfo("@US11043K A blank-populated PDF that is generated should properly display special" +
                    " characters", new string[] {
                        "release_2012.1.0",
                        "US11043K",
                        "Draft"});
#line 65
this.ScenarioSetup(scenarioInfo);
#line 34
this.FeatureBackground();
#line 68
 testRunner.And("I select Study \"Mediflex_Monitor\" in \"EDC\"");
#line 69
 testRunner.And("I select link \"Monitor Visits\"");
#line 70
 testRunner.When("I View Blank PDF \"PDF Report\"");
#line hidden
            TechTalk.SpecFlow.Table table1 = new TechTalk.SpecFlow.Table(new string[] {
                        "Symbol"});
            table1.AddRow(new string[] {
                        "&gt"});
            table1.AddRow(new string[] {
                        "&ge"});
            table1.AddRow(new string[] {
                        "&ge;"});
            table1.AddRow(new string[] {
                        "&lt"});
            table1.AddRow(new string[] {
                        "&le"});
            table1.AddRow(new string[] {
                        "&le;"});
            table1.AddRow(new string[] {
                        "&lt;li&gt;"});
            table1.AddRow(new string[] {
                        "&lt;br&gt;"});
#line 71
 testRunner.Then("the text should not contain \"<Symbol>\"", ((string)(null)), table1);
#line hidden
            this.ScenarioCleanup();
        }
        
        [Microsoft.VisualStudio.TestTools.UnitTesting.TestMethodAttribute()]
        [Microsoft.VisualStudio.TestTools.UnitTesting.DescriptionAttribute("@US11043L A data-populated PDF that is generated should properly display special " +
            "characters")]
        [Microsoft.VisualStudio.TestTools.UnitTesting.TestPropertyAttribute("FeatureTitle", "When an EDC form contains special characters such as \"<\" \">\" \"<=\" \">=\" the PDF fi" +
            "le should display the special characters appropriately.")]
        [Microsoft.VisualStudio.TestTools.UnitTesting.TestCategoryAttribute("release_2012.1.0")]
        [Microsoft.VisualStudio.TestTools.UnitTesting.TestCategoryAttribute("US11043L")]
        [Microsoft.VisualStudio.TestTools.UnitTesting.TestCategoryAttribute("Draft")]
        public virtual void US11043LAData_PopulatedPDFThatIsGeneratedShouldProperlyDisplaySpecialCharacters()
        {
            TechTalk.SpecFlow.ScenarioInfo scenarioInfo = new TechTalk.SpecFlow.ScenarioInfo("@US11043L A data-populated PDF that is generated should properly display special " +
                    "characters", new string[] {
                        "release_2012.1.0",
                        "US11043L",
                        "Draft"});
#line 85
this.ScenarioSetup(scenarioInfo);
#line 34
this.FeatureBackground();
#line 88
 testRunner.And("I select Folder \"Interim Visit\"");
#line 89
 testRunner.And("I select Form \"CRF and Source Documentation\"");
#line 90
 testRunner.And("I verify the field label \"Date of Visit<>>(underlined)>(underlined)<(underlined)<" +
                    "(underlined)bullet points <li>(user hitting \"enter\")\" is displayed");
#line hidden
            TechTalk.SpecFlow.Table table2 = new TechTalk.SpecFlow.Table(new string[] {
                        "Field",
                        "Data"});
            table2.AddRow(new string[] {
                        "Date of Visit<>>(underlined)>(underlined)<(underlined)<(underlined)bullet points " +
                            "<li>(user hitting \"enter\")",
                        "01 Jan 2012"});
            table2.AddRow(new string[] {
                        "Not reviewed at this visit",
                        "true"});
            table2.AddRow(new string[] {
                        "Were original source documents and CRFs available for review? (list the documents" +
                            " that have been reviewed in \"Comments\")",
                        "Yes"});
            table2.AddRow(new string[] {
                        "Comment:",
                        "&lt&gt&ge&ge;"});
            table2.AddRow(new string[] {
                        "Do the source documents adequately support the data on the CRFs?",
                        "No"});
            table2.AddRow(new string[] {
                        "Comment:",
                        ";&le&le;"});
            table2.AddRow(new string[] {
                        "Are CRFs being completed accurately, legibly and in a timely manner?",
                        "Yes"});
            table2.AddRow(new string[] {
                        "Comment:",
                        "bullet points&lt;li&gt;&lt;br/&gt;break"});
#line 91
 testRunner.And("I enter data in CRF and save", ((string)(null)), table2);
#line 101
 testRunner.And("I select Form \"Visit Information and Comments\"");
#line 102
 testRunner.And("I verify the field label \"Visit Start Date<>>(underlined)>(underlined)<(underline" +
                    "d)<(underlined)bullet points <li>(user hitting \"enter\")\" is displayed");
#line 103
 testRunner.And("I verify the field label \"<>>(underlined)>(underlined)<(underlined)<(underlined)b" +
                    "ullet points <li>(user hitting \"enter\")Representative\" is displayed");
#line hidden
            TechTalk.SpecFlow.Table table3 = new TechTalk.SpecFlow.Table(new string[] {
                        "Field",
                        "Data"});
            table3.AddRow(new string[] {
                        "Visit Start Date<>>(underlined)>(underlined)<(underlined)<(underlined)bullet poin" +
                            "ts <li>(user hitting \"enter\")",
                        "01 Feb 2012"});
            table3.AddRow(new string[] {
                        "Visit End Date",
                        "01 Mar 2012"});
            table3.AddRow(new string[] {
                        "<>>(underlined)>(underlined)<(underlined)<(underlined)bullet points <li>(user hit" +
                            "ting \"enter\")Representative",
                        "test1"});
            table3.AddRow(new string[] {
                        "Association",
                        "Site"});
            table3.AddRow(new string[] {
                        "Role",
                        "Lead Monitor"});
            table3.AddRow(new string[] {
                        "Comment:",
                        "&lt&gt&ge&ge;&le&le;bullet points&lt;li&gt;&lt;br/&gt;break"});
            table3.AddRow(new string[] {
                        "have reviewed all data recorded in this report and confirm that it is complete an" +
                            "d accurate",
                        "defuser password"});
#line 104
 testRunner.And("I enter data in CRF and save", ((string)(null)), table3);
#line 113
    testRunner.And("I select link \"Monitor Visits\"");
#line 114
 testRunner.And("I select Form \"Issues Log\"");
#line 115
 testRunner.And("I verify the field label \"<>>(underlined)>(underlined)<(underlined)<(underlined)b" +
                    "ullet points <li>(user hitting \"enter\")Status\" is displayed");
#line hidden
            TechTalk.SpecFlow.Table table4 = new TechTalk.SpecFlow.Table(new string[] {
                        "Field",
                        "Data"});
            table4.AddRow(new string[] {
                        "<>>(underlined)>(underlined)<(underlined)<(underlined)bullet points <li>(user hit" +
                            "ting \"enter\")Status",
                        "Open"});
            table4.AddRow(new string[] {
                        "Issue Reported Date",
                        "05 Feb 2012"});
            table4.AddRow(new string[] {
                        "Issue Type",
                        "Source Documentation"});
            table4.AddRow(new string[] {
                        "Issue Description",
                        "&lt&gt&ge&ge;&le&le;bullet points&lt;li&gt;&lt;br/&gt;breakabc123"});
            table4.AddRow(new string[] {
                        "Action Item",
                        "&lt&gt&ge&ge;&le&le;bullet points&lt;li&gt;&lt;br/&gt;breakxyz456"});
            table4.AddRow(new string[] {
                        "Responsible",
                        "&lt&gt&ge&ge;&le&le;qqq789"});
            table4.AddRow(new string[] {
                        "Date Resolved",
                        "25 Feb 2012"});
            table4.AddRow(new string[] {
                        "Resolution Comments",
                        "aaa555&lt&gt&ge&ge;&le&le;bullet points&lt;li&gt;&lt;br/&gt;break"});
#line 116
 testRunner.And("I enter data in CRF and save", ((string)(null)), table4);
#line 126
 testRunner.And("I select link \"Monitor Visits\"");
#line 127
 testRunner.When("I View Blank PDF \"PDF Report\"");
#line hidden
            TechTalk.SpecFlow.Table table5 = new TechTalk.SpecFlow.Table(new string[] {
                        "Symbol"});
            table5.AddRow(new string[] {
                        "&gt"});
            table5.AddRow(new string[] {
                        "&ge"});
            table5.AddRow(new string[] {
                        "&ge;"});
            table5.AddRow(new string[] {
                        "&lt"});
            table5.AddRow(new string[] {
                        "&le"});
            table5.AddRow(new string[] {
                        "&le;"});
            table5.AddRow(new string[] {
                        "&lt;li&gt;"});
            table5.AddRow(new string[] {
                        "&lt;br&gt;"});
#line 128
 testRunner.Then("the text should not contain \"<Symbol>\"", ((string)(null)), table5);
#line hidden
            this.ScenarioCleanup();
        }
    }
}
#pragma warning restore
#endregion
