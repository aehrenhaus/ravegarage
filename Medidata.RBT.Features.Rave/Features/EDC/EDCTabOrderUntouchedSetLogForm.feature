﻿# A site user, while entering data, is able to complete data entry on a set log eCRF using only the keyboard. 
# The user is able to use the tab key to move from one field to another as follows:
# (1) the cursor begins in the data entry position for the first field on the page
# (2) the cursor moves from one field to the next field when the user hits the tab key
# (3) the user is able to tab through all options in a radio button - either horizontal or vertical
# (4) the screen will scroll to the right as the user tabs so that the user can always see the fields into which they enter data
# (5) the user is able to tab from the last enterable field to the add button and hit enter to save
# This is related to DT 13558.
@FT_EDCTabOrderUntouchedSetLogForm
Feature: US11550_DT13558 Ability to navigate by keyboard (tab). Updated tab order to enable mouseless data entry - Untouched landscape log form with set log lines
  As A Rave EDC User
  I want to tab from field to field 
  So that I can enter data without using a mouse 

Background:
Given xml draft "US11550.xml" is Uploaded
Given study "US11550" is assigned to Site "Site_001"
Given following Project assignments exist
| User         | Project | Environment | Role         | Site     | SecurityRole          |
| SUPER USER 1 | US11550 | Live: Prod  | SUPER ROLE 1 | Site_001 | Project Admin Default |
Given I publish and push eCRF "US11550.xml" to "Version 1"
Given I login to Rave with user "SUPER USER 1"
Given I create a Subject
    |Field               |Data              |Control Type |
    |Subject Initials    |SUB               |textbox      |
    |Subject Number      |{RndNum<num1>(5)} |textbox      |
    |Subject ID 	     |SUB {Var(num1)}   |textbox      |	
