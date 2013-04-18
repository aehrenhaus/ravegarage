# Rave Add-ons are not all supported by externally authenticated users.  These requirements describe the various interactions within the Rave Integration.

Feature: Rave Integration Add On Support
    In order to fully use Rave
    As a user
    I want to access Rave add-ons

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
	And there exists Rave study "<Rave Study>" 
		|{Rave Study 1}	|		
	And there exists app "<App>" associated with study 
		|App			|
		|{EDC App}		|
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
		|{EDC App}		|{EDC Role 1}										|
		|{EDC App}		|{EDC Role 2}										|
		|{EDC App}		|{EDC Role 3}										|
		|{EDC App}		|{EDC Role CRA create sub cannot view all sites}	|
		{EDC App}		|{EDC Role RM Monitor}								|
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


@Rave 564 Patch 13
@PB2.5.10.1-10
@Validation
Scenario: As an iMedidata user I can be assigned to a Rave Add-on (BOXI, JReview, Reports, PDF Generator) in Rave after linking to an existing  Rave Study. 
	      When I access the "Rave Modules" App through iMedidata, I can see the modules and add-ons I am assigned.

    Given I am an iMedidata User
    And I am logged in
    And my Name is "<First Name 1>" "<Last Name 1>"
	And my username is "<iMedidata User 1 ID>"
    And my Email is "<iMedidata User 1 Email>"
    And I am not connected to Rave
    And there is not a Rave User with an Email of "<iMedidata User 1 Email>"
    And there is an existing  Rave Study named "<Study A>"
	And a Study named "<Study A>" is created in iMedidata
    And I have an assignment to the iMedidata Study named "<Study A>" for the App link named "<EDC App>" with Role "<EDC Role 1>"
	And I have an assignment to the iMedidata Study named "<Study A>" for the App link named "<Modules App>" with Role "<Modules Role 1>"
	And I follow the app "<Modules App>' associated with study "<Study A>"
	And I should be on the Rave Study page for the Study named "<Study A>"
	And I navigate to the Rave Home page
	And I should see the Installed Modules section
	And I select Report Administration link from the Installed Modules section
	And I navigate to the Report Assignment page
	And I assign the J-Review, BOXI addons to the user
	When I navigate to the Rave Home page
	Then I should see "Reporter" module in the Installed Modules
	And I should see "PDF Generator" module into the Installed Modules
	And I take a screenshot
	And I navigate to the Rave Home page
	And I navigate to the Reporter page
	And I should see the "BOXI" , "J-Review" add-ons I am assigned to
    And I take a screenshot

@Rave 564 Patch 13
@PB2.5.10.1-13
@Validation
Scenario: As an iMedidata user I can be assigned to a Rave Add-on (BOXI, JReview, Reports, PDF Generator) in Rave. 
	      When I access the "Rave Modules" App through iMedidata, I can see the modules and add-ons I am assigned.

	Given I am an iMedidata User
    And I am logged in
    And my Name is "<First Name 1>" "<Last Name 1>"
	And my username is "<iMedidata User 1 ID>"
    And my Email is "<iMedidata User 1 Email>"
    And I am not connected to Rave
    And there is not a Rave User with an Email of "<iMedidata User 1 Email>"
    And there is not an existing  Rave Study named "<Study A>"
	And a Study named "<Study A>" is created in iMedidata
    And I have an assignment to the iMedidata Study named "<Study A>" for the App link named "<EDC App>" with Role "<EDC Role 1>"
	And I have an assignment to the iMedidata Study named "<Study A>" for the App link named "<Modules App>" with Role "<Modules Role 1>"
	And I follow the app "<Modules App>' associated with study "<Study A>"
	And I should be on the Rave Study page for the Study named "<Study A>"
	And I navigate to the Rave Home page
	And I should see the Installed Modules section
	And I select Report Administration link from the Installed Modules section
	And I navigate to the Report Assignment page
	And I assign the J-Review, BOXI addons to the user
	When I navigate to the Rave Home page
	Then I should see "Reporter" module in the Installed Modules
	And I should see "PDF Generator" module into the Installed Modules
	And I take a screenshot
	And I navigate to the Rave Home page
	When I navigate to the Reporter page
	Then I should see the "BOXI" , "J-Review" add-ons I am assigned to 
    And I take a screenshot

