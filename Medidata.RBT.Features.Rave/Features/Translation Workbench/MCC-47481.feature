@ignore
#There are a number of issues with Selenium and Back Navigation
#However with future releases; hopefully this is resolved and scenarios using GoBack can be enabled 
#https://code.google.com/p/selenium/issues/detail?id=3611
@FT_MCC-47481

Feature: MCC-47481 Translation Workbench "Go Back" Button, does not save search result from previous screen
	As a Rave user
	I want to click the go back links on the Where Used page
	And see the results that were previously there, continue to be displayed
	
Background: 
	#Perform search for translations and view usage of first translation item
	Given I login to Rave with user "defuser"
	And I navigate to "Translation Workbench"
	And I choose "English" from "Source locale"	
	And I choose "Japanese" from "Target locale"

@Release_2013.4.0
@PBMCC_47481_001
@Draft
Scenario: PBMCC_47481_001 As an Rave User, when I select "Go Back" link after searching for a User/Clinical string in Translation Workbench, then I verify preivous results are present.

	And I pick "User/Clinical"
	And I click button "Search"
	And I enter value "drug" in "Search" "textbox"
	And I click button "SearchButtonImage"
	And I take a screenshot 	
	And I select the # of Uses link in row 1
	When I select link "Go Back"
	Then I verify rows exist in "results" table
	And I take a screenshot 		
	
@Release_2013.4.0
@PBMCC_47481_002
@Draft
Scenario: PBMCC_47481_002 As an Rave User, when I select "Go Back" link after searching for a User/Global string in Translation Workbench, then I verify previous results are present.
	
	And I pick "User/Global"
	And I click button "Search"
	And I click button "SearchButtonImage"
	And I take a screenshot 	
	And I select the # of Uses link in row 1
	And I take a screenshot 
	When I select link "Go Back"
	Then I verify rows exist in "results" table
	And I take a screenshot 
	
@Release_2013.4.0
@PBMCC_47481_003
@Draft
Scenario: PBMCC_47481_003 As an Rave User, when I select "Go Back" image after searching for a User/Clinical string in Translation Workbench, then I verify preivous results are present.

	And I pick "User/Clinical"
	And I click button "Search"
	And I enter value "drug" in "Search" "textbox"
	And I click button "SearchButtonImage"
	And I take a screenshot 	
	And I select the # of Uses link in row 1
	When I select image "Go Back"
	Then I verify rows exist in "results" table
	And I take a screenshot 		
	
@Release_2013.4.0
@PBMCC_47481_004
@Draft
Scenario: PBMCC_47481_004 As an Rave User, when I select "Go Back" image after searching for a User/Global string in Translation Workbench, then I verify preivous results are present.
	
	And I pick "User/Global"
	And I click button "Search"
	And I click button "SearchButtonImage"
	And I take a screenshot 	
	And I select the # of Uses link in row 1
	And I take a screenshot 
	When I select image "Go Back"
	Then I verify rows exist in "results" table
	And I take a screenshot 	
