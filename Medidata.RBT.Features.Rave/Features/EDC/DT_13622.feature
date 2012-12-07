# When an Edit Check sets Datapoint XYZ to require verification, if the verification is broken on XYZ by a data change, this is not audited.

Feature: US10244_DT13622 When an Edit Check sets Datapoint XYZ to require verification, if the verification is broken on XYZ by a data change, this is not audited.
	As a Rave user
	Given I verify data
	When I change the data
	And the verification is broken
	Then I should see an audit for the unverification

Background:
    Given I login to Rave with user "defuser" and password "password"
	Given xml draft "DT13622 Mediflex.xml" is Uploaded with Environment name "Dev"
	Given Site "MediflexDTSite" exists
	Given study "Mediflex" is assigned to Site "MediflexDTSite" with study environment "Aux: Dev"
	Given I publish and push eCRF "DT13622 Mediflex.xml" to "Version 1" with study environment "Dev"
	Given following Project assignments exist
	| User | Project | Environment | Role | Site | SecurityRole |
	| SUPER USER 1 | Mediflex | Aux: Dev | SUPER ROLE 1 | MediflexDTSite | Project Admin Default |
	Given following Report assignments exist
	| User | Report |
	| SUPER USER 1 | Targeted SDV Configuration - Targeted SDV Configuration | 
	#And I select Study "Mediflex" and Site "MediflexDTSite"
	#And following Project assignments exist
	#|User	|Project	|Environment	|Role |Site	  |Site Number	|
	#|User 1 |Mediflex	|Prod			|cdm1 |Site 1 |S100			|
    #And Role "cdm1" has Action "Entry"
	#And Role "cdm1" has Action "Verify"
	#And Project "Mediflex" has Draft "<Draft1>"
	#And I publish and push CRF Version "CRF Version<RANDOMNUMBER>" of Draft "<Draft1>" to site "Site 1" in Project "Mediflex" for Enviroment "Prod"
	#And I select Study "Mediflex20120710040626 (Dev)" and Site "MediflexDTSite"
	# Edit check exists to set field Visit Date on form Visit Date to require verification if field Age has a value less than 18.
	# Edit check exists to set field Field 1 on form Form 1 to require verification if field Field 1 has a value other than 20.
	# Edit check exists to set field DOB on form Form 2 to require verification if field Age has a value less than 18.
	# Derivation exists to derive field Age on Form 2 from field Visit Date and DOB on Form 2.			
	# Edit check exists to set field Field 2 on form Form 2 to require verification if field Field 1 has a value other than 20.
	# TSDV is turned ON on Database.
	# An active Block plan exists in TSDV for study Mediflex with No Forms tier and 1 Custom Tier that has Form 2 excluded from verification.

@release_2012.1.0 
@PB_US10244_DT13622_01
@Validation
Scenario: PB_US10244_DT13622_01 As an EDC user, when I have an edit check fired on one field that sets another field to require verification, and I verify the data for the field, and I change the data, and the verification is broken, then I should see an audit recorded for the unverification.
	
	Given I login to Rave with user "SUPER USER 1"
	When I create a Subject
	|Field			 |Data|
	|Subject Number	 |101 |
	|Subject Initials|SUBJ|	
	And I select Form "Visit Date" in Folder "VISIT"
	And I enter data in CRF
	|Field		|Data		|
	|Visit Date	|01 Feb 2011|
	|Age		|20			|
	And I save the CRF page
	And I verify data on Fields in CRF
	| Field      | Data        | Requires Verification |
	| Visit Date | 01 Feb 2011 | False                 |
	| Age        | 20          | False                 |
	And I enter data in CRF
	|Field|Data|
	|Age  |17  |
	And I save the CRF page
	And I verify data on Fields in CRF
	| Field      | Data        | Requires Verification |
	| Visit Date | 01 Feb 2011 | True                  |
	| Age        | 17          | False                 |
	And I check "Verify" in "Visit Date"
	And I save the CRF page
	And I take a screenshot
	And I enter data in CRF
	|Field		|Data		|
	|Visit Date	|02 Feb 2011|
	And I save the CRF page
	And I verify data on Fields in CRF
	| Field      | Data        | Requires Verification |
	| Visit Date | 02 Feb 2011 | True                  |
	| Age        | 17          | False                 |
	And I take a screenshot
	And I click audit on Field "Visit Date"
	Then I verify Audits exist
	| Audit Type   | Query Message |  
	| User entered | '02 Feb 2011' |
	| DataPoint    | Un-verified.  |
	| DataPoint    | Verified.     |
	| User entered | '01 Feb 2011' |
	And I take a screenshot

