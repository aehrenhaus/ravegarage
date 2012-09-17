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
	# |User |Project |Environment |Role |Site |Site Number |
	# |User 1 |Mediflex |Prod |CDM1 |LabSite01 |2426 |
	#And Role "CDM1" has Action "Lock" and "Unlock"
	#And Project "Mediflex" has Draft "Draft 1"
	#And I publish and push CRF Version "CRF Version<RANDOMNUMBER>" of Draft "Draft 1" to site "LabSite01" in Project "Mediflex" for Enviroment "Prod"
	#And the Central Lab "Mediflex Central Lab" exists
	#And the following Lab assignment exists
	# | Project | Environment | Site | Lab |
	# | Mediflex | Prod | LabSite01 | Mediflex Local Lab 1 |
	# | Mediflex | Prod | LabSite01 | Mediflex Local Lab 2 |
	# | Mediflex | Prod | LabSite01 | Mediflex Central Lab |

	# And the following Lab Unit Dictionary exists
	#	 | Name              | Units          |
	#	 | WBCREGAQT         | *10E6/ulREGAQT |
	#	 | WBCREGAQT         | FractionREGAQT |
	#	 | NeutrophilsREGAQT | *10E6/ulREGAQT |
	#	 | NeutrophilsREGAQT | FractionREGAQT |

	# And the following Analytes exists
		# | Analytes    | Lab Unit Dictionary |
		# | WBC         | WBCREGAQT           |
		# | Neutrophils | NeutrophilsREGAQT   |

	# And the following Standard Group Exists with Entries and their related Analytes and Units
		# | Standard Group | Analyte           | Units				|
		# | USREGAQT       | NeutrophilsREGAQT | FractionREGAQT     |
		# | USREGAQT       | WBCREGAQT         | *10E6/ulREGAQT     |

	#And the following Range Types Exists
		#| Range Type     |
		#| StandardREGAQT |

	#And the following Central Labs Exists
		#| Central Labs         | Range Type     |
		#| Mediflex Central Lab | StandardREGAQT |

	#And the following Reference Lab Exists
		#| Type          | Name                 | Range Type      |
		#| Reference Lab | ReferenceLab_1REGAQT | StandardREGAQTe |

	#And the following Alert Lab Exists
		#| Type      | Name             | Range Type      |
		#| Alert Lab | AlertLab_1REGAQT | StandardREGAQTe |

	#And the following Local Labs Exsits
		#| Type      | Name                 | Range Type     |
		#| Local Lab | Mediflex Local Lab 1 | StandardREGAQT |
		#| Local Lab | Mediflex Local Lab 2 | StandardREGAQT |
		#| Local Lab | Mediflex Local Lab 3 | StandardREGAQT |

	#And the following Lab Settings Exists 
		#| Standard Units | Reference Labs       | Alert Labs       |
		#| USREGAQT       | ReferenceLab_1REGAQT | AlertLab_1REGAQT |

	#And the following Analyte Ranges Exsits
		#| Analyte     | From Date   | To Date     | Low Value | High Value | Units  | Dictionary | Comments |
		#| Neutrophils | 01 Jan 2000 | 01 Jan 2020 | 10        | 20         | 10^9/L | ...        |          |
		#| WBC         | 01 Jan 2000 | 01 Jan 2020 | 10        | 20         | 10^9/L | ...        |          |
	
	# And I Checked box for "Normalized Lab View Name" in Configuration
	# And I Type
		# | Normalized Lab View Name |
		# | AnalytesView             |

