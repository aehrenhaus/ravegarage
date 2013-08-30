@FT_MCC-70487

Feature: MCC-70487 when Subject Counts for multiple block plans are updated in any AUX (Dev) environments,
then subjects are allocated based on updated tier slots  (non-Prod env only)

Background:

	Given TSDV is enabled
	Given I perform cache flush of "Medidata.Core.Objects.Configuration"
	Given xml draft "MCC-70487A.xml" is Uploaded with Environment name "Dev"
	Given xml draft "MCC-70487B.xml" is Uploaded with Environment name "Dev"
	Given xml draft "MCC-70487C.xml" is Uploaded with Environment name "Dev"
	Given study "MCC-70487A" is assigned to Site "Site 1" with study environment "Aux: Dev"
	Given study "MCC-70487B" is assigned to Site "Site 1" with study environment "Aux: Dev"
	Given study "MCC-70487C" is assigned to Site "Site 1" with study environment "Aux: Dev"
	Given I publish and push eCRF "MCC-70487A.xml" to "Version 1" with study environment "Dev"
	Given I publish and push eCRF "MCC-70487B.xml" to "Version 2" with study environment "Dev"
	Given I publish and push eCRF "MCC-70487C.xml" to "Version 3" with study environment "Dev"
	Given following Project assignments exist
	| User         | Project    | Environment | Role         | Site   | SecurityRole          |
	| SUPER USER 1 | MCC-70487A | Aux: Dev    | SUPER ROLE 1 | Site 1 | Project Admin Default |
	| SUPER USER 2 | MCC-70487B | Aux: Dev    | SUPER ROLE 1 | Site 1 | Project Admin Default |
	| SUPER USER 3 | MCC-70487C | Aux: Dev    | SUPER ROLE 1 | Site 1 | Project Admin Default |
	Given following Report assignments exist
	| User         | Report                                                           |
	| SUPER USER 1 | Targeted SDV Configuration - Targeted SDV Configuration          |
	| SUPER USER 2 | Targeted SDV Configuration - Targeted SDV Configuration          |
	| SUPER USER 3 | Targeted SDV Configuration - Targeted SDV Configuration          |
	| SUPER USER 1 | Targeted SDV Subject Management - Targeted SDV Subject Managemen |
	| SUPER USER 2 | Targeted SDV Subject Management - Targeted SDV Subject Managemen |
	| SUPER USER 3 | Targeted SDV Subject Management - Targeted SDV Subject Managemen |
	


@Release_2013.4.0
@PB_MCC-70487-001
@SJ12.AUG.2013
@Validation


Scenario: MCC-70487-001 When Subject Counts for multiple block plans are updated,then subjects are allocated based on updated tier slots

	Given I login to Rave with user "SUPER USER 1"
	And I navigate to "Reporter"
	And I select Report "Targeted SDV Configuration"
	And I set report parameter "Study" with table
		| Name       | Environment |
		| MCC-70487A | Dev         |
	And I click button "Submit Report"
	And I switch to "Targeted SDV Study Plan" window
	And I create a new block plan named "MCC-70487A Dev Block Plan" with Data entry Role "SUPER ROLE 1"
	And I delete the tier "Architect Defined" from plan
	And I edit Blocks 
		| Name              | Subject Count |
		| Architect Defined | 6             |
	And I select the tier "No Forms" and Subject Count "2"
	And I select the tier "All Forms" and Subject Count "4"
	And I activate the plan
	And I take a screenshot
	And I switch to "Reports" window
	And I navigate to "Home"
	And I select Study "MCC-70487A" 
	And I create a Subject
		| Field            | Data              |
		| Subject Initials | SUB               |
		| Subject Number   | {RndNum<num1>(5)} |	
	And I take a screenshot
	And I navigate to "Home"
	And I select Study "MCC-70487A" 
	And I create a Subject
		| Field            | Data              |
		| Subject Initials | SUB               |
		| Subject Number   | {RndNum<num2>(5)} |
	And I take a screenshot
	And I navigate to "Home"
	And I navigate to "Reporter"
	And I select Report "Targeted SDV Configuration"
	And I set report parameter "Study" with table
		| Name       | Environment |
		| MCC-70487A | Dev         |
	And I click button "Submit Report"
	And I switch to "Targeted SDV Study Plan" window
	And I inactivate the plan
	And I edit Blocks 
		| Name              | Subject Count            |
		| Architect Defined | 2                        |
	And I edit Tiers	 
		| Block             | Tier					   | Subject Count |
		| Architect Defined | No Forms (Default Tier)  | 1             |
		| Architect Defined | All Forms (Default Tier) | 1             |
	And I create a new block and save
		| Name               | Subject Count | Repeated |
		| New Repeated Block | 3             | True     |
	And I select the tier "Architect Defined" and Subject Count "3" for "New Repeated Block"
	And I activate the plan
	And I take a screenshot
	And I switch to "Reports" window
	And I navigate to "Home"
	And I select Study "MCC-70487A" 
	And I create a Subject
		| Field            | Data              |
		| Subject Initials | SUB               |
		| Subject Number   | {RndNum<num3>(5)} |
	And I select primary record form
	And I click audit on form level
	And I select link "Subject - SUB{Var(num3)}"
	Then I verify last audit exist
		| Audit Type               | Query Message                    | User   | Time                 |
		| subject assigned to TSDV | Architect Defined (Default Tier) | System | dd MMM yyyy HH:mm:ss |		
	And I take a screenshot


