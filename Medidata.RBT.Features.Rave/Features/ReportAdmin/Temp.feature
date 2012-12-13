# When user enters a name with more than 80 characters for Lab Unit Dictionaries and Global Variables that are greater than 80 characters, the application throws an exception error. The error says that names must be less than 255 character.
@ignore
@FT_Temp
Feature: Create Package / Install Package

Background:
	And I login to Rave with user "defuser" and password "password"



Scenario: Create package from report admin

	When I navigate to "Report Administration"
	And I select link "Create Package"
	And I take a screenshot
	And I create report package "Coding Hierarchy"

	#And I check "the check" on "Coding Hierarchy" in "the list" 
	#And I click button "Continue"
	#And I click button "Create Package"
	#And I accept alert window
	#And I wait for Clinical View refresh to complete for project "{project}"

Scenario: Install package from report admin

	When I navigate to "Report Administration"
	And I select link "Install Package"
	And I take a screenshot
	And I install report package "Coding Hierarchy"