#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_2012.1.0
@PB-DT10514-01
@Validation	
Scenario: @PB-DT10514-01 As an EDC user, I have a partially locked lab form, and I change the selected lab to another local lab, then I should see the ranges update for all lab datapoints.

	And I select Study "Mediflex" and Site "LabSite01"
	And I create a Subject
		| Field            | Data              | Control Type |
		| Subject Number   | {RndNum<num1>(5)} | textbox      |
		| Subject Initials | SUB               | textbox      |
		| Pregancy Status  | NoREGAQT          | dropdownlist |
	And I select Form "Visit Date" in Folder "Visit 1"
	And I enter data in CRF and save
		| Field | Data         | Control Type |
		| Age   | 22           | text         |
		| Sex   | FemaleREGAQT | dropdownlist |
	And I select Form "Hematology" in Folder "Visit 2"
	And I choose "Mediflex Local Lab 1" from "Lab"
	And I enter data in CRF and save
		| Field       | Data        | Control Type |
		| Lab Date    | 15 Aug 2012 | datetime     |
		| WBC         | 7           | text         |
		| NEUTROPHILS | 7           | text         |
	And I verify lab ranges
		| Field       | Data | Range Status | Range | Unit           | Status Icon |
		| WBC         | 7    | ++           | 2 - 5 | *10E6/ulREGAQT | Incomplete  |
		| NEUTROPHILS | 7    | +            | 3 - 6 | FractionREGAQT | Complete    |
	And I take a screenshot
	And I check "Hard Lock" in "Lab Date"
	And I check "Hard Lock" in "WBC"
	And I check "Hard Lock" in "NEUTROPHILS"
	And I save the CRF page
	And I take a screenshot
	And I uncheck "Hard Lock" in "WBC"
	And I save the CRF page
	And I verify lab ranges
		| Field       | Data | Range Status | Range | Unit           | Status Icon |
		| WBC         | 7    | ++           | 2 - 5 | *10E6/ulREGAQT | Incomplete  |
		| NEUTROPHILS | 7    | +            | 3 - 6 | FractionREGAQT | Locked      |
	And I take a screenshot
	When I select Lab "Mediflex Local Lab 2"
	Then I verify lab ranges
		| Field       | Data | Range Status | Range | Unit           | Status Icon |
		| WBC         | 7    | ++           | 2 - 4 | *10E6/ulREGAQT | Incomplete  |
		| NEUTROPHILS | 7    |              | 4 - 7 | FractionREGAQT | Complete    |
	And I take a screenshot

#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_2012.1.0
@PB-DT10514-02
@Validation	
Scenario: @PB-DT10514-02 As an EDC user, I have a partially locked lab form, and I change the selected lab to another local lab, then I should see the ranges update for all lab datapoints.

	And I select Study "Mediflex" and Site "LabSite01"
	And I create a Subject
		| Field            | Data              | Control Type |
		| Subject Number   | {RndNum<num1>(5)} | textbox      |
		| Subject Initials | SUB               | textbox      |
		| Pregancy Status  | NoREGAQT          | dropdownlist |
	And I select Form "Visit Date" in Folder "Visit 1"
	And I enter data in CRF and save
		| Field | Data         | Control Type |
		| Age   | 22           | text         |
		| Sex   | FemaleREGAQT | dropdownlist |
	And I select Form "Hematology" in Folder "Visit 2"
	And I choose "Mediflex Local Lab 1" from "Lab"
	And I enter data in CRF and save
		| Field       | Data        | Control Type |
		| Lab Date    | 15 Aug 2012 | datetime     |
		| WBC         | 7           | text         |
		| NEUTROPHILS | 7           | text         |
	And I verify lab ranges
		| Field       | Data | Range Status | Range | Unit           | Status Icon |
		| WBC         | 7    | ++           | 2 - 5 | *10E6/ulREGAQT | Incomplete  |
		| NEUTROPHILS | 7    | +            | 3 - 6 | FractionREGAQT | Complete    |
	And I take a screenshot
	And I check "Hard Lock" in "Lab Date"
	And I check "Hard Lock" in "WBC"
	And I check "Hard Lock" in "NEUTROPHILS"
	And I save the CRF page
	And I take a screenshot
	And I uncheck "Hard Lock" in "WBC"
	And I save the CRF page
	And I verify lab ranges
		| Field       | Data | Range Status | Range | Unit           | Status Icon |
		| WBC         | 7    | ++           | 2 - 5 | *10E6/ulREGAQT | Incomplete  |
		| NEUTROPHILS | 7    | +            | 3 - 6 | FractionREGAQT | Locked      |
	And I take a screenshot
	When I select Lab "Mediflex Local Lab 3"
	Then I verify lab ranges
		| Field       | Data | Range Status | Range | Unit           | Status Icon |
		| WBC         | 7    | ++           | 4 - 7 | *10E6/ulREGAQT | Incomplete  |
		| NEUTROPHILS | 7    | +            | 2 - 5 | FractionREGAQT | Locked      |
	And I take a screenshot

