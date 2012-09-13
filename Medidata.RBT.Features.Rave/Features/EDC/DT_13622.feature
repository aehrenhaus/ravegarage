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

	# Edit check exists to set field Visit Date on form Visit Date to require verification if field Age has a value less than 18.
	# Edit check exists to set field Field 1 on form Form 1 to require verification if field Field 1 has a value other than 20.
	# Edit check exists to set field DOB on form Form 2 to require verification if field Age has a value less than 18.
	# Derivation exists to derive field Age on Form 2 from field Visit Date and DOB on Form 2.			
	# Edit check exists to set field Field 2 on form Form 2 to require verification if field Field 1 has a value other than 20.
	# An active Block plan exists in TSDV for study Mediflex with only 1 Custom Tier that has Form 2 excluded from verification.

@release_2012.1.0 
@PB-DT13622-01
@WIP
Scenario: As an EDC user, when I have an edit check fired on one field that sets another field to require verification, and I verify the data for the field, and I change the data, and the verification is broken, then I should see an audit recorded for the unverification.
	When I create a Subject
	|Field			 |Value|
	|Subject Number	 |101  |
	|Subject Initials|SUBJ |	
	And I am on CRF page "Visit Date" in Subject "101SUBJ" in Site "Site 1" in Study "Mediflex"
	And I enter data in CRF
	|Field		|Value		|
	|Visit Date	|01 FEB 2011|
	|Age		|20			|
	And I save the CRF
	And I verify data in CRF
	|Field     |Value      |Requires Verification|
	|Visit Date|01 FEB 2011|False                |
	|Age       |20         |False                |
	And I enter data in CRF
	|Field|Value|
	|Age  |17   |
	And I verify data in CRF
	|Field     |Value      |Requires Verification|
	|Visit Date|01 FEB 2011|True                 |
	|Age       |17         |False                |
	And I check Verify box for data in CRF
	|Field		|Value		|
	|Visit Date	|01 FEB 2011|
	And I save the CRF
	And I take screenshot
	And I enter data in CRF
	|Field		|Value		|
	|Visit Date	|02 FEB 2011|
	And I save the CRF
	And I verify data in CRF
	|Field     |Value      |Requires Verification|
	|Visit Date|02 FEB 2011|True                 |
	|Age       |17         |False                |
	And I take screenshot
	And I go to Audits for Field "Visit Date"
	Then I verify Audits exist
	|Audit Message              |
	|User entered '02 FEB 2011' |
	|DataPoint Un-verified.     |
	|DataPoint Verified.        |
	|User entered '01 FEB 2011' |
	And I take screenshot

@release_2012.1.0
@PB-DT13622-02
@WIP
Scenario: As an EDC user, when I have an edit check fired on one field that sets another field to require verification, and I verify the data for the form, and I change the data, and the verification is broken, then I should see an audit recorded for the unverification.
	When I create a Subject
	|Field			 |Value|
	|Subject Number	 |102  |
	|Subject Initials|SUBJ |	
	And I am on CRF page "Visit Date" in Subject "102SUBJ" in Site "Site 1" in Study "Mediflex"
	And I enter data in CRF
	|Field		|Value		|
	|Visit Date	|01 FEB 2011|
	|Age		|20			|
	And I save the CRF
	And I verify data in CRF
	|Field     |Value      |Requires Verification|
	|Visit Date|01 FEB 2011|False                |
	|Age       |20         |False                |
	And I enter data in CRF
	|Field|Value|
	|Age  |17   |
	And I verify data in CRF
	|Field     |Value      |Requires Verification|
	|Visit Date|01 FEB 2011|True                 |
	|Age       |17         |False                |
	And I check Verify box for data in CRF
	|Form	   |
	|Visit Date|
	And I save the CRF
	And I take screenshot
	And I enter data in CRF
	|Field		|Value		|
	|Visit Date	|02 FEB 2011|
	And I save the CRF
	And I verify data in CRF
	|Field     |Value      |Requires Verification|
	|Visit Date|02 FEB 2011|True                 |
	|Age       |17         |False                |
	And I take screenshot
	And I go to Audits for Field "Visit Date"
	Then I verify Audits exist
	|Audit Message             |
	|User entered '02 FEB 2011'|
	|DataPoint Un-verified.    |
	|DataPoint Verified.       |
	|User entered '01 FEB 2011'|
	And I take screenshot

