@FT_MCC-46642

Feature: MCC-46642 As a TSDV user when custom tiers are only linked to any Aux (Dev) study, 
TSDV Configuration Report shows as being linked to Dev study.

Background:

	Given TSDV is enabled
	Given I perform cache flush of "Medidata.Core.Objects.Configuration"
	Given xml draft "MCC-46642A.xml" is Uploaded with Environments
		| Name |
		| Dev  |
	Given xml draft "MCC-46642B.xml" is Uploaded with Environments
		| Name |
		| Prod |
	Given xml draft "MCC-46642C.xml" is Uploaded with Environments
		| Name |
		| Dev  |
		| Prod |
	Given xml draft "MCC-46642D.xml" is Uploaded with Environments
		| Name |
		| Dev  |
	Given xml draft "MCC-46642E.xml" is Uploaded with Environments
		| Name |
		| Dev  |

	Given study "MCC-46642A" is assigned to Site "Site 001" with study environment "Aux: Dev"
	Given study "MCC-46642B" is assigned to Site "Site 002" with study environment "Live: Prod"
	Given study "MCC-46642C" is assigned to Site "Site 003A" with study environment "Aux: Dev"
	Given study "MCC-46642C" is assigned to Site "Site 003B" with study environment "Live: Prod"
	Given study "MCC-46642D" is assigned to Site "Site 004" with study environment "Aux: Dev"
	Given study "MCC-46642E" is assigned to Site "Site 005" with study environment "Aux: Dev"

	Given I publish and push eCRF "MCC-46642A.xml" to "Version 1" with study environment "Dev"
	Given I publish and push eCRF "MCC-46642B.xml" to "Version 1" with study environment "Prod"
	Given I publish and push eCRF "MCC-46642C.xml" to "Version 1" with study environment "Prod"
	Given I publish and push eCRF "MCC-46642C.xml" to "Version 1" with study environment "Dev"
	Given I publish and push eCRF "MCC-46642D.xml" to "Version 1" with study environment "Dev"
	Given I publish and push eCRF "MCC-46642E.xml" to "Version 1" with study environment "Dev"

	And following Project assignments exist
	| User         | Project    | Environment | Role         | Site      | SecurityRole          |
	| SUPER USER 1 | MCC-46642A | Aux: Dev    | SUPER ROLE 1 | Site 001  | Project Admin Default |
	| SUPER USER 1 | MCC-46642B | Live: Prod  | SUPER ROLE 1 | Site 002  | Project Admin Default |
	| SUPER USER 1 | MCC-46642C | Aux: Dev    | SUPER ROLE 1 | Site 003A | Project Admin Default |
	| SUPER USER 1 | MCC-46642C | Live: Prod  | SUPER ROLE 1 | Site 003B | Project Admin Default |
	| SUPER USER 1 | MCC-46642D | Aux: Dev    | SUPER ROLE 1 | Site 004  | Project Admin Default |
	| SUPER USER 1 | MCC-46642E | Aux: Dev    | SUPER ROLE 1 | Site 005  | Project Admin Default |
	
	Given following Report assignments exist
	| User         | Report                                                             |
	| SUPER USER 1 | Targeted SDV Configuration - Targeted SDV Configuration            |
	| SUPER USER 1 | Targeted SDV Configuration Report - Targeted SDV Configuration Rep |


@Release_2013.4.0
@PBMCC-46642-001
@SJ08.AUG.2013
@Validation	

Scenario: MCC46642-001 When a custom tier is only linked to an Aux (Dev) study,TSDV Configuration Report shows as being linked to Dev study

	Given I login to Rave with user "SUPER USER 1"
	And I navigate to "Reporter"
	And I select Report "Targeted SDV Configuration"
	And I set report parameter "Study" with table
		| Name       | Environment |
		| MCC-46642A | Dev         |
	And I click button "Submit Report"
	And I switch to "Targeted SDV Study Plan" window
	And I create a new block plan named "MCC46648A Block Plan" with Data entry Role "SUPER ROLE 1"
	And I select link "Tiers"
	And I create a custom tier named "Custom Tier 001" and description "Custom Tier 001" with table
		| Form               | Selected |
		| Form 1 (MX)        | True     |
		| Form 2 (SCENARIO1) | True     |
	And I take a screenshot
	And I select link "Study Block Plan"
	And I edit Blocks 
		| Name              | Subject Count |
		| Architect Defined | 2             |            
	And I select the tier "Custom Tier 001" and Subject Count "1"
	And I activate the plan
	And I take a screenshot
	And I switch to "Reports" window
	And I navigate to "Home"
	And I navigate to "Reporter"
	And I select Report "Targeted SDV Configuration Report"
	And I set report parameter "Study" with table
		| Name       | Environment |
		| MCC-46642A | Dev         |
	And I click the "Submit Report" button to download
	Then I verify "CustomTiers" spreadsheet data
		| Tier Name       | Tier Description | Linked To Prod Study |
		| Custom Tier 001 | Custom Tier 001  | No                   |
	And I take a screenshot




