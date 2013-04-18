# The Rave Architect Security application in iMedidata provides a way for owners to set the User with a particular Rave Security Group, for Architect access.

Feature: Rave Architect Security
    In order to use Rave Architect
    As a User
    I want to be able to assign security through Rave Architect Security

Given I am an iMedidata user "<User>" with pin "<PIN>" password "<Password>" and user id "<User ID>"
	|User						|PIN						| Password							|User ID						|Email 							|
	|{iMedidata User 1}			|iMedidata User 1 PIN}		|{iMedidata User 1 Password}		|{iMedidata User 1 ID}			|{iMedidata User 1 Email}		|
	|{iMedidata User 2}			|iMedidata User 2 PIN}		|{iMedidata User 2 Password}		|{iMedidata User 2 ID}			|{iMedidata User 2 Email}		|
	|{iMedidata User 3}			|iMedidata User 3 PIN}		|{iMedidata User 3 Password}		|{iMedidata User 3 ID}			|{iMedidata User 3 Email}		|
	|{Admin User}		     	|Admin User PIN }		    |{Admin User Password}		|{Admin User ID}		|{Admin User Email}		|
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
And there exists Rave study "<Rave Study>" 
	|{Study A}	|			
And there exists User Group "<All Modules>" , "<iMedidata EDC>", "<Security Group>" in Rave
And there exists app "<App>" associated with study in iMedidata
	|App			|
	|{Edc App}		|
	|{Modules App}	|
	|{Security App}	|
#add security grp in background
And there exists site "<Site>" in study "<Study>", 	in iMedidata	
	|Study		|Site		|
	|{Study A}	|{Site A1}	|
And there exists role "<Role>" in app "<App>", 		
	|App			|Role												|
	|{Edc App}		|{EDC Role 1}										|
	|{Edc App}		|{EDC Role 2}										|
	|{Edc App}		|{EDC Role 3}										|
	|{Edc App}		|{EDC Role CRA create sub cannot view all sites}	|
	|{Edc App}		|{EDC Role RM Monitor}								|
	|{Modules App}	|{Modules Role 1}									|
	|{Modules App}	|{Modules Role 2 No Reports}						|
	|{Modules App}	|{Modules Role 3 No Sites}							|
	|{Security App}	|{Security Role 1}									|
    |{Security App}	|{Security Role 2}
	|{Security App}	|{Architect Role 1}									|					
