# When All Upper Case is selected in the Configuration Other Settings and my Locale is Japanese, the month component of the date, and the meridian component of the time, should be displayed in uppercase.

@ignore
Feature: US10246_DT13300 When All Upper Case is selected in the Configuration Other Settings and my Locale is Japanese, the month component of the date, and the meridian component of the time, should be displayed in uppercase.
	The month component of the date in a date field, and the meridian component of the time in a time field, should be displayed in uppercase when All Upper Case is selected in Configuration and Locale is set to Japanese
	As a Rave Administrator
	When I have selected All Upper Case in Configuration > Other Settings
	And my Locale is set to Japanese in My Profile
	And I enter data for datetime fields
	Then the month component of the date in all date fields should be in uppercase
	And the meridian component of the time in all time fields should be in uppercase

Background:
	Given xml draft "US10246_DT13300.xml" is Uploaded
	Given Site "Site 1" exists
	Given study "US10246_DT13300" is assigned to Site "Site 1" with study environment "Live: Prod"
	Given I publish and push eCRF "US10246_DT13300.xml" to "Version 1" with study environment "Prod"
	Given Clinical Views exist for project "US10246_DT13300"
	Given following Project assignments exist
	| User 		   | Project 		 | Environment| Role         | Site  | SecurityRole 		 |
	| defjapan		| US10246_DT13300 | Live: Prod | SUPER ROLE 1 | Site 1| Project Admin Default |
	
	#Given I login to Rave with user "defjapan" and password "password"
	#And the following Project assignments exist
	#| User		| Project		      | Environment	| Role			| Site		| Site Number |
	#| defuser	| US10246_DT13300  | Prod		| cdm1			| Site 1	| S100		  |
    #And Role "cdm1" has Action "Entry"
	#And Project "US10246_DT13300" has Draft "<Draft1>"
	#And Draft "<Draft1>" has Form "Device Form" with fields
	#| FieldOID		|Data Dictionary| Control Type	| Data Format	| IsLog		|
	#| DEVIMPDT1	| N/A			| DateTime      | dd-			| False		|
	#| DEVIMPDT2	| N/A			| DateTime      | MMM			| False		|
	#| DEVIMPDT3	| N/A			| DateTime      | MMM-			| False		|
	#| DEVIMPDT4	| N/A			| DateTime      | dd MMM yyyy	| False		|
	#| DEVIMPDT5	| N/A			| DateTime      | dd- MMM yyyy	| False		|
	#| DEVIMPDT6	| N/A			| DateTime      | dd MMM- yyyy  | False		|
	#| DEVIMPDT7	| N/A			| DateTime      | dd- MMM- yyyy | False		|
	#| DEVIMPDT8	| N/A			| DateTim       | dd- mm yyyy  	| False		|
	#| DEVIMPDT9	| N/A			| DateTime      | dd- mm- yyyy	| False		|
	#| DEVIMPTM		| N/A			| DateTime      | hh:nn rr		| False		|
	

@release_2012.1.0 
@PB_US10246_DT13300_01
@Validation 
Scenario: PB_US10246_DT13300_01 As a Study Coordinator, when I save the month into a date field, and the time into a time field, then I see the month and meridian displayed in uppercase.
	
	When I login to Rave with user "defjapan"
	And I create a Subject
	| Field              | Data                  | Control Type |
	| Subject Identifier | SUB {RndNum<num1>(3)} | text         |
	
	And I select link "Device Form"
	And I enter data in CRF and save
	| Field                 | Data        | Control Type |
	| Device Implant Date 1 | UN          | datetime     |
	| Device Implant Date 2 | Jul         | datetime     |
	| Device Implant Date 3 | UNK         | datetime     |
	| Device Implant Date 4 | 12 Jul 1972 | datetime     |
	| Device Implant Date 5 | UN Jul 1972 | datetime     |
	| Device Implant Date 6 | 12 UNK 1972 | datetime     |
	| Device Implant Date 7 | UN UNK 1972 | datetime     |
	| Device Implant Date 8 | UN 07 1972  | datetime     |
	| Device Implant Date 9 | UN UN 1972  | datetime     |
	| Device Implant Time   | 11:59 am    | datetime     |
	Then I should see data on Fields in CRF
	| Field                 | Data        |
	| Device Implant Date 1 | UN          |
	| Device Implant Date 2 | Jul         |
	| Device Implant Date 3 | UNK         |
	| Device Implant Date 4 | 12 Jul 1972 |
	| Device Implant Date 5 | UN JUL 1972 |
	| Device Implant Date 6 | 12 UNK 1972 |
	| Device Implant Date 7 | UN UNK 1972 |
	| Device Implant Date 8 | UN 07 1972  |
	| Device Implant Date 9 | UN UN 1972  |
	| Device Implant Time   | 11:59 am    |
	And I take a screenshot