#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_2012.1.0
@PB-DT10514-03
@Validation	
Scenario: @PB-DT10514-03 As an EDC user, I have a partially locked lab form, and I change the selected lab to central lab, then I should see the ranges update for all lab datapoints.

	And I select Study "Mediflex" and Site "LabSite01"
	And I create a Subject
		| Field            | Data              | Control Type |
		| Subject Number   | {RndNum<num1>(5)} | textbox      |
		| Subject Initials | SUB               | textbox      |
		| Pregancy Status  | NoREGAQT          | dropdownlist |
	And I select Form "Visit Date" in Folder "Visit 1"
	And I enter data in CRF and save
		| Field | Data         | Control Type |
		| Age   | 22           | text         |
		| Sex   | FemaleREGAQT | dropdownlist |
	And I select Form "Hematology" in Folder "Visit 2"
	And I choose "Mediflex Local Lab 1" from "Lab"
	And I enter data in CRF and save
		| Field       | Data        | Control Type |
		| Lab Date    | 15 Aug 2012 | datetime     |
		| WBC         | 7           | text         |
		| NEUTROPHILS | 7           | text         |
	And I verify lab ranges
		| Field       | Data | Range Status | Range | Unit           | Status Icon |
		| WBC         | 7    | ++           | 2 - 5 | *10E6/ulREGAQT | Incomplete  |
		| NEUTROPHILS | 7    | +            | 3 - 6 | FractionREGAQT | Complete    |
	And I take a screenshot
	And I check "Hard Lock" in "Lab Date"
	And I check "Hard Lock" in "WBC"
	And I check "Hard Lock" in "NEUTROPHILS"
	And I save the CRF page
	And I take a screenshot
	And I uncheck "Hard Lock" in "WBC"
	And I save the CRF page
	And I verify lab ranges
		| Field       | Data | Range Status | Range | Unit           | Status Icon |
		| WBC         | 7    | ++           | 2 - 5 | *10E6/ulREGAQT | Incomplete  |
		| NEUTROPHILS | 7    | +            | 3 - 6 | FractionREGAQT | Locked      |
	And I take a screenshot
	When I select Lab "Central - Mediflex Central Lab"
	Then I verify lab ranges
		| Field       | Data | Range Status | Range | Unit           | Status Icon |
		| WBC         | 7    | ++           | 2 - 8 | *10E6/ulREGAQT | Incomplete  |
		| NEUTROPHILS | 7    |              | 4 - 9 | FractionREGAQT | Complete    |
	And I take a screenshot

#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_2012.1.0
@PB-DT10514-04
@Validation	
Scenario: @PB-DT10514-04 As an EDC user, I have a partially locked lab form, and I change the selected central lab to local lab, then I should see the ranges update for all lab datapoints.

	And I select Study "Mediflex" and Site "LabSite01"
	And I create a Subject
		| Field            | Data              | Control Type |
		| Subject Number   | {RndNum<num1>(5)} | textbox      |
		| Subject Initials | SUB               | textbox      |
		| Pregancy Status  | NoREGAQT          | dropdownlist |
	And I select Form "Visit Date" in Folder "Visit 1"
	And I enter data in CRF and save
		| Field | Data         | Control Type |
		| Age   | 22           | text         |
		| Sex   | FemaleREGAQT | dropdownlist |
	And I select Form "Hematology" in Folder "Visit 2"
	And I select Lab "Central - Mediflex Central Lab"
	And I enter data in CRF and save
		| Field       | Data        | Control Type |
		| Lab Date    | 15 Aug 2012 | datetime     |
		| WBC         | 7           | text         |
		| NEUTROPHILS | 7           | text         |
	And I verify lab ranges
		| Field       | Data | Range Status | Range | Unit           | Status Icon |
		| WBC         | 7    | ++           | 2 - 8 | *10E6/ulREGAQT | Incomplete  |
		| NEUTROPHILS | 7    |              | 4 - 9 | FractionREGAQT | Complete    |
	And I take a screenshot
	And I check "Hard Lock" in "Lab Date"
	And I check "Hard Lock" in "WBC"
	And I check "Hard Lock" in "NEUTROPHILS"
	And I save the CRF page
	And I take a screenshot
	And I uncheck "Hard Lock" in "NEUTROPHILS"
	And I save the CRF page
	And I verify lab ranges
		| Field       | Data | Range Status | Range | Unit           | Status Icon |
		| WBC         | 7    | ++           | 2 - 8 | *10E6/ulREGAQT | Locked      |
		| NEUTROPHILS | 7    |              | 4 - 9 | FractionREGAQT | Complete    |
	And I take a screenshot
	When I choose "Mediflex Local Lab 1" from "Lab"
	Then I verify lab ranges
		| Field       | Data | Range Status | Range | Unit           | Status Icon |
		| WBC         | 7    | ++           | 2 - 5 | *10E6/ulREGAQT | Locked      |
		| NEUTROPHILS | 7    | +            | 3 - 6 | FractionREGAQT | Complete    |
	And I take a screenshot

