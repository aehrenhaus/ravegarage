# Subject Date is being used in searching Lab variable mapping value. If subject date is not set from any datapoint value, then it defaults to the timestamp the subjects was first created.
# If the study is not built perfectly, system may not find Lab variable mapping value because of subject date.
# For example, Age is a lab variable (Closest to InputDate) and exists in each visit.
# Subject is created on 2010-01-05 and there is not any datapoint can set subject date, so subject data is 2010-01-05 too.
# Screen (2010-01-01, Age=40) -> Visit 1 (Missing, Age is empty) -> Visit2 (2010-01-20, Age=40)
# Also, these is a lab form with sample date = 2010-01-04
# Now, when system do Lab range searching, system will try to use the Age in Visit 1 which is the closest mapped variable because of subject date.
# To fix: we need to remove subject date from order by so that subject date will not affect search order. Also we need to keep all lab variable datapoints in search targets, it is to say when record date, datapage date and instance date is null for an Age datapoint, but if it is the only one in subject, it will be fetched.
@ignore
Feature: US12994_DT10991 Remove Subject Date from order by statement in searching Lab Variable Mapping Value
	Remove Subject Date from order by statement in searching Lab Variable Mapping Value
	As a Rave user
	When I skip a visit
	And enter lab data after that visit
	Then I expect to see lab ranges for the lab data
	So that I can use the Rave lab features of out of range flagging, clinical significance prompts, and lab clinical view

Background:
    Given I login to Rave with user "defuser" and password "password"
	#And following Project assignments exist
	#	| User    | Project         | Environment | Role | Site                                   | Site Number |
	#	| Defuser | US12994_DT10991 | Prod        | CDM1 | Latest Date Site                       | LDS1        |
	#	| Defuser | US12994_DT10991 | Prod        | CDM1 | Earliest Date Site                     | EDS1        |
	#	| Defuser | US12994_DT10991 | Prod        | CDM1 | Closest in Time to Lab Date Site       | CTLDS1      |
	#	| Defuser | US12994_DT10991 | Prod        | CDM1 | Closest in Time Prior to Lab Date Site | CTPLDV1     |
	#And Project "US12994_DT10991" has Draft "Earliest Date Draft"
	#And Project "US12994_DT10991" has Draft "Latest Date Draft"
	#And Project "US12994_DT10991" has Draft "Closest in Time to Lab Date Draft"
	#And Project "US12994_DT10991" has Draft "Closest in Time Prior to Lab Date Draft"
	#And Draft has "Default" Matrix with "FolderForms"
	#	| Folder  | Form       |
	#	| Visit 1 | Visit Date |
	#	| Visit 2 | Visit Date |
	#And Draft "Earliest Date Draft, Latest Date Draft, Closest in Time to Lab Date Draft, Closest in Time Prior to Lab Date Draft" has Form "Visit Date" with fields
	#	| FieldOID | Field Label       | Control Type | Data Format | IsVisible | Observation Date of Form |
	#	| Missing  | Visit is missing? | Checkbox     | 1           | True      | False                    |
	#	| VISDT    | Visit Date        | DateTime     | dd MMM yyyy | True      | True                     |
	#	| Age      | Age               | Text         | 3           | True      | False                    |
	#And Draft "Earliest Date Draft, Latest Date Draft, Closest in Time to Lab Date Draft, Closest in Time Prior to Lab Date Draft" has Form "Hematology" with fields
	#	| FieldOID | Field Label | Control Type | Data Format | IsVisible | Lab Analyte | Observation Date of Form |
	#	| SampleDT | Sample Date | DateTime     | dd MMM yyyy | True      |             | True                     |
	#	| WBC      | WBC         | Text         | 5.1         | True      | WBC         | False                    |
	#And Draft has "Lab Settings" with "Range Types"
	#	| Range Types    |
	#	| StandardREGAQT |
	#And "Range Types" with "Lab Variable Mapping"
	#	| Draft                                   | Variable  | Form       | Field | Location                          |
	#	| Earliest Date Draft                     | AgeREGAQT | Visit Date | Age   | Earliest Date                     |
	#	| Latest Date Draft                       | AgeREGAQT | Visit Date | Age   | Latest Date                       |
	#	| Closest in Time to Lab Date Draft       | AgeREGAQT | Visit Date | Age   | Closest in Time to Lab Date       |
	#	| Closest in Time Prior to Lab Date Draft | AgeREGAQT | Visit Date | Age   | Closest in Time Prior to Lab Date |
	#And I publish and push CRF Version "CRF Version<RANDOMNUMBER>" of Draft "Earliest Date Draft" to site "Earliest Date Site" in Project "US12994_DT10991" for Enviroment "Prod"
	#And I publish and push CRF Version "CRF Version<RANDOMNUMBER>" of Draft "Latest Date Draft" to site "Latest Date Site" in Project "US12994_DT10991" for Enviroment "Prod"
	#And I publish and push CRF Version "CRF Version<RANDOMNUMBER>" of Draft "Closest in Time to Lab Date Draft" to site "Closest in Time to Lab Date Site" in Project "US12994_DT10991" for Enviroment "Prod"	
	#And I publish and push CRF Version "CRF Version<RANDOMNUMBER>" of Draft "Closest in Time Prior to Lab Date Draft" to site "Closest in Time Prior to Lab Date Site" in Project "US12994_DT10991" for Enviroment "Prod"
	#And the Local Lab "US12994_DT10991 Central Lab" exists
	#And the following Lab assignment exists
	#	 | Project         | Environment | Site                                   | Lab         |
	#	 | US12994_DT10991 | Prod        | Earliest Date Site                     | Local Lab 1 |
	#	 | US12994_DT10991 | Prod        | Latest Date Site                       | Local Lab 1 |
	#	 | US12994_DT10991 | Prod        | Closest in Time to Lab Date Site       | Local Lab 1 |
	#	 | US12994_DT10991 | Prod        | Closest in Time Prior to Lab Date Site | Local Lab 1 |

