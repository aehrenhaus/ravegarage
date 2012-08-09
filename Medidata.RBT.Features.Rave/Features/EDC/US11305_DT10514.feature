Feature: US11305_DT10514 
	As a Rave user
	When a lab form is partially locked
	And I change the selected lab
	Then I expect to see lab ranges from the new lab for the lab data
	So that I can reference the applicable lab ranges

# Datapoints in same lab datapage may associate analyte ranges of different labs.

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
@release_564_2012.1.0
@PB-DT10514-01
@Draft		
Scenario: As an EDC user, I have a partially locked lab form, and I change the selected lab, then I should see the ranges update for all lab datapoints.

	When I create a Subject
	    | Field            | Data              | Control Type |
	    | Subject Number   | {RndNum<num1>(5)} | textbox      |
	    | Subject Initials | SUB               | textbox         |
	    | Pregancy Status  | NoREGAQT          | dropdownlist |
	And I select Form "Visit Date" in Folder "Visit 1"
	And I enter data in CRF and save
		| Field | Data         | Control Type |
		| Age   | 22           | text         |
		| Sex   | FemaleREGAQT | dropdownlist |
	And I select Form "Visit Date" in Folder "Visit 2"
	And I enter data in CRF and save
		| Field | Data         | Control Type |
		| Age   | 22           | text         |
		| Sex   | FemaleREGAQT | dropdownlist |
	And I select Form "Hematology" in Folder "Visit 2"
	And I choose "Mediflex Local Lab 1" from "Lab"
	And I enter data in CRF and save
		| Field       | Data        | Control Type |
		| Lab Date    | 15 Aug 2012 | datetime     |
		| WBC         | 3           | text         |
		| NEUTROPHILS | 5           | text         |
	And I verify lab ranges
		| Field       | Data  | Range | Unit           |
		| WBC         | 3     | 1 - 5 | *10E6/ulREGAQT |
		| NEUTROPHILS | 5     | 3 - 7 | FractionREGAQT |
	And I take a screenshot
	And I check "Hard Lock" on "Lab Date"
	And I check "Hard Lock" on "WBC"
	And I check "Hard Lock" on "NEUTROPHILS"
	And I save the CRF page
	And I take a screenshot
	And I uncheck "Hard Lock" on "WBC"
	And I save the CRF page
	And I take a screenshot
	And I select Lab "Mediflex Local Lab 2"
	And I verify lab ranges
		| Field       | Data  | Range | Unit           |
		| WBC         | 3     | 1 - 6 | *10E6/ulREGAQT |
		| NEUTROPHILS | 5     | 3 - 8 | FractionREGAQT |
	And I take a screenshot
	And I select Lab "Central - Mediflex Central Lab"
	And I verify lab ranges
		| Field       | Data  | Range | Unit           |
		| WBC         | 3     | 2 - 8 | *10E6/ulREGAQT |
		| NEUTROPHILS | 5     | 4 - 9 | FractionREGAQT |
	And I take a screenshot
	
#----------------------------------------------------------------------------------------------------------------------------------------	

Scenario: Test

	When I select a Subject "SUB21807"
	And I select Form "Hematology" in Folder "Visit 2"
	And I choose "Mediflex Local Lab 1" from "Lab"
	And I enter data in CRF and save
		| Field       | Data        | Control Type |
		| Lab Date    | 15 Aug 2012 | datetime     |
		| WBC         | 3           | textbox      |
		| NEUTROPHILS | 5           | textbox      |
	And I check "Hard Lock" on "Lab Date"
	And I check "Hard Lock" on "WBC"
	And I check "Hard Lock" on "NEUTROPHILS"
	And I save the CRF page
	And I take a screenshot
	And I uncheck "Hard Lock" on "WBC"
	And I save the CRF page
	And I take a screenshot
	And I select Lab "Mediflex Local Lab 2"
	And I verify lab ranges
		| Field       | Data  | Range | Unit           |
		| WBC         | 3     | 1 - 6 | *10E6/ulREGAQT |
		| NEUTROPHILS | 5     | 3 - 8 | FractionREGAQT |
	And I take a screenshot
	And I select Lab "Central - Mediflex Central Lab"
	And I verify lab ranges
		| Field       | Data  | Range | Unit           |
		| WBC         | 3     | 2 - 8 | *10E6/ulREGAQT |
		| NEUTROPHILS | 5     | 4 - 9 | FractionREGAQT |
	And I take a screenshot