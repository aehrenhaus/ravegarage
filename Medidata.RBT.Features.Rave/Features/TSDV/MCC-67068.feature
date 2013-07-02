@FT_MCC-67068


Feature: MCC-67068 Run Retrospective will affect fields if the field exists in multiple forms included in Custom Tier in TSDV


Background:

	Given TSDV is enabled
	Given I perform cache flush of "Medidata.Core.Objects.Configuration"
	Given study "MCC-67068A" is assigned to Site "Site 1" with study environment "Live: Prod"
	Given study "MCC-67068B" is assigned to Site "Site 2" with study environment "Live: Prod"
	Given following Project assignments exist
	| User         | Project    | Environment | Role         | Site   | SecurityRole          |
	| SUPER USER 1 | MCC-67068A | Live: Prod  | SUPER ROLE 1 | Site 1 | Project Admin Default |
	| SUPER USER 1 | MCC-67068B | Live: Prod  | SUPER ROLE 1 | Site 2 | Project Admin Default | 
	Given I publish and push eCRF "MCC-67068A.xml" to "Version 1"
	Given I publish and push eCRF "MCC-67068B.xml" to "Version 2"
	Given following Report assignments exist
	| User         | Report                                                  |
	| SUPER USER 1 | Targeted SDV Configuration - Targeted SDV Configuration |
	
	


@release_2013.2.0 
@PB_MCC-67068_01
@SJ02.JUL.2013
@Validation
Scenario: PB_MCC-67068_01 When a TSDV user select 4 forms in a custom tier then 2 forms are unselected and Run Retrospective will affect fields if fields exist in multiple forms 


	Given I login to Rave with user "SUPER USER 1"
	And I navigate to "Reporter"
	And I select Report "Targeted SDV Configuration"
	And I set report parameter "Study" with table
		| Name       | Environment |
		| MCC-67068A | Prod        |
	And I click button "Submit Report"
	And I switch to "Targeted SDV Study Plan" window
	And I create a new block plan named "MCC-67068A Block Plan" with Data entry Role "SUPER ROLE 1"
	And I delete the tier "Architect Defined" from plan 
	And I select link "Tiers"
	And I create a custom tier named "Custom Tier 1" and description "Custom Tier 1" with table
		| Form               | Selected |
		| Form 1 (MX)        | True     |
		| Form 2 (SCENARIO1) | True     |
		| Form 3 (FRM3)      | True     |
		| Form 4 (FRM4)      | True     |
	And I take a screenshot
	And I select link "Study Block Plan"
	And I select the tier "Custom Tier 1" and Subject Count "1"
	And I activate the plan
	And I take a screenshot
	And I switch to "Reports" window
	And I navigate to "Home"
	And I select Study "MCC-67068A" and Site "Site 1"
	And I create a Subject
		| Field            | Data              |
		| Subject Initials | SUB               |
		| Subject Number   | {RndNum<num1>(4)} |
	And I select link "Form 1"
    And I enter data in CRF and save
   		| Field       | Data        | Control Type |
   		| Standard 1  | 1           | textbox      |
   		| Log Field 1 | 2           | textbox      |
   		| Log Field 2 | 3           | textbox      |
   		| Date Time   | 01 Jan 2013 | datetime     |
	And I select link "2"
	And I verify data on Fields in CRF
		| Field       | Data        | Requires Verification |
		| Standard 1  | 1           | True                  |
		| Log Field 1 | 2           | True                  |
		| Log Field 2 | 3           | True                  |
		| Date Time   | 01 Jan 2013 | True                  |
   	And I take a screenshot
   	And I select link "Form 2"
    And I enter data in CRF and save
   		| Field      		 | Data | Control Type |
   		| Standard 1 		 | 1   	| textbox      |
   		| Age Is Less than 18| 16  	| textbox      |
   		| Age Null 			 | 3   	| textbox      |
	And I verify data on Fields in CRF
		| Field               | Data | Requires Verification |
		| Standard 1          | 1    | True                  |
		| Age Is Less than 18 | 16   | True                  |
		| Age Null            | 3    | True                  |
   	And I take a screenshot
   	And I select link "Form 3"
    And I enter data in CRF and save
   		| Field      		 | Data | Control Type |
   		| Standard 1 		 | 1   	| textbox      |
	And I verify data on Fields in CRF
		| Field      | Data | Requires Verification |
		| Standard 1 | 1    | True                  |
   	And I take a screenshot
   	And I select link "Form 4"
    And I enter data in CRF and save
   		| Field      | Data | Control Type |
   		| Standard 1 | 1    | textbox      |
	And I verify data on Fields in CRF
		| Field      | Data | Requires Verification |
		| Standard 1 | 1    | True                  |
   	And I take a screenshot
  	And I navigate to "Home"
  	And I navigate to "Reporter"
	And I select Report "Targeted SDV Configuration"
	And I set report parameter "Study" with table
		| Name       | Environment |
		| MCC-67068A | Prod        |
	And I click button "Submit Report"
	And I switch to "Targeted SDV Study Plan" window
	And I select link "Tiers"
	And I select link "Create New Draft"
	And I select link "Custom Tier 1 (Draft)"
	And I select link "Selected Form and Fields"
	And I select fields in Custom Tier 
		| Form         | Field      | Selected |
		| Form 1 (MX)  | Standard 1 | False    |
	And I select link "Selected Form and Fields"
	And I select fields in Custom Tier 
		| Form         | Field      | Selected |
		| Form 1 (MX)  | Log Field 1| False    |
	And I select link "Selected Form and Fields"
	And I select fields in Custom Tier 
		| Form         | Field      | Selected |
		| Form 1 (MX)  | Log Field 2| False    |
	And I select link "Selected Form and Fields"
	And I select fields in Custom Tier
		| Form        | Field    | Selected |
		| Form 1 (MX) | DATETIME | False    |
	And I select link "Selected Form and Fields"
	And I select fields in Custom Tier 
		| Form          | Field      | Selected |
		| Form 4 (FRM4) | Standard 1 | False    |
	And I take a screenshot
	And I click button "Publish Draft"
	And I select button "Publish Draft" with check "Run Retrospective"
	And I take a screenshot
	And I switch to "Reports" window
	And I navigate to "Home"
	And I select Study "MCC-67068A" and Site "Site 1"
	And I select a Subject "{Var(num1)}"
	And I select link "Form 1"
	And I select link "2"
	And I verify data on Fields in CRF
		| Field       | Data        | Requires Verification |
		| Standard 1  | 1           | False                 |
		| Log Field 1 | 2           | False                 |
		| Log Field 2 | 3           | False                 |
		| Date Time   | 01 Jan 2013 | False                 |
   	And I take a screenshot
   	And I select link "Form 2"
	And I verify data on Fields in CRF
		| Field               | Data | Requires Verification |
		| Standard 1          | 1    | True                  |
		| Age Is Less than 18 | 16   | True                  |
		| Age Null            | 3    | True                  |  
   	And I take a screenshot
	And I select link "Form 3"
	And I verify data on Fields in CRF
		| Field      | Data | Requires Verification |
		| Standard 1 | 1    | True                  | 
   	And I take a screenshot
	And I select link "Form 4"
	And I verify data on Fields in CRF
		| Field      | Data | Requires Verification |
		| Standard 1 | 1    | False                 |
   	And I take a screenshot



