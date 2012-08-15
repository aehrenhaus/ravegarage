# When All Upper Case is selected in the Configuration Other Settings and my Locale is Japanese, the month component of the date, and the meridian component of the time, should be displayed in uppercase.

Feature: The month component of the date in a date field, and the meridian component of the time in a time field, should be displayed in uppercase when All Upper Case is selected in Configuration and Locale is set to Japanese
  As a Rave Administrator
	When I have selected All Upper Case in Configuration > Other Settings
	And my Locale is set to Japanese in My Profile
	And I enter data for datetime fields
	Then the month component of the date in all date fields should be in uppercase
	And the meridian component of the time in all time fields should be in uppercase

 Background:
	Given I am logged in to Rave with username "defuser" and password "password"
	#And the following Project assignments exist
	#| User		| Project		      | Environment	| Role			| Site		| Site Number |
	#| defuser	| US10246_DT13300_SJ  | Prod		| cdm1			| Site 1	| S100		  |
    #And Role "cdm1" has Action "Entry"
	#And Project "US10246_DT13300_SJ" has Draft "<Draft1>"
	#And Draft "<Draft1>" has Form "Device Form" with fields
	#| FieldOID	|Data Dictionary| Control Type	| Data Format	| IsLog		|
	#| DEVIMPDT1	| N/A			| DateTime      | dd-			| False		|
	#| DEVIMPDT2	| N/A			| DateTime      | MMM			| False		|
	#| DEVIMPDT3	| N/A			| DateTime      | MMM-			| False		|
	#| DEVIMPDT4	| N/A			| DateTime      | dd MMM yyyy	| False		|
	#| DEVIMPDT5	| N/A			| DateTime      | dd- MMM yyyy	| False		|
	#| DEVIMPDT6	| N/A			| DateTime      | dd MMM- yyyy  | False		|
	#| DEVIMPDT7	| N/A			| DateTime      | dd- MMM- yyyy | False		|
	#| DEVIMPDT8	| N/A			| DateTim       | dd- mm yyyy  	| False		|
	#| DEVIMPDT9	| N/A			| DateTime      | dd- mm- yyyy	| False		|
	#| DEVIMPTM	| N/A			| DateTime      | hh:nn rr		| False		|
	#And my Locale is set to Japanese in My Profile
	#And All Upper Case in Configuration > Other Settings has been selected
	And I select Study "US10246_DT13300_SJ" and Site "Site 1"
@PB_US10246_DT13300_01
Scenario: @PB_US10246_DT13300_01 As a Study Coordinator, when I save the month into a date field, and the time into a time field, then I see the month and meridian displayed in uppercase.
	
	And my Locale is set to Japanese in My Profile
	And All Upper Case in Configuration > Other Settings has been selected
	
	When I create a subject
	| Field				| Data				   |
	| Subject Identifier| SUB {RndNum<num1>(3)}|
	
	And I select Form "Device Form"
	And I enter data in CRF and save
	| Field                		| Data          | Record Position|
	| Device Implant Date 1		| UN			| 0				 |
	| Device Implant Date 2		| Jul			| 0				 |
	| Device Implant Date 3		| UNK			| 0				 |
	| Device Implant Date 4		| 12 Jul 1972	| 0				 |
	| Device Implant Date 5		| UN Jul 1972	| 0				 |
	| Device Implant Date 6		| 12 UNK 1972	| 0				 |
	| Device Implant Date 7		| UN UNK 1972	| 0				 |
	| Device Implant Date 8		| UN 07 1972	| 0				 |
	| Device Implant Date 9		| UN UN 1972	| 0				 |
	| Device Implant Time		| 11:59 am		| 0			     |		
	And I take a screenshot
	Then I should see in CRF
	| Field                		| Data          | Record Position|
	| Device Implant Date 1		| UN			| 0				 |
	| Device Implant Date 2		| JUL			| 0				 |
	| Device Implant Date 3		| UNK			| 0				 |
	| Device Implant Date 4		| 12 JUL 1972	| 0				 |
	| Device Implant Date 5		| UN JUL 1972	| 0				 |
	| Device Implant Date 6		| 12 UNK 1972	| 0				 |
	| Device Implant Date 7		| UN UNK 1972	| 0				 |
	| Device Implant Date 8		| UN 07 1972	| 0				 |
	| Device Implant Date 9		| UN UN 1972	| 0				 |
	| Device Implant Time		| 11:59 AM		| 0			     |	
	And I take a screenshot