@release_2012.1.0
@PB_US10244_DT13622_02
@Validation
Scenario: PB_US10244_DT13622_02 As an EDC user, when I have an edit check fired on one field that sets another field to require verification, and I verify the data for the form, and I change the data, and the verification is broken, then I should see an audit recorded for the unverification.
	
	Given I login to Rave with user "SUPER USER 1"
	When I create a Subject
	|Field			 |Data |
	|Subject Number	 |102  |
	|Subject Initials|SUBJ |	
	And I select Form "Visit Date" in Folder "VISIT"
	And I enter data in CRF
	|Field		|Data		|
	|Visit Date	|01 Feb 2011|
	|Age		|20			|
	And I save the CRF page
	And I verify data on Fields in CRF
	| Field      | Data        | Requires Verification |
	| Visit Date | 01 Feb 2011 | False                 |
	| Age        | 20          | False                 |
	And I enter data in CRF
	|Field|Data |
	|Age  |17   |
	And I save the CRF page
	And I verify data on Fields in CRF
	| Field      | Data        | Requires Verification |
	| Visit Date | 01 Feb 2011 | True                  |
	| Age        | 17          | False                 |
	And I check "Verify" in "Form level"
	And I save the CRF page
	And I take a screenshot
	And I enter data in CRF
	|Field		|Data		|
	|Visit Date	|02 Feb 2011|
	And I save the CRF page
	And I verify data on Fields in CRF
	| Field      | Data        | Requires Verification |
	| Visit Date | 02 Feb 2011 | True                  |
	| Age        | 17          | False                 |
	And I take a screenshot
	And I click audit on Field "Visit Date"
	Then I verify Audits exist
	| Audit Type   | Query Message |  
	| User entered | '02 Feb 2011' |
	| DataPoint    | Un-verified.  |
	| DataPoint    | Verified.     |
	| User entered | '01 Feb 2011' |
	And I take a screenshot

@release_2012.1.0
@PB_US10244_DT13622_03
@Validation
Scenario: PB_US10244_DT13622_03 As an EDC user, when I have an edit check that sets a field to require verification, and I verify the data for the field, and I change the data, and the verification is broken, then I should see an audit recorded for the unverification.
	
	Given I login to Rave with user "SUPER USER 1"
	When I create a Subject
	|Field			 |Data |
	|Subject Number	 |103  |
	|Subject Initials|SUBJ |	
	And I select Form "Form 1"
	And I enter data in CRF
	|Field	|Data |
	|Field 1|19	  |
	And I save the CRF page
	And I verify data on Fields in CRF
	| Field   | Data | Requires Verification |
	| Field 1 | 19   | True                  |
	And I check "Verify" in "Field 1"
	And I save the CRF page
	And I take a screenshot
	And I enter data in CRF
	|Field	|Data |
	|Field 1|18   |
	And I save the CRF page
	And I verify data on Fields in CRF
	| Field   | Data | Requires Verification |
	| Field 1 | 18   | True                  |
	And I take a screenshot
	And I click audit on Field "Field 1"
	Then I verify Audits exist
	| Audit Type   | Query Message |
	| User entered | '18'          |
	| DataPoint    | Un-verified.  |
	| DataPoint    | Verified.     |
	| User entered | '19'          |
	And I take a screenshot

