# 

Feature: Site Assignments
    In order to use Rave Sites
    As a User
    I want to be able to be assigned to a Rave Study Site by iMedidata

Background:
    Given I am an iMedidata user "<User>" with pin "<PIN>" password "<Password>" and user id "<User ID>"
		|User						|PIN						| Password							|User ID						|Email 							|
		|{Imedidata User 1}			|Imedidata User 1 PIN}		|{Imedidata User 1 Password}		|{Imedidata User 1 ID}			|{Imedidata User 1 Email}		|
	And there exists a Rave user "<Rave User>" with username "<Rave User Name>" and password "<Rave Password>"
		|Rave User		|Rave User Name		|Rave Password		|
		|{Rave User 1}	|{Rave User Name 1}	|{Rave Password 1}	|
	    |{Rave User 2}	|{Rave User Name 2}	|{Rave Password 2}	|
	And there exists study "<Study>" in study group "<Study Group>"
		|Study		|Study Group 	|
		|{Study A}	|{Study Group} 	| 
		|{Study B}	|{Study Group} 	| 
		|{Study C}	|{Study Group} 	| 
		|{Study D}	|{Study Group} 	| 
		|{Study E}	|{Study Group} 	| 
	And there exists Rave study "<Rave Study>" 
		|{Study A}	|
        |{Study B}	|
		|{Study C}	|
		|{Study D}	|
    And there exists site "<Site>" in study "<Study>", 	in iMedidata	
	|Study		|Site		|
	|{Study A}	|{Site A1}	|
    And there exists User Group " All Modules" , "iMedidata EDC"
	And there exists app "<App>" associated with study in iMedidata
		|App			|
		|{Edc App}		|
		|{Modules App}	|
		|{Security App}	|
	And there exists site "<Site>" in study "<Study>", 	in iMedidata	
		|Study		|Site		|
		|{Study A}	|{Site A1}	|
		|{Study B}	|{Site B1}	|
		|{Study B}	|{Site B2}	|
		|{Study C}	|{Site C1}	|
		|{Study C}	|{Site C2}	|
		|{Study C}	|{Site C3}	|
	And there exists role "<Role>" in app "<App>", 		
		|App			|Role												|
		|{Edc App}		|{EDC Role 1}										|
		|{Edc App}		|{EDC Role 2}										|
		|{Edc App}		|{EDC Role Data Manager}						    |
		|{Edc App}		|{EDC Role CRA create sub cannot view all sites}	|
		|{Edc App}		|{EDC Role RM Monitor}								|
		|{Modules App}	|{Modules Role 1}									|
		|{Modules App}	|{Modules Role 2 No Reports}						|
		|{Modules App}	|{Modules Role 3 No Sites}	
		|{Modules App}  |{Modules Role 4 All Sites}                         |
		|{Security App}	|{Security Role 1}									|		
	And there exist "<Rave URL>" with "<URL Name>"
		|Rave URL		|URL Name							|
		|{Rave URL 1}	|{rave564conlabtesting1.mdsol.com	|
		
@Patch 13
@PB2.5.8.29-100
@DRAFT
@BUG
Scenario: If there is a study in iMedidata that is linked to a study in Rave, and there is an iMedidata-managed, linked studysite that is in both iMedidata and Rave, Rave-managed users who are not linked to a corresponding iMedidata account can be assigned to this site from the Rave User Administration panel.

    Given I am an iMedidata User
    And I am logged in to iMedidata
    And my Username is "<Imedidata User 1 ID>" in iMedidata
    And there is a Rave User with user name "<Rave User Name 1>" 
	And the Rave Username "<Rave User Name 1"> is not connected to iMedidata
	And the Rave User named "<Rave User Name 1>" has a User Group of "All Modules"	
	And there is a Rave Study named "<Study A>"
	And there is an iMedidata Study named "<Study A>"
    And the iMedidata Study named "<Study A>" has Site "<Site A1>" 
	And the iMedidata Study "<Study A>" is linked with Rave Study "<Study A>"
    And I have an assignment to the iMedidata Study named "<Study A>" for the App named "<Edc App>" and the Role "<EDC Role 1>"
	And I have an assignment to the iMedidata Study named "<Study A>" for the App named "<Modules App>" and the Role "<Modules Role 1>"
	And I follow App named "<Edc App>" for Study "<Study A>"
	And I am on Rave Site "<Site A1>" home page for Study "<Study A>"
	And I navigate to User Adminstration
	And I navigate to User Details page for Rave User "<Rave User Name 1>"
	And there is no assignment to any Study for the Rave "<Rave User Name 1>"
	And I follow Assign to Study
	And I assign username "<Rave User Name 1>" with Study "<Study A>"
	And I follow Sites 
	And I assign the user with "<Site A1>"
	And I log out of Rave
	When I log in as "<Rave User Name 1>" in Rave
	Then I should see Site "<Site A1>" home page in Rave
	And I take a screenshot
	
@Patch 13
@PB2.5.8.31-01
@DRAFT
Scenario: If I have an unlinked study in iMedidata, and a project + environment in Rave that is not linked to that study, when Rave receives a studysite or user assignment to that unlinked study, Rave should do a name match against the iMedidata study and link the two automatically, creating the new studysite or user assignment.
   
    Given I am an iMedidata User
    And I am logged in to iMedidata
    And my Username is "<Imedidata User 1 ID>" in iMedidata
    And there is an iMedidata Study named "<Study A>"
    And the iMedidata Study named "<Study A>" has Site "<Site A1>" 
	And there is a Rave Study named "<Study A>"
	And there are no Sites associated with the Rave Study "<Study A>"
    And the iMedidata Study named "<Study A>" is not connected to the Rave Study named "<Study A>"
    And I have an Invitation to the iMedidata Study named "<Study A>" for the App named "<Edc App>" and the Role "<EDC Role 1>"
	And I have an Invitation to the iMedidata Study named "<Study A>" for the App named "<Modules App>" and the Role "<Modules Role 1>"
    And I have an invitation to the iMedidata site named "<Site A1>" with Study Site Number "1234" for the iMedidata study named "<Study A>"
	And I accept the invitations
    When I follow App named "<Edc App>" for Study "<Study A>"
	Then I should be on Rave Site Home page for "<Site A1>" for "<Study A>"
	And I should see user as "<Imedidata User 1 ID>" in Rave
	And I navigate to Site Adminstration 
	And I search for Study "<Study A>" 
	And I should see Site "<Site A1>" in search results
	And I navigate to Site Details page for "<Site A1>" for Study "<Study A>"
	And I should see Source "iMedidata"
	And I should see "<Study A>" with Number "1234" in Study Sites pane 
	And I navigate to User Adminstration page
	And I search for User name "<Imedidata User 1 ID>" with Authenticator "iMedidata"
	And I navigate to User Details page for user name "<Imedidata User 1 ID>"
	And I should see Authenticator "iMedidata"
	And I should see Study "<Study A>" listed in Studies pane
	And I take a screenshot
   
@Patch 13
@PB2.5.8.32-01
@DRAFT
Scenario: If I have an unlinked study in iMedidata, when Rave receives a studysite or user assignment to that unlinked study, Rave should do a name match against the iMedidata study and, failing that, create a new project and environment that maps to that study.

    Given I am an iMedidata User
    And I am logged in to iMedidata
    And my Username is "<Imedidata User 1 ID>" in iMedidata
    And there is an iMedidata Study named "<Study E>"
    And the iMedidata Study named "<Study E>" has Site "<Site E1>" 
	And there exists no Rave Study named "<Study E>"
	And there are no Sites associated with the Rave Study "<Study E>"
    And I have an assignment to the iMedidata Study named "<Study E>" for the App named "<Edc App>" and the Role "<EDC Role 1>"
	And I have an assignment to the iMedidata Study named "<Study E>" for the App named "<Modules App>" and the Role "<Modules Role 1>"
    And I have an assignment to the iMedidata site named "<Site E1>" with Study Site Number "1234" for the iMedidata study named "<Study E>"
    When I follow App named "<Edc App>" for Study "<Study E>"
	Then I should be on Rave Site Home page for "<Site E1>" for "<Study E>"
	And I take a screenshot
	And I should see User as "<Imedidata User 1 ID>" in Rave
	And I navigate to Architect 
	And I should see "<Study E>" listed 
	And I navigate to Studies Environment setup page for "<Study E>"
	And I should see Environment "Prod"
	And I should see Active "Checked"
	And I should see Linked to "iMedidata"
	And I take a screenshot
	And I navigate to Site Adminstration 
	And I search for Study "<Study E>" 
	And I should see Site "<Site E1>" in search results
	And I navigate to Site Details page for "<Site E1>" for Study "<Study E>"
	And I should see Source "iMedidata"
	And I should see "<Study E>" with Number "1234" in Study Sites pane 
	And I navigate to User Adminstration page
	And I search for User name "<Imedidata User 1 ID>" with Authenticator "iMedidata"
	And I navigate to User Details page for user name "<Imedidata User 1 ID>"
	And I should see Authenticator "iMedidata"
	And I should see Study "<Study E>" listed in Studies pane
	And I take a screenshot
   

@Patch 13
@PB2.5.9.29-01
@DRAFT
Scenario: If the user has access to study and site in Rave that is linked with the study and site on iMedidata and if the user is unassigned to the site for the study on iMedidata then that site will not be accessible for the user in Rave. 

    Given I am an iMedidata User
    And I am logged in to iMedidata
    And my Username is "<Imedidata User 1 ID>" in iMedidata
    And there is a Rave User named "<Rave User Name 1>"
    And the Rave User named "<Rave User Name 1>" has a User Group of "iMedidata EDC"
    And there is an iMedidata Study named "<Study A>"
    And the iMedidata Study named "<Study A>" has Sites "<Site A1>" 
	And there is a Rave Study named "<Study A>"
	And there is a Rave Site named "<Site A1>" for Study "<Study A>"
    And the iMedidata Study named "<Study A>" is connected to the Rave Study named "<Study A>"
    And I have an assignment to the iMedidata Study named "<Study A>" for the App named "<Edc App>" and the Role "<EDC Role 1>"
    And I have an assignment to the iMedidata site named "<Site A1>" for the iMedidata study named "<Study A>"
	And I follow app named "<EDC App>" for "<Study A>"
	And I see <"Site A1>" home page in Rave for Study "<Study A>"
	And I follow iMedidata link
	And I am on iMedidata home page
    And my assignment to the iMedidata site named "<Site A1>" for the iMedidata study named "<Study A>" is removed
	And there is no assignment for an iMedidata study for the "<Imedidata User 1 ID>"
	When I follow app named "<EDC App>" for "<Study A>"
    And I am on Rave Study Home Page for "<Study A>"
	Then I should see message "No Sites Found"
	And I take a screenshot
	
@Patch 13
@PB2.5.9.29-03
@DRAFT
Scenario: If the user has access to study in Rave that is linked with the study on iMedidata with multiple sites assignment and if the user is unassigned to site for the study on iMedidata then that site will not be accessible in Rave.

    Given I am an iMedidata User
    And I am logged in to iMedidata
    And my Username is "<Imedidata User 1 ID>" in iMedidata
    And there is a Rave User named "<Imedidata User 1 ID>"
    And the Rave User named "<Imedidata User 1 ID>" has a User Group of "iMedidata EDC"
    And there is an iMedidata Study named "<Study C>"
    And the iMedidata Study named"<Study C>" has Sites "<Site C1>" "<Site C2>" "<Site C3>"
	And there is a Rave Study named "<Study C>"
    And the iMedidata Study named "<Study C>" is connected to the Rave Study named "<Study C>"
    And I have an assignment to the iMedidata Study named "<Study C>" for the App named "<Edc App>" and the Role "<EDC Role 1>"
    And I have an assignment to the iMedidata site named "<Site C1>" site named "<Site C2>" site named "<Site C3>" for the iMedidata study named "<Study C>"
	And I follow app named "<EDC App>" for "<Study C>"
	And I am on Study "<Study C>" home page 
	And I see "<Site C1>" "<Site C2>" "<Site C3>" on the study home page
    And I follow iMedidata link
	And I am on iMedidata home page
	And my assignment to the iMedidata site named "<Site C1>" for the iMedidata study named "<Study C>" is removed
    When I follow the app named "<EDC App>" for "<Study C>"
    Then I am on the Rave Home Page for Study "<Study C>"
    And I should see "<Site C2>"
    And I should see "<Site C3>"
    And I should not see "<Site C1>"
	And I take a screenshot

@Patch 13
@PB2.5.9.34-01
@DRAFT
Scenario: If the user has access to study in iMedidata that is linked with a study on Rave.When a new site is created for a study on iMedidata, then the site will appear for that study on Rave.

    Given I am an iMedidata User
    And I am logged in to iMedidata
    And my Username is "<Imedidata User 1 ID>" in iMedidata
    And there is a Rave User named "<Imedidata User 1 ID>"
    And the Rave User named "<Imedidata User 1 ID>" has a User Group of "iMedidata EDC"
    And there is an iMedidata Study named "<Study D>"
    And the iMedidata Study named "<Study D>" is connected to the Rave Study named "<Study D>"
    And I have an assignment to the iMedidata Study named "<Study D>" for the App named "<Edc App>" and the Role "<EDC Role 1>"
    And I have an assignment to the iMedidata Study named "<Study D>" for the App named "<Modules App>" and the Role "<Modules Role 1>"
	And I am the study owner for the iMedidata study named "<Study D>"
    And I navigate to Sites on Manage Study page for Study "<Study D>"
    And I follow "Create New Sites"
    And I save the following:
	|Name| Site Number |Study-Site Number|Notes|
	|Site D1|   123   |   12345    |   Note1   |
	And I navigate to iMedidata home page
	And I follow App named "<Edc App>" for Study "<Study D>"
    And I am on Rave Site "<Site D1>" page for Study "<Study D>"
	When I navigate to Site "<Site D1>" in Site Adminstration
    Then I should see the Rave SiteName "<Site D1>"
	And I should see SiteNumber is "123" 
    And I should see Source is "iMedidata"
	And I should see Number "12345" in Study Sites pane
	And I take a screenshot
	

@Patch 13
@PB2.5.9.35-01
@DRAFT
Scenario: If an externally authenticated user does not have access to a particular site in Rave, but has been invited to a Role in Rave that permits them access to all sites, that user will see the sites in Rave in accordance with these Role settings, regardless of the site access set in iMedidata.

    Given I am an iMedidata User
    And I am logged in to iMedidata
    And my Username is "<Imedidata User 1 ID>" in iMedidata
    And there is a Rave User named "<Imedidata User 1 ID>"
    And the Rave User named "<Imedidata User 1 ID>" has a User Group of "iMedidata EDC"
    And there is an iMedidata Study named "<Study C>"
	And the iMedidata Study named"<Study C>" has Sites "<Site C1>" "<Site C2>" "<Site C3>"
    And there is a Rave Study named "<Study C>"
	And the Rave Study named "<Study C>" has Sites "<Site C1>" "<Site C2>" "<Site C3>"
    And the iMedidata Study named "<Study C>" is connected to the Rave Study named "<Study C>"
    And I have an assignment to the iMedidata Study named "<Study C>" for the App named "<EdcApp>" and the Role "<EDC Role Data Manager>"
    And I have an assignment to the iMedidata site named "<Site C1>" for the iMedidata study named "<Study C>"
	And I follow "<Edc App>" for "<Study C>"
	And I see Rave Home page for "<Site C1>"
	And I should not see "<Site C2>" "<Site C3>"
	And I follow iMedidata link
	And I have an assignment to the iMedidata Study named "<Study C>" for the App named "<EDC App>" and the Role "<EDC Role 3 All Sites>"
	When I follow "<Edc App>" for "<Study C>"
	Then I Should be on Rave Study Home page for "<Study C>"
	And I should see "<Site C1>" 
	And I should see "<Site C2>" "<Site C3>"
	And I take a screenshot

@Patch 13
@PB2.5.9.35-03
@DRAFT
Scenario: If an externally authenticated user does not have access to a particular site in Rave, but has been invited to a Role in Rave that permits them access to a set of sites, that user will see the sites in Rave in accordance with these Role settings, regardless of the site access set in iMedidata.

    Given I am an iMedidata User
    And I am logged in to iMedidata
    And my Username is "<Imedidata User 1 ID>" in iMedidata
    And I am connected to Rave
	And the username "<Imedidata User 1 ID>" in Rave Site Group is "<World>"
    And there is an iMedidata Study named "<Study C>"
	And the iMedidata Study named"<Study C>" has Sites "<Site C1>" "<Site C2>" "<Site C3>"
	And Sites "<Site C1>" "<Site C2>" country associated with is "United States of America"
	And Site "<Site C3>" country associated with is "India"
    And there is a Rave Study named "<Study C>"
	And the Rave Study named "<Study C>" has Sites "<Site C1>" "<Site C2>" "<Site C3>"
    And the iMedidata Study named "<Study C>" is connected to the Rave Study named "<Study C>"
    And I have an assignment to the iMedidata Study named "<Study C>" for the App named "<EdcApp>" and the Role "<EDC Role 1>"
    And I have an assignment to the iMedidata site named "<Site C1>" "<Site C2>" "<Site C3>" for the iMedidata study named "<Study C>"
	And I follow "<Edc App>" for "<Study C>"
	And I see Rave Home page for Study "<Study C>"
    And I should see Sites "<Site C1>" "<Site C2>" "<Site C3>"
	And my Site Group assignment in Rave is changed to "<Asia >"
	And I navigate back to iMedidata
	And I follow "<EDC App>" for "<Study C>"
	When I follow iMedidata link
	Then I should be on Site "<Site C3>" home page for Study "<Study A>"
	And I should not see "<Site C1>" "<Site C2>"
	And I take a screenshot

@Patch 13
@PB2.5.9.35-02
@DRAFT
Scenario: If an internally authenticated user does not have access to a particular site in Rave, but has been invited to a Role in Rave that permits them access to all sites or a set of sites, that user will see the sites in Rave in accordance with these Role settings, regardless of the site access set in iMedidata.

#Ask JS to clarify what the intention of the Rek

    Given I am an Rave managed User
    And I have an account in iMedidata
	And my Rave account is linked to iMedidata account
    And my Username is "<Imedidata User 1 ID>" in iMedidata
    And my Rave Username is "<Imedidata User 1 ID>"
    And my Rave User Group assignment is "iMedidata EDC"
    And there is an iMedidata Study named "<Study C>"
	And the iMedidata Study named"<Study C>" has Sites "<Site C1>" "<Site C2>" "<Site C3>"
    And there is a Rave Study named "<Study C>" 
	And there is a Rave Sites named "<Site C1>" "<Site C2"> "<Site C3"> for Study "<Study C>"
	And I do not have permission to view the Rave Site "<Site C1>"
    And the iMedidata Study named "<Study C>" is connected to the Rave Study named "<Study C>"
    And I have an assignment to the iMedidata Study named "<Study C>" for the App named "<EdcApp>" and the Role "<EDC Role Data Manager>"
    And I am logged in to iMedidata
	And I have an assignment to the iMedidata sites "<Site C2>" "<Site C3>" for the iMedidata study named "<Study C>"
	And I follow "<Edc App>" for "<Study C>"
	And I see Rave Study "<Study A>" home page
	And I should see "<Site C2>" "<Site C3>"
	And I Should not see "<Site C1>"
	And follow iMedidata link
	And I have an assignment to the iMedidata Study named "<Study C>" for the App named "<Modules App>" and the Role "<Modules Role 3 All Sites>"
	When I follow "<Edc App>" for "<Study C>"
	Then I Should be on Rave Study Home page for "<Study C>"
	And I should see Sites "<Site C1>" "<Site C2>" "<Site C3>"
#   And I follow iMedidata link
#	And I should not see "<Site C1>" in Sites pane on iMedidata home page
    And I take a Screenshot

	# '''''''''''''''''''''''''''' Added to new scenarios --------------------------------------------

	Scenario: If an already connected iMedidata user access Rave through a study application link
           with multiple EDC roles for that Study, then data in Rave should be updated accordingly 


    Given I am an iMedidata User
        And I am logged in
        And my Name is "<Imedidata User 1 ID>"
        And there is an iMedidata Study  "<Study A>" in Study Group "<Study Group>"
        And there is a Rave Study  "<Study A>" 
        And the iMedidata Study  "<Study A> is linked to the Rave Study  "<Study A>"
        And I have an assignment to the iMedidata only one Study  "<Study A>" for the App  "<EDC App>" Role "<EDC Role 1>" "<EDC Role 2>"
        And I have an assignment to the iMedidata Study  "<Study A>" for the App  "<Modules App>" Role "<Modules Role 1>"
        And I am on the iMedidata Home page
        And I click on the App  "<EDC App>" next to the Study  "<Study A>"
        And I should see the Role Selection Page
	    And I see "<EDC Role 1>" "<EDC Role 2>" in Select Role Dropdown
	    And I select "<EDC Role 1>" 
	    And I select continue 
	    And I am on Study "<Study A>" home page in Rave
	    And I navigate to User Adminstration
	    And I search for User "<Imedidata User 1 ID>" with Authenticator "iMedidata"
	    And I should see Role "<Edc Role 1>" assigned to user "<Imedidata User 1 ID>"
	    And I should see Role "<Edc Role 2>" assigned to user "<Imedidata User 1 ID>"
        And I take a screenshot 1 of 5
        And I navigate to the User Details page
        And I see the assignment to the iMedidata Study "<Study A>" for Roles "<EDC Role 1>" "<EDC Role 2>"
        And I see the account "Active" check box is checked 
        And I take a screenshot 2 of 5
        And I click on iMedidata link to navigate back to iMedidata
        And I navigate to the Mannage Study Users Tab
        And I remove one role "<EDC Role 2>" from the assignment
        And I have an assignment to the iMedidata Study  "<Study A>" for the App  "<EDC App>" Role "<EDC Role 1>"
        And I navigate to the iMedidata Home page
        And I click on the App  "<EDC App>" next to the Study  "<Study A>"
        And I am on Study "<Study A>" home page in Rave
	    And I navigate to User Adminstration
	    When I search for User "<Imedidata User 1 ID>" with Authenticator "iMedidata"
	    Then I should see Role "<Edc Role 1>" assigned to user "<Imedidata User 1 ID>"
	    And I should not see Role "<Edc Role 2>" assigned to user "<Imedidata User 1 ID>"
        And I see "Include Inactive Records" checkbox is unchecked
        And I take a screenshot 3 of 5
        And I navigate to the User Details page for the user "<Imedidata User 1 ID>" Role "<Edc Role 1>"
        And I see the assignment to the iMedidata Study "<Study A>" for Role "<EDC Role 1>" only
        And I see the account "Active" check box is checked
        And I take a screenshot 4 of 5
        And I select "Go Back" link
        And I am on User Adminstration search result page
        And I set the "Include Inactive Records" checkbox as checked
        And I search for User "<Imedidata User 1 ID>" with Authenticator "iMedidata"
        And I should see Role "<Edc Role 2>" listed into search result
        And I navigate to the User Details page for the user "<Imedidata User 1 ID>" Role "<Edc Role 2>"
        And I should not see the assignment to the iMedidata Study "<Study A>" for Role "<EDC Role 2>"
        And I see the account "Active" check box is un-checked
        And I take a screenshot 5 of 5
        




Scenario: If an already connected iMedidata user access Rave through a study application link
           with multiple EDC roles for internal and external Studies, then data in Rave should be updated accordingly for each assignment


    Given I am an iMedidata User
        And I am logged in
        And my Name is "<Imedidata User 1 ID>"
        And there is an iMedidata Study  "<Study A>" in Study Group "<Study Group>"
        And there is a Rave Study  "<Study A>"
        And there is a Rave Study  "<Study B>"
        And the iMedidata Study  "<Study A> is linked to the Rave Study  "<Study A>"
        And I have an assignment to the iMedidata Study  "<Study A>" for the App  "<EDC App>" Role "<EDC Role 1>" "<EDC Role 2>" "<EDC Role 3>"
        And I have an assignment to the Rave Study  "<Study B>" for the App  "<EDC App>" Role "<EDC Role 2>"
        And I have an assignment to the iMedidata Study  "<Study A>" for the App  "<Modules App>" Role "<Modules Role 1>"
        And I am on the iMedidata Home page
        And I click on the App  "<EDC App>" next to the Study  "<Study A>"
        And I should see the Role Selection Page
	    And I see "<EDC Role 1>" "<EDC Role 2>" in Select Role Dropdown
	    And I select "<EDC Role 1>" 
	    And I select continue 
	    And I am on Study "<Study A>" home page in Rave
	    And I navigate to User Adminstration
	    And I search for User "<Imedidata User 1 ID>" with Authenticator "iMedidata"
        And I should see Role "<Edc Role 1>" assigned to user "<Imedidata User 1 ID>"
	    And I should see Role "<Edc Role 2>" assigned to user "<Imedidata User 1 ID>"
        And I should see Role "<Edc Role 3>" assigned to user "<Imedidata User 1 ID>"
	    And I click on iMedidata link to navigate back to iMedidata
        And I navigate to the Mannage Study Users Tab
        And I remove the role "<EDC Role 2>"  and "<EDC Role 3>" from the assignment
        And I have an assignment to the iMedidata Study  "<Study A>" for the App  "<EDC App>" Role "<EDC Role 1>"
        And I navigate to the iMedidata Home page
        And I click on the App  "<EDC App>" next to the Study  "<Study A>"
        And I am on Study "<Study A>" home page in Rave
	    And I navigate to User Adminstration
	    When I search for User "<Imedidata User 1 ID>" with Authenticator "iMedidata"
	    Then I should see Role "<Edc Role 1>" assigned to user "<Imedidata User 1 ID>"
	    And I should not see Role "<Edc Role 2>" assigned to user "<Imedidata User 1 ID>"
        And I should not see Role "<Edc Role 3>" assigned to user "<Imedidata User 1 ID>"
        And I see "Include Inactive Records" checkbox is unchecked
        And I take a screenshot 1 of 4
        And I navigate to the User Details page for the user "<Imedidata User 1 ID>" Role "<Edc Role 1>"
        And I see the assignment to the iMedidata Study "<Study A>" for Role "<EDC Role 1>" only
        And I see the account "Active" check box is checked
        And I take a screenshot 2 of 4
        And I select "Go Back" link
        And I am on User Adminstration search result page
        And I set the "Include Inactive Records" checkbox as checked
        And I search for User "<Imedidata User 1 ID>" with Authenticator "iMedidata"
        And I should see Role "<Edc Role 2>" listed into search result
        And I should see Role "<Edc Role 3>" listed into search result
        And I navigate to the User Details page for the user "<Imedidata User 1 ID>" Role "<Edc Role 2>"
        And I should not see the assignment to the iMedidata Study "<Study A>" for Role "<EDC Role 2>"
        And I should see the assignment to the Rave Study "<Study B>" for Role "<EDC Role 2>"
        And I see the account "Active" check box is un-checked
        And I take a screenshot 3 of 4
        And I select "Go Back" link
        And I navigate to the User Details page for the user "<Imedidata User 1 ID>" Role "<Edc Role 3>"
        And I should not see any assignment
        And I see the account "Active" check box is un-checked
        And I take a screenshot 4 of 4

    