@release_2012.1.0
@PB-DT13622-03
@WIP
Scenario: As an EDC user, when I have an edit check that sets a field to require verification, and I verify the data for the field, and I change the data, and the verification is broken, then I should see an audit recorded for the unverification.
	When I create a Subject
	|Field			 |Value|
	|Subject Number	 |103  |
	|Subject Initials|SUBJ |	
	And I am on CRF page "Form 1" in Subject "103SUBJ" in Site "Site 1" in Study "Mediflex"
	And I enter data in CRF
	|Field	|Value|
	|Field 1|19	  |
	And I save the CRF
	And I verify data in CRF
	|Field  |Value|Requires Verification|
	|Field 1|19   |True                 |
	And I check Verify box for data in CRF
	|Field	|
	|Field 1|
	And I save the CRF
	And I take screenshot
	And I enter data in CRF
	|Field	|Value|
	|Field 1|18   |
	And I save the CRF
	And I verify data in CRF
	|Field  |Value|Requires Verification|
	|Field 1|18   |True                 |
	And I take screenshot
	And I go to Audits for Field "Field 1"
	Then I verify Audits exist
	|Audit Message         |
	|User entered '18'     |
	|DataPoint Un-verified.|
	|DataPoint Verified.   |
	|User entered '19'     |
	And I take screenshot

@release_2012.1.0
@PB-DT13622-04
@WIP
Scenario: As an EDC user, when I have an edit check that sets a field to require verification, and I verify the data for the form, and I change the data, and the verification is broken, then I should see an audit recorded for the unverification.
	When I create a Subject
	|Field			 |Value|
	|Subject Number	 |104  |
	|Subject Initials|SUBJ |	
	And I am on CRF page "Form 1" in Subject "104SUBJ" in Site "Site 1" in Study "Mediflex"
	And I enter data in CRF
	|Field	|Value|
	|Field 1|19	  |
	And I save the CRF
	And I verify data in CRF
	|Field  |Value|Requires Verification|
	|Field 1|19   |True                 |
	And I check Verify box for data in CRF
	|Form  |
	|Form 1|
	And I save the CRF
	And I take screenshot
	And I enter data in CRF
	|Field	|Value|
	|Field 1|18   |
	And I save the CRF
	And I verify data in CRF
	|Field  |Value|Requires Verification|
	|Field 1|18   |True                 |
	And I take screenshot
	And I go to Audits for Field "Field 1"
	Then I verify Audits exist
    |Audit Message         |
	|User entered '18'     |
	|DataPoint Un-verified.|
	|DataPoint Verified.   |
	|User entered '19'     |
	And I take screenshot

@release_2012.1.0
@PB-DT13622-05
@WIP
Scenario: As an EDC user, when I have an edit check fired on a field that is derived to sets another field to require verification, and I verify the data for the field, and I change the data, and the verification is broken, then I should see an audit recorded for the unverification.
	When I create a Subject
	|Field			 |Value|
	|Subject Number	 |105  |
	|Subject Initials|SUBJ |	
	And I am on CRF page "Form 2" in Subject "105SUBJ" in Site "Site 1" in Study "Mediflex"
	And I enter data in CRF
	|Field     |Value      |
	|DOB       |05 Mar 1995|
	|Visit Date|10 Dec 2011|
	And I save the CRF
	And I verify data in CRF
	|Field     |Value      |Requires Verification|
	|DOB       |05 Mar 1995|True                 | 
	|Visit Date|10 Dec 2011|False                | 
	|Age       |16         |False                |
	And I check Verify box for data in CRF
	|Field|
	|DOB  |
	And I save the CRF
	And I take screenshot
	And I enter data in CRF
	|Field|Value      |
	|DOB  |12 Jun 1993|
	And I save the CRF
	And I verify data in CRF
	|Field     |Value      |Requires Verification|
	|DOB       |12 Jun 1993|False                | 
	|Visit Date|10 Dec 2011|False                | 
	|Age       |18         |False                |
	And I take screenshot
	And I go to Audits for Field "DOB"
	Then I verify Audits exist
	|Audit Message             |
	|User entered '12 Jun 1993'|
	|DataPoint Un-verified.    |
	|DataPoint Verified.       |
	|User entered '05 Mar 1995'|
	And I take screenshot

