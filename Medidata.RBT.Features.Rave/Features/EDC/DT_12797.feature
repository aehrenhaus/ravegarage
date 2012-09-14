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

	# Edit check exists to set field Visit Date on form Visit Date to require review if field Age has a value less than 18.
	# Edit check exists to set field Field 1 on form Form 1 to require review if field Field 1 has a value other than 20.
	# Edit check exists to set field DOB on form Form 2 to require review if field Age has a value less than 18.
	# Derivation exists to derive field Age on Form 2 from field Visit Date and DOB on Form 2.			
	# Edit check exists to set field Field 2 on form Form 2 to require review if field Field 1 has a value other than 20.
	
@release_2012.1.0 
@PB-DT12797-01
@WIP
Scenario: As an EDC user, when I have an edit check fired on one field that sets another field to require review and I see the requires review icon, then I should see the review box enabled.
	
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
	|Field     |Value      |Requires Review|
	|Visit Date|01 FEB 2011|False          |
	|Age       |20         |False          |
	And I enter data in CRF
	|Field|Value|
	|Age  |17   |
	And I save the CRF
	Then I verify Requires Review icon is displayed for Visit Date field 
	And I verify data in CRF
	|Field     |Value      |Requires Review|
	|Visit Date|01 FEB 2011|True           |
	|Age       |17         |False          |
	And I verify data in CRF
	| Form       | Requires Review |
	| Visit Date | True            |
	And I take screenshot

@release_2012.1.0
@PB-DT12797-02
@WIP
Scenario: As an EDC user, when I have an edit check that sets a field to require review and I see the requires review icon, I review the data for the field, and I change the data, then I should see the review box enabled.
	
	When I create a Subject
	|Field			 |Value|
	|Subject Number	 |102  |
	|Subject Initials|SUBJ |	
	And I am on CRF page "Form 1" in Subject "102SUBJ" in Site "Site 1" in Study "Mediflex"
	And I enter data in CRF
	|Field	|Value|
	|Field 1|19	  |
	And I save the CRF
	And I verify Requires Review icon is displayed for Field 1 field
	And I verify data in CRF
	|Field  |Value|Requires Review|
	|Field 1|19   |True           |
	And I verify data in CRF
	| Form   | Requires Review |
	| Form 1 | True            |
	And I take screenshot
	And I check Review box for data in CRF
	|Field	|
	|Field 1|
	And I save the CRF
	And I take screenshot
	And I enter data in CRF
	|Field	|Value|
	|Field 1|18   |
	And I save the CRF
	Then I verify Requires Review icon is displayed for Field 1 field
	And I verify data in CRF
	|Field  |Value|Requires Review|
	|Field 1|18   |True           |
	And I verify data in CRF
	| Form   | Requires Review |
	| Form 1 | True            |
	And I take screenshot
	
@release_2012.1.0
@PB-DT12797-03
@WIP
Scenario: As an EDC user, when I have an edit check fired on a field that is derived to sets another field to require review and I see the requires review icon, then I should see the review box enabled.
	
	When I create a Subject
	|Field			 |Value|
	|Subject Number	 |103  |
	|Subject Initials|SUBJ |	
	And I am on CRF page "Form 2" in Subject "103SUBJ" in Site "Site 1" in Study "Mediflex"
	And I enter data in CRF
	|Field     |Value      |
	|DOB       |05 Mar 1995|
	|Visit Date|10 Dec 2011|
	And I save the CRF
	And I verify Requires Review icon is displayed for DOB field
	And I verify data in CRF
	|Field     |Value      |Requires Review|
	|DOB       |05 Mar 1995|True           | 
	|Visit Date|10 Dec 2011|False          | 
	|Age       |16         |False          |
	And I verify data in CRF
	| Form   | Requires Review |
	| Form 2 | True            |
	And I take screenshot
	

