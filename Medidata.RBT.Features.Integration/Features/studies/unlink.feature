# Two cases for manual unlinking / linking / refreshing of study:
# 1. I create a study in iMedidata, misnamed or otherwise incorrect, and it links to the wrong study.
# 2. I need to refresh a study that was copied to a Rave sandbox.
# Need a way to somehow indicate to Rave that one or many studies may need to be fully resynchronized as they are newly linked.

Feature: Study Unlinking
    In order to unlink and resynchronize studies
    As a User
    I want to be able to unlink a study in Rave from iMedidata

Background:
	Given I am an iMedidata user "<User>" with pin "<PIN>" password "<Password>"  user id <"User ID/Name>"
		|User						|PIN						| Password							|User ID/Name						|Email 							|
		|{Imedidata User 1}			|Imedidata User 1 PIN}		|{Imedidata User 1 Password}		|{Imedidata User 1 ID}			|{Imedidata User 1 Email}		|
		|{Imedidata User 2}			|Imedidata User 2 PIN}		|{Imedidata User 2 Password}		|{Imedidata User 2 ID}			|{Imedidata User 2 Email}		|
	And there exists a Rave user "<Rave User>" with username "<Rave User Name>" password "<Rave Password>" with "<Email>"
		|Rave User		|Rave User Name		|Rave Password		|Email			|
		|{Rave User 1}	|{Rave User Name 1}	|{Rave Password 1}	|{Rave Email 1}	|
	And there exists study "<Study>" in study group "<Study Group>"
		|Study		|Study Group 	|
		|{Study A}	|{Study Group} 	|
		|{Study B}	|{Study Group} 	|
	And there exists Rave study "<Rave Study>" 
		|Rave Study|
		|{Study A}	|
		|{Study B}	|
    And the Rave Study "<Rave Study>" are linked to iMedidata "<Study>"
	    |Rave Study | Study |
		|{Study A}	|{Study A}	|
		|{Study B}	|{Study B}|
	And there exists app "<App>" associated with study 
		|App			|
		|{Edc App}		|
		|{Modules App}	|
		|{Security App}	|
	And there exists site "<Site>" in study "<Study>", 		
		|Study		|Site		|
		|{Study A}	|{Site A1}	|
		|{Study B}	|{Site B1}	|
		|{Study C}	|{Site C1}	|
	And there exists role "<Role>" in app "<App>", 		
		|App			|Role												|
		|{Edc App}		|{EDC Role 1}										|
		|{Edc App}		|{EDC Role 2}										|
		|{Edc App}		|{EDC Role 3}										|
		|{Edc App}		|{EDC Role CRA create sub cannot view all sites}	|
		{Edc App}		|{EDC Role RM Monitor}								|
		|{Modules App}	|{Modules Role 1}									|
		|{Modules App}	|{Modules Role 2 No Reports}						|
		|{Modules App}	|{Modules Role 3 No Sites}							|
		|{Security App}	|{Security Role 1}									|	
	And there exist <Rave URL> with <URL Name>
		|Rave URL		|URL Name							|
		|{Rave URL 1}	|{rave564conlabtesting1.mdsol.com	|
		|{Rave URL 2}	|{rave564conlabtesting2.mdsol.com	|
	
@Rave2012.2.0
@PB2.5.8.37-01
@DRAFT
Scenario: If a Rave study is copied to a new URL and Study Group, and I now have an unlinked study in iMedidata, and a project + environment in Rave that is not linked to that study, and new studysite assignments and user assignments exist on the new iMedidata Study Group, when Rave receives a studysite or user assignment to that unlinked study, Rave should do a name match against the iMedidata study and link the two automatically, creating the new studysite or user assignment. If a full refresh is required to capture the new assignments, a manual unlink and link may be completed to fully refresh the study.

@Rave2012.2.0
@PB2.5.8.33-01
@DRAFT
Scenario: If I have an linked study in iMedidata, and I manually unlink that study in Rave, then the study is now unlinked.  All user assignments and studysite assignments are also unlinked / removed, and users cannot access anything in that study from either iMedidata or Rave.

@Rave2012.2.0
@PB2.5.8.34-01
@DRAFT
Scenario: If I have a manually unlinked study in iMedidata, and I manually re-link that study in Rave, then the study is now linked.  Rave should also look for any other assignments that exist in iMedidata and may not yet exist in Rave and create them.

@Rave2012.2.0
@PB2.5.8.35-01
@DRAFT
Scenario: If I have a manually unlinked study in iMedidata, and a project + environment in Rave that was manually unlinked to that study, when Rave receives a studysite or user assignment to that unlinked study, Rave should do nothing.

@Rave2012.2.0
@PB2.5.8.36-01
@DRAFT
Scenario: If a Rave study is copied to a new URL and Study Group, and I now have an unlinked study in iMedidata, and a project + environment in Rave that is not linked to that study, when Rave receives a studysite or user assignment to that unlinked study, Rave should do a name match against the iMedidata study and link the two automatically, creating the new studysite or user assignment.

# Perhaps there is a way to ensure everything is always synchronized? Perhaps there is a way for Rave to 'tell' if something was not explicitly unlinked or had never been linked before.  If Rave finds that there is a study with a matching Name but not UUID, perhaps Rave can assume that a full 'manual' refresh is required for that study.


@release2012.1.0
@PB2.5.8.12-01
@DRAFT
## No matching spigot script
Scenario: If the Link To iMedidata checkbox was initially checked and is subsequently unchecked for a Project/Study created in Rave and linked from iMedidata , then the corresponding Study and Study Sites will become inaccessible to EDC Roles on Rave and Rave Home page is displayed for a user with multiple study assignments .


## 08/14 - i unlink study as owner and then log back in as user and stil see the study when i follow the "<App"> for tat particular study.
When i go in as a study owner.. and access the app for that study  i dont see the study on studies home page- study environment setup page shows as study is UNLINKED to iMedidata.. but user is still able to see it in Home page - User has only EDC Role.

currently we can only uncheck PROD env.


    Given I am logged in to iMedidata as "{Imedidata User 1 ID}"
    And I have an assignment to Study "<Study A>" for EDC App "<Edc App>" for Role "<Edc Role 1>" 
	And I have an assignment to Study "<Study B>" for EDC App "<Edc App>" for Role "<Edc Role 1>" 
	And I have an assignment to Study "<Study C>" for EDC App "<Edc App>" for Role "<Edc Role 1>"
	And I have an assignment to Site "<Site A1>" in Study "<Study A>"
	And I have an assignment to Site "<Site B1>" in Study "<Study B>"
	And I have an assignment to Site "<Site C1>" in Study "<Study C>"
	And I follow EDC App "<Edc App>" for Role "<Edc Role 1>" for Study "<Study A>"
	And I am on "<Site A1>" page
	And I follow Home
	And I see "<Study A>" "<Study B>" "<Study C>"
	And I log out 
	And I log in to iMedidata as "{Imedidata User 2 ID}" 
	And I am owner of Study Group "<Study Group>" for EDC App "<Edc App>" for Role "<Edc Role 1>" Modules App "<Modules App>" for Role "<Modules Role>"
	And I follow EDC App "<Edc App>" for Role "<Edc Role 1>" for Study "<Study A>"
    And I navigate to Studies Environment Setup page for Study "<Study A>" in Rave
	And I see Link to iMedidata Checkbox Checked for Environment "PROD"
	And I update by unchecking Link to iMedidata Checkbox
	And I log out   
	And I log in to iMedidata as "{Imedidata User 1 ID}"
	And I follow link iMedidata
	And I am on iMedidata home page
	When I follow EDC App "<EDC App> with Role "<EDC Role 1>" for <"Study A">
	Then I should not see "<Study A>" listed in Home page of Rave
	And I should see "<Study B>" "<Study C>"
	And I take a screen shot

## newly added 08/07

@release2012.1.0
@PB2.5.8.12-02
@DRAFT
## No matching spigot script
Scenario: If the Link To iMedidata checkbox was initially checked and is subsequently unchecked for a Project/Study created in Rave and linked from iMedidata, then the corresponding Study and Study Sites will be accessible to All Modules Roles on Rave. 
  	
    Given I am logged in to iMedidata as "{Imedidata User 1 ID}"
    And I have an assignment to Study "<Study A>" for EDC App "<Edc App>" for Role "<Edc Role 1>" for Modules App "<Modules App>" for Role "<Modules Role 1>"
	And I have an assignment to Study "<Study B>" for EDC App "<Edc App>" for Role "<Edc Role 1>" for Modules App "<Modules App>" for Role "<Modules Role 1>"
	And I have an assignment to Study "<Study C>" for EDC App "<Edc App>" for Role "<Edc Role 1>" for Modules App "<Modules App>" for Role "<Modules Role 1>"
	And I have an assignment to Site "<Site A1>" in Study "<Study A>"
	And I have an assignment to Site "<Site B1>" in Study "<Study B>"
	And I have an assignment to Site "<Site C1>" in Study "<Study C>"
	And I follow EDC App "<Edc App>" for Role "<Edc Role 1>" for Study "<Study A>" for Modules App "<Modules App>" for Role "<Modules Role 1>"
	And I am on "<Site A1>" page
	And I follow Home
	And I see "<Study A>" "<Study B>" "<Study C>"
	And I log out 
	And I log in to iMedidata as "{Imedidata User 2 ID}" 
	And I am owner of Study Group "<Study Group>" for EDC App "<Edc App>" for Role "<Edc Role 1>" Modules App "<Modules App>" for Role "<Modules Role>"
	And I follow EDC App "<Edc App>" for Role "<Edc Role 1>" for Study "<Study A>"
    And I navigate to Studies Environment Setup page for Study "<Study A>" in Rave
	And I see Link to iMedidata Checkbox Checked for Environment "PROD"
	And I update by unchecking Link to iMedidata Checkbox
	And I log out 
	And I log in to iMedidata as "{Imedidata User 1 ID}"
	And I follow link iMedidata
	And I am on iMedidata home page
	When I follow EDC App "<EDC App> with Role "<EDC Role 1>" for <"Study A">
	Then I should not see "<Study A>" listed in Home page of Rave
	And I should see "<Study B>" "<Study C>"
	And I navigate to Architect Module
	And I see "<Study A>" listed
	And I see "<Study B>" "<Study C>"
	And I take a screen shot
	
	
	------------------
    Given I am logged in to iMedidata
    And I have an assignment to Study <Study 123>" "<Modules App>" with Role "<All Modules Role>"
	And I follow "<Modules App>" with Role "<Modules Role>" for "Study 123"
    And I navigate to Studies Environment Setup  page for Study "Study 123" in Rave
	And I see Link to iMedidata Checkbox Checked for Environment "PROD"
	And I update by unchecking Link to iMedidata Checkbox
	And I navigate to iMedidata
	When I follow " <Modules App>" with Role "<All Modules Role>" for "Study 123"
	And I am in Rave Study Home page
	And I navigate to Architect page
	Then I should see "Study 123" 
	And I take a screen shot
@Patch 13
@PB2.5.8.12-02
@DRAFT
Scenario: If the Link To iMedidata checkbox was initially checked and is subsequently unchecked for a Project/Study created in Rave and linked from iMedidata , then the corresponding Study and Study Sites will become inaccessible to EDC Roles on Rave and Rave Home page is displayed for a user with multiple study assignments .