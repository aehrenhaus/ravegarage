@FT_MCC-56501

Feature: MCC-56501 As a TSDV user When I have 2 blocks in my plan, 
and 1 is a Repeating block, and I add subjects and fill the blocks 
and tiers per my plan,and I move all subjects from my filled non-Repeating block into the Repeating block, 
and I add new subjects, 
then they should be allocated to a tier in the original non-Repeating block.

Background:

	Given TSDV is enabled
	Given I perform cache flush of "Medidata.Core.Objects.Configuration"
	Given xml draft "MCC-56501A.xml" is Uploaded 
	Given xml draft "MCC-56501B.xml" is Uploaded
	Given study "MCC-56501A" is assigned to Site "Site 1" with study environment "Live: Prod"
	Given study "MCC-56501B" is assigned to Site "Site 1" with study environment "Live: Prod"
	Given I publish and push eCRF "MCC-56501A.xml" to "Version 1" with study environment "Prod"
	Given I publish and push eCRF "MCC-56501B.xml" to "Version 2" with study environment "Prod"
	Given following Project assignments exist
	| User         | Project    | Environment | Role         | Site   | SecurityRole          |
	| SUPER USER 1 | MCC-56501A | Live: Prod  | SUPER ROLE 1 | Site 1 | Project Admin Default |
	| SUPER USER 1 | MCC-56501B | Live: Prod  | SUPER ROLE 1 | Site 1 | Project Admin Default |
	Given following Report assignments exist
	| User         | Report                                                           |
	| SUPER USER 1 | Targeted SDV Configuration - Targeted SDV Configuration          |
	| SUPER USER 1 | Targeted SDV Subject Management - Targeted SDV Subject Managemen |
	Given I login to Rave with user "SUPER USER 1"

@Release_2013.4.0
@PB_MCC-MCC-56501-001
@SJ14.AUG.2013
@Validation

Scenario: MCC56501-001 When I move a subject from filled non-Repeating block into the Repeating block, then all new created subject(s) will be allocated to the tier in the original non-Repeating block first

	
	And I navigate to "Reporter"
	And I select Report "Targeted SDV Configuration"
	And I set report parameter "Study" with table
		| Name       | Environment |
		| MCC-56501A | Prod        |
	And I click button "Submit Report"
	And I switch to "Targeted SDV Study Plan" window
	And I create a new block plan named "MCC-56501A (Prod) Block Plan" with Data entry Role "SUPER ROLE 1"
	And I select link "Tiers"
	And I create a custom tier named "Custom Tier 1" and description "Custom Tier 1" with table
		| Form                | Selected |
		| Demographics (DEMO) | True     |
		| Form 1 (FRM1)       | True     |
	And I select link "Study Block Plan"
	And I create a new block and save
		| Name               | Subject Count | Repeated |
		| New Repeated Block | 3             | True     |
	And I select the tier "All Forms" and Subject Count "1" for "New Repeated Block"
	And I select the tier "No Forms" and Subject Count "1" for "New Repeated Block"
	And I select the tier "Custom Tier 1" and Subject Count "1" for "New Repeated Block"
	And I activate the plan
	And I take a screenshot
	And I switch to "Reports" window
	And I navigate to "Home"
	And I select Study "MCC-56501A" 
	And I create a Subject
		| Field      | Data                 |
		| Subject ID | SUB{RndNum<num1>(5)} |
	And I select primary record form
	And I click audit on form level
	And I select link "Subject - SUB{Var(num1)}"
	Then I verify last audit exist
		| Audit Type               | Query Message                    | User   | Time                 |
		| subject assigned to TSDV | Architect Defined (Default Tier) | System | dd MMM yyyy HH:mm:ss |		
	And I take a screenshot
	And I navigate to "Home"
	And I select Study "MCC-56501A" 
	And I create a Subject
		| Field      | Data                 |
		| Subject ID | SUB{RndNum<num2>(5)} |
	And I take a screenshot
	And I navigate to "Home"
	And I select Study "MCC-56501A" 
	And I create a Subject
		| Field      | Data                 |
		| Subject ID | SUB{RndNum<num3>(5)} |
	And I take a screenshot
	And I navigate to "Home"
	And I select Study "MCC-56501A" 
	And I create a Subject
		| Field      | Data                 |
		| Subject ID | SUB{RndNum<num4>(5)} |
	And I take a screenshot
	And I navigate to "Home"
	And I navigate to "Reporter"
	And I select Report "Targeted SDV Subject Management"
	And I set report parameter "Study" with table
		| Name       | Environment |
		| MCC-56501A | Prod        |
	And I click button "Submit Report"
	And I switch to "Targeted SDV Subject Override" window 
	And I Override Subject
	    | Subject              | New Tier                    | Override Reason    |
		| SUB{Var(num1)}	   | Custom Tier 1 (Custom Tier) | Changing Tier Test |
	And I take a screenshot
	And I switch to "Reports" window
	And I navigate to "Home"
	And I select Study "MCC-56501A" 
	And I create a Subject
		| Field      | Data                 |
		| Subject ID | SUB{RndNum<num5>(5)} |
	And I select primary record form
	And I click audit on form level
	And I select link "Subject - SUB{Var(num5)}"
	Then I verify last audit exist
		| Audit Type               | Query Message                    | User   | Time                 |
		| subject assigned to TSDV | Architect Defined (Default Tier) | System | dd MMM yyyy HH:mm:ss |		
	And I take a screenshot