#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_2012.1.0
@PB_US12994_DT10991_01
@Validation		
Scenario: PB_US12994_DT10991_01 As an EDC user, when I enter a missing date in the first Visit Date, a valid date in the second Visit Date, and a Lab Date after the second Visit Date and the lab Age variable is mapped to the Earliest date, then I should see lab ranges.
	
	And I select Study "US12994_DT10991" and Site "Earliest Date Site"
	And I create a Subject
		| Field      | Data                  | Control Type |
		| Subject ID | SUB {RndNum<num1>(5)} | textbox      |
	And I select Form "Visit Date" in Folder "Visit 1"
	And I save the CRF page
	And I take a screenshot
	And I select link "SUB {Var(num1)}"
	And I select Form "Visit Date" in Folder "Visit 2"
	And I enter data in CRF and save
		| Field      | Data        | Control Type |
		| Visit Date | 01 Feb 2011 | datetime     |
		| Age        | 20          | textbox      |
	And I take a screenshot
	And I select link "SUB {Var(num1)}"
	And I select Form "Hematology"
	And I select Lab "Local Lab 1"
	When I enter data in CRF and save
		|Field		|Data		|Control Type |
		|Sample Date|02 Feb 2011|datetime     | 
	Then I verify lab ranges
		| Field | Data | Range Status | Range | Unit   | Status Icon |
		| WBC   |      |              | 2 - 8 | 10^9/L | Complete    |
	And I take a screenshot

#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_2012.1.0
@PB_US12994_DT10991_02
@Validation
Scenario: PBUS12994_DT10991_02 As an EDC user, when I enter a missing date in the first Visit Date, a valid date in the second Visit Date, and a Lab Date after the second Visit Date and the lab Age variable is mapped to the Latest date, then I should see lab ranges.
	
	And I select Study "US12994_DT10991" and Site "Latest Date Site"
	And I create a Subject
		| Field      | Data                  | Control Type |
		| Subject ID | SUB {RndNum<num1>(5)} | textbox      |
	And I select link "SUB {Var(num1)}"
	And I select Form "Visit Date" in Folder "Visit 2"
	And I enter data in CRF and save
		| Field      | Data        | Control Type |
		| Visit Date | 01 Feb 2011 | datetime     |
		| Age        | 20          | textbox      |
	And I take a screenshot
	And I select link "SUB {Var(num1)}"
	And I select Form "Hematology"
	And I select Lab "Local Lab 1"
	When I enter data in CRF and save
		|Field		|Data		|Control Type |
		|Sample Date|02 Feb 2011|datetime     | 
	Then I verify lab ranges
		| Field | Data | Range Status | Range | Unit   | Status Icon |
		| WBC   |      |              | 2 - 8 | 10^9/L | Complete    |
	And I take a screenshot

#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_2012.1.0
@PB_US12994_DT10991_03
@Validation
Scenario: PB_US12994_DT10991_03 As an EDC user, when I enter a missing date in the first Visit Date, a valid date in the second Visit Date, and a Lab Date after the second Visit Date and the lab Age variable is mapped to the Closest in time to the lab date, then I should see lab ranges.
	
	And I select Study "US12994_DT10991" and Site "Closest in Time to Lab Date Site"
	And I create a Subject
		| Field      | Data                  | Control Type |
		| Subject ID | SUB {RndNum<num1>(5)} | textbox      |
	And I select link "SUB {Var(num1)}"
	And I select Form "Visit Date" in Folder "Visit 2"
	And I enter data in CRF and save
		| Field      | Data        | Control Type |
		| Visit Date | 01 Feb 2011 | datetime     |
		| Age        | 20          | textbox      |
	And I take a screenshot
	And I select link "SUB {Var(num1)}"
	And I select Form "Hematology"
	And I select Lab "Local Lab 1"
	When I enter data in CRF and save
		|Field		|Data		|Control Type |
		|Sample Date|02 Feb 2011|datetime     | 
	Then I verify lab ranges
		| Field | Data | Range Status | Range | Unit   | Status Icon |
		| WBC   |      |              | 2 - 8 | 10^9/L | Complete    |
	And I take a screenshot

#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_2012.1.0
@PB_US12994_DT10991_04
@Validation
Scenario: PB_US12994_DT10991_04 As an EDC user, when I enter a missing date in the first Visit Date, a valid date in the second Visit Date, and a Lab Date after the second Visit Date and the lab Age variable is mapped to the Closest in time prior to lab date, then I should see lab ranges.
	
	And I select Study "US12994_DT10991" and Site "Closest in Time Prior to Lab Date Site"
	And I create a Subject
		| Field      | Data                  | Control Type |
		| Subject ID | SUB {RndNum<num1>(5)} | textbox      |
	And I select link "SUB {Var(num1)}"
	And I select Form "Visit Date" in Folder "Visit 2"
	And I enter data in CRF and save
		| Field      | Data        | Control Type |
		| Visit Date | 01 Feb 2011 | datetime     |
		| Age        | 20          | textbox      |
	And I take a screenshot
	And I select link "SUB {Var(num1)}"
	And I select Form "Hematology"
	And I select Lab "Local Lab 1"
	When I enter data in CRF and save
		|Field		|Data		|Control Type |
		|Sample Date|02 Feb 2011|datetime     | 
	Then I verify lab ranges
		| Field | Data | Range Status | Range | Unit   | Status Icon |
		| WBC   |      |              | 2 - 8 | 10^9/L | Complete    |
	And I take a screenshot

