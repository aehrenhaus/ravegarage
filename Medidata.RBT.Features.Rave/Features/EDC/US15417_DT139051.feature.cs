// ------------------------------------------------------------------------------
//  <auto-generated>
//      This code was generated by SpecFlow (http://www.specflow.org/).
//      SpecFlow Version:1.8.1.0
//      SpecFlow Generator Version:1.8.0.0
//      Runtime Version:4.0.30319.544
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
    public partial class DT13905NeedsCVRefreshIsNotSetToOnForAllDatapointsRelatedWhenLabUnitConversionIsCreatedOrUpdatedFeature
    {
        
        private static TechTalk.SpecFlow.ITestRunner testRunner;
        
#line 1 "US15417_DT13905.feature"
#line hidden
        
        [Microsoft.VisualStudio.TestTools.UnitTesting.ClassInitializeAttribute()]
        public static void FeatureSetup(Microsoft.VisualStudio.TestTools.UnitTesting.TestContext testContext)
        {
            testRunner = TechTalk.SpecFlow.TestRunnerManager.GetTestRunner();
            TechTalk.SpecFlow.FeatureInfo featureInfo = new TechTalk.SpecFlow.FeatureInfo(new System.Globalization.CultureInfo("en-US"), "DT 13905 NeedsCVRefresh is not set to On for all datapoints related when Lab Unit" +
                    " Conversion is created or updated", @"As a Rave user
Given I enter lab data in non-standard units
And I do not use Alert or Reference Labs for the lab data
When I update or create a lab unit conversion formula to convert the lab data to standard units
Then I should see the lab data converted to standard values in the standard units in Clinical Views", ProgrammingLanguage.CSharp, ((string[])(null)));
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
                        && (TechTalk.SpecFlow.FeatureContext.Current.FeatureInfo.Title != "DT 13905 NeedsCVRefresh is not set to On for all datapoints related when Lab Unit" +
                            " Conversion is created or updated")))
            {
                Medidata.RBT.Features.Rave.Features.EDC.DT13905NeedsCVRefreshIsNotSetToOnForAllDatapointsRelatedWhenLabUnitConversionIsCreatedOrUpdatedFeature.FeatureSetup(null);
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
#line 12
#line 13
    testRunner.Given("I am logged in to Rave with username \"defuser\" and password \"password\"");
#line 57
  testRunner.And("I select Study \"Mediflex_SJ\" and Site \"Site 1\"");
#line hidden
        }
        
        [Microsoft.VisualStudio.TestTools.UnitTesting.TestMethodAttribute()]
        [Microsoft.VisualStudio.TestTools.UnitTesting.DescriptionAttribute("PB_DT13905_01 As an EDC user, when I create a unit conversion formula to convert " +
            "lab data in a non-standard unit to standard values in a standard unit, then I sh" +
            "ould see the standard value and standard units in Clinical Views.")]
        [Microsoft.VisualStudio.TestTools.UnitTesting.TestPropertyAttribute("FeatureTitle", "DT 13905 NeedsCVRefresh is not set to On for all datapoints related when Lab Unit" +
            " Conversion is created or updated")]
        [Microsoft.VisualStudio.TestTools.UnitTesting.TestCategoryAttribute("release_2012.1.0")]
        [Microsoft.VisualStudio.TestTools.UnitTesting.TestCategoryAttribute("PB_DT13905_01")]
        [Microsoft.VisualStudio.TestTools.UnitTesting.TestCategoryAttribute("Draft")]
        public virtual void PB_DT13905_01AsAnEDCUserWhenICreateAUnitConversionFormulaToConvertLabDataInANon_StandardUnitToStandardValuesInAStandardUnitThenIShouldSeeTheStandardValueAndStandardUnitsInClinicalViews_()
        {
            TechTalk.SpecFlow.ScenarioInfo scenarioInfo = new TechTalk.SpecFlow.ScenarioInfo("PB_DT13905_01 As an EDC user, when I create a unit conversion formula to convert " +
                    "lab data in a non-standard unit to standard values in a standard unit, then I sh" +
                    "ould see the standard value and standard units in Clinical Views.", new string[] {
                        "release_2012.1.0",
                        "PB_DT13905_01",
                        "Draft"});
#line 62
this.ScenarioSetup(scenarioInfo);
#line 12
this.FeatureBackground();
#line hidden
            TechTalk.SpecFlow.Table table1 = new TechTalk.SpecFlow.Table(new string[] {
                        "Field",
                        "Data"});
            table1.AddRow(new string[] {
                        "Subject Initials",
                        "SUB"});
            table1.AddRow(new string[] {
                        "Subject number",
                        "{RndNum<num1>(3)}"});
            table1.AddRow(new string[] {
                        "Age",
                        "20"});
            table1.AddRow(new string[] {
                        "Sex",
                        "MaleREGAQT"});
            table1.AddRow(new string[] {
                        "Pregancy Status",
                        "NoREGAQT"});
            table1.AddRow(new string[] {
                        "Subject Date",
                        "01 Feb 2011"});
#line 63
 testRunner.When("I create a Subject", ((string)(null)), table1);
#line 71
 testRunner.And("I take a screenshot");
#line 72
 testRunner.And("I select Form \"Hematology\"");
#line 73
 testRunner.And("I take a screenshot");
#line 74
 testRunner.And("I choose \"Local Lab DT13905\" from \"Lab\"");
#line hidden
            TechTalk.SpecFlow.Table table2 = new TechTalk.SpecFlow.Table(new string[] {
                        "Field",
                        "Data",
                        "Unit"});
            table2.AddRow(new string[] {
                        "WBC",
                        "1",
                        "10^9/L"});
#line 75
 testRunner.And("I enter data in CRF and save", ((string)(null)), table2);
#line 79
 testRunner.And("I select \"Home\"");
#line 80
 testRunner.And("I navigate to \"Lab Administration\"");
#line 81
 testRunner.And("I navigate to \"Unit Conversions\"");
#line hidden
            TechTalk.SpecFlow.Table table3 = new TechTalk.SpecFlow.Table(new string[] {
                        "From",
                        "To",
                        "Analyte",
                        "A",
                        "B",
                        "C",
                        "D"});
            table3.AddRow(new string[] {
                        "10^9/L",
                        "%",
                        "...",
                        "2",
                        "1",
                        "0",
                        "0"});
#line 82
 testRunner.And("I add new unit conversion data", ((string)(null)), table3);
#line 85
 testRunner.And("I take a screenshot");
#line 88
 testRunner.And("I navigate to \"Home\"");
#line 89
 testRunner.And("I navigate to \"Reporter\"");
#line 90
 testRunner.And("I select Report \"Data Listing\"");
#line hidden
            TechTalk.SpecFlow.Table table4 = new TechTalk.SpecFlow.Table(new string[] {
                        "Name",
                        "Environment"});
            table4.AddRow(new string[] {
                        "Mediflex_SJ",
                        "Prod"});
#line 91
 testRunner.And("I set report parameter \"Study\" with table", ((string)(null)), table4);
#line 94
 testRunner.And("I click button \"Submit Report\"");
#line 95
 testRunner.And("I switch to \"DataListingsReport\" window");
#line 96
 testRunner.And("I choose \"Clinical Views\" from \"Data Source\"");
#line 97
 testRunner.And("I choose \"AnalytesView\" from \"Form\"");
#line 98
 testRunner.And("I click button \"Run\"");
#line hidden
            TechTalk.SpecFlow.Table table5 = new TechTalk.SpecFlow.Table(new string[] {
                        "Subject",
                        "FormName",
                        "AnalyteName",
                        "AnalyteValue",
                        "LabUnits",
                        "StdValue",
                        "StdUnits"});
            table5.AddRow(new string[] {
                        "SUB{Var(num1)}",
                        "Hematology",
                        "WBC",
                        "10",
                        "10^9/L",
                        "20",
                        "%"});
#line 99
 testRunner.Then("I should verify row(s) exist in \"Result\" table", ((string)(null)), table5);
#line hidden
            this.ScenarioCleanup();
        }
        
        [Microsoft.VisualStudio.TestTools.UnitTesting.TestMethodAttribute()]
        [Microsoft.VisualStudio.TestTools.UnitTesting.DescriptionAttribute("PB_DT13905_02 As an EDC user, when I create a unit conversion formula to convert " +
            "lab data in a non-standard unit to standard values in a standard unit for a spec" +
            "ific analyte, then I should see the standard value and standard units in Clinica" +
            "l Views.")]
        [Microsoft.VisualStudio.TestTools.UnitTesting.TestPropertyAttribute("FeatureTitle", "DT 13905 NeedsCVRefresh is not set to On for all datapoints related when Lab Unit" +
            " Conversion is created or updated")]
        [Microsoft.VisualStudio.TestTools.UnitTesting.TestCategoryAttribute("release_2012.1.0")]
        [Microsoft.VisualStudio.TestTools.UnitTesting.TestCategoryAttribute("PB_DT13905_02")]
        [Microsoft.VisualStudio.TestTools.UnitTesting.TestCategoryAttribute("Draft")]
        public virtual void PB_DT13905_02AsAnEDCUserWhenICreateAUnitConversionFormulaToConvertLabDataInANon_StandardUnitToStandardValuesInAStandardUnitForASpecificAnalyteThenIShouldSeeTheStandardValueAndStandardUnitsInClinicalViews_()
        {
            TechTalk.SpecFlow.ScenarioInfo scenarioInfo = new TechTalk.SpecFlow.ScenarioInfo("PB_DT13905_02 As an EDC user, when I create a unit conversion formula to convert " +
                    "lab data in a non-standard unit to standard values in a standard unit for a spec" +
                    "ific analyte, then I should see the standard value and standard units in Clinica" +
                    "l Views.", new string[] {
                        "release_2012.1.0",
                        "PB_DT13905_02",
                        "Draft"});
#line 106
this.ScenarioSetup(scenarioInfo);
#line 12
this.FeatureBackground();
#line hidden
            TechTalk.SpecFlow.Table table6 = new TechTalk.SpecFlow.Table(new string[] {
                        "Field",
                        "Data"});
            table6.AddRow(new string[] {
                        "Subject Initials",
                        "SUB"});
            table6.AddRow(new string[] {
                        "Subject number",
                        "{RndNum<num1>(3)}"});
            table6.AddRow(new string[] {
                        "Age",
                        "20"});
            table6.AddRow(new string[] {
                        "Sex",
                        "MaleREGAQT"});
            table6.AddRow(new string[] {
                        "Pregancy Status",
                        "NoREGAQT"});
            table6.AddRow(new string[] {
                        "Subject Date",
                        "01 Feb 2011"});
#line 107
 testRunner.When("I create a Subject", ((string)(null)), table6);
#line 116
 testRunner.And("I select Form \"Hematology\"");
#line 117
 testRunner.And("I choose \"Local Lab DT13905\" from \"Lab\"");
#line hidden
            TechTalk.SpecFlow.Table table7 = new TechTalk.SpecFlow.Table(new string[] {
                        "Field",
                        "Data",
                        "Unit"});
            table7.AddRow(new string[] {
                        "WBC",
                        "1",
                        "10^9/L"});
#line 118
 testRunner.And("I enter data in CRF and save", ((string)(null)), table7);
#line 124
 testRunner.And("I select \"Home\"");
#line 125
 testRunner.And("I navigate to \"Lab Administration\"");
#line 126
 testRunner.And("I navigate to \"Unit Conversions\"");
#line hidden
            TechTalk.SpecFlow.Table table8 = new TechTalk.SpecFlow.Table(new string[] {
                        "From",
                        "To",
                        "Analyte",
                        "A",
                        "B",
                        "C",
                        "D"});
            table8.AddRow(new string[] {
                        "10^9/L",
                        "%",
                        "WBC",
                        "4",
                        "1",
                        "0",
                        "0"});
#line 127
 testRunner.And("I add new unit conversion data", ((string)(null)), table8);
#line 132
 testRunner.And("I navigate to \"Home\"");
#line 133
 testRunner.And("I navigate to \"Reporter\"");
#line 134
 testRunner.And("I select Report \"Data Listing\"");
#line hidden
            TechTalk.SpecFlow.Table table9 = new TechTalk.SpecFlow.Table(new string[] {
                        "Name",
                        "Environment"});
            table9.AddRow(new string[] {
                        "Mediflex_SJ",
                        "Prod"});
#line 135
 testRunner.And("I set report parameter \"Study\" with table", ((string)(null)), table9);
#line 138
 testRunner.And("I click button \"Submit Report\"");
#line 139
 testRunner.And("I switch to \"DataListingsReport\" window");
#line 140
 testRunner.And("I choose \"Clinical Views\" from \"Data Source\"");
#line 141
 testRunner.And("I choose \"AnalytesView\" from \"Form\"");
#line 142
 testRunner.And("I click button \"Run\"");
#line hidden
            TechTalk.SpecFlow.Table table10 = new TechTalk.SpecFlow.Table(new string[] {
                        "Subject",
                        "FormName",
                        "AnalyteName",
                        "AnalyteValue",
                        "LabUnits",
                        "StdValue",
                        "StdUnits"});
            table10.AddRow(new string[] {
                        "SUB{Var(num1)}",
                        "Hematology",
                        "WBC",
                        "10",
                        "10^9/L",
                        "40",
                        "%"});
#line 144
 testRunner.Then("I should verify row(s) exist in \"Result\" table", ((string)(null)), table10);
#line hidden
            this.ScenarioCleanup();
        }
        
        [Microsoft.VisualStudio.TestTools.UnitTesting.TestMethodAttribute()]
        [Microsoft.VisualStudio.TestTools.UnitTesting.DescriptionAttribute("PB_DT13905_03 As an EDC user, when I update a unit conversion formula to convert " +
            "lab data in a non-standard unit to standard values in a standard unit, then I sh" +
            "ould see the standard value and standard units in Clinical Views.")]
        [Microsoft.VisualStudio.TestTools.UnitTesting.TestPropertyAttribute("FeatureTitle", "DT 13905 NeedsCVRefresh is not set to On for all datapoints related when Lab Unit" +
            " Conversion is created or updated")]
        [Microsoft.VisualStudio.TestTools.UnitTesting.TestCategoryAttribute("release_2012.1.0")]
        [Microsoft.VisualStudio.TestTools.UnitTesting.TestCategoryAttribute("PB_DT13905_03")]
        [Microsoft.VisualStudio.TestTools.UnitTesting.TestCategoryAttribute("Draft")]
        public virtual void PB_DT13905_03AsAnEDCUserWhenIUpdateAUnitConversionFormulaToConvertLabDataInANon_StandardUnitToStandardValuesInAStandardUnitThenIShouldSeeTheStandardValueAndStandardUnitsInClinicalViews_()
        {
            TechTalk.SpecFlow.ScenarioInfo scenarioInfo = new TechTalk.SpecFlow.ScenarioInfo("PB_DT13905_03 As an EDC user, when I update a unit conversion formula to convert " +
                    "lab data in a non-standard unit to standard values in a standard unit, then I sh" +
                    "ould see the standard value and standard units in Clinical Views.", new string[] {
                        "release_2012.1.0",
                        "PB_DT13905_03",
                        "Draft"});
#line 152
this.ScenarioSetup(scenarioInfo);
#line 12
this.FeatureBackground();
#line 154
 testRunner.When("I navigate to \"Lab Administration\"");
#line 155
 testRunner.And("I navigate to \"Unit Conversions\"");
#line hidden
            TechTalk.SpecFlow.Table table11 = new TechTalk.SpecFlow.Table(new string[] {
                        "From",
                        "To",
                        "Analyte",
                        "A",
                        "B",
                        "C",
                        "D"});
            table11.AddRow(new string[] {
                        "10^9/L",
                        "%",
                        "",
                        "2",
                        "1",
                        "0",
                        "0"});
#line 156
 testRunner.And("I enter unit conversion data", ((string)(null)), table11);
#line hidden
            TechTalk.SpecFlow.Table table12 = new TechTalk.SpecFlow.Table(new string[] {
                        "Field",
                        "Data"});
            table12.AddRow(new string[] {
                        "Subject Initials",
                        "SUB"});
            table12.AddRow(new string[] {
                        "Subject Number",
                        "{RndNum<num1>(3)}"});
            table12.AddRow(new string[] {
                        "Age",
                        "20"});
            table12.AddRow(new string[] {
                        "Sex",
                        "MaleREGAQT"});
            table12.AddRow(new string[] {
                        "Pregancy Status",
                        "NoREGAQT"});
            table12.AddRow(new string[] {
                        "Subject Date",
                        "01 Feb 2011"});
#line 159
 testRunner.And("I create a Subject", ((string)(null)), table12);
#line 169
 testRunner.And("I select Form \"Hematology\"");
#line 170
 testRunner.And("I choose \"Local Lab DT13905\" from \"Lab\"");
#line hidden
            TechTalk.SpecFlow.Table table13 = new TechTalk.SpecFlow.Table(new string[] {
                        "Field",
                        "Data",
                        "Unit"});
            table13.AddRow(new string[] {
                        "WBC",
                        "1",
                        "10^9/L"});
#line 171
 testRunner.And("I enter data in CRF and save", ((string)(null)), table13);
#line 176
 testRunner.And("I navigate to \"Home\"");
#line 177
 testRunner.And("I navigate to \"Reporter\"");
#line 178
 testRunner.And("I select Report \"Data Listing\"");
#line hidden
            TechTalk.SpecFlow.Table table14 = new TechTalk.SpecFlow.Table(new string[] {
                        "Name",
                        "Environment"});
            table14.AddRow(new string[] {
                        "Mediflex_SJ",
                        "Prod"});
#line 179
 testRunner.And("I set report parameter \"Study\" with table", ((string)(null)), table14);
#line 182
 testRunner.And("I click button \"Submit Report\"");
#line 183
 testRunner.And("I switch to \"DataListingsReport\" window");
#line 184
 testRunner.And("I choose \"Clinical Views\" from \"Data Source\"");
#line 185
 testRunner.And("I choose \"AnalytesView\" from \"Form\"");
#line 186
 testRunner.And("I click button \"Run\"");
#line hidden
            TechTalk.SpecFlow.Table table15 = new TechTalk.SpecFlow.Table(new string[] {
                        "Subject",
                        "FormName",
                        "AnalyteName",
                        "AnalyteValue",
                        "LabUnits",
                        "StdValue",
                        "StdUnits"});
            table15.AddRow(new string[] {
                        "SUB{Var(num1)}",
                        "Hematology",
                        "WBC",
                        "10",
                        "10^9/L",
                        "20",
                        "%"});
#line 188
 testRunner.Then("I should verify row(s) exist in \"Result\" table", ((string)(null)), table15);
#line 193
 testRunner.And("I select \"Home\"");
#line 194
 testRunner.And("I navigate to \"Lab Administration\"");
#line hidden
            TechTalk.SpecFlow.Table table16 = new TechTalk.SpecFlow.Table(new string[] {
                        "From",
                        "To",
                        "Analyte",
                        "A",
                        "B",
                        "C",
                        "D"});
            table16.AddRow(new string[] {
                        "10^9/L",
                        "%",
                        "",
                        "3",
                        "1",
                        "0",
                        "0"});
#line 195
 testRunner.And("I navigate to \"Unit Conversions\"", ((string)(null)), table16);
#line 201
 testRunner.And("I navigate to \"Home\"");
#line 202
 testRunner.And("I navigate to \"Reporter\"");
#line 203
 testRunner.And("I select Report \"Data Listing\"");
#line hidden
            TechTalk.SpecFlow.Table table17 = new TechTalk.SpecFlow.Table(new string[] {
                        "Name",
                        "Environment"});
            table17.AddRow(new string[] {
                        "Mediflex_SJ",
                        "Prod"});
#line 204
 testRunner.And("I set report parameter \"Study\" with table", ((string)(null)), table17);
#line 207
 testRunner.And("I click button \"Submit Report\"");
#line 208
 testRunner.And("I switch to \"DataListingsReport\" window");
#line 209
 testRunner.And("I choose \"Clinical Views\" from \"Data Source\"");
#line 210
 testRunner.And("I choose \"AnalytesView\" from \"Form\"");
#line 211
 testRunner.And("I click button \"Run\"");
#line hidden
            TechTalk.SpecFlow.Table table18 = new TechTalk.SpecFlow.Table(new string[] {
                        "Subject",
                        "FormName",
                        "AnalyteName",
                        "AnalyteValue",
                        "LabUnits",
                        "StdValue",
                        "StdUnits"});
            table18.AddRow(new string[] {
                        "SUB{Var(num1)}",
                        "Hematology",
                        "WBC",
                        "10",
                        "10^9/L",
                        "30",
                        "%"});
#line 213
 testRunner.Then("I should verify row(s) exist in \"Result\" table", ((string)(null)), table18);
#line hidden
            this.ScenarioCleanup();
        }
        
        [Microsoft.VisualStudio.TestTools.UnitTesting.TestMethodAttribute()]
        [Microsoft.VisualStudio.TestTools.UnitTesting.DescriptionAttribute("PB_DT13905_04 As an EDC user, when I update a unit conversion formula to convert " +
            "lab data in a non-standard unit to standard values in a standard unit for a spec" +
            "ific analyte, then I should see the standard value and standard units in Clinica" +
            "l Views.")]
        [Microsoft.VisualStudio.TestTools.UnitTesting.TestPropertyAttribute("FeatureTitle", "DT 13905 NeedsCVRefresh is not set to On for all datapoints related when Lab Unit" +
            " Conversion is created or updated")]
        [Microsoft.VisualStudio.TestTools.UnitTesting.TestCategoryAttribute("release_2012.1.0")]
        [Microsoft.VisualStudio.TestTools.UnitTesting.TestCategoryAttribute("PB_DT13905_04")]
        [Microsoft.VisualStudio.TestTools.UnitTesting.TestCategoryAttribute("Draft")]
        public virtual void PB_DT13905_04AsAnEDCUserWhenIUpdateAUnitConversionFormulaToConvertLabDataInANon_StandardUnitToStandardValuesInAStandardUnitForASpecificAnalyteThenIShouldSeeTheStandardValueAndStandardUnitsInClinicalViews_()
        {
            TechTalk.SpecFlow.ScenarioInfo scenarioInfo = new TechTalk.SpecFlow.ScenarioInfo("PB_DT13905_04 As an EDC user, when I update a unit conversion formula to convert " +
                    "lab data in a non-standard unit to standard values in a standard unit for a spec" +
                    "ific analyte, then I should see the standard value and standard units in Clinica" +
                    "l Views.", new string[] {
                        "release_2012.1.0",
                        "PB_DT13905_04",
                        "Draft"});
#line 221
this.ScenarioSetup(scenarioInfo);
#line 12
this.FeatureBackground();
#line 222
 testRunner.When("I navigate to \"Lab Administration\"");
#line 223
 testRunner.And("I navigate to \"Unit Conversions\"");
#line 224
 testRunner.And("I enter unit conversion data");
#line hidden
            TechTalk.SpecFlow.Table table19 = new TechTalk.SpecFlow.Table(new string[] {
                        "From",
                        "To",
                        "Analyte",
                        "A",
                        "B",
                        "C",
                        "D"});
            table19.AddRow(new string[] {
                        "10^9/L",
                        "%",
                        "WBC",
                        "3",
                        "1",
                        "0",
                        "0"});
#line 225
 testRunner.And("I enter unit conversion data", ((string)(null)), table19);
#line hidden
            TechTalk.SpecFlow.Table table20 = new TechTalk.SpecFlow.Table(new string[] {
                        "Field",
                        "Data"});
            table20.AddRow(new string[] {
                        "Subject Initials",
                        "SUB"});
            table20.AddRow(new string[] {
                        "Subject Number",
                        "{RndNum<num1>(3)}"});
            table20.AddRow(new string[] {
                        "Age",
                        "20"});
            table20.AddRow(new string[] {
                        "Sex",
                        "MaleREGAQT"});
            table20.AddRow(new string[] {
                        "Pregancy Status",
                        "NoREGAQT"});
            table20.AddRow(new string[] {
                        "Subject Date",
                        "01 Feb 2011"});
#line 230
 testRunner.And("I create a Subject", ((string)(null)), table20);
#line 240
 testRunner.And("I select Form \"Hematology\"");
#line 241
 testRunner.And("I choose \"Local Lab DT13905\" from \"Lab\"");
#line hidden
            TechTalk.SpecFlow.Table table21 = new TechTalk.SpecFlow.Table(new string[] {
                        "Field",
                        "Data",
                        "Unit"});
            table21.AddRow(new string[] {
                        "WBC",
                        "1",
                        "10^9/L"});
#line 242
 testRunner.And("I enter data in CRF and save", ((string)(null)), table21);
#line 247
 testRunner.And("I navigate to \"Home\"");
#line 248
 testRunner.And("I navigate to \"Reporter\"");
#line 249
 testRunner.And("I select Report \"Data Listing\"");
#line hidden
            TechTalk.SpecFlow.Table table22 = new TechTalk.SpecFlow.Table(new string[] {
                        "Name",
                        "Environment"});
            table22.AddRow(new string[] {
                        "Mediflex_SJ",
                        "Prod"});
#line 250
 testRunner.And("I set report parameter \"Study\" with table", ((string)(null)), table22);
#line 253
 testRunner.And("I click button \"Submit Report\"");
#line 254
 testRunner.And("I switch to \"DataListingsReport\" window");
#line 255
 testRunner.And("I choose \"Clinical Views\" from \"Data Source\"");
#line 256
 testRunner.And("I choose \"AnalytesView\" from \"Form\"");
#line 257
 testRunner.And("I click button \"Run\"");
#line hidden
            TechTalk.SpecFlow.Table table23 = new TechTalk.SpecFlow.Table(new string[] {
                        "Subject",
                        "FormName",
                        "AnalyteName",
                        "AnalyteValue",
                        "LabUnits",
                        "StdValue",
                        "StdUnits"});
            table23.AddRow(new string[] {
                        "SUB{Var(num1)}",
                        "Hematology",
                        "WBC",
                        "10",
                        "10^9/L",
                        "30",
                        "%"});
#line 259
 testRunner.Then("I should verify row(s) exist in \"Result\" table", ((string)(null)), table23);
#line 264
 testRunner.And("I select \"Home\"");
#line 265
 testRunner.And("I navigate to \"Lab Administration\"");
#line 266
 testRunner.And("I navigate to \"Unit Conversions\"");
#line hidden
            TechTalk.SpecFlow.Table table24 = new TechTalk.SpecFlow.Table(new string[] {
                        "From",
                        "To",
                        "Analyte",
                        "A",
                        "B",
                        "C",
                        "D"});
            table24.AddRow(new string[] {
                        "10^9/L",
                        "%",
                        "",
                        "5",
                        "1",
                        "0",
                        "0"});
#line 267
 testRunner.And("I add new unit conversion data", ((string)(null)), table24);
#line 272
 testRunner.And("I navigate to \"Home\"");
#line 273
 testRunner.And("I navigate to \"Reporter\"");
#line 274
 testRunner.And("I select Report \"Data Listing\"");
#line hidden
            TechTalk.SpecFlow.Table table25 = new TechTalk.SpecFlow.Table(new string[] {
                        "Name",
                        "Environment"});
            table25.AddRow(new string[] {
                        "Mediflex_SJ",
                        "Prod"});
#line 275
 testRunner.And("I set report parameter \"Study\" with table", ((string)(null)), table25);
#line 278
 testRunner.And("I click button \"Submit Report\"");
#line 279
 testRunner.And("I switch to \"DataListingsReport\" window");
#line 280
 testRunner.And("I choose \"Clinical Views\" from \"Data Source\"");
#line 281
 testRunner.And("I choose \"AnalytesView\" from \"Form\"");
#line 282
 testRunner.And("I click button \"Run\"");
#line hidden
            TechTalk.SpecFlow.Table table26 = new TechTalk.SpecFlow.Table(new string[] {
                        "Subject",
                        "FormName",
                        "AnalyteName",
                        "AnalyteValue",
                        "LabUnits",
                        "StdValue",
                        "StdUnits"});
            table26.AddRow(new string[] {
                        "SUB{Var(num1)}",
                        "Hematology",
                        "WBC",
                        "10",
                        "10^9/L",
                        "50",
                        "%"});
#line 284
 testRunner.Then("I should verify row(s) exist in \"Result\" table", ((string)(null)), table26);
#line hidden
            this.ScenarioCleanup();
        }
    }
}
#pragma warning restore
#endregion