@release_2012.1.0
@PB_US10244_DT13622_04
@Validation
Scenario: PB_US10244_DT13622_04 As an EDC user, when I have an edit check that sets a field to require verification, and I verify the data for the form, and I change the data, and the verification is broken, then I should see an audit recorded for the unverification.
	
	Given I login to Rave with user "SUPER USER 1"
	When I create a Subject
	|Field			 |Data |
	|Subject Number	 |104  |
	|Subject Initials|SUBJ |	
	And I select Form "Form 1"
	And I enter data in CRF
	|Field	|Data |
	|Field 1|19	  |
	And I save the CRF page
	And I verify data on Fields in CRF
	| Field   | Data | Requires Verification |
	| Field 1 | 19   | True                  |         	
	And I check "Verify" in "Form level"
	And I save the CRF page
	And I take a screenshot
	And I enter data in CRF
	|Field	|Data |
	|Field 1|18   |
	And I save the CRF page
	And I verify data on Fields in CRF
	| Field   | Data | Requires Verification |
	| Field 1 | 18   | True                  |             
	And I take a screenshot
	And I click audit on Field "Field 1"
	Then I verify Audits exist
	| Audit Type   | Query Message |
	| User entered | '18'          |
	| DataPoint    | Un-verified.  |
	| DataPoint    | Verified.     |
	| User entered | '19'          |
	And I take a screenshot

@release_2012.1.0
@PB_US10244_DT13622_05
@Validation
Scenario: PB_US10244_DT13622_05 As an EDC user, when I have an edit check fired on a field that is derived to sets another field to require verification, and I verify the data for the field, and I change the data, and the verification is broken, then I should see an audit recorded for the unverification.
	
	Given I login to Rave with user "SUPER USER 1"
	When I create a Subject
	|Field			 |Data |
	|Subject Number	 |105  |
	|Subject Initials|SUBJ |	
	And I select Form "Form 2"
	And I enter data in CRF
	|Field     |Data       |
	|DOB       |05 Mar 1995|
	|Visit Date|10 Dec 2011|
	And I save the CRF page
	And I verify data on Fields in CRF
	| Field      | Data        | Requires Verification |
	| DOB        | 05 Mar 1995 | True                  |
	| Visit Date | 10 Dec 2011 | False                 |
	| Age        | 16          | False                 |
	And I check "Verify" in "DOB"
	And I save the CRF page
	And I take a screenshot
	And I enter data in CRF
	|Field|Data       |
	|DOB  |12 Jun 1993|
	And I save the CRF page
	And I verify data on Fields in CRF
	| Field      | Data        | Requires Verification |
	| DOB        | 12 Jun 1993 | False                 |
	| Visit Date | 10 Dec 2011 | False                 |
	| Age        | 18          | False                 |
	And I take a screenshot
	And I click audit on Field "DOB"
	Then I verify Audits exist
	| Audit Type   | Query Message |
	| User entered | '12 Jun 1993' |
	| DataPoint    | Un-verified.  |
	| DataPoint    | Verified.     |
	| User entered | '05 Mar 1995' |
	And I take a screenshot

