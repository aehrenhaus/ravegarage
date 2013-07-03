# 

Feature: Site Assignments
    In order to use Rave Sites
    As a User
    I want to be able to be assigned to a Rave Study Site by iMedidata

Background:
    Given I am an iMedidata user "<User>" with pin "<PIN>" password "<Password>" and user id "<User ID>"
		|User						|PIN						| Password							|User ID						|Email 							|
		|{iMedidata User 1}			|iMedidata User 1 PIN}		|{iMedidata User 1 Password}		|{iMedidata User 1 ID}			|{iMedidata User 1 Email}		|
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

    And there exists User Group " All Modules" , "iMedidata EDC"
	And there exists app "<App>" associated with study in iMedidata
		|App			|
		|{EDC App}		|
		|{Modules App}	|
		|{Security App}	|

    And there exists site "<Site>" in study "<Study>", with site number "<Site Number>" and Syudy-Site number "<StudySiteNumber>"	in iMedidata	
	|Study		|Site		|Site Number		|StudySiteNumber		|
	|{Study A}	|{Site A1}	|{Site Number A1}	|{StudySiteNumber A1}	|
	|{Study B}	|{Site B1}	|{Site Number B1}	|{StudySiteNumber B1}	|
	|{Study B}	|{Site B2}	|{Site Number B2}	|{StudySiteNumber B2}	|
	|{Study C}	|{Site C1}	|{Site Number C1}	|{StudySiteNumber C1}	|
	|{Study C}	|{Site C2}	|{Site Number C2}	|{StudySiteNumber C2}	|
	|{Study C}	|{Site C3}	|{Site Number C3}	|{StudySiteNumber C3}	|
	|{Study D}	|{Site D1}	|{Site Number D1}	|{StudySiteNumber D1}	|
	|{Study E}	|{Site E1}	|{Site Number E1}	|{StudySiteNumber E1}	|


	And there exists site "<Site>" in study "<Study>", 	in iMedidata	
		|Study		|Site		|
		|{Study A}	|{Site A1}	|
		|{Study B}	|{Site B1}	|
		|{Study B}	|{Site B2}	|
		|{Study C}	|{Site C1}	|
		|{Study C}	|{Site C2}	|
		|{Study C}	|{Site C3}	|
	And there exists role "<Role>" in app "<App>", with "<Permissions>" as applicable 		
		|App			|Role												|Permissions				|
		|{EDC App}		|{EDC Role 1}										|No ViewAllSitesinSiteGroup |
		|{EDC App}		|{EDC Role 2}										|No ViewAllSitesinSiteGroup |
		|{EDC App}		|{EDC Role Data Manager}						    |
		|{EDC App}		|{EDC Role CRA create sub cannot view all sites}	|
		|{EDC App}		|{EDC Role 4}										|ViewAllSitesinSiteGroup	|
		|{Modules App}	|{Modules Role 1}									|
		|{Modules App}	|{Modules Role 2 No Reports}						|
		|{Modules App}	|{Modules Role 3 No Sites}	                        |
		|{Modules App}  |{Modules Role 4 All Sites}                         |
		|{Security App}	|{Security Role 1}									|		
	And there exist "<Rave URL>" with "<URL Name>"
		|Rave URL		|URL Name							|
		|{Rave URL 1}	|{rave564conlabtesting1.mdsol.com	|
		
@Rave 2013.2.0
@PB2.5.8.29-100
@Validation
@BUG
Scenario: If there is a study in iMedidata that is linked to a study in Rave, and there is an iMedidata-managed,
          linked studysite that is in both iMedidata and Rave, Rave-managed users who are not linked to iMedidata
		  can be assigned to this site from the Rave User Administration panel.

    Given I am an iMedidata User
	And there is a Rave User with user name "<Rave User Name 1>" 
	And the Rave User "<Rave User Name 1"> is not linked to iMedidata
	And the Rave User named "<Rave User Name 1>" has a User Group of "All Modules"	
	And there is a Rave Study named "<Study A>"
    And I am logged in to iMedidata
    And my Username is "<iMedidata User 1 ID>" in iMedidata
    And there is an iMedidata Study named "<Study A>"
    And the iMedidata Study named "<Study A>" has Site "<Site A1>" 
	And the iMedidata Study "<Study A>" is linked with Rave Study "<Study A>"
	And I have an assignment to the iMedidata Study named "<Study A>" for the App named "<EDC App>" and the Role "<EDC Role 1>"
	And I have an assignment to the iMedidata Study named "<Study A>" for the App named "<Modules App>" and the Role "<Modules Role 1>"
	And I take a screenshot
	And I accept the invitation
	And I follow App named "<EDC App>" for Study "<Study A>"
	And I am on Rave Site "<Site A1>" home page for Study "<Study A>"
	And I take a screenshot
	And I navigate to User Adminstration
	And I search for Rave User name "<Rave User Name 1"> with Authenticator "Internal"
	And I navigate to User Details page for Rave User "<Rave User Name 1>"
	And there is no assignment to any Study for the Rave "<Rave User Name 1>"
	And I take a screenshot
	And I follow Assign to Study
	And I assign username "<Rave User Name 1>" with Study "<Study A>"
	And I take a screenshot
	And I follow Sites 
	And I assign the user with "<Site A1>"
	And I take a screenshot
	And I log out
	When I log in as "<Rave User Name 1>" in Rave
	Then I should be on Site "<Site A1>" Home page in Rave
	And I take a screenshot
	
@Rave 2013.2.0
@PB2.5.8.31-01
@Validation
Scenario: If I have an unlinked study in iMedidata, and a project + environment in Rave that is not linked to that study,
            when Rave receives a studysite or user assignment to that unlinked study, Rave should do a name match against
			the iMedidata study and link the two automatically, creating the new studysite or user assignment.
   
    Given I am an iMedidata User
    And I am logged in to iMedidata
    And my Username is "<iMedidata User 1 ID>" in iMedidata
    And there is an iMedidata Study named "<Study A>"
    And the iMedidata Study named "<Study A>" has Site "<Site A1>" and site number "<Unique Number 1>"
	And I have an Invitation to the iMedidata Study named "<Study A>" for the App named "<EDC App>" and the Role "<EDC Role 1>"
	And I have an Invitation to the iMedidata Study named "<Study A>" for the App named "<Modules App>" and the Role "<Modules Role 1>"
    And I have an invitation to the iMedidata site named "<Site A1>" with Study Site Number "<StudySiteNumber A1>" for the iMedidata study named "<Study A>"
	And I take a screenshot
	And I accept the invitations
    When I follow App named "<EDC App>" for Study "<Study A>"
	Then I should be on Rave Site Home page for "<Site A1>" for "<Study A>"
	And I should see user as "<iMedidata User 1 ID>" in Rave
	And I take a screenshot
	And I navigate to Site Adminstration 
	And I search for Study "<Study A>" 
	And I should see Site "<Site A1>" in search results
	And I navigate to Site Details page for "<Site A1>" for Study "<Study A>"
	And I should see Source "iMedidata"
	And I should see "<Study A>" with Study Site Number "<StudySiteNumber A1>" in Study Sites pane
	And I take a screenshot
	And I navigate to User Adminstration page
	And I search for User name "<iMedidata User 1 ID>" with Authenticator "iMedidata"
	And I navigate to User Details page for user name "<iMedidata User 1 ID>"
	And I should see Authenticator "iMedidata"
	And I should see Study "<Study A>" listed in Studies pane
	And I take a screenshot
   
@Rave 2013.2.0
@PB2.5.8.32-01
@Validation
Scenario: If I have an unlinked study in iMedidata, when Rave receives a studysite or user assignment to that unlinked study,
          Rave should do a name match against the iMedidata study and, failing that, create a new project and environment that maps to that study.

    Given I am an iMedidata User
    And I am logged in to iMedidata
    And my Username is "<iMedidata User 1 ID>" in iMedidata
    And there is an iMedidata Study named "<Study E>"
    And the iMedidata Study named "<Study E>" has Site "<Site E1>" with Site Number "<Unique Number 2>"
	And there exists no Rave Study named "<Study E>"
	And there are no Sites associated with the Rave Study "<Study E>"
	And there exists no Site named "<Site E1>" in Rave with Site Number "<Unique Number 2>"
    And I have an assignment to the iMedidata Study named "<Study E>" for the App named "<EDC App>" and the Role "<EDC Role 1>"
	And I have an assignment to the iMedidata Study named "<Study E>" for the App named "<Modules App>" and the Role "<Modules Role 1>"
    And I have an assignment to the iMedidata site named "<Site E1>" with Study Site Number "<StudySiteNumber E1>" for the iMedidata study named "<Study E>"
	When I follow App named "<EDC App>" for Study "<Study E>"
	Then I should be on Rave "<Site E1>" Site Home page for "<Study E>"
	And I should see User as "<iMedidata User 1 ID>" in Rave
	And I take a screenshot
	And I navigate to Architect
	And I should see "<Study E>" listed
	And I take a screenshot
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
	And I should see "<Study E>" with Study Site Number "<StudySiteNumber E1>" in Study Sites pane
	And I take a screenshot
	And I navigate to User Adminstration page
	And I search for User name "<iMedidata User 1 ID>" with Authenticator "iMedidata"
	And I navigate to User Details page for user name "<iMedidata User 1 ID>"
	And I should see Authenticator "iMedidata"
	And I should see Study "<Study E>" listed in Studies pane
	And I take a screenshot
   

@Rave 2013.2.0
@PB2.5.9.29-01
@Validation
Scenario: If the user has access to study and site in Rave that is linked with the study and site on iMedidata and
 if the user is unassigned to the site for the study on iMedidata then that site will not be accessible for the user in Rave. 

    Given I am an iMedidata User
    And I am logged in to iMedidata
    And my Username is "<iMedidata User 1 ID>" in iMedidata
    And there is a Rave User named "<Rave User Name 1>"
    And there is an iMedidata Study named "<Study A>"
    And the iMedidata Study named "<Study A>" has Site "<Site A1>"  with Site Number "<SiteNumber A1>"
	And there is a Rave Study named "<Study A>"
	And there is a Rave Site named "<Site A1>"  with Site Number "<SiteNumber A1>" for Study "<Study A>"
    And the iMedidata Study named "<Study A>" is connected to the Rave Study named "<Study A>"
    And I have an assignment to the iMedidata Study named "<Study A>" for the App named "<EDC App>" and Role "<EDC Role 1>" "<Modules App>" with  Role "<Modules Role 1>"
    And I have an assignment to the iMedidata site named "<Site A1>" for the iMedidata study named "<Study A>"
	And I follow app named "<EDC App>" for "<Study A>"
	And I see "<Site A1>" home page in Rave for Study "<Study A>"
	And I take a screenshot
	And I follow iMedidata link
	And I am on iMedidata home page
    And my assignment to the iMedidata site named "<Site A1>" for the iMedidata study named "<Study A>" is removed (set as None)
	And I take a screenshot
	When I follow app named "<EDC App>" for "<Study A>"
    Then I am on Rave Study Home Page for "<Study A>"
	And I should see the message "No Sites Found"
	And I take a screenshot
	
@Rave 2013.2.0
@PB2.5.9.29-03
@Validation
Scenario: If the user has access to study in Rave that is linked with the study on iMedidata with multiple sites assignment
 and if the user is unassigned to site for the study on iMedidata then that site will not be accessible in Rave.

    Given I am an iMedidata User
    And I am logged in to iMedidata
    And my Username is "<iMedidata User 1 ID>" in iMedidata
    And there is a Rave User named "<iMedidata User 1 ID>"
    And the Rave User named "<iMedidata User 1 ID>" has a User Group of "iMedidata EDC"
    And there is an iMedidata Study named "<Study C>"
    And the iMedidata Study named"<Study C>" has Sites "<Site C1>" "<Site C2>" "<Site C3>"
	And there is a Rave Study named "<Study C>"
    And the iMedidata Study named "<Study C>" is connected to the Rave Study named "<Study C>"
    And I have an assignment to the iMedidata Study named "<Study C>" for the App named "<EDC App>" and the Role "<EDC Role 1>"
    And I have an assignment to the iMedidata site named "<Site C1>" site named "<Site C2>" site named "<Site C3>" for the iMedidata study named "<Study C>"
	And I accept the invitations
	And I follow app named "<EDC App>" for "<Study C>"
	And I am on Study "<Study C>" Home page 
	And I see "<Site C1>" "<Site C2>" "<Site C3>" on the Study Home page
	And I take a screenshot
    And I follow iMedidata link
	And I am on iMedidata home page
	And my assignment to the iMedidata site named "<Site C1>" for the iMedidata study named "<Study C>" is removed (set as None)
	And I take a screenshot
    When I follow the app named "<EDC App>" for "<Study C>"
    Then I am on the Rave Home Page for Study "<Study C>"
    And I should see "<Site C2>"
    And I should see "<Site C3>"
    And I should not see "<Site C1>"
	And I take a screenshot

@Rave 2013.2.0
@PB2.5.9.34-01
@Validation
Scenario: If the user has access to study in iMedidata that is linked with a study on Rave. When a new site is created for a study on iMedidata,
          then the site will appear for that study on Rave.

    Given I am an iMedidata User
    And I am logged in to iMedidata
    And my Username is "<iMedidata User 1 ID>" in iMedidata
  	And there is a Rave Study named "<Study D>"
    And there is an iMedidata Study named "<Study D>"
    And the iMedidata Study named "<Study D>" is connected to the Rave Study named "<Study D>"
    And I have an assignment to the iMedidata Study named "<Study D>" for the App named "<EDC App>" and the Role "<EDC Role 1>"
    And I have an assignment to the iMedidata Study named "<Study D>" for the App named "<Modules App>" and the Role "<Modules Role 1>"
	And I accept the "<Study D>" invitations as Study Owner
	And I navigate to Sites on Manage Study page for Study "<Study D>"
    And I follow "Create New Sites"
    And I save the following:
	|Name		| Site Number				|Study-Site Number				|Notes			|
	|<Site D1>	|  "<SiteNumber D1>"		|<StudySiteNumber D1>			|<Note1>		|
	And I take a screenshot
	And I follow Assign Sites for "<iMedidata User 1 ID>"
	And I assign the Site "<Site D1>" 
	And I take a screenshot
	And I navigate to iMedidata home page
	And I follow App named "<EDC App>" for Study "<Study D>"
    And I am on Rave Site "<Site D1>" page for Study "<Study D>"
	And I take a screenshot
	When I navigate  in Site Adminstration
	And navigate to Site Details page for Site "<Site D1>"
    Then I should see the SiteName "<Site D1>"
	And I should see SiteNumber is "<SiteNumber D1>" 
    And I should see Source is "iMedidata"
	And I should see Study Site Number "<StudySiteNumber D1>" in Study Sites pane
	And I take a screenshot
	

@Rave 2013.2.0
@PB2.5.9.35-01
@Validation
Scenario: If an externally authenticated user does not have access to a particular site in Rave, but has been
           invited to a Role in Rave that permits them access to all sites, that user will see the sites in
		   Rave in accordance with these Role settings, regardless of the site access set in iMedidata.

    Given I am an iMedidata User
    And I am logged in to iMedidata
    And there is an iMedidata Study named "<Study C>"
	And the iMedidata Study named"<Study C>" has Sites "<Site C1>" "<Site C2>" "<Site C3>"
    And there is a Rave Study named "<Study C>"
	And the Rave Study named "<Study C>" has Sites "<Site C1>" "<Site C2>" "<Site C3>"
    And the iMedidata Study named "<Study C>" is connected to the Rave Study named "<Study C>"
    And I have an assignment to the iMedidata Study named "<Study C>" for the App named "<EDC App>" and the Role "<EDC Role 1>"
    And I have an assignment to the iMedidata site named "<Site C1>" for the iMedidata study named "<Study C>"
	And I accept the invitations
	And I follow "<EDC App>" for "<Study C>"
	And I see Rave Home page for "<Site C1>"
	And I take a screenshot
	And I follow Home Icon
	And I should not see site "<Site C2>" and site "<Site C3>"
	And I take a screenshot
	And I follow iMedidata link
	And I have change Role assignment to the iMedidata Study named "<Study C>" for the App named "<EDC App>"  Role "<EDC Role 4>" that allows to see all sites
	And I take a screenshot
	When I follow "<EDC App>" for "<Study C>"
	Then I should be on Rave Study Home page for "<Study C>"
	And I should see site "<Site C1>" 
	And I should see site "<Site C2>"
	And I should see site "<Site C3>"
	And I take a screenshot

@Rave 2013.2.0
@PB2.5.9.35-03
@Validation
Scenario: If an externally authenticated user does not have access to a particular site in Rave, but has been invited
          to a Role in Rave that permits them access to a set of sites, that user will see the sites in Rave in accordance
		  with these Role settings, regardless of the site access set in iMedidata.


    Given I am an iMedidata User
    And I am logged in to iMedidata
	And there is a Rave Study named "<Study C>"
	And there is Site Group "Asia" existing in Rave
	And the Rave Study named "<Study C>" has Sites "<Site C1>" "<Site C2>" "<Site C3>"
	And Rave site "<Site C3>" is assigned to Site Group "<Site Group A>"
	And Rave sites "<Site C1>" and "<Site C2>" are assigned to Site Group "World"
	And there is a iMedidata user with username "<iMedidata User 1 ID>" in iMedidata
    And iMedidata user with username "<iMedidata User 1 ID>" linked to Rave
    And there is an iMedidata Study named "<Study C>"
	And the iMedidata Study named "<Study C>" is connected to the Rave Study named "<Study C>"
	And the iMedidata Study named"<Study C>" has Sites "<Site C1>" "<Site C2>" "<Site C3>"
	And Sites "<Site C1>" "<Site C2>" country associated with is "United States of America"
	And Site "<Site C3>" country associated with is "India"
    And I have an assignment to the iMedidata Study named "<Study C>" for the App named "<EdcApp>" and the Role "<EDC Role 1>" 
    And I have an assignment to the iMedidata site named "<Site C1>" "<Site C2>" "<Site C3>" for the iMedidata study named "<Study C>"
	And I accept the invitations as Study Owner and as Site Owner
	And I follow "<Edc App>" for "<Study C>"
	And I enter password and link to Rave account
	And I see Rave Home page for Study "<Study C>"
	And I should see Sites "<Site C1>" "<Site C2>" "<Site C3>"
	And I take a screenshot
	And I navigate to "User Administration" Module
	And my Site Group assignment in Rave is changed to "<Asia >"
	And I take a screenshot
	When I navigate back to iMedidata
	And I follow "<EDC App>" for "<Study C>"
	Then I should be on Site "<Site C3>" home page for Study "<Study A>"
	And I should not see site "<Site C1>" 
	And I should not see site "<Site C2>"
	And I take a screenshot

@Rave 2013.2.0
@PB2.5.9.35-02
@Validation
Scenario: If an internally authenticated user does not have access to a particular site in Rave, but has been invited
          to a Role in Rave that permits them access to all sites or a set of sites, that user will see the sites
		  in Rave in accordance with these Role settings.

    Given I am an Rave User
	And my Rave Username is "<iMedidata User 1 ID>"
	And my Rave User email address is "iMedidata User 1 Email>"
    And there is a iMedidata user with username "<iMedidata User 1 ID>"
    And there is a Rave Study named "<Study C>" 
    And there is an iMedidata Study named "<Study C>"
	And the iMedidata Study named"<Study C>" has Sites "<Site C1>" "<Site C2>" "<Site C3>"
    And the Rave Study named"<Study C>" has Sites "<Site C1>" "<Site C2>" "<Site C3>"
	And I do not have permission to view the Rave Site "<Site C1>"
    And the iMedidata Study named "<Study C>" is connected to the Rave Study named "<Study C>"
	And I have an assignment to the Study "<Study C>" with Role "<EDC Role 1>" in Rave
	And I accept the invitations as Study Owner
    And I follow "<Edc App>" for "<Study C>"
	And I enter password and link to the Rave account
	And I am on Study Home page
	And I should see "<Site C2>" "<Site C3>" in Rave
	And I should not see "<Site C1>"
	And I take a screenshot
	And follow iMedidata link
	And I my Role is updated to "<EDC Role 4>" for Study "<Study C>" that allows to see all sites
	When I follow "<Edc App>" for "<Study C>"
	Then I should see Sites "<Site C1>" "<Site C2>" "<Site C3>"
     And I take a Screenshot


    