@Rave 564 Patch 13
@PB2.5.10.1-11
@Validation
Scenario: As a Rave internal user, I am assigned to addons.  When my account is linked to iMedidata (making me a Rave External user) I still have access to the addons 
          I was originally assigned.  

    Given I am a Rave User
    And I am logged in to Rave
  	And my username is "<Rave User Name 1>"
    And my Email is "<iMedidata User 1 Email>"
    And there is an existing  Rave Study named "<Study A>" with site "<Site 1>" assigned to rave user "<Rave User Name 1>"
	And I follow link "Report Administration"
	And I follow link "Report Assignment"
	And I assign report "Business Objects XI" to Rave user "<Rave User Name 1>"
	And I assign report "J-Review"" to Rave user "<Rave User Name 1>"
	And I follow link "Home"
	And I follow link "Reporter"
	And I see the report "Business Objects XI" is assigned to the Rave user
	And I see the report "J-Review" is assigned to the Rave user
	And I take a screenshot
	And I follow link "J-Review" 
	And I see the Report Parameters" page for "J-Review"
	And I see study "<Study A>" in the Study selection list
	And I take a screenshot
	And I follow the link "My Reports"
	And I follow link "Business Objects XI" 
	And I see the "Report Parameters" page for "Business Objects XI"
	And I see study "<Study A>" in the Study selection list
	And I take a screenshot
    And I log out of Rave
	And I am logged in to iMedidata
	And my username is "<iMedidata User 1 ID>"
    And my Email is "<iMedidata User 1 Email>"
    And I create iMedidata Study named "<Study A>"
    And I am not connected to Rave
	And the iMedidata Study named "<Study A>" is linked to the Rave Study named "<Study A>"
    And I have an assignment to the iMedidata Study named "<Study A>" for the App link named "<EDC App>" with Role "<EDC Role 1>"
	And I have an assignment to the iMedidata Study named "<Study A>" for the App link named "<Modules App>" with Role "<Modules Role 1>"
	And I follow the link "<EDC App>" associated with study "<Study A>"
	And I see the "Rave Connection" Page
	And I enter the Rave password "<Rave Password 1>"
	And I follow link "Link Account"
	And I should be on the Rave Study page for the Study named "<Study A>"
	And I navigate to the Rave Home page
	And I should see the Installed Modules section
	When I navigate to the Reporter Module
	Then I  should see BOXI assignment
	And I take a screenshot
	And I see JReview assignment
	And I follow link "J-Review" 
	And I see the Report Parameters page for "J-Review"
	And I see study "<Study A>" in the Study selection list
	And I take a screenshot
	And I follow the link "My Reports"
	And I follow link "Business Objects XI" 
	And I see the Report Parameters" page for "Business Objects XI"
	And I see study "<Study A>" in the selection list
	And I take a screenshot


@Rave 564 Patch 13
@PB2.5.10.1-12
@Validation
Scenario: As an iMedidata user I can be assigned to a Rave Add-on (BOXI, JReview, Reports, PDF Generator) in Rave along with a Rave EDC study assignment. 
          If I have multiple EDC Roles assigned in any study and subsequently access the Rave EDC app in iMedidata, then Rave will display all roles across 
		  all studies in the Rave URL assigned to me. When I select an EDC Role, I will see all the Rave Modules assigned to me no matter which role I select.

	Given I am a Rave User
    And I am logged in to Rave
  	And my username is "<Rave User Name 1>"
    And my Email is "<iMedidata User 1 Email>"
	And I have access to All Modules
    And there is an existing  Rave Study named "<Study A>" with site "<Site 1>" assigned to rave user "<Rave User Name 1>"
	And I follow link "Report Administration"
	And I follow link "Report Assignment"
	And I assign report "Business Objects XI" to Rave user "<Rave User Name 1>"
	And I assign report "J-Review"" to Rave user "<Rave User Name 1>"
	And I follow link "Home"
	And I follow link "Reporter"
	And I see the report "Business Objects XI" is assigned to the Rave user
	And I take a screenshot
	And I see the report "J-Review" is assigned to the Rave user
	And I take a screenshot
	And I follow link "J-Review" 
	And I see the Report Parameters" page for J-Review"
	And I see study "<Study A>" in the Study selection list
	And I take a screenshot
	And I follow the link "My Reports"
	And I follow link "Business Objects XI" 
	And I see the Report Parameters" page for "Business Objects XI"
	And I see study "<Study A>" in the Study selection list
	And I take a screenshot
	And I should see PDF Generator in Installed Modules Section
	And I log out of Rave
	And I login to iMedidata
	And my username is "<iMedidata User 1 ID>"
    And my Email is "<iMedidata User 1 Email>"
    And I create iMedidata Study named "<Study A>"
	And I am not connected to Rave
    And the iMedidata Study named "<Study A>" is linked to the Rave Study named "<Study A>"
    And I have an assignment to the iMedidata Study named "<Study A>" for the App link named "<EDC App>" with Role "<EDC Role 1>"
    And I have an assignment to the iMedidata Study named "<Study A>" for the App link named "<EDC App>" with Role "<EDC Role 2>"
	And I have an assignment to the iMedidata Study named "<Study A>" for the App link named "<Modules App>" with Role "<Modules Role 1>"
 	And I follow the link "<EDC App>" associated with study "<Study A>"
	And I see the "Rave Connection" Page
	And I enter the Rave password "<Rave Password 1>"
	And I follow link "Link Account"
	And I should see Role Selection page with text "Please select a role from the list below."
	And I open "Select Role" drop down
	And I take a screenshot
	And I select "<EDC Role 1>" role from the drop down
	And I click on "Continue" button
	And I should be on the Rave Study page for the Study named "<Study A>"
	And I navigate to the Rave Home page
	And I should see the Installed Modules section
	And I should see PDF Generator
	And I take a screenshot
	When I navigate to the Reporter page
	Then I should see the "Business Objects XI" , "J-Review" add-ons I am assigned  
    And I take a screenshot
	And I navigate back to iMedidata
	And I access the "<Modules App>" associated with study "<Study A>"
	And I should see Role Selection page with text "Please select a role from the list below."
	And I select "<EDC Role 2>" role from the drop down
	And I click on "Continue" button
	And I should be on the Rave Study page for the Study named "<Study A>"
	And I navigate to the Rave Home page
	And I should see the Installed Modules section
	And I should see PDF Generator module
	And I take a screenshot
	And I navigate to the Reporter page
	And I should see the "Business Objects XI" , "J-Review" add-ons I am assigned  
    And I take a screenshot
