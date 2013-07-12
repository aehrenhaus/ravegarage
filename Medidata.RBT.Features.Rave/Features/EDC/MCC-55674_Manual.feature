@FT_MCC-55674_Manual
@ignore

Feature: MCC-55674_Manual Unsupported Browser Negative Test feature file
	As a user
	I want to open and navigate URL
	So I should not see the message 'You are using an outdated browser. For a faster, safer browsing experience, upgrade for free today.'
	
Background:
	Given I am a user "<User>" with pin "<PIN>", password "<Password>" and user id "<User ID>" , from the table below
		|User			|PIN	|Password	|User ID			|
		|SUPER USER 1	|12345	|password	|{Rave User ID}		|
		|esiguser4		|12345	|Password1	|{iMedidat User ID}	|
	Given xml draft "MCC_55674_Draft_1.xml" is Uploaded
	Given Site "MCC_55674 Site" exists	
	Given study "MCC_55674" is assigned to Site "MCC_55674 Site"	
	Given I publish and push eCRF "MCC_55674_Draft_1.xml" to "Version1" with study environment "Prod" for site "MCC_55674 Site"	
	Given following Project assignments exist
		| User         | Project    | Environment | Role           | Site           | SecurityRole          |
		| SUPER USER 1 | MCC_55674  | Live: Prod  | SUPER ROLE 1   | MCC_55674 Site | Project Admin Default |	
	And there exists "<Rave Apps>", from the table below
		|Apps			|
		| Rave EDC		|
		| Rave Modules	|		
	
#----------------------------------------------------------------------------------------------------------------------------------
@release_2013.2.0
@PB_MCC_55674_01
@Validation
@manaul
Scenario: PB_MCC_55674_01 As an EDC user, when I open Rave URL, then I should not see message 'You are using an outdated browser. For a faster, safer browsing experience, upgrade for free today.'
	
	Given I open Rave url in "<Browser>"
		|Browser 		|
		|IE 			|	
		|Firefox	 	|
		|Safari			|
		|Chrome			|
	And I verify text "You are using an outdated browser. For a faster, safer browsing experience, upgrade for free today." does not exist
	And I take a screenshot
	
#----------------------------------------------------------------------------------------------------------------------------------
@release_2013.2.0
@PB_MCC_55674_02
@Validation
@manaul
Scenario: PB_MCC_55674_02 As an EDC user, when I log in to Rave URL, then I should not see message 'You are using an outdated browser. For a faster, safer browsing experience, upgrade for free today.'	

	Given I open Rave url in "<Browser>"
		|Browser 		|
		|IE 			|	
		|Firefox	 	|
		|Safari			|
		|Chrome			|	
  	And I am logged in as user "<User>" with password "<Password>" in "<App>"
		|User		    |Password	|App		|
		|SUPER USER 1	|password	|Rave		|
		|esiguser4	    |Password1	|iMedidata	|
	And I verify text "You are using an outdated browser. For a faster, safer browsing experience, upgrade for free today." does not exist
	And I take a screenshot
	
#----------------------------------------------------------------------------------------------------------------------------------
@release_2013.2.0
@PB_MCC_55674_03
@Validation
@manaul
Scenario: PB_MCC_55674_03 As an EDC user, when I am on Change Password, then I should not see message 'You are using an outdated browser. For a faster, safer browsing experience, upgrade for free today.'	

	Given I open Rave url in "<Browser>"
		|Browser 		|
		|IE 			|	
		|Firefox	 	|
		|Safari			|
		|Chrome			|	
  	When I am logged in as user "<User>" with password "<Password>" in "<App>"
		|User		    |Password	|App		|
		|SUPER USER 1	|password	|Rave		|
		|esiguser4	    |Password1	|iMedidata	|
	Then I verify text "You are using an outdated browser. For a faster, safer browsing experience, upgrade for free today." does not exist
	And I take a screenshot	
	And I select link "My Profile"
	When I select link "Change Password"
	Then I verify text "You are using an outdated browser. For a faster, safer browsing experience, upgrade for free today." does not exist
	And I take a screenshot
	
#----------------------------------------------------------------------------------------------------------------------------------
@release_2013.2.0
@PB_MCC_55674_04
@Validation
@manaul
Scenario: PB_MCC_55674_04 As an EDC user, when I am on Form Preview page in Form Designer, then I should not see message 'You are using an outdated browser. For a faster, safer browsing experience, upgrade for free today.'	

	Given I open Rave url in "<Browser>"
		|Browser 		|
		|IE 			|	
		|Firefox	 	|
		|Safari			|
		|Chrome			|	
  	When I am logged in as user "<User>" with password "<Password>" in "<App>"
		|User		    |Password	|App		|
		|SUPER USER 1	|password	|Rave		|
		|esiguser4	    |Password1	|iMedidata	|
	Then I verify text "You are using an outdated browser. For a faster, safer browsing experience, upgrade for free today." does not exist
	And I take a screenshot	
	And I select link "Architect"
	And I select link "MCC_55674"
	And I select link "Draft 1"
	And I select link "Forms"
	And I select fields arrow for "PRIMARY"
	When I select link "Preview"
	Then I verify text "You are using an outdated browser. For a faster, safer browsing experience, upgrade for free today." does not exist	
	And I take a screenshot
	
#----------------------------------------------------------------------------------------------------------------------------------
@release_2013.2.0
@PB_MCC_55674_05
@Validation
@manaul
Scenario: PB_MCC_55674_05 As an EDC user, when I on 'Activate New Account' page, then I should not see message 'You are using an outdated browser. For a faster, safer browsing experience, upgrade for free today.'
	
	Given I open Rave url in "<Browser>"
		|Browser 		|
		|IE 			|	
		|Firefox	 	|
		|Safari			|
		|Chrome			|
	When I select link "Activate New Account"		
	Then I verify text "You are using an outdated browser. For a faster, safer browsing experience, upgrade for free today." does not exist
	And I take a screenshot
	
#----------------------------------------------------------------------------------------------------------------------------------
@release_2013.2.0
@PB_MCC_55674_06
@Validation
@manaul
Scenario: PB_MCC_55674_06 As an EDC user, when I on 'Forgot Password' page, then I should not see message 'You are using an outdated browser. For a faster, safer browsing experience, upgrade for free today.'
	
	Given I open Rave url in "<Browser>"
		|Browser 		|
		|IE 			|	
		|Firefox	 	|
		|Safari			|
		|Chrome			|
	When I select link "Forgot Password?"		
	Then I verify text "You are using an outdated browser. For a faster, safer browsing experience, upgrade for free today." does not exist
	And I take a screenshot
	
#----------------------------------------------------------------------------------------------------------------------------------
@release_2013.2.0
@PB_MCC_55674_07
@Validation
@manaul
Scenario: PB_MCC_55674_07 As an EDC user, when I on Rave Login page with Japanesse locale, then I should not see message 'You are using an outdated browser. For a faster, safer browsing experience, upgrade for free today.'
	
	Given I open Rave url in "<Browser>"
		|Browser 		|
		|IE 			|	
		|Firefox	 	|
		|Safari			|
		|Chrome			|
	When I select link "Japanesse" from "Locale" dropdown
	Then I verify text "You are using an outdated browser. For a faster, safer browsing experience, upgrade for free today." does not exist				
	And I take a screenshot	