@ignore
#There are a number of issues with Selenium and Back Navigation
#However with future releases; hopefully this is resolved and scenarios using GoBack can be enabled 
#https://code.google.com/p/selenium/issues/detail?id=3611
#https://code.google.com/p/selenium/issues/detail?id=2181
#http://stackoverflow.com/questions/17958595/selenium-using-the-old-page-after-browser-back-button-action-and-not-showing-alt?noredirect=1#comment26296287_17958595
@FT_DT_11710

Feature: DT_11710 Back button issue in Firefox
	As a Rave user
	I want to click the browser back button after performing a search for all translations
	And confirm that the search button is still displayed on the previous page
	
Background: 
	#Perform search for translations and view usage of first translation item
	Given I login to Rave with user "defuser"
	And I navigate to "Translation Workbench"
	And I choose "English" from "Source locale"	
	And I choose "Japanese" from "Target locale"

@Release_2013.4.0
@PBDT_11710_001
@Draft
Scenario: PBDT_11710_001 As an Rave User, when I select browser "Back" button after searching for a User/Clinical string in Translation Workbench, then I verify Generating results text is not displayed.

	And I pick "User/Clinical"
	And I click button "Search"
	And I click button "SearchButtonImage"
	And I take a screenshot 	
	And GoBack
	Then I verify text "Generating results..." does not exist
	And I verify button "SearchButtonImage" exists
	And I take a screenshot 		
	
@Release_2013.4.0
@PBDT_11710_002
@Draft
Scenario: PBDT_11710_002 As an Rave User, when I select browser "Back" button after searching for a User/Global string in Translation Workbench, then I verify Generating results text is not displayed.
	
	And I pick "User/Global"
	And I click button "Search"
	And I click button "SearchButtonImage"
	And I take a screenshot 	
	And GoBack
	Then I verify text "Generating results..." does not exist
	And I verify button "SearchButtonImage" exists
	And I take a screenshot