@Release_2013.4.0
@PB_MCC-70487-002
@SJ12.AUG.2013
@Validation


Scenario: MCC-70487-002 When Subject Counts for multiple block plans are updated by reassigning tiers,then subjects are allocated based on updated tier slots

	Given I login to Rave with user "SUPER USER 2"
	And I navigate to "Reporter"
	And I select Report "Targeted SDV Configuration"
	And I set report parameter "Study" with table
		| Name       | Environment |
		| MCC-70487B | Dev         |
	And I click button "Submit Report"
	And I switch to "Targeted SDV Study Plan" window
	And I create a new block plan named "MCC-70487B Dev Block Plan" with Data entry Role "SUPER ROLE 1"
	And I delete the tier "Architect Defined" from plan
	And I edit Blocks 
		| Name              | Subject Count |
		| Architect Defined | 6             |
	And I select the tier "No Forms" and Subject Count "2"
	And I select the tier "All Forms" and Subject Count "4"
	And I activate the plan
	And I take a screenshot
	And I switch to "Reports" window
	And I navigate to "Home"
	And I select Study "MCC-70487B" 
	And I create a Subject
		| Field            | Data              |
		| Subject Initials | SUB               |
		| Subject Number   | {RndNum<num1>(5)} |	
	And I take a screenshot
	And I navigate to "Home"
	And I select Study "MCC-70487B" 
	And I create a Subject
		| Field            | Data              |
		| Subject Initials | SUB               |
		| Subject Number   | {RndNum<num2>(5)} |
	And I take a screenshot
	And I navigate to "Home"
	And I navigate to "Reporter"
	And I select Report "Targeted SDV Configuration"
	And I set report parameter "Study" with table
		| Name       | Environment |
		| MCC-70487B | Dev         |
	And I click button "Submit Report"
	And I switch to "Targeted SDV Study Plan" window
	And I inactivate the plan
	And I edit Blocks 
		| Name              | Subject Count |
		| Architect Defined | 2             |
	And I delete the tier "No Forms" from plan
	And I delete the tier "All Forms" from plan
	And I select the tier "No Forms" and Subject Count "1"
	And I select the tier "All Forms" and Subject Count "1"
	And I create a new block and save
		| Name               | Subject Count | Repeated |
		| New Repeated Block | 3             | True     |
	And I select the tier "Architect Defined" and Subject Count "3" for "New Repeated Block"
	And I activate the plan
	And I take a screenshot
	And I switch to "Reports" window
	And I navigate to "Home"
	And I select Study "MCC-70487B" 
	And I create a Subject
		| Field            | Data              |
		| Subject Initials | SUB               |
		| Subject Number   | {RndNum<num3>(5)} |
	And I select primary record form
	And I click audit on form level
	And I select link "Subject - SUB{Var(num3)}"
	Then I verify last audit exist
		| Audit Type               | Query Message                    | User   | Time                 |
		| subject assigned to TSDV | Architect Defined (Default Tier) | System | dd MMM yyyy HH:mm:ss |		
	And I take a screenshot