@Release_2013.4.0
@PB_MCC-MCC-56501-002
@SJ14.AUG.2013
@Validation

Scenario: MCC56501-002 When I move a subject from filled non-Repeating block into the Repeating block, then included subject(s) will be allocated to the tier in the original non-Repeating block first


	And I navigate to "Reporter"
	And I select Report "Targeted SDV Configuration"
	And I set report parameter "Study" with table
		| Name       | Environment |
		| MCC-56501B | Prod        |
	And I click button "Submit Report"
	And I switch to "Targeted SDV Study Plan" window
	And I create a new block plan named "MCC-56501B (Prod) Block Plan" with Data entry Role "SUPER ROLE 1"
	And I select link "Tiers"
	And I create a custom tier named "Custom Tier 1" and description "Custom Tier 1" with table
		| Form                | Selected |
		| Demographics (DEMO) | True     |
		| Form 1 (FRM1)       | True     |
	And I select link "Study Block Plan"
	And I create a new block and save
		| Name               | Subject Count | Repeated |
		| New Repeated Block | 3             | True     |
	And I select the tier "All Forms" and Subject Count "1" for "New Repeated Block"
	And I select the tier "No Forms" and Subject Count "1" for "New Repeated Block"
	And I select the tier "Custom Tier 1" and Subject Count "1" for "New Repeated Block"
	And I activate the plan
	And I take a screenshot
	And I switch to "Reports" window
	And I navigate to "Home"
	And I select Study "MCC-56501B" 
	And I create a Subject
		| Field      | Data                 |
		| Subject ID | SUB{RndNum<num1>(5)} |
	And I select primary record form
	And I click audit on form level
	And I select link "Subject - SUB{Var(num1)}"
	Then I verify last audit exist
		| Audit Type               | Query Message                    | User   | Time                 |
		| subject assigned to TSDV | Architect Defined (Default Tier) | System | dd MMM yyyy HH:mm:ss |		
	And I take a screenshot
	And I navigate to "Home"
	And I select Study "MCC-56501B"
	And I create a Subject
		| Field      | Data                 |
		| Subject ID | SUB{RndNum<num2>(5)} |
	And I take a screenshot
	And I navigate to "Home"
	And I select Study "MCC-56501B"
	And I create a Subject
		| Field      | Data                 |
		| Subject ID | SUB{RndNum<num3>(5)} |
	And I take a screenshot
	And I navigate to "Home"
	And I select Study "MCC-56501B"
	And I create a Subject
		| Field      | Data                 |
		| Subject ID | SUB{RndNum<num4>(5)} |
	And I take a screenshot
	And I navigate to "Home"
	And I navigate to "Reporter"
	And I select Report "Targeted SDV Subject Management"
	And I set report parameter "Study" with table
		| Name       | Environment |
		| MCC-56501B | Prod        |
	And I click button "Submit Report"
	And I switch to "Targeted SDV Subject Override" window 
	And I Override Subject
	    | Subject        | New Tier                    | Override Reason    |
	    | SUB{Var(num1)} | Custom Tier 1 (Custom Tier) | Changing Tier Test |
	And I take a screenshot
	And I switch to "Reports" window
	And I navigate to "Home"
	And I navigate to "Reporter"
	And I select Report "Targeted SDV Configuration"
	And I set report parameter "Study" with table
		| Name       | Environment |
		| MCC-56501B | Prod        |
	And I click button "Submit Report"
	And I switch to "Targeted SDV Study Plan" window
	And I inactivate the plan
	And I take a screenshot
	And I switch to "Reports" window
	And I navigate to "Home"
	And I select Study "MCC-56501B"
	And I create a Subject
		| Field      | Data                 |
		| Subject ID | SUB{RndNum<num5>(5)} |
	And I take a screenshot
	And I navigate to "Home"
	And I navigate to "Reporter"
	And I select Report "Targeted SDV Configuration"
	And I set report parameter "Study" with table
		| Name       | Environment |
		| MCC-56501B | Prod        |
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
		| MCC-56501B | Prod        |
	And I click button "Submit Report"
	And I switch to "Targeted SDV Subject Override" window 
	And I select link "Subject Include"
	And I include 1 subjects in TSDV
	And I take a screenshot
	And I select link "Subject Override"
	And I take a screenshot
	And I switch to "Reports" window
	And I navigate to "Home"
	And I select Study "MCC-56501B"
	And I select a Subject "{Var(num5)}"
	And I select primary record form
	And I click audit on form level
	And I select link "Subject - SUB{Var(num5)}"
	Then I verify last audit exist
		| Audit Type               | Query Message                    | User   | Time                 |
		| subject assigned to TSDV | Architect Defined (Default Tier) | System | dd MMM yyyy HH:mm:ss |		
	And I take a screenshot