@release_2012.1.0
@PB_US10244_DT13622_06
@Validation
Scenario: PB_US10244_DT13622_06 As an EDC user, when I have an edit check fired on a field that is derived to sets another field to require verification, and I verify the data for the form, and I change the data, and the verification is broken, then I should see an audit recorded for the unverification.
	
	Given I login to Rave with user "SUPER USER 1"
	When I create a Subject
	|Field			 |Data |
	|Subject Number	 |105  |
	|Subject Initials|SUBJ |	
	And I select Form "Form 2"
	And I enter data in CRF
	|Field     |Data       |
	|DOB       |05 Mar 1995|
	|Visit Date|10 Dec 2011|
	And I save the CRF page
	And I verify data on Fields in CRF
	| Field      | Data        | Requires Verification |
	| DOB        | 05 Mar 1995 | True                  |
	| Visit Date | 10 Dec 2011 | False                 |
	| Age        | 16          | False                 |
	And I check "Verify" in "Form level"
	And I save the CRF page
	And I take a screenshot
	And I enter data in CRF
	|Field|Data       |
	|DOB  |12 Jun 1993|
	And I save the CRF page
	And I verify data on Fields in CRF
	| Field      | Data        | Requires Verification |
	| DOB        | 12 Jun 1993 | False                 |
	| Visit Date | 10 Dec 2011 | False                 |
	| Age        | 18          | False                 |
	And I take a screenshot
	And I click audit on Field "DOB"
	Then I verify Audits exist
	| Audit Type   | Query Message |
	| User entered | '12 Jun 1993' |
	| DataPoint    | Un-verified.  |
	| DataPoint    | Verified.     |
	| User entered | '05 Mar 1995' |
	And I take a screenshot

@release_2012.1.0
@PB_US10244_DT13622_07
@Validation
Scenario: PB_US10244_DT13622_07 As an EDC user, when I have TSDV turned off for a form, when I have an edit check that sets a field to require verification, and I verify the data for the field, and I change the data, and the verification is broken, then I should see an audit recorded for the unverification.
	
	Given I login to Rave with user "SUPER USER 1"
	Given I navigate to "Reporter"
	And I select Report "Targeted SDV Configuration"
	And I set report parameter "Study" with table
		| Name                   | Environment |
		| Mediflex                | Dev         |
	And I click button "Submit Report"
	And I switch to "Targeted SDV Study Plan" window
	And I create a new block plan named "Block Plan 1" with Data entry Role "SUPER ROLE 1"
	And I delete the tier "Architect Defined" from plan
	And I create a custom tier named "Custom Tier 101" and description "Exclude Form 3" with table
	| Form       | Selected |
	| Visit Date | True     |
	| Form 1     | True     |
	| Form 2     | True     |
	| Form 3     | False    |
	And I select link "Study Block Plan"
	And I select the tier "Custom Tier 101" and Subject Count "1"
	And I activate the plan
	And I switch to "Reports" window
	And I select link "Home"
	When I create a Subject
	|Field			 |Data |
	|Subject Number	 |107  |
	|Subject Initials|SUBJ |	
	And I select Form "Form 3"
	And I enter data in CRF
	|Field	|Data |
	|Field 2|19	  |
	And I save the CRF page
	And I verify data on Fields in CRF
	| Field   | Data | Requires Verification |
	| Field 2 | 19   | True                  |
	And I check "Verify" in "Field 2"
	And I save the CRF page
	And I take a screenshot
	And I enter data in CRF
	|Field	|Data |
	|Field 2|18   |
	And I save the CRF page
	And I verify data on Fields in CRF
	| Field   | Data | Requires Verification |
	| Field 2 | 18   | True                  |
	And I take a screenshot
	And I click audit on Field "Field 2"
	Then I verify Audits exist
	| Audit Type   | Query Message |
	| User entered | '18'          |
	| DataPoint    | Un-verified.  |
	| DataPoint    | Verified.     |
	| User entered | '19'          |
	And I take a screenshot
	And I switch to "Targeted SDV Study Plan" window
	And I delete the tier "Custom Tier 101" from plan
	And I inactivate the plan
	And I switch to "Audits" window

