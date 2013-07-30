# A new User Group will be created in Rave called ‘iMedidata EDC’.
# Users invited to the Rave EDC Application will automatically be in the ‘iMedidata EDC’ User Group. During invitation to Rave EDC a Rave EDC Role must be selected on iMedidata. Users that enter data will usually be invited to Rave EDC on iMedidata.
# The Rave Modules application allows a user group other than the iMedidata EDC User group to be assigned. During invitation to Rave Modules a Rave User Group must be selected. 
# The Rave Architect Security application allows a security group to be assigned. During invitation to Rave Architect Security a Rave Security Group  must be selected. 

Feature: Study Assignments
    In order to use Rave Studies
    As a User
    I want to be able to be assigned to a Rave study by iMedidata


Given I am an iMedidata user "<User>" with pin "<PIN>" password "<Password>" and user id "<User ID>"
		|User						|PIN						| Password							|User ID						|Email 							|
		|{iMedidata User 1}			|iMedidata User 1 PIN}		|{iMedidata User 1 Password}		|{iMedidata User 1 ID}			|{iMedidata User 1 Email}		|
		|{iMedidata User 2}			|iMedidata User 2 PIN}		|{iMedidata User 2 Password}		|{iMedidata User 2 ID}			|{iMedidata User 2 Email}		|
		|{Admin User }			|Admin User PIN}		|{Admin User  Password}		|{Admin User  ID}			|{Admin User Email}		|
	And there exists a Rave user "<Rave User>" with username "<Rave User Name>" and password "<Rave Password>"
		|Rave User		|Rave User Name		|Rave Password		|
		|{Rave User 1}	|{Rave User Name 1}	|{Rave Password 1}	|
	    |{Rave User 2}	|{Rave User Name 2}	|{Rave Password 2}	|
	And there exists study "<Study>" in study group "<Study Group>"
		|Study		|Study Group 	|Is Production 
		|{Study A}	|{Study Group} 	| Check
		|{Study B}	|{Study Group} 	| Check
		|{Study C}	|{Study Group} 	| Check
	And there exists Rave study "<Rave Study>" 
		|{Rave Study A}	|			
    And there exists User Group "<All Modules>" , "<iMedidata EDC>" "<Security Group>"
	And there exists app "<App>" associated with study in iMedidata
		|App			|
		|{EDC App}		|
		|{Modules App}	|
		|{Security App}	|
	And there exists site "<Site>" in study "<Study>", 	in iMedidata	
		|Study		|Site		|
		|{Study A}	|{Site A1}	|
	And there exists role "<Role>" in app "<App>", 		
		|App			|Role												| Permissions
		|{EDC App}		|{EDC Role 1}										|                                |
		|{EDC App}		|{EDC Role 2}										|View all Sites in a study group |
		|{EDC App}		|{EDC Role 3}										|                                |
		|{EDC App}		|{EDC Role CRA}                                  	|create sub cannot view all sites|
		|{EDC App}		|{EDC Role RM Monitor}								|                                |
		|{Modules App}	|{Modules Role 1}									|                                |
		|{Modules App}	|{Modules Role 2 No Reports}						|                                |
		|{Modules App}	|{Modules Role 3 No Sites}							|                                |
		|{Modules App}	|{Modules Role 4  }						         	|    User Adminstration          |
		|{Security App}	|{Security Role 1}									|	                             |	
	And there exist "<Rave URL>" with "<URL Name>"
		|Rave URL		|URL Name							|
		|{Rave URL 1}	|{rave564conlabtesting1.mdsol.com	|
	
@Rave 2013.2.0
@PB2.5.8.28-10
@Validation
Scenario: If an iMedidata user has a study assignment removed in iMedidata, that study assignment is removed in Rave.


    Given I am an iMedidata User
    And I am logged in
    And my Username is "<iMedidata User 1 ID>" in iMedidata
    And I am connected to the Rave 
    And there is an iMedidata Study Group named "<Study Group>"
    And there is an iMedidata Study named "<Study A>" "<Study B>" "<Study C>"in the Study Group named "<Study Group>"
    And the iMedidata Study named "<Study A>" is linked to Rave Study named "<Study A>"
	And the iMedidata Study named "<Study B>" is linked to Rave Study named "<Study B>"
	And the iMedidata Study named "<Study C>" is linked to Rave Study named "<Study C>"
	And I have an assignment to the iMedidata Study named "<Study A>" for the App named "<EDC App>" the Role "<EDC Role 1>" Role "<EDC Role 2>" Role "<EDC Role 3>" App named "<Modules App>" Role "<Modules Role 1>"or app "<Security App>" with Role "<Security Group 1>"
	And I have an assignment to the iMedidata Study named "<Study B>" for the App named "<EDC App>" the Role "<EDC Role 1>" Role "<EDC Role 2>" Role "<EDC Role 3>" App named "<Modules App>" Role "<Modules Role 1>"or app "<Security App>" with Role "<Security Group 1>"
	And I have an assignment to the iMedidata Study named "<Study C>" for the App named "<EDC App>" the Role "<EDC Role 1>" Role "<EDC Role 2>" Role "<EDC Role 3>" App named "<Modules App>" Role "<Modules Role 1>"or app "<Security App>" with Role "<Security Group 1>"
	And I accept the invitations
	And I am on the iMedidata Home page
    And I click the App named "<EDC App>" associated with study "<Study A>"
	And I select "<EDC Role 1>"
	And I am on Study "<Study A>" Home page
	And I take a screenshot
	And I navigate to Rave Home page
	And I should see "<Study A>" "<Study B>" "<Study C>" in Home Page
    And I take a screenshot
	And I select link "User Administration"
	And I search for user "<iMedidata User 1 ID>" with iMedidata as "Authenticator"	
	And I see three rows in the search results table
	And I take a screenshot
	And I navigate to user details page for "<EDC Role 1>"
	And I should see "<Study A>" "<Study B>" "<Study C>" listed in the Studies Pane		
	And I should see User Group Role "<Modules Role 1>"
	And I should see "<Security App>" with Role "<Security Group 1>" in  "Other Modules" section of the User
	And I take a screenshot
	And I select the "Go Back" link
	And I navigate to user details page for "<EDC Role 2>"
	And I should see "<Study A>" "<Study B>" "<Study C>" listed in the Studies Pane
	And I should see User Group Role "<Modules Role 1>"
	And I should see "<Security App>" with Role "<Security Group 1>" in  "Other Modules" section of the User
	And I take a screenshot
	And I select the "Go Back" link
	And I navigate to user details page for "<EDC Role 3>"
	And I should see "<Study A>" "<Study B>" "<Study C>" listed in the Studies Pane
	And I should see User Group Role "<Modules Role 1>"
	And I should see "<Security App>" with Role "<Security Group 1>" in  "Other Modules" section of the User
	And I take a screenshot	
	And I click on iMedidata Link to navigate back to iMedidata
    And I am on iMedidata Home page
	And my assignment to "<Study A>" is removed in iMedidata
	And I take a screenshot
	And I should not see "<Study A>" listed in Studies pane in iMedidata
	And I should see "<Study B>" "<Study C>" listed in Studies pane in iMedidata
	And I take a screenshot	
	When I navigate to Rave by following "<EDC App>" for "<Study B>"
	And I select "<EDC Role 1>"
	And I click "Continue"
	And I am on Study "<Study B>" Home page 
	And I navigate to Rave Home page
	Then I should not see "<Study A>" listed in Home page
	And I should see "<Study B>" "<Study C>" 
	And I take a screenshot	
	And I select link "User Administration"
	And I search for user "<iMedidata User 1 ID>" with iMedidata as "Authenticator"	
	And I see three rows in the search results table
	And I take a screenshot
	And I navigate to user details page for "<EDC Role 1>"
	And I should not see "<Study A>" listed in the Studies pane for User name "<iMedidata User 1 ID>"
	And I should see "<Study B>" "<Study C>" listed in the Studies Pane	
	And I should see User Group Role "<Modules Role 1>"	
	And I should see "<Security App>" with Role "<Security Group 1>" in  "Other Modules" section of the User	
	And I take a screenshot
	And I select the "Go Back" link
	And I navigate to user details page for "<EDC Role 2>"
	And I should not see "<Study A>" listed in the Studies pane for User name "<iMedidata User 1 ID>"
	And I should see "<Study B>" "<Study C>" listed in the Studies Pane	
	And I should see User Group Role "<Modules Role 1>"	
	And I should see "<Security App>" with Role "<Security Group 1>" in  "Other Modules" section of the User	
	And I take a screenshot
	And I select the "Go Back" link
	And I navigate to user details page for "<EDC Role 3>"
	And I should not see "<Study A>" listed in the Studies pane for User name "<iMedidata User 1 ID>"
	And I should see "<Study B>" "<Study C>" listed in the Studies Pane	
	And I should see User Group Role "<Modules Role 1>"	
	And I should see "<Security App>" with Role "<Security Group 1>" in  "Other Modules" section of the User	
	And I take a screenshot
	



	
@Rave 564 Patch 13
@PB2.5.8.28-11
@Validation
Scenario: If an iMedidata user has a  new study assignment added in iMedidata, that study assignment appears in Rave.

    Given I am an iMedidata User
    And I am connected to the Rave
	And there are a Rave Studies named "<Study A>" "<Study B>" "<Study C>"
	And I am logged in into iMedidata
    And my Username is "<iMedidata User 1 ID>" in iMedidata
	And iMedidata user "<iMedidata User 1 ID>" is not an owner of Study Group "<Study Group>"
    And there is an iMedidata Study Group named "<Study Group>"
    And there are an iMedidata Studies named "<Study A>" "<Study B>" "<Study C>"in the Study Group named "<Study Group>"
    And the iMedidata Study named "<Study A>" is linked to Rave Study named "<Study A>"
	And the iMedidata Study named "<Study B>" is linked to Rave Study named "<Study B>"
	And I have an assignment to the iMedidata Study named "<Study A>" for the App named "<EDC App>" the Role "<EDC Role 1>" App named "<Modules App>" Role "<Modules Role 1>"
	And I have an assignment to the iMedidata Study named "<Study B>" for the App name "<EDC App>" Role "<EDC Role 1>" App named "<Modules App>" Role "<Modules Role 1>"
	And I accept the invitations for "<Study A>" and "<Study B>"
	And I am on the iMedidata Home page
    And I click the App named "<EDC App>" associated with study "<Study A>"
	And I should be on Study "<Study A>" Home page
	And I navigate to Rave Home page
	And I should see "<Study A>" "<Study B>" in Rave
	And I take a screenshot
    And I click on iMedidata Link to navigate back to iMedidata
    And I am on iMedidata Home page
	And have an invitation to "<Study C>" for App "<EDC App>" role "<EDC role 1>  App "<Modules App>" with Role "<Modules Role 1>" in iMedidata
	And I take a screenshot
	And I accept the invitation
	When I follow "<EDC App>" for Study "<Study C>"
	Then I should be on Study "<Study C>" Home page
	And I take a screenshot
	And I navigate to Rave Home page
	And I should see "<Study A>" "<Study B>" "<Study C>" listed in Rave Home page
	And I take a screenshot
	And I navigate to the User Administration module
	And I search the user "<iMedidata User 1 ID>" 
	And I navigate to the user details page for user "<iMedidata User 1 ID>" 
	And I should see "<Study A>" "<Study B>" "<Study C>" listed in "Studies" pane 
	And I should see Role "<Edc Role 1>" listed for all studies
	And I take a screenshot
	
@Rave 564 Patch 13
@PB2.5.1.24-02
@Validation
Scenario: If the user is an iMedidata user, when the user that has only one EDC Role subsequently accesses a specific Study in Rave from iMedidata,
           and that user has at least one site assignment for that study in Rave, then Rave will direct the user to that Site page on Rave.

    Given I am an iMedidata User
    And I am logged in
    And my Username is "<iMedidata User 1 ID>" in iMedidata
    And I am connected to the Rave User named "<iMedidata User 1 ID>"
	And there is an iMedidata Study Group named "<Study Group>"
    And there is an iMedidata Study named "<Study A>" in the Study Group "<Study Group>"
    And the iMedidata Study named "<Study A>" has Site "<Site A>" assigned to it
    And I have an assignment to the iMedidata Study named "<Study A>" for the App named "<EDC App>" the Role "<EDC Role 1>" 
	And I have been invited to the Site "<Site A>" for Study "<Study A>"
	And I take a Screenshot
	And I accept the invitation to the Study "<Study A>"
	And I accept the invitation to the Site "<Site A>"
	When I follow app "<EDC App>" for Study "<Study A>"
	Then I should be on Site "<Site A>" page in Rave for Study "<Study A>"
	And I take a Screenshot

@Rave 564 Patch 13
@PB2.5.1.24-03
@Validation
Scenario: If the user is an iMedidata user, when the user that has only one EDC Role subsequently accesses the Rave EDC App for a Study in iMedidata,
                 then Rave will direct the user to the Rave Study Homepage.

    Given I am an iMedidata User
    And I am logged in
    And my Username is "<iMedidata User 1 ID>" in iMedidata
    And I am connected to the Rave User named "<iMedidata User 1 ID>"
    And there is an iMedidata Study Group named "<Study Group>"
    And there is an iMedidata Study named "<Study A>" in the Study Group named "<Study Group>"
    And I have an assignment to the iMedidata Study named "<Study A>" for the App named "<EDC App>"  Role "<EDC Role 1>" 
	And I take a Screenshot
	And I accept the invitation to the "<Study A>"
	When I follow "<EDC App>" for Study "<Study A>"
	Then I should see "<Study A>" study Home page in Rave
    And I take a Screenshot
	
@Rave 2013.2.0
@PB2.5.1.24-05
@Validation
Scenario: If the user is an iMedidata user, when the user that has only one EDC Role and has an assignment to a Study Group with Multiple Studies in 
           iMedidata,and access the study group then Rave will direct the user to the Rave Studies Homepage.

    Given I am an iMedidata User
    And I am logged in
    And my Username is "<iMedidata User 1 ID>" in iMedidata
    And I am connected to the Rave User named "<iMedidata User 1 ID>"
    And there is an iMedidata Study Group named "<Study Group>"
    And there is an iMedidata Study named "<Study A>" "<Study B>" "<Study C>" in the Study Group named "<Study Group>"
	And I have an assignment to the iMedidata Study Group named "<Study Group>" for the App named "<EDC App>" Role "<EDC Role 1>" 
    And I have an assignment to the iMedidata Study named "<Study A>" for the App named "<EDC App>" Role "<EDC Role 1>" 
	And I have an assignment to the iMedidata Study named "<Study B>" for the App named "<EDC App>" Role "<EDC Role 1>"
	And I have an assignment to the iMedidata Study named "<Study C>" for the App named "<EDC App>" Role "<EDC Role 1>"
	And I accept the invitation to the Studies
	And I take a Screenshot
	When I follow Apps link named "<Study Group>"
	Then I should be on Rave Home page
	And I should see "<Study A>" "<Study B>" "<Study C>"
    And I take a Screenshot

@Rave 564 Patch 13
@PB2.7.5.5-01
@Validation
Scenario: If a user is only assigned to ‘Rave EDC’ application on iMedidata, then the user will be assigned to ‘iMedidata EDC’ User Group on Rave by default.

    Given I am an iMedidata User
    And I am logged in
    And my Username is "<iMedidata User 1 ID>" in iMedidata
    And I am connected to the Rave User named "<iMedidata User 1 ID>" 
    And there is an iMedidata Study Group named "<Study Group>"
    And there is an iMedidata Study named "<Study A>" in the Study Group named "<Study Group>"
	And there is a Rave Study named "<Study A>"
    And the iMedidata Study named "<Study A>" is linked to the Rave Study named "<Study A>"
    And I have an assignment to the iMedidata Study named "<Study A>" for the App named "<EDC App>" the Role "<EDC Role 1>" 
	And I accept the invotation
    And I am on iMedidata Home page
	And I see only "<Study A>" with "<EDC App>" listed in "Studies" Pane
	And I take a Screenshot
	And I follow App "<EDC App>" for Study "<Study A>"
	And I linked to the rave account
	And I am on Rave Study "<Study A>" Home page
	And I follow Home Link on Rave
	And I should be on Study "<Study A>" home page
	And I should not see All Modules 
	And I take a Screenshot
	And I log out
	And I login as "<Rave User Name 1>" in to Rave with access to User Adminstration Module
	And I navigate to User Adminstration
	When I search for user "<iMedidata User 1 ID>" with Authenticator "iMedidata"
	Then I should see User Group "iMedidata EDC" for Log In "<iMedidata User 1 ID>"
	And I take a Screenshot
	And I navigate to User Details for User "<iMedidata User 1 ID>"
	And I see User Group is "iMedidata EDC"
	And I take a Screenshot

@Rave 564 Patch 13
@PB2.7.5.6-01
@Validation
Scenario: If a user is assigned to ‘Rave EDC’ and ‘Rave Modules’ applications on iMedidata, then the User Group 
           associated with ‘Rave Modules’ will be assigned to the user on Rave when the user accesses either ‘Rave EDC’ or ‘Rave Modules’.
		   Example: The User Group will be ‘Reporter’ for a user that clicks on Rave EDC or Rave Modules on iMedidata if the User Group was
		   selected as ‘Reporter’ during the invitation to Rave Modules.

    Given I am an iMedidata User
    And I am logged in
    And my Username is "<iMedidata User 1 ID>" in iMedidata
    And I am connected to the Rave User named "<iMedidata User 1 ID>"
	And there is an iMedidata Study Group named "<Study Group>"
    And there is an iMedidata Study named "<Study A>" in the Study Group named "<Study Group>"
	And there is a Rave Study named "<Study A>"
    And the iMedidata Study named "<Study A>" is linked to the Rave Study named "<Study A>"
	And I am the Study owner of Study "<Study A>"
    And I have an assignment to the iMedidata Study named "<Study A>" for the App named "<EDC App>" the Role "<EDC Role 1>" 
	And I have an assignment to the iMedidata Study named "<Study A>" for the App named "<Modules App>" the Role "<Modules Role 1>"
	And I accept the invitation to the study "<Study A>"
    And I follow "<EDC App>" for "<Study A>"
	And I linked to the Rave account
	And I should be on Study "<Study A>" home page
	And I navigate to Rave Home Page
	And I should see All Modules listed
	And I take a Screenshot
	And I navigate to User Adminstation in Rave
	When I search for User "<iMedidata User 1 ID>" Authenticator "iMedidata"
	Then I should see "<iMedidata User 1 ID>" is assigned to UserGroup "<All Modules>"
	And I take a Screenshot
	And I navigate to User Details page for User "<iMedidata User 1 ID>"
	And I should see "<All Modules>" assigned to the User 
	And I take a screenshot

@Rave 2013.2.0
@PB2.7.5.12-01
@Validation
@BUG
Scenario: Rave user groups are assigned in iMedidata by selecting the "Rave Modules" App and a corresponding Module Role for that app.
      In iMedidata a user can have different assignments to the 'Rave Modules' application for different studies.
      Rave does not acknowledge multiple user group assignments for a single user. When a user has been given multiple assignments
	  to the Rave Modules application in iMedidata, the user will only have access to the first Rave Modules assignment.  They will see a warning once they have accessed Rave.

	Given I am an iMedidata User
    And I am logged in
    And my Username is "<iMedidata User 1 ID>" in iMedidata
	And there is an iMedidata Study Group named "<Study Group>"
    And there is an iMedidata Study named "<Study A>" "<Study B>" "<Study C>" in the Study Group named "<Study Group>"
    And I have an assignment to the iMedidata Study named "<Study A>" for the App named "<Modules App>"  Role "<Modules Role 1>" 
	And I take a screenshot
    And I have an assignment to the iMedidata Study named "<Study B>" for the App named "<Modules App>"  Role "<Modules Role 2 No Reports>"
	And I take a screenshot
	And I have an assignment to the iMedidata Study named "<Study C>" for the App named "<Modules App>"  Role "<Modules Role 3 No Sites>"
	And I take a screenshot
	When I follow "<Modules App>" for Study "<Study A>" 
	Then I am on Rave Home page
	And I see the message "You have 3 "Rave Modules" invitations in iMedidata."
	And I take a screenshot
	And I select link iMedidata
	And I am on iMedidata Home page
	And I follow "<Modules App>" for Study "<Study B>" 
	And I am on Rave Home page
	And I see the message "You have 3 "Rave Modules" invitations in iMedidata."
	And I take a screenshot
	And I select link iMedidata
	And I am on iMedidata Home page
	And I follow "<Modules App>" for Study "<Study C>" 
	And I am on Rave Home page
	And I see the message "You have 3 "Rave Modules" invitations in iMedidata."
	And I take a screenshot


@Rave 2013.2.0
@PB2.7.5.12-02 NO GO
@Validation
Scenario: If a user has assignments to the ‘Rave Modules’ and "EDC" application for a study and EDC Application only to a another study,
         then the user will be provided access to the 'Rave Modules' Role.
		
	Given I am an iMedidata User
    And I am logged in
    And my Username is "<iMedidata User 1 ID>" in iMedidata
	And there is an iMedidata Study Group named "<Study Group>"
    And there is an iMedidata Study named "<Study A>" "<Study B>" in the Study Group named "<Study Group>"
    And I have an assignment to the iMedidata Study named "<Study A>" for the App named "<Modules App>"  Role "<Modules Role 1>" for app "<EDC App>" with Role "<EDC Role 1>" 
    And I take a screenshot
	And I have an assignment to the iMedidata Study named "<Study B>" for the App named "<EDC App>"  Role "<EDC Role 1>"
	And I take a screenshot
	And I accept the invitations
	When I follow "<EDC App>" for Study "<Study A>" 
	Then I am on Rave Home page
	And I do not see the message "You have 2 "Rave Modules" invitations in iMedidata."
	And I take a screenshot
	And I select link iMedidata
	And I am on iMedidata Home page
	And I follow "<EDC App>" for Study "<Study B>" 
	And I am on Rave Home page
	And I do not see the message "You have 2 "Rave Modules" invitations in iMedidata."
	And I take a screenshot
	And I navigate to User Administration Module
	And I search for the iMedidata user "<iMedidata User 1 ID>"
	And I navigate to User Detailes page
	And I should see the User Group Role "<Modules Role 1>" assigned to <Study B>
	And I do not see User Group Role <iMedidata EDC> assigned to <Study B>
	And I take a screenshot
	



@Rave 2013.2.0
MCC-58380-1
Scenario:  If a user has been assigned two Module Roles assignments for two different studies, they will only see the first assignment in Rave.
            If the first assignment is then removed, they will see the second assignment in Rave.

Given I am an iMedidata User
    And I am logged in
    And my Username is "<iMedidata User 1 ID>" in iMedidata
	And there is an iMedidata Study Group named "<Study Group>"
    And there is an iMedidata Study named "<Study A>" "<Study B>" in the Study Group named "<Study Group>"
    And I have an assignment to the iMedidata Study named "<Study A>" for the App named "<Modules App>"  Role "<Modules Role 1>" 
	And I take a screenshot
    And I have an assignment to the iMedidata Study named "<Study B>" for the App named "<Modules App>"  Role "<Modules Role 2 No Reports>"
	And I take a screenshot
    And  I follow "<Modules App>" for Study "<Study A>" 
	And I am on Rave Home page
	And I see the message "You have 2 "Rave Modules" invitations in iMedidata."
	And I take a screenshot
	And I navigate to User Administration Module
	And I search for the iMedidata user "<iMedidata User 1 ID>"
	And I navigate to User Detailes page
	And I should see the User Group Role "<Modules Role 1>" assigned to <Study A>
	And I take a screenshot
	And I return back to iMedidata
	And I follow "<Modules App>" for Study "<Study B>" 
	And I am on Rave Home page
	And I see the message "You have 2 "Rave Modules" invitations in iMedidata."
	And I take a screenshot
	And I navigate to User Administration Module
	And I search for the iMedidata user "<iMedidata User 1 ID>"
	And I navigate to User Detailes page
	And I should see the User Group Role "<Modules Role 1>" assigned to <Study B>
	And I take a screenshot
	And I remove the assignment to the iMedidata Study named "<Study A>" for the App named "<Modules App>"  Role "<Modules Role 1>" 
	And I take a screenshot
	And I Logout from iMedidata
	When I login into iMedidata as "<iMedidata User 1 ID>" user
	Then I should see only "<Study B>" assigned to  "<iMedidata User 1 ID>" user
	And I follow "<Modules App>" for Study "<Study B>" 
	And I am on Rave Home page
	And I do not see the message "You have 2 "Rave Modules" invitations in iMedidata."
	And I take a screenshot 
	And I navigate to User Administration Module
	And I search for the iMedidata user "<iMedidata User 1 ID>"
	And I navigate to User Detailes page
	And I should see the User Group Role "<Modules Role 2 No Reports>" assigned to <Study B>
	And I take a screenshot



@Rave 564 Patch 13
@PB2.7.5.12-03
@Validation
Scenario: If the user accepts invitation to study with an EDC and/or Modules Application, and tries to go to Rave and if the message for the study assignment is not processed yet then the user will see message "User has no Role for the Study".	
   
    Given I am an iMedidata User
    And I am logged in
    And my Username is "<iMedidata User 1 ID>" in iMedidata
	And there is an iMedidata Study Group named "<Study Group>"
    And there is an iMedidata Study named "<Study A>" "<Study B>" in the Study Group named "<Study Group>"
    And I have an invitation to the iMedidata Study named  "<Study A>" for the App named "<Modules App>"  Role "<Modules Role 1>" for app "<EDC App>" with Role "<EDC Role 1>" 
	And I accept the Invitation
	When I follow "<EDC App>" for Study "<Study A>"
	And the Study Assignment  message is not processed yet 
	Then I should see an Error message "User has no Role for the Study"
	And I take Screenshot
	And I should not be on Rave Study "<Study A>" homepage


@Rave 564 Patch 13
@PB2.7.5.12-04
@Validation
Scenario: If the user accepts invitation to study with all three applications for a Study and has Modules Only assignment to Another Study, and tries to go to Rave with the Study that has modules only assignment then the user will see message "User has no Role for the Study".	
   
    Given I am an iMedidata User
    And I am logged in
    And my Username is "<iMedidata User 1 ID>" in iMedidata
	And there is an iMedidata Study Group named "<Study Group>"
    And there is an iMedidata Study named "<Study A>" "<Study B>" in the Study Group named "<Study Group>"
    And I have an assignment to the iMedidata Study named "<Study A>" for the App named "<Modules App>"  Role "<Modules Role 1>" for app "<EDC App>" with Role "<EDC Role 1>" for App "<Architect Security>" with Role "<Security Group 1>"
	And I have an assignment to the iMedidata Study named "<Study B>" for the App named "<Modules App>"  Role "<Modules Role 1>" 
	And I accept the invitation
    When I follow "<modules App>" for "<Study B>"
	Then I should see an Error message "User has no Role for the Study"
	And I take Screenshot
	And I navigate back to iMedidata
	And I follow the "<EDC App>" for Study "<Study A>"
	And I should be on "<Study A>" page in Rave
	And I take a screenshot


@Rave 564 Patch 13
@PB2.5.8.28-02 
@Validation
Scenario: If an iMedidata user with one EDC Role1 in a study linked to Rave and has that role changed to Role2, when they access Rave after the role change,
          they will see that they do not have Role1, but Role2.

    Given I am an iMedidata User
    And I am logged in
    And my Username is "<iMedidata User 1 ID>" in iMedidata
    And I am connected to the Rave User named "<Rave User 1>"
    And there is an iMedidata Study Group named "<Study Group>"
	And I am the owner of the iMedidata Study Group "<Study Group>"
    And there is an iMedidata Study named "<Study A>" in the Study Group named "<Study Group>"
	And there is a Rave Study named "<Study A>" assigned to Rave User named "<Rave User 1>" with Role "<EDC Role 1>"
    And the iMedidata Study named "<Study A>" is linked to the Rave Study named "<Study A>"
	And I have an invitation to study "<Study A>" for the App named "<EDC App>" with Role "<EDC Role 1>" for App named "<Modules App>" with Role "<Modules Role 1>"
	And accept the invitation to Study "<Study A>"
	And I follow app "<EDC App>" for study "<Study A>"
	And I am on Rave Study Home page
	And I take a screenshot
	And I navigate to User Adminstration 
	And I search for user "<iMedidata User 1 ID>" Authenticator "iMedidata" 
	And I see Role "<EDC Role 1>" assigned to user "<iMedidata User 1 ID>"
	And I take a screenshot
	And I navigate to User Details page for User "<iMedidata User 1 ID>"
	And I see "<EDC Role 1>" assigned to User for Study "<Study A>"
	And I take a screenshot
	And I navigate to iMedidata
	And my role assignment to Study "<Study A>" is changed from "<EDC role 1>" to "<EDC Role 2>"
	And I follow app "<EDC App>" for study "<Study A>"
	And I am on Rave Study Home page
	And I take a screenshot
	And I navigate to User Adminstration
	And I search for user "<iMedidata User 1 ID>" Authenticator "iMedidata" 
	And I see Role "<EDC Role 2>" assigned to user "<iMedidata User 1 ID>"
	And I should not see "<EDC Role 1>" assigned to user "<iMedidata User 1 ID>" in search results
	And I take a screenshot
	When I navigate to User Details page for User "<iMedidata User 1 ID>"
	Then I should see Role "<EDC Role 2>" assigned to user "<iMedidata User 1 ID>" for Study "<Study A>" 
	And I should not see Role "<EDC Role 1>" 
	And I take a Screenshot
	And I navigate back to User Adminstration 
	And I search for User "<iMedidata User 1 ID>" with Authenticator "iMedidata" 
	And I check the "Include Inactive Records"
	And I should see two search results
	And I take a screenshot
	And I should see "<EDC Role 1>" 
	And I navigate to User Details for user "<iMedidata User 1 ID>" with Role "<EDC Role 1>"
	And I should see Active check box is unchecked
	And I take a screenshot

@Rave 564 Patch 13
@PB2.5.8.28-03 
@Validation
Scenario: If an iMedidata user with one EDC role in a linked study receives a Rave Modules assignment to the same study,
          when they access Rave they will see they have access to the Home button, providing them access to All modules.

	Given I am an iMedidata User
    And I am logged in
    And my Username is "<iMedidata User 1 ID>" in iMedidata
    And I am connected to the Rave User 
	And there is an iMedidata Study Group "<Study Group>"
    And there is an iMedidata Study named "<Study A>" in the Study Group "<Study Group>"
    And the iMedidata Study "<Study A>" is linked to the Rave Study "<Study A>"
    And I have an assignment to the iMedidata Study "<Study A>" for the App named "<EDC Roles App>"  Role "<EDC Role 1>" 
	And I take a screenshot
	And I accept the invitation
	And I follow "<EDC Roles App>" for Study "<Study A>" 
	And I should see Rave Study "<Study A>" Home page
	And I follow Home Link
	And I see Rave Study "<Study A>" Home page
	And I do not see Modules listed on left hand side 
	And I take a screenshot
	And I navigate to User Adminstration 
	And I search for User "<iMedidata User 1 ID>" with Authenticator "iMedidata"
	And I see User Group "<iMedidata EDC>" assigned to User "<iMedidata User 1 ID>"
	And I take a screenshot
	And I navigate back to iMedidata 
	And I have new assignment to iMedidata Study named "<Study A>" for the App named "<Modules App>"  Role "<Modules Role 1>" 
	And I follow "<EDC App>" for Study "<Study A>"
	And I see Study "<Study A>" Home page in Rave
	When I follow Home link
	Then I should see All Modules listed on left hand side
	And I take a Screenshot
	And I follow Architect 
	And I am on Architect page
	And I take a screenshot
	And I navigate to User Adminstration 
	And I search for User "<iMedidata User 1 ID>" with Authenticator "iMedidata"
	And I see User Group "<All Modules>" assigned to User "<iMedidata User 1 ID>"
	And I take a screenshot
	
@Rave 564 Patch 13
@PB2.5.8.28-05 
@Validation
Scenario: An iMedidata study owner can invite a new user to an iMedidata study that is linked to a Rave study with a single EDC role. After the user accepts the invitation, Rave creates a user assignment with the EDC role from iMedidata on the Rave project and environment.

    Given I am an iMedidata User
    And I am logged in
    And my Username is "<iMedidata User 1 ID>" in iMedidata
    And I am connected to the Rave User named "<Rave User 1>"
    And there is an iMedidata Study Group named "<Study Group>"
	And there is an Rave Study "<Study A>"
    And there is an iMedidata Study "<Study A>" 
	And the iMedidata Study "<Study A>" is linked to the Rave Study named "<Study A>"
	And I am the owner of the Study "<Study A>"
	And I have an assignment to Study "<Study A>" for App named "<EDC App>" with Role "<EDC Role 1>"
	And I have an assignment to Study "<Study A>" for App named "<Modules App>" with Role "<Modules Role 1>"
	And I invite user name "<iMedidata User 2 ID>" to Study "<Study A>" with access to App "<EDC App>" the Role "<EDC Role 1>" 
	And the User "<iMedidata User 2 ID>" is not connected to Rave
	And I log out 
	And I log in as User "<iMedidata User 2 ID>"
	And I accept the invitation to Study "<Study A>"
	And I log out
	And I log in as "<iMedidata User 1 ID>"
	And I follow "<EDC App>" for Study "<Study A>"
	And I navigate to User Adminstration in Rave
	And I search for User "<iMedidata User 2 ID>" with Authenticator "iMedidata"
	And I see User Account created with Role "<EDC Role 1>"
	And I take a Screenshot
	When I navigate to User Details page for User "<iMedidata User 2 ID>"
	Then I should see Study "<Study A>:Prod" listed in Studies Pane
	And I should see Role "<Edc Role 1>"
	And I take a Screenshot

@Rave 564 Patch 13
@PB2.5.8.28-55 Re Do
@Validation
Scenario: An iMedidata study owner can invite a new user to an iMedidata study that is linked to a Rave study with a single EDC role.
          After the user accepts the invitation, Rave creates a user assignment with the EDC role from iMedidata on the Rave project
		  and environment and links the user account if it is not already linked.

    Given I am an iMedidata User
    And I am logged in
    And my Username is "<iMedidata User 1 ID>" in iMedidata
    And I am connected to the Rave User named "<Rave User 1>"
    And there is an iMedidata Study Group named "<Study Group>"
    And the iMedidata Study named "<Study A>" is linked to the Rave Study named "<Study A>"
	And the iMedidata Study "<Study A>" has Is production checked 
	And I am an owner to the iMedidata Study named "<Study A>" for the App named "<EDC App>" the Role "<EDC Role 1>"
	And I have an assignment to Study "<Study A>" for App named "<Modules App>" for Role "<Modules Role 1>"
	And I am on iMedidata Home page
	And there exists user with user name "<iMedidata User 2 ID>" in Rave
	And I invite user name "<iMedidata User 2 ID>" to Study "<Study A>" with access to App "<EDC App>" the Role "<EDC Role 1>" 
	And the User "<iMedidata User 2 ID>" is not connected to Rave
	And I log out 
	And I log in as User "<iMedidata User 2 ID>"
	And I accept the invitation
	And I follow "<EDC App>" for "<Study A>"
	And I am on Rave Connection page
	And I link my account with password "<Rave User 1 Password>"
	And I am on Rave Study"<Study A>" page
	And I log out
	And I log in as "<iMedidata User 1 ID>"
	And I follow "<EDC App>" for Study "<Study A>"
	And I navigate to User Adminstration in Rave
	And I search for User "<iMedidata User 2 ID>" Authenticator "Internal"
	And I should see no search results
	And I take a Screenshot
	And I search for User "<iMedidata User 2 ID>" Authenticator "iMedidata"
	And I should see 1 User Account "<iMedidata User 2 ID>"
	And I should see Role "<EDC Role 1>" 
	When I navigate to User Details page for User "<iMedidata User 2 ID>"
	Then I should see Study "<Study A>:Prod" listed in Studies Pane
	And I should see Role "<Edc Role 1>"
	And I should see Authenticator "iMedidata" in User Details
	And I should see Login "<iMedidata User 2 ID>"
	And I take a Screenshot
	And I search for User "<iMedidata User 2 ID>" Authenticator "iMedidata" Check "Include Inactive Records"
	And I should see "<iMedidata User 2 ID>" with blank role
	And I navigate to User Details page for "<iMedidata User 2 ID>" with blank role
	And I should see Active checkbox "unchecked"
	And I should see Authenticator "iMedidata"
	And I take a screenshot


@Rave 564 Patch 13
@PB2.7.5.28-56
@Validation
Scenario: If a Users Modules App invitation is changed , then that should be reflected appropriately in Rave.

    Given I am an iMedidata User
    And I am logged in
    And my Username is "<iMedidata User 1 ID>" in iMedidata
	And there is an iMedidata Study Group named "<Study Group>"
    And there is an iMedidata Study named "<Study A>" in the Study Group named "<Study Group>"
    And I have an assignment to the iMedidata Study named "<Study A>" for the App named "<Modules App>"  Role "<Modules Role 1>" for app "<EDC App>" with Role "<EDC Role 1>" for App "<Architect Security>" with Role "<Security Group 1>"
	And I accept the invitation to "<Study A>"
    And I follow "<Modules App>" for "<Study A>"
	And I am on Rave Study "<Study A>" Home page
	And I click on Home
	And I should see All installed modules
	And I take a screenshot
	And I navigate to User Details page for "<iMedidata User 1 ID>"
	And I should see "<Modules 1>" User Group assigned
	And I take a screenshot
	And I follow iMedidata link
	And I am in iMedidata
	And my assignment to Modules is changed to "<Modules Role 4>"
	And I take a screenshot
	When I follow "<Modules App>" for "<Study A>"
	And I am in Rave
	And I click on Home
	And I should see "User Adminstratiom" listed in left hand pane
	And I should not see other modules listed
	And I take a screenshot
	And I navigate to User Details page for "<iMedidata User 1 ID>"
	Then I should see "<User Admin>" as User Group
	And I take a screenshot


@Rave 564 Patch 13 
@PB2.5.8.28-57
@Validation
DT # 14195
Scenario: If an existing iMedidata user has a study assignment removed in iMedidata and then invited to a Study Group, that study assignment is also removed in Rave.

    Given I am an iMedidata Administrator User
	And I login as an iMedidata Administrator
	And I invite an iMedidata user "<iMedidata User 1 ID>" to  "<Study A>" with  "<EDC App>" Role "<EDC Role 1>"
	And I Login as iMedidata user that was just invited
	And I accept the invitation to  "<Study A>"
	And I navigate to Rave
	And I am on Study "<Study A>" Home page
	And I should see Study A 
	And I take a screenshot
	And I navigate to User Administration 
	And I search for iMedidata user "<iMedidata User 1 ID>" with iMedidata as "Authenticator"	
	And I see one row in the search results table
	And I take a screenshot
	And I navigate to user details page
	And I should see "<Study A>" listed in the Studies pane for User name "<iMedidata User 1 ID>"
	And I take a screenshot
	And I login as iMedidata Administrator 
	And I remove "<Study A>" with "<EDC Role 1>" assignment from previously invited user.
    And I Invite iMedidata user "<iMedidata User 1 ID>" to a Study Group named "<Study Group A>" for "<EDC App>" with "<EDC Role 2>"
	And I take a screenshot
    And I login as  iMedidata user "<iMedidata User 1 ID>"
	And I accept the invitation to a Study Group
	And I navigate to Rave by following "<EDC App>" for "<Study Group>"
	And I am on Rave home page
	And I take a screenshot
	And I Logout
	And I login as iMedidata Administrator User	
	And I click on EDC App "<EDC App>" next to the Study Group "<Study Group A>"
	And I am on the Rave home page
	And I select link "User Administration"
	And I search for iMedidata user "<iMedidata User 1 ID>" with iMedidata as "Authenticator"	
	When I navigate to user details page
	Then I should not see "<Study A>" with "<EDC Role 1>" listed in the Studies pane for User name "<iMedidata User 1 ID>"
    And I take a screenshot
	And I follow the iMedidata link
	And I am on the iMedidata home page 
	And I select the Logout link

@Rave 2013.2.0.
MCC-58852
@Validation
Scenario: As an iMedidata study and site owner, and linked to a Rave study and site with all assignments. Forms should not be locked in Rave while connecting from iMedidata for a new study.

	Given I am a Rave User "<Rave User 1>" with rave username "<Rave User Name 1>"  password "<Rave Password 1>"
	And I am logged in to Rave
	And I follow link "Architect"
	And I follow link "Upload Draft"
	And I upload a study "Study A"
	And I navigate to study "Study A" and publish a "CRF Version"
	And I push "CRF Version" to "All Sites" and "Prod" study
    And I take a screenshot
	And I navigate to "Home" page
	And I follow link "Site Administration"
	And I follow link "New Site"
	And I create a new site with SiteName "Site A" and SiteNumber "<Unique Number>"
	And I add study "Study A" to site "Site A"
    And I take a screenshot
	And I am an iMedidata user "<iMedidata User 1 ID>"  
    And I am logged in to iMedidata
	And I am an owner of the Study Group named "SG 1"
	And I create same study "Study A" with "Protocol Number" and "Is Production"
    And I take a screenshot
    And Rave Study "Study A" is linked to iMedidata Study "Study A"
    And I take a screenshot
	And I create same site with SiteName "Site A" and SiteNumber "<Unique Number>"
    And I take a screenshot
    And Rave Site "Site A" is linked to iMedidata Site "Site A"
    And I take a screenshot
	And I invite iMedidata user "<iMedidata New User 2>" as a study owner and site owner to Study "<Study A>" and Site "Site A" with App named "<Edc App>" and the Role "<EDC Role 1>" and App named "<Modules App>" and the Role "<Modules Role 1>"and App "<Security App>" with Role "<Security Role 1>"
    And I take a screenshot
	And I select link from email to activate account
	And I activate iMedidata account for new user "<iMedidata New User 2>"
	And I log in to iMedidata as new user "<iMedidata New User 2>"
	And I see the invitation for Study "Study A" and Site "Site A"
	And I accept the invitations for Study and Site
    And I take a screenshot
	And I follow "<EDC App>" for <Study A>
    And I am on Rave Site Home page
    And I take a screenshot
	When I select link "Add Subject" 
	Then I should not see Primary form "locked"
    And I take a screenshot
	And I add a subject
	And I should not see Forms and Folders "locked"
    And I take a screenshot

@release2012.2.0
@PB2.5.8.28-07 
@Draft
Scenario: As an iMedidata study owner, I can invite a new user to an iMedidata study linked to a Rave study with a Modules assignment. After the user accepts the invitation and follows the Modules link to Rave, then Rave should create a user with the user group assignment from iMedidata on the Rave project and link the account.



@release2012.2.0
@PB2.5.8.28-08 
@Draft
Scenario: As an iMedidata study owner, I can invite a new user to an iMedidata study linked to a Rave study with one EDC role and a Modules assignment. After the user accepts the invitation and follows the EDC link to Rave, then Rave should create a user with the EDC role and the Modules assignments from iMedidata on the Rave project and links the account. 



@release2012.2.0
@PB2.5.8.28-10
@Draft
Scenario: As an iMedidata study owner, I can invite a new user to an iMedidata study linked to a Rave study with only an Architect Security Group role. When the user accepts the invitation and clicks on the Architect Security link to go to Rave for the first time, Rave must assign the user to the 'iMedidata Architect' user group before applying the Architect Security Group assignment to the user.
