# All actions that occur through the synchronization must be audited. The audit trail of Rave is critically important because Rave provides several critical audit reports
# to users that integration studies, site, and user audit data with clinical audits around subjects, eCRF pages and datapoints, and other details.

Feature: Audit
    In order to stay in compliance with 21 CFR Part 11 and GxP
	As a User
	I need to see standard Rave audit reports that show study, site, studysite, studysite assignments, study assignments, and user activity

	
	
	Background:
	Given I am an iMedidata user with first name "<Fname>" and last name "<Lname>" with pin "<PIN>" password "<Password>" and user id "<User ID/Name>"
		|Fname								|Lname								|PIN						| Password							|User ID/Name						|Email 							|
		|{First Name 1}						|{Last Name 1}						|iMedidata User 1 PIN}		|{iMedidata User 1 Password}		|{iMedidata User 1 ID}			|{iMedidata User 1 Email}		|
		|{First Name 2}						|{Last Name 2}						|iMedidata User 2 PIN}		|{iMedidata User 2 Password}		|{iMedidata User 2 ID}			|{iMedidata User 2 Email}		|
		|{First Name 3}						|{Last Name 3}						|iMedidata User 3 PIN}		|{iMedidata User 3 Password}		|{iMedidata User 3 ID}			|{iMedidata User 3 Email}		|
		|{First Name 4}						|{Last Name 4}						|iMedidata User 4 PIN}		|{iMedidata User 4 Password}		|{iMedidata User 4 ID}			|{iMedidata User 4 Email}		|
		|{First Name 5}						|{Last Name 5}						|iMedidata User 5 PIN}		|{iMedidata User 5 Password}		|{iMedidata User 5 ID}			|{iMedidata User 5 Email}		|
		|{First Name 6}						|{Last Name 6}						|iMedidata User 6 PIN}		|{iMedidata User 6 Password}		|{iMedidata User 6 ID}			|{iMedidata User 6 Email}		|
		|{First Name 7}						|{Last Name 7}						|iMedidata User 7 PIN}		|{iMedidata User 7 Password}		|{iMedidataUser 7 ID}			|{iMedidata  User7 Email}		|
		|{iMedidata Base User First Name}	|{iMedidata Base User Last Name} 	|iMedidata Base User PIN}	|{iMedidata Base User Password}		|{iMedidata Base User ID}		|{iMedidata Base User Email}	|
		|{New User First Name }				|{New User Last Name }				|							|{New User Password}				|{New User ID}					|{New User Email}				|
	
	And there exists a Rave user "<Rave User>" with username <Rave User Name>" and password "<Rave Password>" with "<Email>" and "<Rave First Name>" and "<Rave Last "Nane>"
		|Rave User		|Rave User Name		|Rave Password		|Email			|Rave First Name 	|Rave Last Name 	|
		|{Rave User 1}	|{Rave User Name 1}	|{Rave Password 1}	|{Rave Email 1}	|Rave First Name 1	|Rave Last Name 1	|
		|{Rave User 2}	|{Rave User Name 2}	|{Rave Password 2}	|{Rave Email 2}	|Rave First Name 2	|Rave Last Name 2	|
		|{Rave User 3}	|{Rave User Name 3}	|{Rave Password 3}	|{Rave Email 3}	|Rave First Name 3	|Rave Last Name 3	|	
		|{Rave User 4}	|{Rave User Name 4}	|{Rave Password 4}	|{Rave Email 4}	|Rave First Name 4	|Rave Last Name 4	|
		|{Rave User 5}	|{Rave User Name 5}	|{Rave Password 5}	|{Rave Email 5}	|Rave First Name 5	|Rave Last Name 5	|
		
	And there exists study "<Study>" in study group "<Study Group>"
		|Study		|Study Group 	|
		|{Study A}	|{Study Group} 	|
		|{Study B}	|{Study Group} 	|
		|{Study C}	|{Study Group} 	|
		|{Study D}	|{Study Group} 	|
		|{Study E}	|{Study Group} 	|
		|{Study F}	|{Study Group} 	|
		|{Study G}	|{Study Group} 	|
		|{Study H}	|{Study Group} 	|	
	And there exists Rave study "<Rave Study>" 
		|{Rave Study 1}	|			
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
		|{Study D}	|{Site D1}	|	
		|{Study E}	|{Site E1}	|
		|{Study F}	|{Site F1}	|	
		|{Study G}	|{Site G1}	|	
	And there exists subject <Subject> with eCRF page <eCRF Page>" in Site <Site>
		|Site		|Subject		|eCRF Page		|
		|{Site A1}	|{Subject 1}	|{eCRF Page 1}	|
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
		|{Rave URL 3}	|{rave564conlabtesting3.mdsol.com	|
		|{Rave URL 4}	|{rave564conlabtesting4.mdsol.com	|


    
@Rave2013.2.0
@PB2.5.8.28-01A
@Validation

Scenario: Operations on studies, sites, studysites, users, study assignments, studysite assignments must be audited in the 'name' 
          of the user that did the original action in iMedidata.  (new iMedidata User linked to a Rave user)

	Given I am an existing Rave User "<Rave User 1 ID>"
	And my Email is "<iMedidata User 2 Email>"
	And there is a Rave Study named "<Study A>" 
	And there is an Rave Site named "<Site A>"
	And I have assignment to the Rave Site named "<Site A>" and  Rave Study named "<Study A>"
	And there is iMedidata User "<iMedidata User 1 ID>"
	And I am logged  in iMedidata as iMedidata User "<iMedidata User 1 ID>"
	And I am a Study Group owner
	And I created a new Study named "<Study A>"
	And I created a new Site named  "<Site A>"
	And I have invited a new iMedidata user with Email "<iMedidata User 2 Email>"
	And new iMedidata username is "<iMedidata User 2 ID>"
    And new iMedidata username "<iMedidata User 2 ID>" is the Study "<Study A>" owner
	And Logged out as iMedidata User "<iMedidata User 1 ID>"
	And I am login as iMedidata username "<iMedidata User 2 ID>" 
	And new iMedidata username "<iMedidata User 2 ID>" accept the invitation
	And I am assigned to iMedidata Study named "<Study A>"
    And I am assigned to iMedidata Site named "<Site A>"
	And I have an assignment to the iMedidata Study named "<Study A>" for the App link named "<Edc App>" with Roles "<EDC Role 1>"
	And I have an assignment to the iMedidata Study named "<Study A>" for the App link named "<Modules App>" with Role "<Modules Role 1>"
	And I am on iMedidata Home page
	And I access the "Rave Modules" App through iMedidata
	And I am on Rave Connection page
	And I connect to the Rave by entering password
	And I select Link Account button

	And I am on Rave Site named "<Site A>" Home page
	And I navigate to Report Module
	And I am assigned to the "Audit Trail Report" in Rave
    And I am on the Rave "My Reports" page
	And I select "Audit Trail Report" report link
	And I select Rave Study named "<Study A>" from Report Parameters section
	And I select Rave study Site "<Site A>"
	And I click on Submit Report button
	When "Audit Trail Report" for "<Study A>" opened
	Then I should see that the original actions in iMedidata are audited
	And I should see iMedidata Study named "<Study A>" is displayed on the report page 
	And I should see iMedidata Site named "<Site A>" is displayed on report page in "Site" column
    And I should see a audit data in "Audit Action Type" column
	And I should see a audit data in "Audit Action" column
	And I take a screenshot (take as many screenshots as needed)
	And I close the Audit Trail Report" report
	And I select link iMedidata
	And I am back on iMedidata Home page
	And I navigate to Manage Study "<Study A>"page
	And I have updated iMedidata Study named "<Study Azz>"
    And I have updated iMedidata Site named "<Site Azz>"
	And I navigate to iMedidata Home page
	And I access the "Rave Modules" App through iMedidata
	And I am on Rave Site named "<Site Azz>" Home page
	And I navigate to the Rave Home page
	And I select "Reporter" link from the Installed Modules section
	And I should be on "My Reports" page
	And I select "Audit Trail Report" report link
	And I select Rave Study named "<Study Azz>" from Report Parameters section
	And I select Rave study Site "<Site Azz>"
	And I click on Submit Report button
	And I should see the "Audit Trail Report" for "<Study Azz>"
	And I should see iMedidata Study named "<Study Azz>" is displayed on the report page 
	And I should see iMedidata Site named "<Site Azz>" is displayed on report page in "Site" column
    And I should see a audit data in "Audit Action Type" column
	And I should see a audit data in "Audit Action" column
	And I take a screenshot (take as many screenshots as needed)
	And I close the Audit Trail Report" report

@Rave2013.2.0
@PB2.5.8.28-01B
@Validation

Scenario: Operations on studies, sites, studysites, users, study assignments, studysite assignments must be audited in the 'name' 
          of the user that did the original action in iMedidata. (existing iMedidata user not linked to a rave user)

	Given I am an existing iMedidata User "<iMedidata User 1 ID>"
	And I am a Study Group owner
	And I am logged in
	And I created a new Study named "<Study A>"
	And I created a new Site named  "<Site A>"
	And I have invited a new iMedidata user with Email "<iMedidata User 2 Email>"
	And new iMedidata username is "<iMedidata User 2 ID>"
    And new iMedidata username "<iMedidata User 2 ID>" is the Study "<Study A>" owner
	And the new iMedidata username "<iMedidata User 2 ID>" accept the invitation
	And I am login as iMedidata username "<iMedidata User 2 ID>" 
	And I assigned to iMedidata Study named "<Study A>"
    And I assigned to iMedidata Site named "<Site A>"
	And I have an assignment to the iMedidata Study named "<Study A>" for the App link named "<Edc App>" with Roles "<EDC Role 1>"
	And I have an assignment to the iMedidata Study named "<Study A>" for the App link named "<Modules App>" with Role "<Modules Role 1>"
	And I access the "Rave Modules" App through iMedidata
	And I am on Rave Site named "<Site A>" Home page
	And I navigate to Reporter Module
	And I assigned to the "Audit Trail Report" in Rave
	And I navigate to the Rave Home page
	And I select "Reporter" link from the Installed Modules section
	And I should be on "My Reports" page
	And I select "Audit Trail Report" report link
	And I select Rave Study named "<Study A>" from Report Parameters section
	And I select Rave study Site "<Site A>"
	And I click on Submit Report button
	When "Audit Trail Report" for "<Study A>" opened
	Then I should see that the original actions in iMedidata are audited
	And I should see iMedidata Study named "<Study A>" is displayed on the report page 
	And I should see iMedidata Site named "<Site A>" is displayed on report page in "Site" column
	And I should see a audit data in "Audit Action Type" column
	And I should see a audit data in "Audit Action" column
	And I take a screenshot (take as many screenshots as needed)
	And I close the Audit Trail Report" report
	And I select link iMedidata
	And I am back on iMedidata Home page
	And I navigate to Manage Study "<Study A>"page
	And I have updated iMedidata Study named "<Study Azz>"
    And I have updated iMedidata Site named "<Site Azz>"
	And I navigate to iMedidata Home page
	And I access the "Rave Modules" App through iMedidata
	And I am on Rave Site named "<Site Azz>" Home page
	And I navigate to the Rave Home page
	And I select "Reporter" link from the Installed Modules section
	And I should be on "My Reports" page
	And I select "Audit Trail Report" report link
	And I select Rave Study named "<Study Azz>" from Report Parameters section
	And I select Rave study Site "<Site Azz>"
	And I click on Submit Report button
	And I should see the "Audit Trail Report" for "<Study Azz>"
	And I should see iMedidata Study named "<Study Azz>" is displayed on the report page 
	And I should see iMedidata Site named "<Site Azz>" is displayed on report page in "Site" column
	And I should see a audit data in "Audit Action Type" column
	And I should see a audit data in "Audit Action" column
	And I take a screenshot (take as many screenshots as needed)
	And I close the Audit Trail Report" report


@Rave2013.2.0
@PB2.5.8.28-04A
@Validation

Scenario: Operations on studies, sites, studysites, users, study assignments, studysite assignments must be audited in the 'name' 
          of the user that did the original action in iMedidata. (New user)

	And I am logged in to iMedidata as iMedidata User "<iMedidata User 1 ID>"
	And there is a Rave Study named "<Study A>"
	And there is a Rave Site named "<Site A>"
	And the Rave Site named "<Site A>" is assigned to Rave Study named "<Study A>" 
	And I take a screenshot
	And I am a Study Group owner
	And I created a new Study named "<Study A>"
	And I created a new Site named  "<Site A>"
	And I created a new Site named  "<Site B>"
	And I have invited iMedidata user with user ID "<iMedidata User 2 ID>" and  with Email "<iMedidata User 2 Email>" to study "Study A>" as Study and Site owner
	And new iMedidata username "<iMedidata User 2 ID>" accept the invitation
	And Logged out as iMedidata User "<iMedidata User 1 ID>"
	And I am login as iMedidata username "<iMedidata User 2 ID>" 
	And new iMedidata username "<iMedidata User 2 ID>" accept the invitations to study and sites
	And I assigned to iMedidata Study named "<Study A>"
    And I assigned to iMedidata Site named "<Site A>"
	And I assigned to iMedidata Site named "<Site B>"
	And I have an assignment to the iMedidata Study named "<Study A>" for the App link named "<Edc App>" with Roles "<EDC Role 1>"
	And I have an assignment to the iMedidata Study named "<Study A>" for the App link named "<Modules App>" with Role "<Modules Role 1>"
	And I am on iMedidata Home page
	And I access the "Rave Modules" App through iMedidata
	And I am on Rave Study Home page
	And I see Site named "<Site A>" and Site named "<Site B>" are displayed
	And I navigate to Report Module
	And I assigned to the "Audit Trail Report" in Rave
    And I am on the Rave "My Reports" page
	And I select "Audit Trail Report" report link
	And I select Rave Study named "<Study A>" from Report Parameters section
	And I select Rave study Site "<Site A>"
	And I click on Submit Report button
	When "Audit Trail Report" for "<Study A>" opened
	Then I should see that the original actions in iMedidata are audited
	And I should see iMedidata Study named "<Study A>" is displayed on the report page 
	And I should see iMedidata Site named "<Site A>" is displayed on report page in "Site" column
	And I should see the "Audit Action Type" column has data displayed
	And I should see the "Audit Action" column has data displayed
	And I take a screenshot (take as many screenshots as needed)
	And I close the Audit Trail Report" report
	And I select link iMedidata
	And I am back on iMedidata Home page
	And I navigate to Manage Study "<Study A>"page
	And I have updated assignment to the iMedidata Study named "<Study A>" for the App link named "<Edc App>" with Roles "<EDC Role 2>"
    And I have updated iMedidata Site named "<Site Azz>"
	And I have updated iMedidata Site named "<Site Bzz>"
	And I navigate to iMedidata Home page
	And I access the "Rave Modules" App through iMedidata
	And I am on Rave Study named "<Study A>" Home page
	And I see Site named "<Site Azz>" and Site named "<Site Bzz>" are displayed
	And I navigate to the Rave Home page
	And I select "Reporter" link from the Installed Modules section
	And I should be on "My Reports" page
	And I select "Audit Trail Report" report link
	--And I select Rave Study named "<Study A>" from Report Parameters section
	And I select Rave study Site "<Site Azz>"
	And I select Rave study Site "<Site Bzz>"
	And I click on Submit Report button
	And I should see the "Audit Trail Report" for "<Study A>"
	--And I should see iMedidata Study named "<Study A>" is displayed on the report page 
	And I should see iMedidata Site named "<Site Azz>" is displayed on report page 
	And I should see iMedidata Site named "<Site Bzz>" is displayed on report page 
	And I should see a audit data in "Audit Action Type" column
	And I should see a audit data in "Audit Action" column
	And I take a screenshot (take as many screenshots as needed)
	And I close the Audit Trail Report" report


@Rave2013.2.0
@PB2.5.8.28-04B
@Validation

Scenario: Operations on studies, sites, studysites, users, study assignments, studysite assignments must be audited in the 'name' 
          of the user that did the original action in iMedidata. (existing user)

	Given I am an existing iMedidata User "<iMedidata User 1 ID>"
	And I am a Study Group owner
	And I am logged in
	And I created a new Study named "<Study A>"
	And I created a new Site named  "<Site A>"
	And I created a new Site named  "<Site B>"
	And I have invited a new iMedidata user with Email "<iMedidata User 2 Email>"
	And new iMedidata username is "<iMedidata User 2 ID>"
    And new iMedidata username "<iMedidata User 2 ID>" is invited to the Study "<Study A>" for App "<EDC App>" with Role "<EDC Role 1>" for App "<Modules App>" with Role "<Modules Role 1>" as Study owner
	And the new iMedidata username "<iMedidata User 2 ID>" accept the invitation
	And I am login as iMedidata username "<iMedidata User 2 ID>" 
	And I assigned to iMedidata Study named "<Study A>"
    And I assigned to iMedidata Site named "<Site A>"
	And I assigned to iMedidata Site named "<Site B>"
	And I access the "<Modules App>" for Study "<Study A>
	And I am on Rave Study "<Study A>" home Page
	And I see Sites "<Site A>" and "<Site B>"
	And I navigate to "<Site A>"
	And I create a new subject "New Subject A"
	And I navigate to Reporter Module
	And I am assigned to the "Audit Trail Report" in Rave
	And I navigate to the Rave Home page
	And I select "Reporter" link from the Installed Modules section
	And I should be on "My Reports" page
	And I select "Audit Trail Report" report link
	And I select Rave Study named "<Study A>" from Report Parameters section
	And I select Rave study Site "<Site A>"
	And I select Rave study Site "<Site B>"
	And I click on Submit Report button
	When "Audit Trail Report" for "<Study A>" opened
	Then I should see that the original actions in iMedidata are audited
	And I should see iMedidata Study named "<Study A>" is displayed on the report page 
	And I should see iMedidata Site named "<Site A>" on the report
	And I should see iMedidata Site named "<Site B>" on the report
	And I should see a audit data in "Audit Action Type" column
	And I should see a audit data in "Audit Action" column
	And I should see a data for the created subject "New Subject A" on the report
	And I take a screenshot (take as many screenshots as needed)
	And I close the Audit Trail Report" report
	And I navigate to the subject "New Subject A" home page
	And I update subject name to "Updated Subject A"
	And I save changes
	And I select link iMedidata
	And I am back on iMedidata Home page
	And I navigate to Manage Study "<Study A>"page
    And I have updated iMedidata Site named "<Site Azz>"
	And I have updated iMedidata Site named "<Site Bzz>"
	And I change the EDC Role assignment to with Role "<EDC Role 2>"
	And save changes
	And I navigate to iMedidata Home page
	And I access the "<Modules App>" App through iMedidata
	And I am on Rave Home page
	And I should see Site named "<Site Azz>" and  Site named "<Site Bzz>"
	And I have assigned to the "Audit Trail Report"
	And I select "Reporter" link from the Installed Modules section
	And I select "Audit Trail Report" report link
	And I select Rave Study named "<Study A>" from Report Parameters section
	And I select Rave study Site "<Site Azz>"
	And I select Rave study Site "<Site Bzz>"
	And I click on Submit Report button
	And I should see the "Audit Trail Report" for "<Study Azz>"
	And I should see iMedidata Study named "<Study A>" is displayed on the report page 
	And I should see iMedidata Site named "<Site Azz>" on the report
	And I should see iMedidata Site named "<Site Bzz>" on the report
	And I should see a audit data in "Audit Action Type" column
	And I should see a audit data in "Audit Action" column
	And I take a screenshot (take as many screenshots as needed)
	And I close the Audit Trail Report" report


@release2012.2.0
@PB2.5.8.28-02 
@FUTURE
Scenario: If the user that made the action in iMedidata for auditing purposes does not yet exist in Rave,
          a user account must be created in Rave for a legitimate audit record.

    Given I am an iMedidata User
    And I am logged in 
    And my Name is "<First Name 1>" "<Last Name 1>"
	And my username is "<iMedidata User 1 ID>"
    And my Email is "<iMedidata User 1 Email>"
    And I am not connected to Rave
    And there is not a Rave User with an Email of "<iMedidata User 1 Email>"
    And there is an iMedidata Study named "<Study A>"
	And there is an iMedidata Site named "<Site A>"
	And there is a Rave Study named "<Study A>"
	And there is an Rave Site named "<Site A>"
    And the iMedidata Study named "<Study A>" is linked to the Rave Study namd "<Study A>"
	And the iMedidata Study Site named "<Site A>" is linked to the Rave Study Site namd "<Site A>"
    And I have an assignment to the iMedidata Study named "<Study A>" for the App link named "<Edc App>" with Role "<EDC Role 1>"
    And I am on the iMedidata Home page
    And I click on app link "<Edc App>" next to the Study named "<Study A>"
    And I should be on the Rave Study Site page for the Study Site named "<Site A>"
    And I should see my name is "<First Name 1>" "<Last Name 1>"
	And I take a screenshot
	And I navigate to the EDC module Home Page

@release2012.2.0
@PB2.5.8.28-03 
@FUTURE
Scenario: If an API creates the user in iMedidata, Rave will audit the name of the API application passed to it from iMedidata.

