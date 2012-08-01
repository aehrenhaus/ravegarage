Feature: US11306_DT13637 In Rave 5.6.4, in a mixed form, AltCodedValue from a standard DSL field doesn't get propagated into hidden datapoints on newly-created records.
	As a Rave user
	Given I enter a value for a dynamic searchlist field on a mixed form
	When I view the AltCodedValue for the hidden datapoints
	Then I should see the same AltCodedValue for the standard datapoint of the dynamic searchlist field

# In 5.6.4 (DT 11659 fixed the same issue on Rave v5.6.3)
# A form has standard and log fields.  One of the standard fields uses Dynamic Search List as the control type.  After initially submitting the datapage, and later creating a new log line, value for "AltCodedValue"  doesn't get propagated to the newly-created records in the database.  
# There must exist a mixed form with a standard field and a standard dynamic searchlist field.

Background:
    Given I am logged in to Rave with username "defuser" and password "password"
	And following Project assignments exist
		|User	|Project	|Environment	|Role |Site	  |Site Number	|
		|User 1 |Mediflex	|Prod			|cdm1 |Site 1 |S100			|
    And Role "cdm1" has Action "Entry"
	And Project "Mediflex" has Draft "<Draft1>"
	And Draft "<Draft1>" has Form "Device Form" with fields
		| FieldOID    | Data Dictionary | Control Type       | IsLog |
		| DEVICETYPE  | DeviceTypeDD    | RadioButton        | False |
		| DEVICE      | DeviceDD        | Dynamic SearchList | False |
		| DEVIMPDATE  | N/A             | DateTime           | True  |
		| DEVCOMMENTS | N/A             | LongText           | True  |
	And Data Dictionary "DeviceTypDDe" has entries
		| User Value    | Coded Value |
		| Device Type 1 | DVT1        |
		| Device Type 2 | DVT2        |
	And Data Dictionary "DeviceDD" has entries
		| User Value | Coded Value |
		| Device 1A  | DVT1 -DV1A  |
		| Device 1B  | DVT1 -DV1B  |
		| Device 2A  | DVT2 -DV2A  |
		| Device 2B  | DVT2 -DV2B  |
	And Field "Device" on Form "Device Form" has Edit Check "Device DSL Check" using Custom Function "Lookup Device CF"
	And I publish and push CRF Version "CRF Version<RANDOMNUMBER>" of Draft "Draft 1" to site "Site 1" in Project "Mediflex" for Enviroment "Prod"
	
	# Lookup Device CF:
	# select dbo.fnlocaldefault (userdataStringid), right(codedData,len(codedData)-3)
	# from datadictionaryentries dde join datadictionaries dd
	# on dd.datadictionaryid=dde.datadicionaryid join subject s on
	# dd.crfversionid=s.crfversionid
	# where s.subjectid=(subjectid) and rtrim(left(codedData,2))
	# ='(text='datapoint.standardvalue' fieldoid='DEVICETYPE')'
	# and dd.oid='DEVICEDD'

	# Device DSL Check:
	# Check Steps:
	# Data Value: Device Form>Device Type>DEVICETYPE>0
	# Check Function: IsPresent
	# Data Value: Device Form>Device>DEVICE>0
	# Check Function: IsPresent
	# Check Function: And
	# Check Actions:
	# Datapoint: Device Form>Device>DEVICE>0
	# Action: Set DynamicSearchList:Lookup Device CF