@release_2012.1.0
@PB-DT13622-06
@WIP
Scenario: As an EDC user, when I have an edit check fired on a field that is derived to sets another field to require verification, and I verify the data for the form, and I change the data, and the verification is broken, then I should see an audit recorded for the unverification.
	When I create a Subject
	|Field			 |Value|
	|Subject Number	 |105  |
	|Subject Initials|SUBJ |	
	And I am on CRF page "Form 2" in Subject "105SUBJ" in Site "Site 1" in Study "Mediflex"
	And I enter data in CRF
	|Field     |Value      |
	|DOB       |05 Mar 1995|
	|Visit Date|10 Dec 2011|
	And I save the CRF
	And I verify data in CRF
	|Field     |Value      |Requires Verification|
	|DOB       |05 Mar 1995|True                 | 
	|Visit Date|10 Dec 2011|False                | 
	|Age       |16         |False                |
	And I check Verify box for data in CRF
	|Form  |
	|Form 2|
	And I save the CRF
	And I take screenshot
	And I enter data in CRF
	|Field|Value      |
	|DOB  |12 Jun 1993|
	And I save the CRF
	And I verify data in CRF
	|Field     |Value      |Requires Verification|
	|DOB       |12 Jun 1993|False                | 
	|Visit Date|10 Dec 2011|False                | 
	|Age       |18         |False                |
	And I take screenshot
	And I go to Audits for Field "DOB"
	Then I verify Audits exist
	|Audit Message             |
	|User entered '12 Jun 1993'|
	|DataPoint Un-verified.    |
	|DataPoint Verified.       |
	|User entered '05 Mar 1995'|
	And I take screenshot

@release_2012.1.0
@PB-DT13622-07
@WIP
Scenario: As an EDC user, when I have TSDV turned off for a form, when I have an edit check that sets a field to require verification, and I verify the data for the field, and I change the data, and the verification is broken, then I should see an audit recorded for the unverification.
	When I create a Subject
	|Field			 |Value|
	|Subject Number	 |107  |
	|Subject Initials|SUBJ |	
	And I am on CRF page "Form 2" in Subject "107SUBJ" in Site "Site 1" in Study "Mediflex"
	And I enter data in CRF
	|Field	|Value|
	|Field 2|19	  |
	And I save the CRF
	And I verify data in CRF
	|Field  |Value|Requires Verification|
	|Field 2|19   |True                 |
	And I check Verify box for data in CRF
	|Field	|
	|Field 2|
	And I save the CRF
	And I take screenshot
	And I enter data in CRF
	|Field	|Value|
	|Field 2|18   |
	And I save the CRF
	And I verify data in CRF
	|Field  |Value|Requires Verification|
	|Field 2|18   |True                 |
	And I take screenshot
	And I go to Audits for Field "Field 1"
	Then I verify Audits exist
	|Audit Message         |
	|User entered '18'     |
	|DataPoint Un-verified.|
	|DataPoint Verified.   |
	|User entered '19'     |
	And I take screenshot

@release_2012.1.0
@PB-DT13622-08
@WIP
Scenario: As an EDC user, when I have TSDV turned off for a form, and I have an edit check that sets a field to require verification, and I verify the data for the form, and I change the data, and the verification is broken, then I should see an audit recorded for the unverification.
	When I create a Subject
	|Field			 |Value|
	|Subject Number	 |108  |
	|Subject Initials|SUBJ |	
	And I am on CRF page "Form 2" in Subject "108SUBJ" in Site "Site 1" in Study "Mediflex"
	And I enter data in CRF
	|Field	|Value|
	|Field 2|19	  |
	And I save the CRF
	And I verify data in CRF
	|Field  |Value|Requires Verification|
	|Field 2|19   |True                 |
	And I check Verify box for data in CRF
	|Form  |
	|Form 2|
	And I save the CRF
	And I take screenshot
	And I enter data in CRF
	|Field	|Value|
	|Field 2|18   |
	And I save the CRF
	And I verify data in CRF
	|Field  |Value|Requires Verification|
	|Field 2|18   |True                 |
	And I take screenshot
	And I go to Audits for Field "Field 1"
	Then I verify Audits exist
    |Audit Message         |
	|User entered '18'     |
	|DataPoint Un-verified.|
	|DataPoint Verified.   |
	|User entered '19'     |
	And I take screenshot