Given I select Form "Log Form Landscape (Set)"

	
	#Given user "User 1"  has study "Standard Study" has site "Site A1" has subject "Subj A1001" in database "<EDC> Database"
	#And study "Standard Study" had draft "Draft 1" has form "Log Form"
	#And draft "Draft 1" has form "Log Form"
	#And form "Log Form" has field "<Field>" has varOID "<VarOID>" has format "<Format>" has dictionary "<Dictionary>" has field name "<Field Name>" has field OID "<Field OID>" has status "<Active>" has visible status "<Is Visible Field>" has log data entry "<Log Data Entry>" has field label "<Field Label>" has control type "<Control Type>" has value "<Default Value>" has field help text "<Field Help Text>" in row "<Row>" in database "<EDC> Database", from the table below
	#	|Row	|Field		|VarOID		|Format					|Dictionary		|Unit Dictionary	|Field Name		|Field OID		|Active		|Is Visible Field 	|Log Data Entry	|Field Label	|Control Type			|Default Value 	|Field Help Text	|
	#	|1		|Field 1	|VAROID1	|$25					|				| 					|VAROID1		|VAROID1		|true		|true				|true			|Field Label 1 	|Text					|				|					|
	#	|2		|Field 2	|VAROID2	|dd mm yyyy hh:nn:ss	|				| 					|VAROID2		|VAROID2		|true		|true				|true			|Field Label 2 	|DateTime				|				|Help				|
	#	|3		|Field 3	|VAROID3	|$1						|Dictionary 1	| 					|VAROID3		|VAROID3		|true		|true				|true			|Field Label 3 	|DropDownList			|1%2%3%			|					|
	#	|4		|Field 4	|VAROID4	|$10					|				| 					|VAROID4		|VAROID4		|true		|true				|true			|Field Label 4 	|Dynamic SearchList		|				|					|
	#	|5		|Field 5	|VAROID5	|$200					|				| 					|VAROID5		|VAROID5		|true		|true				|true			|Field Label 5 	|File Upload			|				|					|
	#	|6		|Field 6	|VAROID6	|$250					|				| 					|VAROID6		|VAROID6		|true		|true				|true			|Field Label 6 	|LongText				|				|					|
	#	|7		|Field 7	|VAROID7	|$1						|Dictionary 1	| 					|VAROID7		|VAROID7		|true		|true				|true			|Field Label 7 	|RadioButton			|				|					|
	#	|8		|Field 8	|VAROID8	|1						|Dictionary 2	| 					|VAROID8		|VAROID8		|true		|true				|true			|Field Label 8 	|RadioButton (Vertical)	|				|					|
	#	|9		|Field 9	|VAROID9	|$1						|Dictionary 1	| 					|VAROID9		|VAROID9		|true		|true				|true			|Field Label 9	|SearchList				|				|					|
	#	|10		|Field 10	|VAROID10	|1						|				| 					|VAROID10		|VAROID10		|true		|true				|true			|Field Label 10	|Checkbox				|				|					|
	#	|11		|Field 11	|VAROID11	|5						|				| 					|VAROID11		|VAROID11		|true		|true				|true			|Field Label 11	|Text					|				|					|
	#	|12		|Field 12	|VAROID12	|4.2					|				| 					|VAROID12		|VAROID12		|true		|true				|true			|Field Label 12	|Text					|				|					|
	#	|13		|Field 13	|VAROID13	|$50					|				| 					|VAROID13		|VAROID13		|true		|true				|true			|Field Label 13	|Text					|				|					|
	#	|14		|Field 14	|VAROID14	|5						|				|Unit Dictionary 1	|VAROID14		|VAROID14		|true		|true				|true			|Field Label 14 |Text					|				|					|
 	#	|15		|Field 15	|VAROID15	|$25					|				| 					|VAROID15		|VAROID15		|true		|true				|true			|Field Label 15	|Text					|				|Help				|
	#	|16		|Field 16	|VAROID16	|$25					|				| 					|VAROID16		|VAROID16		|true		|true				|true			|Field Label 16	|Text					|Default		|					|
	#	|17		|Field 17	|			|						|				| 					|VAROID17		|VAROID17		|true		|true				|true			|Field Label 17	|Text					|				|					|
	#	|18		|Field 18	|VAROID18	|$25					|				| 					|VAROID18		|VAROID18		|true		|true				|true			|Field Label 18	|Text					|				|					|
	#And dictionary "<Dictionary>" has user data string "<User Data String>" has specify "<Specify>" has coded data "<Coded Data>", from the table below
	#	|Dictionary 		|User Data String	|Specify	|Coded Data	|
	#	|Dictionary 1		|UDS A				|			|A			|
	#	|Dictionary 1		|UDS B				|			|B			|
	#	|Dictionary 1		|UDS C				|			|C			|
	#	|Dictionary 2		|UDS 1				|			|1			|
	#	|Dictionary 2		|UDS 2				|			|2			|
	#	|Dictionary 2		|UDS 3				|true		|3			|
	#And unit dictionary "<Unit Dictionary>" has user data string "<User Data String>" has standard "<Standard>" has coded unit "<Coded Unit>", from the table below
	#	|Unit Dictionary 		|User Data String	|Standard	|Coded Unit	|
	#	|Unit Dictionary 1		|U1					|true		|U1			|
	#	|Unit Dictionary 1		|U2					|			|U2			|		
  
@release_2012.1.0
@PB_US11550_DT13558_01c
@Validation
Scenario: PB_US11550_DT13558_01c The cursor begins in the data entry position for the first field on the page when I click on the page from the left-hand side menu.
	
	Then the cursor focus is located on "textbox" in the column labeled "Field Label 1" in the "first" position in the "first" row
  
@release_2012.1.0
@PB_US11550_DT13558_02c
@Validation
Scenario: PB_US11550_DT13558_02c The cursor moves from one field to the next when the user hits the tab key and ignores help text.
	
	When I hit "tab" key
	Then the cursor focus is located on "datetime" in the column labeled "Field Label 2" in the "first" position in the "first" row

@release_2012.1.0
@PB_US11550_DT13558_03c
@Validation
Scenario: PB_US11550_DT13558_03c The cursor moves from one field to the next when the user hits the tab key and ignores other non-enterable fields.
	
	Given move cursor focus to "textbox" in the column labeled "Field Label 16" in the "first" position in the "first" row
	When I hit "tab" key
	Then the cursor focus is located on "textbox" in the column labeled "Field Label 18" in the "first" position in the "first" row