#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_2012.1.0
@PB-DT10514-05
@Validation	
Scenario: @PB-DT10514-05 As an EDC user, I have a partially locked lab form, and I change the selected lab to Units Only lab, then I should see the ranges update for all lab datapoints.

	And I select Study "Mediflex" and Site "LabSite02"
	And I create a Subject
		| Field            | Data              | Control Type |
		| Subject Number   | {RndNum<num1>(5)} | textbox      |
		| Subject Initials | SUB               | textbox      |
		| Pregancy Status  | NoREGAQT          | dropdownlist |
	And I select Form "Visit Date" in Folder "Visit 1"
	And I enter data in CRF and save
		| Field | Data         | Control Type |
		| Age   | 22           | text         |
		| Sex   | FemaleREGAQT | dropdownlist |
	And I select Form "Hematology" in Folder "Visit 2"
	And I choose "Mediflex Local Lab 3" from "Lab"
	And I enter data in CRF and save
		| Field       | Data        | Control Type |
		| Lab Date    | 15 Aug 2012 | datetime     |
		| WBC         | 7           | text         |
		| NEUTROPHILS | 7           | text         |
	And I verify lab ranges
		| Field       | Data | Range Status | Range | Unit           | Status Icon |
		| WBC         | 7    | ++           | 1 - 5 | *10E6/ulREGAQT | Incomplete  |
		| NEUTROPHILS | 7    |	            | 3 - 7 | FractionREGAQT | Complete    |
	And I take a screenshot
	And I check "Hard Lock" in "Lab Date"
	And I check "Hard Lock" in "WBC"
	And I check "Hard Lock" in "NEUTROPHILS"
	And I save the CRF page
	And I take a screenshot
	And I uncheck "Hard Lock" in "WBC"
	And I save the CRF page
	And I verify lab ranges
		| Field       | Data | Range Status | Range | Unit           | Status Icon |
		| WBC         | 7    | ++           | 1 - 5 | *10E6/ulREGAQT | Incomplete  |
		| NEUTROPHILS | 7    |              | 3 - 7 | FractionREGAQT | Locked      |
	And I take a screenshot
	And I select Lab "Units Only"
	And I verify lab ranges
		| Field       | Data | Range Status | Range | Unit | Status Icon |
		| WBC         | 7    |              |       |      | Incomplete  |
		| NEUTROPHILS | 7    |              |       |      | Locked      |
	And I take a screenshot
	When I select Unit
		| Field       |Unit           |
		| WBC         |*10E6/ulREGAQT |
		| NEUTROPHILS |FractionREGAQT |
	And I save the CRF page
	Then I verify lab ranges
		| Field       | Data | Range Status | Range | Unit           | Status Icon |
		| WBC         | 7    | ++           | 2 - 4 | *10E6/ulREGAQT | Incomplete  |
		| NEUTROPHILS | 7    |              | 4 - 7 | FractionREGAQT | Locked      |
	And I take a screenshot

#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_2012.1.0
@PB-DT10514-06
@Validation	
Scenario: @PB-DT10514-06 As an EDC user, I have a locked lab form, and I set lab variable, then I should see the ranges update for all lab datapoints.

	And I select Study "Mediflex" and Site "LabSite01"
	And I create a Subject
		| Field            | Data              | Control Type |
		| Subject Number   | {RndNum<num1>(5)} | textbox      |
		| Subject Initials | SUB               | textbox      |
	And I select Form "Visit Date" in Folder "Visit 1"
	And I enter data in CRF and save
		| Field | Data         | Control Type |
		| Age   | 22           | text         |
		| Sex   | FemaleREGAQT | dropdownlist |
	And I select Form "Hematology" in Folder "Visit 2"
	And I choose "Mediflex Local Lab 1" from "Lab"
	And I enter data in CRF and save
		| Field       | Data        | Control Type |
		| Lab Date    | 15 Aug 2012 | datetime     |
		| WBC         | 7           | text         |
		| NEUTROPHILS | 7           | text         |
	And I verify lab ranges
		| Field       | Data | Range Status | Range | Unit | Status Icon |
		| WBC         | 7    |              |       |      | Incomplete  |
		| NEUTROPHILS | 7    |              |       |      | Incomplete  |
	And I take a screenshot
	And I check "Hard Lock" in "Lab Date"
	And I check "Hard Lock" in "WBC"
	And I check "Hard Lock" in "NEUTROPHILS"
	And I save the CRF page
	And I verify lab ranges
		| Field       | Data | Range Status | Range | Unit | Status Icon |
		| WBC         | 7    |              |       |      | Locked      |
		| NEUTROPHILS | 7    |              |       |      | Locked      |
	And I take a screenshot
	And I select link "SUB{Var(num1)}"
	And I select link "SubjectEnrollment"
	And I enter data in CRF and save
		| Field            | Data        | Control Type |
		| Pregancy Status  | NoREGAQT    | dropdownlist |
	When I select Form "Hematology" in Folder "Visit 2"
	Then I verify lab ranges
		| Field       | Data | Range Status | Range | Unit           | Status Icon |
		| WBC         | 7    | ++           | 2 - 5 | *10E6/ulREGAQT | Incomplete  |
		| NEUTROPHILS | 7    | +            | 3 - 6 | FractionREGAQT | Complete    |
	And I take a screenshot

#----------------------------------------------------------------------------------------------------------------------------------------