@Release_2013.4.0
@PBMCC-46642-002
@SJ08.AUG.2013
@Validation	

Scenario: MCC46642-002 When a custom tier is only linked to a Prod study,TSDV Configuration Report shows as being linked to Prod study

	Given I login to Rave with user "SUPER USER 1"
	And I navigate to "Reporter"
	And I select Report "Targeted SDV Configuration"
	And I set report parameter "Study" with table
		| Name       | Environment |
		| MCC-46642B | Prod        |
	And I click button "Submit Report"
	And I switch to "Targeted SDV Study Plan" window
	And I create a new block plan named "MCC46648B Block Plan" with Data entry Role "SUPER ROLE 1"
	And I select link "Tiers"
	And I create a custom tier named "Custom Tier 002" and description "Custom Tier 002" with table
		| Form               | Selected |
		| Form 1 (MX)        | True     |
		| Form 2 (SCENARIO1) | True     |
	And I take a screenshot
	And I select link "Study Block Plan"
	And I edit Blocks 
		| Name              | Subject Count |
		| Architect Defined | 2             |            
	And I select the tier "Custom Tier 002" and Subject Count "1"
	And I activate the plan
	And I take a screenshot
	And I switch to "Reports" window
	And I navigate to "Home"
	And I navigate to "Reporter"
	And I select Report "Targeted SDV Configuration Report"
	And I set report parameter "Study" with table
		| Name       | Environment |
		| MCC-46642B | Prod        |
	And I click the "Submit Report" button to download
	Then I verify "CustomTiers" spreadsheet data
		| Tier Name       | Tier Description | Linked To Prod Study |
		| Custom Tier 002 | Custom Tier 002  | Yes                  |
	And I take a screenshot


@Release_2013.4.0
@PBMCC-46642-003
@SJ08.AUG.2013
@Validation	

Scenario: MCC46642-003 When a custom tier is linked to a Prod and an Aux (Dev) study,TSDV Configuration Report shows as being linked to Prod study


	Given I login to Rave with user "SUPER USER 1"
	And I navigate to "Reporter"
	And I select Report "Targeted SDV Configuration"
	And I set report parameter "Study" with table
		| Name       | Environment |
		| MCC-46642C | Prod        |
	And I click button "Submit Report"
	And I switch to "Targeted SDV Study Plan" window
	And I create a new block plan named "MCC46648C Block Plan" with Data entry Role "SUPER ROLE 1"
	And I select link "Tiers"
	And I create a custom tier named "Custom Tier 003Prod" and description "Custom Tier 003Prod" with table
		| Form               | Selected |
		| Form 1 (MX)        | True     |
		| Form 2 (SCENARIO1) | True     |
	And I take a screenshot
	And I select link "Study Block Plan"
	And I edit Blocks 
		| Name              | Subject Count |
		| Architect Defined | 2             |            
	And I select the tier "Custom Tier 003Prod" and Subject Count "1"
	And I activate the plan
	And I take a screenshot
	And I switch to "Reports" window
	And I navigate to "Home"
	And I navigate to "Reporter"
	And I select Report "Targeted SDV Configuration"
	And I set report parameter "Study" with table
		| Name       | Environment |
		| MCC-46642C | Dev         |
	And I click button "Submit Report"
	And I switch to "Targeted SDV Study Plan" window
	And I create a new block plan named "MCC46648C Block Plan" with Data entry Role "SUPER ROLE 1"
	And I edit Blocks 
		| Name              | Subject Count |
		| Architect Defined | 2             |            
	And I select the tier "Custom Tier 003Prod" and Subject Count "1"
	And I activate the plan
	And I take a screenshot
	And I switch to "Reports" window
	And I navigate to "Home"
	And I navigate to "Reporter"
	And I select Report "Targeted SDV Configuration Report"
	And I set report parameter "Study" with table
		| Name       | Environment |
		| MCC-46642C | Dev         |
	And I click the "Submit Report" button to download
	Then I verify "CustomTiers" spreadsheet data
		| Tier Name           | Tier Description    | Linked To Prod Study |
		| Custom Tier 003Prod | Custom Tier 003Prod | Yes                  |
	And I take a screenshot