@release_2012.1.0
@PB_US10244_DT13622_08
@Validation
Scenario: PB_US10244_DT13622_08 As an EDC user, when I have TSDV turned off for a form, and I have an edit check that sets a field to require verification, and I verify the data for the form, and I change the data, and the verification is broken, then I should see an audit recorded for the unverification.
	
	Given I login to Rave with user "SUPER USER 1"
	Given I navigate to "Reporter"
	And I select Report "Targeted SDV Configuration"
	And I set report parameter "Study" with table
		| Name                   | Environment |
		| Mediflex               | Dev         |
	And I click button "Submit Report"
	And I switch to "Targeted SDV Study Plan" window
	And I create a new block plan named "Block Plan 1" with Data entry Role "SUPER ROLE 1"
	And I delete the tier "Architect Defined" from plan
	And I create a custom tier named "Custom Tier 102" and description "Exclude Form 3" with table
	| Form       | Selected |
	| Visit Date | True     |
	| Form 1     | True     |
	| Form 2     | True     |
	| Form 3     | False    |
	And I select link "Study Block Plan"
	And I select the tier "Custom Tier 102" and Subject Count "1"
	And I activate the plan
	And I switch to "Reports" window
	And I select link "Home"
	When I create a Subject
	|Field			 |Data |
	|Subject Number	 |108  |
	|Subject Initials|SUBJ |	
	And I select Form "Form 3"
	And I enter data in CRF
	|Field	|Data |
	|Field 2|19	  |
	And I save the CRF page
	And I verify data on Fields in CRF
	| Field   | Data | Requires Verification |
	| Field 2 | 19   | True                  |
	And I check "Verify" in "Form level"
	And I save the CRF page
	And I take a screenshot
	And I enter data in CRF
	|Field	|Data |
	|Field 2|18   |
	And I save the CRF page
	And I verify data on Fields in CRF
	| Field   | Data | Requires Verification |
	| Field 2 | 18   | True                  |
	And I take a screenshot
	And I click audit on Field "Field 2"
	Then I verify Audits exist
    | Audit Type   | Query Message |
	| User entered | '18'          |
	| DataPoint    | Un-verified.  |
	| DataPoint    | Verified.     |
	| User entered | '19'          |
	And I take a screenshot
	And I switch to "Targeted SDV Study Plan" window
	And I delete the tier "Custom Tier 102" from plan
	And I inactivate the plan
	And I switch to "Audits" window

@release_2012.1.0 
@PB_US10244_DT13622_09 
@Validation
Scenario: PB_US10244_DT13622_09 As an EDC user, when I have a No Forms TSDV tier and I have an edit check that sets a field to require verification, and I verify the data for the field, and I change the data, and the verification is broken, then I should see an audit recorded for the unverification. 
	
	Given I login to Rave with user "SUPER USER 1"
	Given I navigate to "Reporter"
	And I select Report "Targeted SDV Configuration"
	And I set report parameter "Study" with table
		| Name                   | Environment |
		| Mediflex               | Dev         |
	And I click button "Submit Report"
	And I switch to "Targeted SDV Study Plan" window
	And I create a new block plan named "Block Plan 1" with Data entry Role "SUPER ROLE 1"
	And I delete the tier "Architect Defined" from plan
	And I select the tier "No Forms" and Subject Count "1"
	And I activate the plan
	And I switch to "Reports" window
	And I select link "Home"
	When I create a Subject 
	|Field |Data | 
	|Subject Number |109 | 
	|Subject Initials|SUBJ | 
	And I select Form "Form 3" 
	And I enter data in CRF 
	|Field |Data | 
	|Field 2|19 | 
	And I save the CRF page 
	And I verify data on Fields in CRF 
	| Field   | Data | Requires Verification |
	| Field 2 | 19   | True                  |
	And I check "Verify" in "Field 2" 
	And I save the CRF page 
	And I take a screenshot 
	And I enter data in CRF 
	|Field |Data | 
	|Field 2|18 | 
	And I save the CRF page 
	And I verify data on Fields in CRF 
	| Field   | Data | Requires Verification |
	| Field 2 | 18   | True                  |
	And I take a screenshot 
	And I click audit on Field "Field 2" 
	Then I verify Audits exist 
	| Audit Type | Query Message | 
	| User entered | '18' | 
	| DataPoint | Un-verified. | 
	| DataPoint | Verified.  |
	| User entered | '19' | 
	And I take a screenshot
	And I switch to "Targeted SDV Study Plan" window
	And I delete the tier "No Forms" from plan
	And I inactivate the plan
	And I switch to "Audits" window
