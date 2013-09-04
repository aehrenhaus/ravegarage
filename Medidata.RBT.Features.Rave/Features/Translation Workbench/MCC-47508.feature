@ignore
#There are a number of issues with Selenium and Back Navigation
#However with future releases; hopefully this is resolved and scenarios using "I go back to the previous page via the browser back button" can be enabled 
#https://code.google.com/p/selenium/issues/detail?id=3611
@FT_MCC-47508

Feature: MCC-47508 Using browser back button in Translation Workbench and searching for another object results in "String Not Found in Paging Session" Error
	As a Rave user
	I want to click the browser back button while on the Where Used page
	Then perform another search and have the results display
	
Background: 
	#Perform search for translations and view usage of first translation item
	Given I login to Rave with user "defuser"
	And I navigate to "Translation Workbench"
	And I choose "Japanese" from "Target locale"

@Release_2013.4.0
@PBMCC-47508-001
@Draft
Scenario: PBMCC-47508-001 As an Rave User, when I search for a User/Clinical string in Translation Workbench after selecting browser back button, then I verify error text "String not found in paging session." is not displayed.

#Go back and perform a new search for drug

	And I pick "User/Clinical"
	And I click button "Search"
	And I click button "SearchButtonImage"
	And I select the # of Uses link in row 1
	And I take a screenshot 
	And I go back to the previous page via the browser back button
	And I enter value "drug" in "Search" "textbox"
	When I click button "SearchButtonImage"
	Then I verify text "String not found in paging session." does not exist
	And I take a screenshot

	
@Release_2013.4.0
@PBMCC-47508-002
@Draft
Scenario: PBMCC-47508-002 As an Rave User, when I search for a User/Global string in Translation Workbench after selecting browser back button, then I verify error text "String not found in paging session." is not displayed
	
	And I pick "User/Global"
	And I click button "Search"
	And I click button "SearchButtonImage"
	And I select the # of Uses link in row 1
	And I take a screenshot 
	And I go back to the previous page via the browser back button
	And I enter value "Entry Error" in "Search" "textbox"
	When I click button "SearchButtonImage"
	Then I verify text "String not found in paging session." does not exist
	And I take a screenshot

		
