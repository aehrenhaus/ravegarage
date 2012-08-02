# When an Edit Check sets Datapoint XYZ to require verification, if the verification is broken on XYZ by a data change, this is not audited.

Feature: DT 13622 When an Edit Check sets Datapoint XYZ to require verification, if the verification is broken on XYZ by a data change, this is not audited.
	As a Rave user
	Given I verify data
	When I change the data
	And the verification is broken
	Then I should see an audit for the unverification

Background:
    Given I am logged in to Rave with username "defuser" and password "password"
	And following Project assignments exist
	|User	|Project	|Environment	|Role |Site	  |Site Number	|
	|User 1 |Mediflex	|Prod			|cdm1 |Site 1 |S100			|
    And Role "cdm1" has Action "Entry"
	And Role "cdm1" has Action "Verify"
	And Project "Mediflex" has Draft "<Draft1>"
	And I publish and push CRF Version "CRF Version<RANDOMNUMBER>" of Draft "<Draft1>" to site "Site 1" in Project "Mediflex" for Enviroment "Prod"

	# There must be an edit check to set a field to require verification.  Example if Age < 18 then set Visit Date to require verification.
				
@PB-DT13622-01
Scenario: As an EDC user, when I have an edit check that sets a field to require verification, and I verify the data, and I change the data, and the verification is broken, then I should see an audit recorded for the unverification.
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
	| Field      | Value       | Requires Verification |
	| Visit Date | 01 FEB 2011 | False                 |
	| Age        | 20          | False                 |
	And I enter data in CRF
	| Field      | Value       |
	| Age        | 17          |
	And I verify data in CRF
	| Field      | Value       | Requires Verification |
	| Visit Date | 01 FEB 2011 | True                  |
	| Age        | 20          | False                 |
	And I check Verify box for data in CRF
	|Field		|Value		|
	|Visit Date	|01 FEB 2011|
	And I take screenshot
	And I enter data in CRF
	|Field		|Value		|
	|Visit Date	|02 FEB 2011|
	And I take screenshot
	And I go to Audits for Field "Visit Date"
	And I verify audits
	| Audit Message                                              |
	| User unverified data.                                      |
	| User changed data "02 FEB 2011" with reason "Data change". |
	| User verified data.                                        |
	| User entered data "01 FEB 2011".                           |
	And I take screenshot




