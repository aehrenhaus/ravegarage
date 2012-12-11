# Derivations that use the Step Function Add, Subtract, Multiply or Divide should not derive to Null when one of the fields involved in the derviation is not numeric and the derivation uses User Value and not Standard Value.

Feature: US19302_DT14205 The derivation field will always derive to NULL when one of the source fields is of char (text) data format.
	Derivations that use the Step Function Add, Subtract, Multiply or Divide should not derive to Null when one of the fields involved in the derviation is not numeric and the derivation uses User Value and not Standard Value.
	As a Rave user
	When create a Derivation
	And I use the Step Function Add, Subtract, Multiply or Divide
	And I save data in Rave
	Then my derivation derives to Null
	
Background:
	Given xml draft "US19032_DT14205_Draft_1.xml" is Uploaded
	Given Site "Site 1" exists
	Given study "US19032_DT14205" is assigned to Site "Site 1"
	Given I publish and push eCRF "US19032_DT14205_Draft_1.xml" to "Version 1"
	Given following Project assignments exist
		| User 		   | Project 		 | Environment| Role         | Site  | SecurityRole 		 |
		| SUPER USER 1 | US19032_DT14205 | Live: Prod | SUPER ROLE 1 | Site 1| Project Admin Default |

#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_2012.1.0
@PB_US19302_DT14205_01
@Validation	
Scenario: PB_US19302_DT14205_01 As a Study Coordinator, when I submit 'Standard Derivations' form which has check steps with standard value, then remaining fields are automatically calculated.
	
	Given I login to Rave with user "SUPER USER 1"
	And I create a Subject
		| Field            | Data              | Control Type |
		| Subject Initials | SUB               | textbox      |
		| Subject Number   | {RndNum<num1>(5)} | textbox      |
	And I select Form "Standard Derivations" in Folder "Derivations"
	When I enter data in CRF
		| Field          | Data                 | Control Type |
		| Start Date     | 01 Jan 2010 01 01 01 |              |
		| Number         | 20                   | textbox      |
		| String 1       | TEST                 | textbox      |
		| String 2       | SUB                  | textbox      |
		| TimeSpan Start | 01 Jan 2010 01 01 01 |              |
		| TimeSpan End   | 01 Jan 2050 01 01 01 |              |
		| Number 1       | 10                   | textbox      |
		| Number 2       | 5                    | textbox      |
		| Date Of Birth  | 01 Jan 1975          | dateTime     |
	And I save the CRF page
	Then I verify data on Fields in CRF
		| Field             | Data                 |
		| Number Added      | 15                   |
		| Number Multiplied | 50                   |
		| Number Divided    | 2.000                |
		| Number Subtract   | 5                    |
		| Age Field         | 37                   |
		| AddDay Field      | 03 Jan 2010          |
		| AddMonth Field    | 01 Mar 2010          |
		| AddYear Field     | 01 Jan 2012          |
		| AddSec Field      | 01 Jan 2010 01:01:03 |
		| AddMin Field      | 01 Jan 2010 01:03:01 |
		| AddHour Field     | 01 Jan 2010 03:01:01 |
		| TimeSpan Field    | 21038400             |
		| StringAdd Field   | TESTSUB              |
		| Space Field       | TEST SUB             |
	And I take a screenshot

#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_2012.1.0
@PB_US19302_DT14205_02
@Validation	
Scenario: PB_US19302_DT14205_02 As a Study Coordinator, when I submit 'Test DT Derivation' form, then remaining fields are automatically calculated.

	Given I login to Rave with user "SUPER USER 1"
	And I create a Subject
		| Field            | Data              | Control Type |
		| Subject Initials | SUB               | textbox      |
		| Subject Number   | {RndNum<num1>(5)} | textbox      |
	And I select Form "Test DT Derivation" in Folder "Derivations"
	When I enter data in CRF and save
		| Field    | Data |
		| Number 1 | 2    |
		| Number 2 | 2    |
		| Number 3 | 2    |
		| Number 4 | 2    |
	Then I verify data on Fields in CRF
		| Field | Data |
		| Total | 8    |
	And I take a screenshot

#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_2012.1.0
@PB_US19302_DT14205_04
@Validation	
Scenario: PB_US19302_DT14205_03 As a Study Coordinator, when I submit 'User Derivations' form which has check steps with user value, then remaining fields are automatically calculated.

	Given I login to Rave with user "SUPER USER 1"
	And I create a Subject
		| Field            | Data              | Control Type |
		| Subject Initials | SUB               | textbox      |
		| Subject Number   | {RndNum<num1>(5)} | textbox      |
	And I select Form "User Derivations" in Folder "Derivations"
	When I enter data in CRF and save
		| Field   | Data |
		| STRFLD1 | 10   |
		| STRFLD2 | 20   |
		| NUMFLD1 | 10   |
		| NUMFLD2 | 20   |
	Then I verify data on Fields in CRF
		| Field        | Data   |
		| SUMM_STR     | 30.00  |
		| SUMM_STR_NUM | 30.00  |
		| SUMM_NUM_STR | 30.00  |
		| SUMM_ADD_STR | 1020   |
		| DIFF_STR_NUM | -10.00 |
		| DIFF_NUM_STR | -10.00 |
		| MULT_STR     | 200.00 |
		| MULT_STR_NUM | 200.00 |
		| MULT_NUM_STR | 200.00 |
		| DIV_STR      | 0.50   |
		| DIV_STR_NUM  | 0.50   |
		| DIV_NUM_STR  | 0.50   |
	And I take a screenshot

#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_2012.1.0
@PB_US19302_DT14205_03
@Validation	
Scenario: PB_US19302_DT14205_04 As a Study Coordinator, when I submit 'Standard Derivation' form which has check steps with standard value, then remaining fields are automatically calculated.

	Given I login to Rave with user "SUPER USER 1"
	And I create a Subject
		| Field            | Data              | Control Type |
		| Subject Initials | SUB               | textbox      |
		| Subject Number   | {RndNum<num1>(5)} | textbox      |
	And I select Form "Standard Derivation" in Folder "Derivations"
	When I enter data in CRF and save
		| Field   | Data |
		| STRFLD1 | 10   |
		| STRFLD2 | 20   |
		| NUMFLD1 | 10   |
		| NUMFLD2 | 20   |
	Then I verify data on Fields in CRF
		| Field        | Data   |
		| SUMM_STR     | 30.00  |
		| SUMM_STR_NUM | 30.00  |
		| SUMM_NUM_STR | 30.00  |
		| SUMM_ADD_STR | 1020   |
		| DIFF_STR_NUM | -10.00 |
		| DIFF_NUM_STR | -10.00 |
		| MULT_STR     | 200.00 |
		| MULT_STR_NUM | 200.00 |
		| MULT_NUM_STR | 200.00 |
		| DIV_STR      | 0.50   |
		| DIV_STR_NUM  | 0.50   |
		| DIV_NUM_STR  | 0.50   |
	And I take a screenshot

#----------------------------------------------------------------------------------------------------------------------------------------