@release_2013.2.0 
@PB_MCC-67068_02
@SJ02.JUL.2013
@Validation
Scenario: PB_MCC-67068_02 When a TSDV user select 4 forms in a custom tier then all 4 forms are unselected and Run Retrospective will affect fields if fields exist in multiple forms 



	Given I login to Rave with user "SUPER USER 1"
	And I navigate to "Reporter"
	And I select Report "Targeted SDV Configuration"
	And I set report parameter "Study" with table
		| Name       | Environment |
		| MCC-67068B | Prod        |
	And I click button "Submit Report"
	And I switch to "Targeted SDV Study Plan" window
	And I create a new block plan named "MCC-67068B Block Plan" with Data entry Role "SUPER ROLE 1"
	And I delete the tier "Architect Defined" from plan 
	And I select link "Tiers"
	And I create a custom tier named "Custom Tier 1" and description "Custom Tier 1" with table
		| Form               | Selected |
		| Form 1 (MX)        | True     |
		| Form 2 (SCENARIO1) | True     |
		| Form 3 (FRM3)      | True     |
		| Form 4 (FRM4)      | True     |
	And I take a screenshot
	And I select link "Study Block Plan"
	And I select the tier "Custom Tier 1" and Subject Count "1"
	And I activate the plan
	And I take a screenshot
	And I switch to "Reports" window
	And I navigate to "Home"
	And I select Study "MCC-67068B" and Site "Site 2"
	And I create a Subject
		| Field            | Data              |
		| Subject Initials | SUB               |
		| Subject Number   | {RndNum<num2>(4)} |
	And I select link "Form 1"
    And I enter data in CRF and save
   		| Field       | Data        | Control Type |
   		| Standard 1  | 1           | textbox      |
   		| Log Field 1 | 2           | textbox      |
   		| Log Field 2 | 3           | textbox      |
   		| Date Time   | 01 Jan 2013 | datetime     |
	And I select link "2"
	And I verify data on Fields in CRF
		| Field       | Data        | Requires Verification |
		| Standard 1  | 1           | True                  |
		| Log Field 1 | 2           | True                  |
		| Log Field 2 | 3           | True                  |
		| Date Time   | 01 Jan 2013 | True                  |
   	And I take a screenshot
   	And I select link "Form 2"
    And I enter data in CRF and save
   		| Field      		 | Data | Control Type |
   		| Standard 1 		 | 1   	| textbox      |
   		| Age Is Less than 18| 16  	| textbox      |
   		| Age Null 			 | 3   	| textbox      |
	And I verify data on Fields in CRF
		| Field               | Data | Requires Verification |
		| Standard 1          | 1    | True                  |
		| Age Is Less than 18 | 16   | True                  |
		| Age Null            | 3    | True                  |
   	And I take a screenshot
   	And I select link "Form 3"
    And I enter data in CRF and save
   		| Field      		 | Data | Control Type |
   		| Standard 1 		 | 1   	| textbox      |
	And I verify data on Fields in CRF
		| Field      | Data | Requires Verification |
		| Standard 1 | 1    | True                  |
   	And I take a screenshot
   	And I select link "Form 4"
    And I enter data in CRF and save
   		| Field      | Data | Control Type |
   		| Standard 1 | 1    | textbox      |
	And I verify data on Fields in CRF
		| Field      | Data | Requires Verification |
		| Standard 1 | 1    | True                  |
   	And I take a screenshot
  	And I navigate to "Home"
  	And I navigate to "Reporter"
	And I select Report "Targeted SDV Configuration"
	And I set report parameter "Study" with table
		| Name       | Environment |
		| MCC-67068B | Prod        |
	And I click button "Submit Report"
	And I switch to "Targeted SDV Study Plan" window
	And I select link "Tiers"
	And I select link "Create New Draft"
	And I select link "Custom Tier 1 (Draft)"
	And I select link "Selected Form and Fields"
	And I select fields in Custom Tier 
		| Form         | Field      | Selected |
		| Form 1 (MX)  | Standard 1 | False    |
	And I select link "Selected Form and Fields"
	And I select fields in Custom Tier 
		| Form         | Field      | Selected |
		| Form 1 (MX)  | Log Field 1| False    |
	And I select link "Selected Form and Fields"
	And I select fields in Custom Tier 
		| Form         | Field      | Selected |
		| Form 1 (MX)  | Log Field 2| False    |
	And I select link "Selected Form and Fields"
	And I select fields in Custom Tier
		| Form        | Field    | Selected |
		| Form 1 (MX) | DATETIME | False    |
	And I select link "Selected Form and Fields"
	And I select fields in Custom Tier 
		| Form               | Field      | Selected |
		| Form 2 (SCENARIO1) | Standard 1 | False    |
	And I select link "Selected Form and Fields"
	And I select fields in Custom Tier 
		| Form               | Field | Selected |
		| Form 2 (SCENARIO1) | AGE18 | False    |
	And I select link "Selected Form and Fields"
	And I select fields in Custom Tier 
		| Form               | Field | Selected |
		| Form 2 (SCENARIO1) | AGEN  | False    |
	And I select link "Selected Form and Fields"
	And I select fields in Custom Tier 
		| Form          | Field      | Selected |
		| Form 3 (FRM3) | Standard 1 | False    |
	And I select link "Selected Form and Fields"
	And I select fields in Custom Tier 
		| Form          | Field      | Selected |
		| Form 4 (FRM4) | Standard 1 | False    |
	And I take a screenshot
	And I click button "Publish Draft"
	And I select button "Publish Draft" with check "Run Retrospective"
	And I take a screenshot
	And I switch to "Reports" window
	And I navigate to "Home"
	And I select Study "MCC-67068B" and Site "Site 2"
	And I select a Subject "{Var(num2)}"
	And I select link "Form 1"
	And I select link "2"
	And I verify data on Fields in CRF
		| Field       | Data        | Requires Verification |
		| Standard 1  | 1           | False                 |
		| Log Field 1 | 2           | False                 |
		| Log Field 2 | 3           | False                 |
		| Date Time   | 01 Jan 2013 | False                 |
   	And I take a screenshot
   	And I select link "Form 2"
	And I verify data on Fields in CRF
		| Field               | Data | Requires Verification |
		| Standard 1          | 1    | False                 |
		| Age Is Less than 18 | 16   | False                 |
		| Age Null            | 3    | False                 |  
   	And I take a screenshot
	And I select link "Form 3"
	And I verify data on Fields in CRF
		| Field      | Data | Requires Verification |
		| Standard 1 | 1    | False                 | 
   	And I take a screenshot
	And I select link "Form 4"
	And I verify data on Fields in CRF
		| Field      | Data | Requires Verification |
		| Standard 1 | 1    | False                 |
   	And I take a screenshot