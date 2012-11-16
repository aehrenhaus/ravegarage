# When an Edit Check sets Datapoint XYZ to require verification, if the verification is broken on XYZ by a data change, this is not audited.
@ignore
Feature: DT 13622 TSDV Off When an Edit Check sets Datapoint XYZ to require verification, if the verification is broken on XYZ by a data change, this is not audited.
	As a Rave user
	Given I verify data
	When I change the data
	And the verification is broken
	Then I should see an audit for the unverification

Background:
    #Given I login to Rave with user "defuser" and password "password"
	Given xml draft "DT13622 Mediflex.xml" is Uploaded
	Given study "Mediflex" is assigned to Site "MediflexDTSite" with study environment "Live: Prod"
	Given I publish and push eCRF "DT13622 Mediflex.xml" to "Version 1" with study environment "Prod"
	Given following Project assignments exist
	| User | Project | Environment | Role | Site | SecurityRole |
	| SUPER USER 1 | Mediflex | Live: Prod | SUPER ROLE 1 | MediflexDTSite | Project Admin Default |
	#And I select Study "Mediflex" and Site "MediflexDTSite"
	#And following Project assignments exist
	#|User	|Project	|Environment	|Role |Site	  |Site Number	|
	#|User 1 |Mediflex	|Prod			|cdm1 |Site 1 |S100			|
    #And Role "cdm1" has Action "Entry"
	#And Role "cdm1" has Action "Verify"
	#And Project "Mediflex" has Draft "<Draft1>"
	#And I publish and push CRF Version "CRF Version<RANDOMNUMBER>" of Draft "<Draft1>" to site "Site 1" in Project "Mediflex" for Enviroment "Prod"
	#And I select Study "Mediflex20120710040626" and Site "MediflexDTSite"
	# Edit check exists to set field Visit Date on form Visit Date to require verification if field Age has a value less than 18.
	# Edit check exists to set field Field 1 on form Form 1 to require verification if field Field 1 has a value other than 20.
	# Edit check exists to set field DOB on form Form 2 to require verification if field Age has a value less than 18.
	# Derivation exists to derive field Age on Form 2 from field Visit Date and DOB on Form 2.			
	# Edit check exists to set field Field 2 on form Form 2 to require verification if field Field 1 has a value other than 20.
	# TSDV is turned off in the database.

@release_2012.1.0 
@PB-DT13622_1-01
@WIP
Scenario: As an EDC user, when I have an edit check fired on one field that sets another field to require verification, and TSDV is off, and I verify the data for the field, and I change the data, and the verification is broken, then I should see an audit recorded for the unverification.
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
@PB-DT13622_1-02
@WIP
Scenario: As an EDC user, when I have an edit check fired on one field that sets another field to require verification, and TSDV is off, and I verify the data for the form, and I change the data, and the verification is broken, then I should see an audit recorded for the unverification.
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
@PB-DT13622_1-03
@WIP
Scenario: As an EDC user, when I have an edit check that sets a field to require verification, and TSDV is off, and I verify the data for the field, and I change the data, and the verification is broken, then I should see an audit recorded for the unverification.
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
@PB-DT13622_1-04
@WIP
Scenario: As an EDC user, when I have an edit check that sets a field to require verification, and TSDV is off, and I verify the data for the form, and I change the data, and the verification is broken, then I should see an audit recorded for the unverification.
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
@PB-DT13622_1-05
@WIP
Scenario: As an EDC user, when I have an edit check fired on a field that is derived to sets another field to require verification, and TSDV is off, and I verify the data for the field, and I change the data, and the verification is broken, then I should see an audit recorded for the unverification.
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
@PB-DT13622_1-06
@WIP
Scenario: As an EDC user, when I have an edit check fired on a field that is derived to sets another field to require verification, and TSDV is off, and I verify the data for the form, and I change the data, and the verification is broken, then I should see an audit recorded for the unverification.
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