And there exist "<Rave URL>" with "<URL Name>"
	|Rave URL		|URL Name							|
	|{Rave URL 1}	|{rave564conlabtesting1.mdsol.com	|
	
	
@Rave 564 Patch 13
@PB2.5.8.23-01
@Validation
Scenario: When an externally authenticated user accesses Rave for the first time with access to the Architect module and EDC provided through iMedidata,
           Rave will assign that user the default Architect Security Role defined in Rave. 

Given I am Rave User with access to All Modules
And I am logged in 
And I navigate to Configuration Module 
And I follow "Security Roles" page
And I assign a "<Default Architect Security Role>" as Default Role for Module "<Architect Project>"
And I log out
And I am logged in to iMedidata
And my Username is "<iMedidata User 1 ID>" in to iMedidata
And there is an iMedidata Study Group  "<Study Group>"
And I am the owner of the Study Group "<Study Group>"
And I created Study  "<Study A>" in the Study Group  "<Study Group>"
And I invite a user "<iMedidata User 2 ID>" to Study "<Study A>" as the Study owner
And the user "<iMedidata User 2 ID>" has assigned to the iMedidata Study "<Study A>"
And the user "<iMedidata User 2 ID>" has an assignment to the iMedidata Study  "<Study A>" for App  "<Edc app>" with "<EDC Role 1>"
And the user "<iMedidata User 2 ID>" has an assignment to the iMedidata Study  "<Study A>" for App  "<Modules App>" with "<Modules Role 1>" 
And I log out from iMedidata
And I log in as user "<iMedidata User 2 ID>" in iMedidata
And I accept the invitation to Study "<Study A>"
And I follow App "<Modules App>" for Study "<Study A>"
And I am on Rave "<Study A>" page
When I navigate to User Details page for User "<iMedidata User 2 ID>"
Then I should see Rave Default Architect Security Role "<Default Architect Security Role>"
And I take a screenshot


@Rave 564 Patch 13
@PB2.5.8.23-02
@Validation
Scenario: A user in iMedidata with Admin rights may invite one or more users to one or more security groups.

Given I am an iMedidata user
And I have admin rights in iMedidata
And I am logged in to iMedidata "<Admin User ID>"
And I am the owner of iMedidata Study Group  "<Study Group>"
And I created Study  "<Study A>" in the Study Group  "<Study Group>"
And I invite a user "<iMedidata User 1 ID>" to Study "<Study A>" for App  "<Security App>" Role  "<Security Group 1>" Role  "<Security Group 2>" as Study Owner
And I log out 
And I log in as User "<iMedidata User 1 ID>" in to iMedidata
And I accept invitation to Study "<Study A>" as Study Owner
And I navigate to Manage Study page for Study "<Study A>"
When I invite user "<iMedidata User 2 ID>"  to Study "<Study A>" for App "<Security App>" Role "<Security Group 1 >"
Then I should see Invitation sent message
And I take a Screenshot


@Rave 564 Patch 13
@PB2.5.8.24-01
@DValidation
Scenario: When a user in iMedidata is assigned a Security Group and has been assigned to an Architect and EDC role,
           then the user will have the security group assignment in Rave for that Study.

Given I am an iMedidata User "<iMedidata User 1 ID>"
And I am logged in to iMedidata
And there is an iMedidata Study Group  "<Study Group>"
And there is an iMedidata Study  "<Study A>" in the Study Group  "<Study Group>"
And I am the owner of the Study  "<Study A>"
And I am connected to Rave
And I invite the User "<iMedidata User 2 ID>" to the following for Study "<Study A>":
|App             | Role                   | 
|"<Security App>"|  "<Security Group 1>"  |
|"<Modules App>" |  "<Modules Role 1>"    |
|"<EDC App>"     |  "<Edc Role 1>"        |
And I logged out as User "<iMedidata User 1 ID>"
And I login as User "<iMedidata User 2 ID>"
And the User "<iMedidata User 2 ID>" accepts the invitation to the Study "<Study A>"
And I follow App "<EDC app>" for Study "<Study A>"
And I am on Rave Study "<Study A>" page
When I navigate to User Details page for User "<iMedidata User 2 ID>"
Then I should see Security Group "<Security Group 1 >" assignment in Rave
And I take a Screenshot

@Rave 564 Patch 13
@PB2.5.8.25-01
@Validation
Scenario: When a user in iMedidata is assigned a Security Group role and User has not been assigned to an Architect and EDC role,
           then the user will  have the security group assigned in Rave but will not be able to go to Rave from iMedidata. The user will see the error message,
		   “A user group or a role must be assigned for an external user” if no EDC or Modules roles have been assigned.

Given I am an iMedidata User
And I am logged in
And my Username is "<iMedidata User 3 ID>" in iMedidata
And there is an iMedidata Study Group  "<Study Group>"
And there is an iMedidata Study  "<Study A>" in the Study Group  "<Study Group>"
And I have an assignment to the iMedidata Study  "<Study A>" for App  "<Security App>" Role "<Security Group 1>" 
And I do not have an assignment to the iMedidata Study  "<Study A>" for App  "<Edc app>" ,"<Modules App>"
When I follow "<Security App>" for Study "<Study A>"
Then I should see Error message "A user group or a role must be assigned for an external user."
And I take a Screenshot
And I log out
And I log in as Rave User "<Rave user Name 1>" with access to User Adminstration
And I navigate to User Adminstration
And I navigate to User Details page for User "<iMedidata User 3 ID>"
And I should see "<Security Group 1>" assigned to the User in Other Modules Section
And I take a screenshot

@Rave 564 Patch 13
@PB2.5.8.27-01
@Validation
Scenario:When iMedidata is used to assign specific access to a study, If user is assigned to more than one EDC role, All the User accounts will have all the Architect security Group assignments.       

Given I am an iMedidata User
And there is a Rave user with Username "<iMedidata User 2 ID>"
And there is an iMedidata Study Group  "<Study Group>"
And there is an iMedidata Studies  "<Study A>" "<Study B>" in the Study Group  "<Study Group>"
And there exists a iMedidata user with Username "<iMedidata User 2 ID>"
And the iMedidata User "<iMedidata User 2 ID >" has an "<Security Group App >" assignment for Study "<Study A>" "<Study B>" with Role "<Security Group 1>"
And the iMedidata User "<iMedidata User 2 ID>" has an "<Edc App>" assignment for Study "<Study A>" "<Study B>" with Role "<Edc Role 1>"
And the iMedidata User "<iMedidata User 2 ID>" has an "<Modules App>"  assignment for Study "<Study A>" "<Study B>" with Role "<Modules Role 1>
And I am logged in iMedidata as "<iMedidata User 2 ID>"
And I change User "<iMedidata User 2 ID>" with an assignment to Study "<Study A>" for App "<EDC App>" Role "<EDC Role 2>"
And I change User "<iMedidata User 2 ID>" with an assignment to Study "<Study A>" for App "<Security Group App>" with role "<Security Group 2>"
And I am on iMedidata Home page 
And I follow "<Edc App>" for Study "<Study A>"
And I am on Rave Connection page
And I have linked to the Rave User with Username "<iMedidata User 2 ID>"
And I am on Study "<Study A>" home page
And I navigate to the User Administration Module
When I search for User "<iMedidata User 2 ID>" 
And I navigate to User Details page for User "<iMedidata User 2 ID>" for EDC "<EDC Role 2>"
Then I should see "<Security Group App>" with role "<Security Group 2>" in Other Modules Section
And I should see "<Security Group App>" with role "<Security Group 1>" in Other Modules Section
And I take a Screenshot
And I navigate back to the search page for User "<iMedidata User 2 ID>"
And I navigate to User Details page for User "<iMedidata User 2 ID>" for EDC "<EDC Role 1>"
And I should see "<Security Group App>" with role "<Security Group 1>" in Other Modules Section
And I should see "<Security Group App>" with role "<Security Group 2>" in Other Modules Section
And I take a Screenshot

@Rave 564 Patch 13
@PB2.5.8.29-01
@Validation
Scenario: When a user in iMedidata has multiple accounts in Rave and is assigned to a security group in iMedidata,
           then all user accounts for the iMedidata user are updated with the security group assignment.
 
Given I am an iMedidata User
And I am logged in
And my Username is "<iMedidata User 1 ID>" in iMedidata
And there is an iMedidata Study Group  "<Study Group>"
And there is an iMedidata Study  "<Study A>" in the Study Group  "<Study Group>"
And I have an assignment to Study "<Study A>" for App "<Edc App>" Role "<EDC Role 1>" "<EDC Role 2>"
And I have an assignment to Study "<Study A>" for App "<Modules App>" Role "<Modules Role 1>"
And I have an assignment to Study "<Study A>" for App "<Security App>" Role "<Security Group 1>"
And I follow app "<EDC App>" for study "<Study A>"
And I on Role Selection page
And I select the Role "<EDC Role 1>" 
And I click on Continue button
And I am on Rave Study Home page
When I navigate to User Adminstration
And I search for user"<iMedidata User 1 ID>" Authenticator "iMedidata"
Then I should see 2 search results for "<iMedidata User 1 ID>"
And I navigate to User Details page for Edc Role "<EDC Role 1>"
And I should see "<Security Group 1>"
And I take a Screenshot
And I select "Go Back" Lik
And I navigate to User Details page for EDC Role "<EDC Role 2>"
And I should see "<Security Group 1>"
And I take a Screenshot