@release_2012.1.0
@PB_US11550_DT13558_04c
@Validation
Scenario: PB_US11550_DT13558_04c The cursor moves through all data entry input elements in a datetime field before moving to the next field.
	
	Given move cursor focus to "datetime" in the column labeled "Field Label 2" in the "first" position in the "first" row
	When I hit "tab" key
	Then the cursor focus is located on "datetime" in the column labeled "Field Label 2" in the "second" position in the "first" row
	When I hit "tab" key
	Then the cursor focus is located on "datetime" in the column labeled "Field Label 2" in the "third" position in the "first" row
	When I hit "tab" key
	Then the cursor focus is located on "datetime" in the column labeled "Field Label 2" in the "fourth" position in the "first" row
	When I hit "tab" key
	Then the cursor focus is located on "datetime" in the column labeled "Field Label 2" in the "fifth" position in the "first" row
	When I hit "tab" key
	Then the cursor focus is located on "datetime" in the column labeled "Field Label 2" in the "sixth" position in the "first" row
	When I hit "tab" key
	Then the cursor focus is located on "dropdown" in the column labeled "Field Label 3" in the "first" position in the "first" row

@release_2012.1.0
@PB_US11550_DT13558_05c
@Validation
Scenario: PB_US11550_DT13558_05c The cursor moves through all options in a radio button (horizontal).
	
	Given move cursor focus to "radiobutton" in the column labeled "Field Label 7" in the "first" position in the "first" row
	When I hit "tab" key
	Then the cursor focus is located on "radiobutton" in the column labeled "Field Label 7" in the "second" position in the "first" row
	When I hit "tab" key
	Then the cursor focus is located on "radiobutton" in the column labeled "Field Label 7" in the "third" position in the "first" row

@release_2012.1.0
@PB_US11550_DT13558_06c
@Validation
Scenario: PB_US11550_DT13558_06c The cursor moves through all options in a radio button (vertical).
	
	Given move cursor focus to "radiobutton vertical" in the column labeled "Field Label 8" in the "first" position in the "first" row
	When I hit "tab" key
	Then the cursor focus is located on "radiobutton vertical" in the column labeled "Field Label 8" in the "second" position in the "first" row
	When I hit "tab" key
	Then the cursor focus is located on "radiobutton vertical" in the column labeled "Field Label 8" in the "third" position in the "first" row
	When I hit "tab" key	
	Then the cursor focus is located on "specify textbox" in the column labeled "Field Label 8" in the "fourth" position in the "first" row
	
@release_2012.1.0
@PB_US11550_DT13558_07c
@Validation
Scenario: PB_US11550_DT13558_07c The cursor moves through all data entry input elements for a field associated with a unit dictionary before moving to the next field.
	
	Given move cursor focus to "textbox" in the column labeled "Field Label 14" in the "first" position in the "first" row
	When I hit "tab" key 
	Then the cursor focus is located on "unit dictionary" in the column labeled "Field Label 14" in the "second" position in the "first" row
	When I hit "tab" key
	Then the cursor focus is located on "textbox" in the column labeled "Field Label 15" in the "first" position in the "first" row

@release_2012.1.0
@PB_US11550_DT13558_08c
@Validation
Scenario: PB_US11550_DT13558_08c The screen scrolls to the right when the eCRF is longer than the width of the screen and I tab away from the last visible field.
	
	Given move cursor focus to "browser file upload button" in the column labeled "Field Label 5" in the "first" position in the "first" row
	When I hit "tab" key
	Then the cursor focus is located on "textbox" in the column labeled "Field Label 6" in the "first" position in the "first" row
	And the browser scrolls to the right

@release_2012.1.0
@PB_US11550_DT13558_09c
@Validation
Scenario: PB_US11550_DT13558_09c When I tab away from the last field of a log line and there is one or more additional log lines to be filled, I should tab to the first field of the next log line.
	
	Given move cursor focus to "textbox" in the column labeled "Field Label 18" in the "first" position in the "first" row
	When I hit "tab" key
	Then the cursor focus is located on "textbox" in the column labeled "Field Label 1" in the "first" position in the "second" row
	
	
@release_2012.1.0
@PB_US11550_DT13558_010c
@Validation
Scenario: PB_US11550_DT13558_010c When I tab away from the last field of the last log line, I should tab to the save button.
	Given move cursor focus to "textbox" in the column labeled "Field Label 18" in the "first" position in the "third" row
	When I hit "tab" key
	Then the cursor focus is on "button" labeled "Save"