@Release_2013.4.0
@PB_MCC-70487-003
@SJ12.AUG.2013
@Validation


Scenario: MCC-70487-003 When Subject Counts for multiple block plans are updated and subjects are included in the block plan,then subjects are allocated based on updated tier slots 

	Given I login to Rave with user "SUPER USER 3"
	And I navigate to "Reporter"
	And I select Report "Targeted SDV Configuration"
	And I set report parameter "Study" with table
		| Name       | Environment |
		| MCC-70487C | Dev         |
	And I click button "Submit Report"
	And I switch to "Targeted SDV Study Plan" window
	And I create a new block plan named "MCC-70487C Dev Block Plan" with Data entry Role "SUPER ROLE 1"
	And I delete the tier "Architect Defined" from plan
	And I edit Blocks 
		| Name              | Subject Count |
		| Architect Defined | 6             |
	And I select the tier "No Forms" and Subject Count "2"
	And I select the tier "All Forms" and Subject Count "4"
	And I activate the plan
	And I take a screenshot
	And I switch to "Reports" window
	And I navigate to "Home"
	And I select Study "MCC-70487C" 
	And I create a Subject
		| Field            | Data              |
		| Subject Initials | SUB               |
		| Subject Number   | {RndNum<num1>(5)} |	
	And I take a screenshot
	And I navigate to "Home"
	And I select Study "MCC-70487C" 
	And I create a Subject
		| Field            | Data              |
		| Subject Initials | SUB               |
		| Subject Number   | {RndNum<num2>(5)} |
	And I take a screenshot
	And I navigate to "Home"
	And I navigate to "Reporter"
	And I select Report "Targeted SDV Configuration"
	And I set report parameter "Study" with table
		| Name       | Environment |
		| MCC-70487C | Dev         |
	And I click button "Submit Report"
	And I switch to "Targeted SDV Study Plan" window
	And I inactivate the plan
	And I edit Blocks 
		| Name              | Subject Count |
		| Architect Defined | 2             |
	And I edit Tiers 
		| Block				| Tier					   | Subject Count |
		| Architect Defined | No Forms (Default Tier)  | 1             |
		| Architect Defined | All Forms (Default Tier) | 1             |
	And I create a new block and save
		| Name               | Subject Count | Repeated |
		| New Repeated Block | 3             | True     |
	And I select the tier "Architect Defined" and Subject Count "3" for "New Repeated Block"
	And I take a screenshot
	And I switch to "Reports" window
	And I navigate to "Home"
	And I select Study "MCC-70487C" 
	And I create a Subject
		| Field            | Data              |
		| Subject Initials | SUB               |
		| Subject Number   | {RndNum<num3>(5)} |
	And I take a screenshot
	And I navigate to "Home"
	And I navigate to "Reporter"
	And I select Report "Targeted SDV Configuration"
	And I set report parameter "Study" with table
		| Name       | Environment |
		| MCC-70487C | Dev         |
	And I click button "Submit Report"
	And I switch to "Targeted SDV Study Plan" window
	And I activate the plan
	And I take a screenshot
	And I switch to "Reports" window
	And I navigate to "Home"
	And I navigate to "Reporter"
	And I select Report "Targeted SDV Subject Management"
	And I set report parameter "Study" with table
		| Name       | Environment |
		| MCC-70487C | Dev         |
	And I click button "Submit Report"
	And I switch to "Targeted SDV Subject Override" window 
	And I select link "Subject Include"
	And I take a screenshot
	And I include 1 subjects in TSDV
	And I take a screenshot
	And I select link "Subject Override"
	And I take a screenshot
	And I switch to "Reports" window
	And I navigate to "Home"
	And I select Study "MCC-70487C" 
	And I select a Subject "{Var(num3)}"
	And I select primary record form
	And I click audit on form level
	And I select link "Subject - SUB{Var(num3)}"
	Then I verify last audit exist
		| Audit Type               | Query Message                    | User   | Time                 |
		| subject assigned to TSDV | Architect Defined (Default Tier) | System | dd MMM yyyy HH:mm:ss |		
	And I take a screenshot


