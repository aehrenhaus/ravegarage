@ignore
@FT_MCC-52790

Feature: MCC-52790 Review through Status Updater is not properly processing the update.

Background:

	Given I am a Rave user "<Rave User>" with username "<Rave User Name>", password "<Rave Password>" that can Verify, Review for Review Group 1 and Review Group2, Freeze Data and Lock Data
		|Rave User		|Rave User Name		|Rave Password		|
		|{Rave User 1}	|{Rave User Name 1}	|{Rave Password 1}	|
	
	  
    And there exists site "<Site>" in study "<Rave Study>", with folder "<Folder>" and form "<Form>" for Rave User "<Rave User>" 	
		|Rave User		|Rave Study		|Site		|Folder					|Form		|
		|{Rave User 1}	|{Study A}		|{Site A1}	|{Subject Level}		|{Form SL}	|
		|{Rave User 1}	|{Study A}		|{Site A1}	|{Folder 1}				|{Form 1}	|

	And I am assigned to the Status Updater Report
	And I am assigned to the Status Updater Configuration Report

	And there exist "<Rave URL>" 
		|Rave URL		|
		|{Rave URL 1}	|
		
#-------------------------------------------------------------------------------------------------------------------------
@Release 2013.1.0
@PBMCC-52790-01
@BG_26.Feb.2013
@Validation

Scenario: MCC-52790-01 Status Updater Reviews a form the Review checkboxe for that form are checked and theaudit trail is updated

Given I am a Rave user "<Rave User 1>"
And I am logged in to Rave
And I select study "<Study A>"
And I select site "<Site A1>"

And I create a subject "<Subject>" according to the following table
	|Study		|Site		|Subject		|
	|{Study A}	|{Site A1}	|{Subject 1}	|

And I enter and save Data on the form "<Form>" in site "<Site>" for study "<Study>"
	|Rave Study		|Site		|Folder					|Form		|
	|{Study A}		|{Site A1}	|{Subject Level}		|{Form SL}	|
	|{Study A}		|{Site A1}	|{Folder 1}				|{Form 1}	|

And I take a Screenshot

And I navigate to the Reporter Module
And I select the report "Status Updater"
And I select study "<Study A>", site "<Site A1>" and subject "<Subject 1>"

And I take a Screenshot

When I click button "Submit Report"
Then I am on the Status Updater Homepage
And I should see study "<Study A>"
And I should see subject "<Subject 1>"
And I should see text "No Folders/Forms have been selected"
And I should see text "No Actions have been selected"
And I should see text Select Folders/Forms 

And I take a Screenshot

And I logout of Rave

And I select folder "<Subject Level>" and "<Folder 1>"
And I select form "<Form SL>" and "<Form 1>"
When I select link "Select"
Then I see text "2 Folder/Form Combinations Selected "

And I take a Screenshot

And I check checkbox Set for Review: Review Group 1
When I select link "Select"
Then I see the Confirm Pane

And I take a Screenshot
When I enter submit all confirm data
Then I see text "Status Update Job:  Completed"

And I take a Screenshot

And I login to Rave as Rave User "<Rave User 1>"

And I choose subject "<Subject 1>" from study "<Study A>", site "<Site A1>"
When I select form "<Form>" from folder "<Folder>"
	|Form		|Folder				|
	|{Form SL}	|{Subject Level}	|
	|{Form 1}	|{Folder 1}			|

Then I see checkbox for "<Review Group 1>" is checked
And I take a Screenshot

When I select audit icon for field
ThenI see audit entry "Reviewed for Review Group 1".
And I take a Screenshot