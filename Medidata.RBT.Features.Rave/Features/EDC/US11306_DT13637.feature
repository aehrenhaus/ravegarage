# In 5.6.4 (DT 11659 fixed the same issue on Rave v5.6.3)
# A form has standard and log fields.  One of the standard fields uses Dynamic Search List as the control type.  After initially submitting the datapage, and later creating a new log line, value for "AltCodedValue"  doesn't get propagated to the newly-created records in the database.  
@ignore
Feature: US11306_DT13637 On a mixed form, AltCodedValue from a standard DSL field doesn't get propagated into hidden datapoints on newly-created records.
	In Rave 5.6.4, in a mixed form, AltCodedValue from a standard DSL field doesn't get propagated into hidden datapoints on newly-created records.
	As a Rave user
	Given I enter a value for a dynamic searchlist field on a mixed form
	When I view the AltCodedValue for the hidden datapoints
	Then I should see the same AltCodedValue for the standard datapoint of the dynamic searchlist field

# There must exist a mixed form with a standard field and a standard dynamic searchlist field.

Background:
	Given xml draft "US11306_DT13637.xml" is Uploaded
	And Site "Site 1" exists
	And study "US11306_DT13637" is assigned to Site "Site 1" with study environment "Live: Prod"
	And I publish and push eCRF "US11306_DT13637.xml" to "Version 1" with study environment "Prod"
    And following Project assignments exist
	| User			| Project 		 | Environment| Role         | Site  | SecurityRole 		 |
	| SUPER USER 1	| US11306_DT13637| Live: Prod | SUPER ROLE 1 | Site 1| Project Admin Default |

@release_2012.1.0		
@PB_US11306_DT13637_01
@Validation
Scenario: PB_US11306_DT13637_01 As a Data Manager, when an EDC user enters data for a standard dynamic searchlist field, then I expect to see the AltCodedValue for that field propagated to the hidden datapoints on the log lines.
	Given I login to Rave with user "SUPER USER 1"
	When I create a Subject
	| Field            | Data              |Control Type |
	| Subject Initials | SUB               |text         |
	| Subject Number   | {RndNum<num1>(3)} |text         |
	And I select link "Device Form"
	And I enter data in CRF and save
	| Field       | Data          | Control Type        |
	| Device Type | Device Type 1 | radiobutton         |
	| Device      | Device 1A     | dynamic search list |
	| Devimpdate  | 01 Jan 2012   |                     |
	| Devcomments | N/A           |                     |
	And I add a new log line
	And I enter data in CRF and save
	| Field       | Data        | Control Type |
	| Devimpdate  | 01 Mar 2012 |              |
	| Devcomments | N/A         |              |
	And I take a screenshot
	Then "AltCodedValue" propagates correctly
		
@release_2012.1.0		
@PB_US11306_DT13637_02
@Validation
Scenario: PB_US11306_DT13637_02 As a Data Manager, when an EDC user enters data for a standard dynamic searchlist field, then I expect to see the AltCodedValue for that field propagated to the hidden datapoints on the log lines.
	
	Given I login to Rave with user "SUPER USER 1"
	When I create a Subject
		| Field            | Data              |
		| Subject Initials | SUB               |
		| Subject Number   | {RndNum<num1>(3)} |
	And I select link "Device Form" 
	And I enter data in CRF and save
		| Field       | Data          | Control Type        |
		| Device Type | Device Type 1 | radiobutton         |
		| Device      | Device 1A     | dynamic search list |
		| Devimpdate  | 01 Jan 2012   |                     |
		| Devcomments | N/A           |                     |
	And I select link "Inactivate"
	And I choose "1" from "Inactivate"
	And I click button "Inactivate"
	And I take a screenshot
	And I enter data in CRF and save
		| Field  | Data      | Control Type        |
		| Device | Device 1B | dynamic search list |
	And I take a screenshot
	And I select link "Reactivate"
	And I choose "1" from "Reactivate"
	And I click button "Reactivate"
	And I take a screenshot
	Then "AltCodedValue" propagates correctly