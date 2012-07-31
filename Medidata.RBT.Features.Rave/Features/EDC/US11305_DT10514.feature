Feature: DT 10514 Datapoints in same lab datapage may associate analyte ranges of different labs.
	As a Rave user
	When a lab form is partially locked
	And I change the selected lab
	Then I expect to see lab ranges from the new lab for the lab data
	So that I can reference the applicable lab ranges

Background:
    Given I am logged in to Rave with username "defuser" and password "password" 
	#And following Project assignments exist
	#	|User	|Project	|Environment	|Role |Site			|Site Number	|
	#	|User 1 |Mediflex	|Prod			|CDM1 |LabSite01	|2426			|
	#And Role "CDM1" has Action "Lock" and "Unlock"
	#And Project "Mediflex" has Draft "Draft 1"
	#And I publish and push CRF Version "CRF Version<RANDOMNUMBER>" of Draft "Draft 1" to site "LabSite01" in Project "Mediflex" for Enviroment "Prod"
	#And the Central Lab "Mediflex Central Lab" exists
	#And the following Lab assignment exists
	#	| Project  | Environment | Site      | Lab                  |
	#	| Mediflex | Prod        | LabSite01 | Mediflex Local Lab 1 |
	#	| Mediflex | Prod        | LabSite01 | Mediflex Local Lab 2 |
	#	| Mediflex | Prod        | LabSite01 | Mediflex Central Lab |
	And I select Study "Mediflex" and Site "LabSite01"
	
#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch11
@PB-DT10514-01
@Draft		
Scenario: As an EDC user, I have a partially locked lab form, and I change the selected lab, then I should see the ranges update for all lab datapoints.

	When I create a Subject
	    | Field				| Data				|
	    | Subject Number	| {RndNum<num1>(5)}	|
	    | Subject Initials	| SUBJ				|
	#	| Pregancy Status	| NoREGAQT			|
	And I select Form "Visit Date" in Folder "Visit 1"
	And I enter data in CRF and save
		| Field      | Data        |
		| Age        | 22           |
	#	| Sex        | FemaleREGAQT |
	And I select Form "Visit Date" in Folder "Visit 2"
	And I enter data in CRF and save
		| Field      | Data        |
		| Age        | 22           |
	#	| Sex        | FemaleREGAQT |
	And I select Form "Hematology" in Folder "Visit 2"
#Need Step Def
	#And I select Lab "Mediflex Local Lab 1"
	#And I enter data in CRF and save
	#	| Field       | Data       |
	#	| Lab Date    | 15 Aug 2012 |
	#	| WBC         | 3           |
	#	| NEUTROPHILS | 5           |
#Need Step Def
	#And I verify lab ranges
	#	| Field       | Data  | Range | Unit           |
	#	| WBC         | 3     | 1 - 5 | *10E6/ulREGAQT |
	#	| NEUTROPHILS | 5     | 3 - 7 | FractionREGAQT |
	And I take a screenshot
	And I check "Hard Lock" on "Lab Date"
	And I check "Hard Lock" on "WBC"
	And I check "Hard Lock" on "NEUTROPHILS"
	And I save the CRF page
	And I take a screenshot
	And I uncheck "Hard Lock" on "WBC"
	And I save the CRF page
	And I take a screenshot
	#And I select Lab "Mediflex Local Lab 2"
	#And I verify lab ranges
	#	| Field       | Data  | Range | Unit           |
	#	| WBC         | 3     | 1 - 6 | *10E6/ulREGAQT |
	#	| NEUTROPHILS | 5     | 3 - 8 | FractionREGAQT |
	And I take a screenshot
	#And I select Lab "Mediflex Central Lab"
	#And I verify lab ranges
	#	| Field       | Data  | Range | Unit           |
	#	| WBC         | 3     | 2 - 8 | *10E6/ulREGAQT |
	#	| NEUTROPHILS | 5     | 4 - 9 | FractionREGAQT |
	And I take a screenshot
	
#----------------------------------------------------------------------------------------------------------------------------------------	