#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_2012.1.0	
@PB-DT13637-01
@Draft
Scenario: @PB-DT13637-01 As a Data Manager, when an EDC user enters data for a standard dynamic searchlist field, then I expect to see the AltCodedValue for that field propagated to the hidden datapoints on the log lines.

	Given I create a Subject
		| Field            | Data              |
		| Subject Number   | {RndNum<num1>(5)} |
		| Subject Initials | SUB               |
	And I am on CRF page "Device Form" in Folder "Visit 1" in Subject "101SUBJ" in Site "Site 1" in Study "Mediflex"
	And I enter data in CRF and save
		| Field                       | Data          |
		| Device Type                 | Device Type 1 |
		| Device                      | Device 1A     |
		| Date Implanted/Re-implanted | 01 JAN 2012   |
		| Comments                    | N/A           |
	And I add a new log line
	And I enter data in CRF and save
		| Field                       | Data        |
		| Date Implanted/Re-implanted | 01 MAR 2012 |
		| Comments                    | N/A         |
	And I take a screenshot
	And I navigate to "Home"
	And I navigate to "Reporter"
	And I select Report "Data Listings Report"
	And I set report parameter "Study" with table
		| Name     | Environment |
		| Mediflex | Prod        |
	And I run Report "Data Listings Report" for Study "Mediflex"
	When I click button "Submit Report"
	And I switch to "ReportViewer" window
	And i select "Clinical Views" from "Data Source"
	And I select Form "Device Form" from "Form"
	And I click button "Run"
	And I verify data
		| Subject Name   | Record Position | DEVICETYPE_RAW | DEVICETYPE_STD | DEVICE_RAW | DEVICE_STD  | DEVICE_ALTCODEDVALUE | DEVIMPDATE  | DEVCOMMENTS |
		| SUB{Var(num1)} | 1               | Device Type 1  | DVT1           | Device 1A  | DVT1 - DV1A | DV1A                 | 01 MAR 2012 | N/A         |
		| SUB{Var(num1)} | 2               | Device Type 1  | DVT1           | Device 1A  | DVT1 - DV1A | DV1A                 | 01 MAR 2012 | N/A         |
	And I take a screenshot

#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_2012.1.0	
@PB-DT13637-02
@Draft
Scenario: @PB-DT13637-02 As a Data Manager, when an EDC user enters data for a standard dynamic searchlist field, then I expect to see the AltCodedValue for that field propagated to the hidden datapoints on the log lines.
	
	Given I create a Subject
		| Field            | Data              |
		| Subject Number   | {RndNum<num2>(5)} |
		| Subject Initials | SUB               |
	And I am on CRF page "Device Form" in Folder "Visit 1" in Subject "101SUBJ" in Site "Site 1" in Study "Mediflex"
	And I enter data in CRF and save
		| Field                       | Data          |
		| Device Type                 | Device Type 1 |
		| Device                      | Device 1A     |
		| Date Implanted/Re-implanted | 01 JAN 2012   |
		| Comments                    | N/A           |
	And I select "Inactivate"
	And I choose "1" from "Inactivate"
	And I click button "Inactivate"
	And I take a screenshot
	And I enter data in CRF and save
		| Field  | Data      |
		| Device | Device 1B |
	And I take a screenshot
	And I select "Reactivate"
	And I choose "1" from "Reactivate"
	And I click button "Reactivate"
	And I take a screenshot
	And I navigate to "Home"
	And I navigate to "Reporter"
	And I select Report "Data Listings Report"
	And I set report parameter "Study" with table
		| Name     | Environment |
		| Mediflex | Prod        |
	And I run Report "Data Listings Report" for Study "Mediflex"
	When I click button "Submit Report"
	And I switch to "ReportViewer" window
	And i select "Clinical Views" from "Data Source"
	And I select Form "Device Form" from "Form"
	And I click button "Run"
	And I verify data
		| Subject Name   | Record Position | DEVICETYPE_RAW | DEVICETYPE_STD | DEVICE_RAW | DEVICE_STD  | DEVICE_ALTCODEDVALUE | DEVIMPDATE  | DEVCOMMENTS |
		| SUB{Var(num2)} | 1               | Device Type 1  | DVT1           | Device 1B  | DVT1 - DV1B | DV1B                 | 01 MAR 2012 | N/A         |
	And I take a screenshot

#----------------------------------------------------------------------------------------------------------------------------------------
		