# When user enters a name with more than 80 characters for Lab Unit Dictionaries and Global Variables that are greater than 80 characters, the application throws an exception error. The error says that names must be less than 255 character.

Feature: US18358_DT14073
	When user enters names with more than 80 characters for Lab Unit Dictionary and Global Variables, the application throws an exception error.
 	As a Study Developer
	When I enter more than 80 characters in Lab Unit Dictionary and Global Variables
	Then an exception error message is displayed

Background:
	#Given I am logged in to Rave with username "defuser" and password "password"
	#And the following Project assignments exist
	#| User		| Project		      | Environment	| Role			| Site		| Site Number |
	#| defuser	| US18358_DT14073_SJ  | Prod		| cdm1			| Site 1	| S100		  |
    #And Role "cdm1" has Action "Entry"
	#And Project "US18358_DT14073_SJ" has Draft "Original Draft"	
	#And All Upper Case box is checked
	And I am logged in to Rave with username "defuser" and password "password"


@release_2012.1.0
@PB_US18358_DT14073_01
@Draft

Scenario: @sample_in_progress_PB_US18358_DT14073_01 As a Lab Administrator, when I upload Lab Loader draft with Global Data Dictionaries name that is greater than 80 characters, I do not see exception error message displayed
	
	When I navigate to "Lab Administration"
	And xml Lab Configuration "test test test.xml" is uploaded
	And I take a screenshot
	And I verify text "Upload successful." does not exist
	And I verify text "Row 27 - Name cannot exceed 255 characters." exists
	And I navigate to "Global Data Dictionaries"
