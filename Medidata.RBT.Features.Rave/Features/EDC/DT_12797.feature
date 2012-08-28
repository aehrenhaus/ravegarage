# Sometimes, edit checks, that set review requirement for datapoints do not fire correctly. 
# What happens internally is that datapoints wind up not requiring review; however, their "object statuses" show that they do require review.  Datapoints wind up having a "requires review" icon, but the checkboxes for review are disabled. 
# After refreshing object statuses for a given subject, the icon displays as "complete".  

Feature: DT 12797 For a field that has a derivation, edit check does not set it to require review correctly in certain cases.  
	As a Rave user
	Given I enter data
	And there is an edit check that sets the data to require review
	Then I should see the requires review icon for the data
	And I should see the review box enabled for the data

Background:
    Given I am logged in to Rave with username "defuser" and password "password"
	And following Project assignments exist
	|User	|Project	|Environment	|Role |Site	  |Site Number	|
	|User 1 |Mediflex	|Prod			|cdm1 |Site 1 |S100			|
    And Role "cdm1" has Action "Entry"
	And Role "cdm1" has Action "Review"
	And Project "Mediflex" has Draft "<Draft1>"
	And I publish and push CRF Version "CRF Version<RANDOMNUMBER>" of Draft "<Draft1>" to site "Site 1" in Project "Mediflex" for Enviroment "Prod"

	# There must be an edit check to set a field to require review.  Example if Age < 18 then set Visit Date to require review.
				
@PB-DT12797-01
Scenario: As an EDC user, when I have an edit check that sets a field to require review and I see the requires review icon, then I should see the review box enabled.
	When I create a Subject
	| Field				|Value	|
	| Subject Number	|101	|
	| Subject Initials	|SUBJ	|	
	And I am on CRF page "Visit Date" in Folder "Visit 1" in Subject "101SUBJ" in Site "Site 1" in Study "Mediflex"
	And I enter data in CRF
	|Field		|Value		|
	|Visit Date	|01 FEB 2011|
	|Age		|20			|
	And I save the CRF
	And I verify data in CRF
	| Field      | Value       | Requires Review |
	| Visit Date | 01 FEB 2011 | False           |
	| Age        | 20          | False           |
	And I take a screenshot
	And I enter data in CRF
	| Field      | Value       |
	| Age        | 17          |
	And I verify data in CRF
	| Field      | Value       | Requires Review |
	| Visit Date | 01 FEB 2011 | True            |
	| Age        | 20          | False           |
	And I take a screenshot

	