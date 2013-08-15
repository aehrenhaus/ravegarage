@FT_MCC-56524

Feature: MCC-56524 As a TSDV user, when a subject enrolled, and there is a non-conformant data query on my subject's Primary form, the subject is not included into TSDV and after resolving non-conformant data query, the subject should automatically be entered into TSDV. 

Background:

	Given TSDV is enabled
	Given I perform cache flush of "Medidata.Core.Objects.Configuration"
	Given study "MCC-56524" is assigned to Site "Site 1" with study environment "Live: Prod"
	Given following Project assignments exist
	| User         | Project   | Environment | Role         | Site   | SecurityRole          | 
	| SUPER USER 1 | MCC-56524 | Live: Prod  | SUPER ROLE 1 | Site 1 | Project Admin Default | 
	Given I publish and push eCRF "MCC-56524.xml" to "Version 1"
	Given following Report assignments exist
	| User         | Report                                                           |
	| SUPER USER 1 | Targeted SDV Configuration - Targeted SDV Configuration          |
	| SUPER USER 1 | Targeted SDV Subject Management - Targeted SDV Subject Managemen |


@Release_2013.2.0
@PB_MCC56524-001
@SJ26.APR.2013
@Validation

Scenario: MCC56524-001 when a subject enrolled by changing non-conformant data to conformant data in the primary form, subject should automatically be entered into TSDV. 

	Given I login to Rave with user "SUPER USER 1"
	And I navigate to "Reporter"
	And I select Report "Targeted SDV Configuration"
	And I set report parameter "Study" with table
		| Name      | Environment |
		| MCC-56524 | Prod        |
	And I click button "Submit Report"
	And I switch to "Targeted SDV Study Plan" window
	And I create a new block plan named "MCC-56524 Block Plan" with Data entry Role "SUPER ROLE 1"
	And I delete the tier "Architect Defined" from plan
	And I edit Blocks 
		| Name              | Subject Count |
		| Architect Defined | 1             |            
	And I select the tier "All Forms" and Subject Count "1"
	And I activate the plan
	And I take a screenshot
	And I switch to "Reports" window
	And I navigate to "Home"
	And I create a Subject
		| Field            | Data|
		| Subject Initials | SUB |
		| Subject Number   | AAA |
	And I take a screenshot
	And I enter data on Primary Form
		| Field          | Data              |
		| Subject Number | {RndNum<num1>(4)} |
	And I take a screenshot
	And I navigate to "Home"	
	And I select a Subject "{Var(num1)}"	
	And I select primary record form
	And I click audit on form level
	And I select link "Subject - SUB{Var(num1)}"
	Then I verify last audit exist
		| Audit Type               | Query Message            | User   | Time                 |
		| subject assigned to TSDV | All Forms (Default Tier) | System | dd MMM yyyy HH:mm:ss |		
	And I take a screenshot