@PB_US10246_DT13300_02
Scenario: @PB_US10246_DT13300_02 As a Study Coordinator, I save an unknown month. When I edit the form and save a month, then I see the month displayed in uppercase.
	And my Locale is set to Japanese in My Profile
	And All Upper Case in Configuration > Other Settings has been selected
	
	When I create a subject
	| Field				| Data				   |
	| Subject Identifier| SUB {RndNum<num1>(3)}|

	And I select Form "Device Form"
	And I enter data in CRF and save
	
	| Field                		| Data          | Record Position|
	| Device Implant Date 1		| UN			| 0			 	 |
	| Device Implant Date 2		| Jul			| 0				 |
	| Device Implant Date 3		| UNK			| 0				 |
	| Device Implant Date 4		| 12 Jul 1972	| 0				 |
	| Device Implant Date 5		| UN Jul 1972	| 0				 |
	| Device Implant Date 6		| 12 UNK 1972	| 0				 |
	| Device Implant Date 7		| UN UNK 1972	| 0				 |
	| Device Implant Date 8		| UN 07 1972	| 0				 |
	| Device Implant Date 9		| UN UN 1972	| 0				 |
	| Device Implant Time		| 11:59 am		| 0			     |		
	And I take a screenshot	
	Then I should see in CRF
	| Field                		| Data          | Record Position|
	| Device Implant Date 1		| UN			| 0				 |
	| Device Implant Date 2		| JUL			| 0				 |
	| Device Implant Date 3		| UNK			| 0				 |
	| Device Implant Date 4		| 12 JUL 1972	| 0				 |
	| Device Implant Date 5		| UN JUL 1972	| 0				 |
	| Device Implant Date 6		| 12 UNK 1972	| 0				 |
	| Device Implant Date 7		| UN UNK 1972	| 0				 |
	| Device Implant Date 8		| UN 07 1972	| 0				 |
	| Device Implant Date 9		| UN UN 1972	| 0				 |
	| Device Implant Time		| 11:59 AM		| 0			     |	
	And I take a screenshot
	And I enter data in CRF and save
	| Field                		| Data          | Record Position|
	| Device Implant Date 6		| 12 Jul 1972	| 0				 |
	| Device Implant Date 7		| UN Jul 1972	| 0				 |
	And I take a screenshot
	Then I see data in CRF
	| Field                		| Data          | Record Position|
	| Device Implant Date 6		| 12 JUL 1972	| 0				 |
	| Device Implant Date 7		| UN JUL 1972	| 0				 |
	And I take a screenshot

@PB_US10246_DT13300_03
Scenario: @PB_US10246_DT13300_03  As a Study Coordinator, My Profile > Locale is set to English. when I save the month into a date field, and the time into a time field, then I see the month and meridian displayed in uppercase. When I set My Profile > Locale to Japanese, and I edit the form and save a new month and new meridian, then I see the month and meridian displayed in uppercase.
	And my Locale is set to English in My Profile
	And All Upper Case in Configuration > Other Settings has been selected
	
	
	When I create a subject
	| Field				| Data				   |
	| Subject Identifier| SUB {RndNum<num1>(3)}|

	And I select Form "Device Form"
	And I enter data in CRF and save
	| Field                		| Data          | Record Position|
	| Device Implant Date 1		| UN			| 0				 |
	| Device Implant Date 2		| Jul			| 0				 |
	| Device Implant Date 3		| UNK			| 0				 |
	| Device Implant Date 4		| 12 Jul 1972	| 0				 |
	| Device Implant Date 5		| UN Jul 1972	| 0				 |
	| Device Implant Date 6		| 12 UNK 1972	| 0				 |
	| Device Implant Date 7		| UN UNK 1972	| 0				 |
	| Device Implant Date 8		| UN 07 1972	| 0				 |
	| Device Implant Date 9		| UN UN 1972	| 0				 |
	| Device Implant Time		| 11:59 am		| 0			     |		
	Then I see data in the CRF
	| Field                		| Data          | Record Position|
	| Device Implant Date 1		| UN			| 0				 |
	| Device Implant Date 2		| JUL			| 0				 |
	| Device Implant Date 3		| UNK			| 0				 |
	| Device Implant Date 4		| 12 JUL 1972	| 0				 |
	| Device Implant Date 5		| UN JUL 1972	| 0				 |
	| Device Implant Date 6		| 12 UNK 1972	| 0				 |
	| Device Implant Date 7		| UN UNK 1972	| 0				 |
	| Device Implant Date 8		| UN 07 1972	| 0				 |
	| Device Implant Date 9		| UN UN 1972	| 0				 |
	| Device Implant Time		| 11:59 AM		| 0			     |	
	And I take a screenshot	
	And I change My Profile > Locale to Japanese
	And I enter data in CRF and save
	| Field                		| Data          | Record Position|
	| Device Implant Date 2		| Aug			| 0				 |
	| Device Implant Date 4		| 12 Aug 1972	| 0				 |
	| Device Implant Date 5		| UN Aug 1972	| 0				 |
	| Device Implant Date 6		| 12 Aug 1972	| 0				 |
	| Device Implant Date 7		| UN Aug 1972	| 0				 |
	| Device Implant Time		| 11:59 pm		| 0			     |		
	And then I take a screenshot
	Then I see data in the CRF
	| Field                		| Data          | Record Position|
	| Device Implant Date 2		| AUG			| 0				 |
	| Device Implant Date 4		| 12 AUG 1972	| 0				 |
	| Device Implant Date 5		| UN AUG 1972	| 0				 |
	| Device Implant Date 6		| 12 AUG 1972	| 0				 |
	| Device Implant Date 7		| UN AUG 1972	| 0				 |
	| Device Implant Time		| 11:59 PM		| 0			     |	
	And I take a screenshot