@release_2012.1.0 
@PB_US10246_DT13300_02
@Validation 
Scenario: PB_US10246_DT13300_02 As a Study Coordinator, I save an unknown month. When I edit the form and save a month, then I see the month displayed in uppercase.
		
	When I login to Rave with user "SUPER USER 1"
	And I create a Subject
	| Field				| Data				   |
	| Subject Identifier| SUB {RndNum<num1>(3)}|
	And I select link "Device Form"
	And I enter data in CRF and save
	| Field                 | Data        | Control Type |
	| Device Implant Date 1 | UN          | datetime     |
	| Device Implant Date 2 | Jul         | datetime     |
	| Device Implant Date 3 | UNK         | datetime     |
	| Device Implant Date 4 | 12 Jul 1972 | datetime     |
	| Device Implant Date 5 | UN Jul 1972 | datetime     |
	| Device Implant Date 6 | 12 UNK 1972 | datetime     |
	| Device Implant Date 7 | UN UNK 1972 | datetime     |
	| Device Implant Date 8 | UN 07 1972  | datetime     |
	| Device Implant Date 9 | UN UN 1972  | datetime     |
	| Device Implant Time   | 11:59 am    | datetime     |
	Then I should see data on Fields in CRF
	| Field                 | Data        |
	| Device Implant Date 1 | UN          | 
	| Device Implant Date 2 | JUL         |
	| Device Implant Date 3 | UNK         |
	| Device Implant Date 4 | 12 JUL 1972 |
	| Device Implant Date 5 | UN JUL 1972 |
	| Device Implant Date 6 | 12 UNK 1972 |
	| Device Implant Date 7 | UN UNK 1972 |
	| Device Implant Date 8 | UN 07 1972  |
	| Device Implant Date 9 | UN UN 1972  |
	| Device Implant Time   | 11:59 AM    |	
	And I take a screenshot
	And I enter data in CRF and save
	| Field                 | Data        |
	| Device Implant Date 6 | 12 Jul 1972 |
	| Device Implant Date 7 | UN Jul 1972 |
	Then I should see data on Fields in CRF
	| Field                 | Data        |
	| Device Implant Date 6 | 12 JUL 1972 |
	| Device Implant Date 7 | UN JUL 1972 |
	And I take a screenshot

@release_2012.1.0 
@PB_US10246_DT13300_03
@Validation 
Scenario: PB_US10246_DT13300_03  As a Study Coordinator, My Profile > Locale is set to English. when I save the month into a date field, and the time into a time field, then I see the month and meridian displayed in uppercase. When I set My Profile > Locale to Japanese, and I edit the form and save a new month and new meridian, then I see the month and meridian displayed in uppercase.
		
	When I login to Rave with user "SUPER USER 1"
	And I create a Subject
	| Field				| Data				   |
	| Subject Identifier| SUB {RndNum<num1>(3)}|
	And I select link "Device Form"
	And I enter data in CRF and save
	| Field                 | Data        | Control Type |
	| Device Implant Date 1 | UN          | datetime     |
	| Device Implant Date 2 | Jul         | datetime     |
	| Device Implant Date 3 | UNK         | datetime     |
	| Device Implant Date 4 | 12 Jul 1972 | datetime     |
	| Device Implant Date 5 | UN Jul 1972 | datetime     |
	| Device Implant Date 6 | 12 UNK 1972 | datetime     |
	| Device Implant Date 7 | UN UNK 1972 | datetime     |
	| Device Implant Date 8 | UN 07 1972  | datetime     |
	| Device Implant Date 9 | UN UN 1972  | datetime     |
	| Device Implant Time   | 11:59 am    | datetime     |
	Then I should see data on Fields in CRF
	| Field                 | Data        |
	| Device Implant Date 1 | UN          |
	| Device Implant Date 2 | JUL         |
	| Device Implant Date 3 | UNK         |
	| Device Implant Date 4 | 12 JUL 1972 |
	| Device Implant Date 5 | UN JUL 1972 |
	| Device Implant Date 6 | 12 UNK 1972 |
	| Device Implant Date 7 | UN UNK 1972 |
	| Device Implant Date 8 | UN 07 1972  |
	| Device Implant Date 9 | UN UN 1972  |
	| Device Implant Time   | 11:59 AM    | 	
	And I take a screenshot
	And I login to Rave with user "defjapan" and password "password"
	And I select Study "US10246_DT13300" and Site "Site 1"
	And I select a Subject "SUB {Var(num1)}"
	And I select link "Device Form"
	And I enter data in CRF and save
	| Field                 | Data        | Control Type |
	| Device Implant Date 2 | Aug         | datetime     |
	| Device Implant Date 4 | 12 Aug 1972 | datetime     |
	| Device Implant Date 5 | UN Aug 1972 | datetime     |
	| Device Implant Date 6 | 12 Aug 1972 | datetime     |
	| Device Implant Date 7 | UN Aug 1972 | datetime     |
	| Device Implant Time   | 11:59 pm    | datetime     |
	Then I should see data on Fields in CRF
	| Field                 | Data        |
	| Device Implant Date 2 | AUG         |
	| Device Implant Date 4 | 12 AUG 1972 |
	| Device Implant Date 5 | UN AUG 1972 |
	| Device Implant Date 6 | 12 AUG 1972 |
	| Device Implant Date 7 | UN AUG 1972 |
	| Device Implant Time   | 11:59 PM    | 	
	And I take a screenshot
	