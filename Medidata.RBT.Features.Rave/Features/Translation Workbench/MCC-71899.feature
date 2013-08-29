@ignore
#There are a number of issues with Selenium and Back Navigation
#However with future releases; hopefully this is resolved and scenarios using "I go back to the previous page via the browser back button" can be enabled 
#https://code.google.com/p/selenium/issues/detail?id=3611
@FT_MCC-71899

Feature: MCC-71899 Back Button Broken Results On Chrome and Firefox in Translation Workbench
	As a Rave user
	I want to click the browser back button while on the Where Used page
	And see the results that were previously there, continue to be displayed

Background: 
	#Perform search for translations and view usage of first translation item
	Given I login to Rave with user "defuser"
	And I navigate to "Translation Workbench"
	And I choose "Japanese" from "Target locale"
	
@Release_2013.4.0
@PBMCC-71899-001
@Draft
Scenario: PBMCC-71899-001 As an Rave User, when I select browser back button after searching for a User/Clinical string in Translation Workbench, then I verify error previous results are displayed.

	And I pick "User/Clinical"
	And I click button "Search"
	And I enter value "drug" in "Search" "textbox"
	And I click button "SearchButtonImage"
	And I take a screenshot 	
	And I select the # of Uses link in row 1
	And I go back to the previous page via the browser back button
	Then I verify rows exist in "results" table
	And I take a screenshot 		
	
@Release_2013.4.0
@PBMCC-71899-002
@Draft
Scenario: PBMCC-71899-002 As an Rave User, when I select browser back button after searching for a User/Global string in Translation Workbench, then I verify error previous results are displayed.
	
	And I pick "User/Global"
	And I click button "Search"
	And I click button "SearchButtonImage"
	And I take a screenshot 	
	And I select the # of Uses link in row 1
	And I take a screenshot 
	And I go back to the previous page via the browser back button
	Then I verify rows exist in "results" table
	And I take a screenshot 	