@Release_2013.4.0
@PBMCC-46642-004
@SJ08.AUG.2013
@Validation	

Scenario: MCC46642-004 When a custom tier is only linked to an Aux (Dev) study in a Site Group level,TSDV Configuration Report shows as being linked to Dev study


	Given I login to Rave with user "SUPER USER 1"
	And I navigate to "Reporter"
	And I select Report "Targeted SDV Configuration"
	And I set report parameter "Study" with table
		| Name       | Environment |
		| MCC-46642D | Dev         |
	And I click button "Submit Report"
	And I switch to "Targeted SDV Study Plan" window
	And I create a new block plan named "MCC46648D Block Plan" with Data entry Role "SUPER ROLE 1"
	And I select link "Tiers"
	And I create a custom tier named "Custom Tier 004" and description "Custom Tier 004" with table
		| Form               | Selected |
		| Form 1 (MX)        | True     |
		| Form 2 (SCENARIO1) | True     |
	And I take a screenshot
	And I select link "Study Block Plan"
	And I select link "World"
	And I create a new block plan named "MCC46648D Block Plan" with Data entry Role "SUPER ROLE 1"
	And I edit Blocks 
		| Name              | Subject Count |
		| Architect Defined | 2             |            
	And I select the tier "Custom Tier 004" and Subject Count "1"
	And I activate the plan
	And I take a screenshot
	And I switch to "Reports" window
	And I navigate to "Home"
	And I navigate to "Reporter"
	And I select Report "Targeted SDV Configuration Report"
	And I set report parameter "Study" with table
		| Name       | Environment |
		| MCC-46642D | Dev         |
	And I click the "Submit Report" button to download
	Then I verify "CustomTiers" spreadsheet data
		| Tier Name       | Tier Description | Linked To Prod Study |
		| Custom Tier 004 | Custom Tier 004  | No                   |
	And I take a screenshot



@Release_2013.4.0
@PBMCC-46642-005
@SJ08.AUG.2013
@Validation	

Scenario: MCC46642-005 When a custom tier is only linked to an Aux (Dev) study in a Site level,TSDV Configuration Report shows as being linked to Dev study


	Given I login to Rave with user "SUPER USER 1"
	And I navigate to "Reporter"
	And I select Report "Targeted SDV Configuration"
	And I set report parameter "Study" with table
		| Name       | Environment |
		| MCC-46642E | Dev         |
	And I click button "Submit Report"
	And I switch to "Targeted SDV Study Plan" window
	And I create a new block plan named "MCC46648E Block Plan" with Data entry Role "SUPER ROLE 1"
	And I select link "Tiers"
	And I create a custom tier named "Custom Tier 005" and description "Custom Tier 005" with table
		| Form               | Selected |
		| Form 1 (MX)        | True     |
		| Form 2 (SCENARIO1) | True     |
	And I take a screenshot
	And I select link "Study Block Plan"
	And I select link "World"
	And I create a new block plan named "MCC46648E Block Plan" with Data entry Role "SUPER ROLE 1"
	And I select Site link "Site 005"
	And I create a new block plan named "MCC46648E Block Plan" with Data entry Role "SUPER ROLE 1"
	And I edit Blocks 
		| Name              | Subject Count |
		| Architect Defined | 2             |            
	And I select the tier "Custom Tier 005" and Subject Count "1"
	And I activate the plan
	And I take a screenshot
	And I switch to "Reports" window
	And I navigate to "Home"
	And I navigate to "Reporter"
	And I select Report "Targeted SDV Configuration Report"
	And I set report parameter "Study" with table
		| Name       | Environment |
		| MCC-46642E | Dev         |
	And I click the "Submit Report" button to download
	Then I verify "CustomTiers" spreadsheet data
		| Tier Name       | Tier Description | Linked To Prod Study |
		| Custom Tier 005 | Custom Tier 005  | No                   |
	And I take a screenshot


