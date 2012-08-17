# In 5.6.4 (DT 11659 fixed the same issue on Rave v5.6.3)
# A form has standard and log fields.  One of the standard fields uses Dynamic Search List as the control type.  After initially submitting the datapage, and later creating a new log line, value for "AltCodedValue"  doesn't get propagated to the newly-created records in the database.  

Feature: DT 13637 In Rave 5.6.4, in a mixed form, AltCodedValue from a standard DSL field doesn't get propagated into hidden datapoints on newly-created records.
	As a Rave user
	Given I enter a value for a dynamic searchlist field on a mixed form
	When I view the AltCodedValue for the hidden datapoints
	Then I should see the same AltCodedValue for the standard datapoint of the dynamic searchlist field

# There must exist a mixed form with a standard field and a standard dynamic searchlist field.

Background:
    Given I am logged in to Rave with username "defuser" and password "password"
	#And following Project assignments exist
	#|User	 |Project	        |Environment|Role |Site   |Site Number|
	#|User 1 |US11306_DT13637_SJ|Prod		|cdm1 |Site 1 |S100		  |
    #And Role "cdm1" has Action "Entry"
	#And Project "US11306_DT13637_SJ" has Draft "<Draft1>"
	#And Draft "<Draft1>" has Form "Device Form" with fields
	#| FieldOID    | Data Dictionary | Control Type       | IsLog |
	#| DEVICETYPE  | DeviceTypeDD    | RadioButton        | False |
	#| DEVICE      | N/A        	 | Dynamic SearchList | False |
	#| DEVIMPDATE  | N/A             | DateTime           | True  |
	#| DEVCOMMENTS | N/A             | LongText           | True  |
	#And Data Dictionary "DeviceTypDDe" has entries
	#| User Value    | Coded Value| 
	#| Device Type 1 | DVT1        |
	#| Device Type 2 | DVT2        |
	#And Data Dictionary "DeviceDD" has entries
	#| User Value | Coded Value |
	#| Device 1A  | DVT1 -DV1A  |
	#| Device 1B  | DVT1 -DV1B  |
	#| Device 2A  | DVT2 -DV2A  |
	#| Device 2B  | DVT2 -DV2B  |
	#And Field "Device" on Form "Device Form" has Edit Check "Device DSL Check" using Custom Function "Lookup Device CF"
	#And I publish and push CRF Version "CRF Version<RANDOMNUMBER>" of Draft "<Draft1>" to site "Site 1" in Project "Mediflex" for Enviroment "Prod"
	
	# Lookup Device CF:
	#select dbo.fnlocaldefault(userdataStringid), right(codedData,len(codeddata)-3)
	#from datadictionaryentries dde join datadictionaries dd
	#on dd.datadictionaryid=dde.datadictionaryid join subjects s on
	#dd.crfversionid=s.crfversionid
	#where s.subjectid = {subjectid}
	#and rtrim(left(codedData,4)) ='{text='datapoint.standardvalue' fieldoid='DEVICETYPE'}'
	#and dd.oid='DEVICEDD' '

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



@release_2012.1.0		
@PB-DT13637-01
@Draft
Scenario: PB-DT13637-01 As a Data Manager, when an EDC user enters data for a standard dynamic searchlist field, then I expect to see the AltCodedValue for that field propagated to the hidden datapoints on the log lines.
	
	When I select Study "US11306_DT13637_SJ" and Site "Site 1"
	When I create a Subject
	| Field            | Data              |
	| Subject Initials | SUB               |
	| Subject Number   | {RndNum<num1>(3)} |
		
	And I select Form "Device Form" 
	And I enter data in CRF and save
	| Field       | Data          | Control Type        |
	| Device Type | Device Type 1 | radiobutton         |
	| Device      | Device 1A     | dynamic search list |
	| Devimpdate  | 01 Jan 2012   |                     |
	| Devcomments | N/A           |                     |
	

	And I add a new log line
	And I enter data in CRF and save
	| Field       | Data        | Control Type |
	| Devimpdate  | 01 Mar 2012 |              |
	| Devcomments | N/A         |              |


	And I take a screenshot
	
	And I run SQL Script "{scriptName}"
	
	Then I should see SQL result

	| recordPosition | oid    | isHidden | isTouched | changecount | data      | AltCodedValue | datapointID | fieldid |
	| 0              | DEVICE | 0        | 1         | 1           | Device 1A | 1 -DV1A       |             |         |
	| 1              | DEVICE | 1        | 1         | 1           | Device 1A | 1 -DV1A       |             |         |
	| 2              | DEVICE | 1        | 1         | 1           | Device 1A | 1 -DV1A       |             |         |


	
@PB-DT13637-02
Scenario: PB-DT13637-02 As a Data Manager, when an EDC user enters data for a standard dynamic searchlist field, then I expect to see the AltCodedValue for that field propagated to the hidden datapoints on the log lines.
	When I select Study "US11306_DT13637_SJ" and Site "Site 1"
	When I create a Subject
		| Field            | Data              |
		| Subject Initials | SUB               |
		| Subject Number   | {RndNum<num1>(3)} |
	
	And I select "Device Form" 
	And I enter data in CRF and save
		| Field                       | Data          |  Control Type        |
		| Device Type                 | Device Type 1 |  radiobutton         |
		| Device                      | Device 1A     |  dynamic search list |
		| Date Implanted/Re-implanted | 01 Jan 2012   |                      |
		| Comments                    | N/A           |                      |

	And I inactivate log line 1
	And I take a screenshot
	And I enter data in CRF and save
		| Field  | Value     | Control Type        |
		| Device | Device 1A | dynamic search list |

	And I take a screenshot
	And I reactivate log line 1
	And I take a screenshot
	
	And I run SQL Script "{scriptName}"
	
	Then I should see SQL result
		| recordPosition | oid    | isHidden | isTouched | changecount | data      | AltCodedValue | datapointID | fieldid |
		| 0              | DEVICE | 0        | 1         | 1           | Device 1A | 1 -DV1A       |             |         |
		| 1              | DEVICE | 1        | 1         | 1           | Device 1A | 1 -DV1A       |             |         |	