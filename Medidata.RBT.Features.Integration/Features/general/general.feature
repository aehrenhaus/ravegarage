# When synchronizing attributes and objects between iMedidata and Rave, there are several standard requirements that must be met that are common across all elements of the integration.
# The eLearning courses that are created and assigned to the users on iMedidata will not appear on Rave. The users that are assigned the eLearning course on iMedidata can view and complete that course on iMedidata and not on Rave
# The Rave user is never exposed to the Rave API. Rave will never expose the password to the outsIDe world through the Rave API Web Service. 
#The version number of the Rave API will be included in all requests. This will enable modification to the API without breaking legacy versions and thus keep it scalable for requests from customers. 
# The Rave Web Services Outbound will be a XML schema that uses SOAP, implemented in .NET 1.1 and integrated with Rave 5.6.4. All communication to the Rave Web Services Outbound will use the encrypted https protocol on port 443 and use a valID SSL Certificate. 
# iMedidata will use GetStudies, GetSites, GetRoles and GetSiteRoles methods and Rave will use the GetStudies, GetSites and GetUsers methods. During the synchronization, information from Rave appears within iMedidata Study Group because the Rave URL is manually connected to specific iMedidata Study Group. The synchronization process and related fields are listed in the appropriate sections below.

Feature: General Synchronization
    In order to create and use studies, sites, and users in Rave
    As a User
    I want to have my studies, sites, and users synchronized between Rave and iMedidata

Background:
	Given I am an iMedidata user "<User>" with pin "<PIN>" password "<Password>" and user ID "<User ID>"
		|User						|PIN						| Password							|User ID						|Email 							|
		|{iMedidata User 1}			|iMedidata User 1 PIN}		|{iMedidata User 1 Password}		|{iMedidata User 1 ID}			|{iMedidata User 1 Email}		|
		|{iMedidata User 2}			|iMedidata User 2 PIN}		|{iMedidata User 2 Password}		|{iMedidata User 2 ID}			|{iMedidata User 2 Email}		|
		|{iMedidata User 3}			|iMedidata User 3 PIN}		|{iMedidata User 3 Password}		|{iMedidata User 3 ID}			|{iMedidata User 3 Email}		|
		|{iMedidata User 4}			|iMedidata User 4 PIN}		|{iMedidata User 4 Password}		|{iMedidata User 4 ID}			|{iMedidata User 4 Email}		|
		|{iMedidata User 5}			|iMedidata User 5 PIN}		|{iMedidata User 5 Password}		|{iMedidata User 5 ID}			|{iMedidata User 5 Email}		|
		|{iMedidata User 6}			|iMedidata User 6 PIN}		|{iMedidata User 6 Password}		|{iMedidata User 6 ID}			|{iMedidata User 6 Email}		|
		|{iMedidata User 7}			|iMedidata User 7 PIN}		|{iMedidata User 7 Password}		|{iMedidataUser 7 ID}			|{iMedidata  User7 Email}		|
		|{iMedidata Base User}		|iMedidata Base User PIN}	|{iMedidata Base User Password}		|{iMedidata Base User ID}		|{iMedidata Base User Email}	|
		|{New User}					|							|{New User Password}				|{New User ID}					|{New User Email}				|
	And there exists a Rave user "<Rave User>" with username "<Rave User Name>" and password "<Rave Password>"
		|Rave User		|Rave User Name		|Rave Password		|
		|{Rave User 1}	|{Rave User Name 1}	|{Rave Password 1}	|
	And there exists study "<Study>" in study group "<Study Group>"
		|Study		|Study Group 	|
		|{Study A}	|{Study Group} 	|
		|{Study B}	|{Study Group} 	|
		|{Study C}	|{Study Group} 	|
		|{Study D}	|{Study Group} 	|
		|{Study E}	|{Study Group} 	|
		|{Study F}	|{Study Group} 	|
		|{Study G}	|{Study Group} 	|
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
	And there exists subject <Subject> with eCRF page "<eCRF Page>" in Site <Site>
		|Site		|Subject		|eCRF Page		|
		|{Site A1}	|{Subject 1}	|{eCRF Page 1}	|	
	And there exists role "<Role>" in app "<App>", 		
		|App			|Role												|
		|{EDC App}		|{EDC Role 1}										|
		|{EDC App}		|{EDC Role 2}										|
		|{EDC App}		|{EDC Role 3}										|
		|{EDC App}		|{EDC Role 4 No Entry}						     	|
		|{EDC App}		|{EDC Role CRA create sub cannot view all sites}	|
		|{EDC App}		|{EDC Role RM Monitor}								|
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
@PB2.6.1.3-02
@Validation
Scenario Outline: If an attribute in an object is copied over to Rave, and the attribute is localized to a different character set,
                  those characters are correctly preserved in Rave.

    Given I am an iMedidata User
	And I am the Study Group Owner
    And I am logged in
    And my Name is "<First Name 1>" "<Last Name 1>"
	And my username is "<iMedidata User 1 ID>"
	And my email is "<iMedidata User 1 Email>"
	And there is iMedidata Study  "<Study A>"
    And there is iMedidata Site  "<Site A>"
	And I have an assignment to the iMedidata Study  "<Study A>" for the App  "<EDC App>" with Role "<EDC Role 1>"
	And I have an assignment to the iMedidata Study  "<Study A>" for the App  "<Modules App>" with Role "<Modules Role 1>"
	And my Locale is set to "<Eng>"
	And I follow link "Account Details"
	And I update First Name with different character set "てすとテスト試験テスト"
	And I update Last Name with different character set "てすとテスト試験テスト"
	And I update Title with different character set "てすとテスト試験テスト"
	And I save my changes 
	And I should see Last Name is "てすとテスト試験テスト"
	And I should see First Name is "てすとテスト試験テスト"
	And I should see Title is "てすとテスト試験テスト"
	And I take screenshot
	And I navigate to Home page
	And I follow "<Modules App>" link for Study "<Study A>"
	And I am in Rave
	And I see First Name, Last Name and Title are displayed in different character set on top right hand sIDe of the page
	And I take screenshot
	When I select My Profile link
	Then I should see Last Name with different character set "てすとテスト試験テスト"
	And I should see First Name with different character set "てすとテスト試験テスト"
	And I should see Title with different character set "てすとテスト試験テスト"
	And I take screenshot 
	And I follow the link "User Administration"
	And I navigate to the User Details page for iMedidata user "<iMedidata User 1 ID>"
	And I should see Last Name with different character set "てすとテスト試験テスト"
	And I should see First Name with different character set "てすとテスト試験テスト"
	And I should see Title with different character set "てすとテスト試験テスト"
	And I should see my Language is set to "<English>"
	And I take a screenshot

#Covered in Spigot "ProjEnvCaseInsensetive" 
@Rave 564 Patch 13 
@PB2.6.1.3-03
@Validation
Scenario Outline: If an attribute in an object is copied over to Rave, and a comparison of that attribute is done for the purpose of matching,
                  that matching should always be done in a case-insensitive manner.
	
    Given I am an iMedidata User
    And I am logged in
    And there is a Rave User "<Rave User 1>"
    And the Rave User  "<Rave User 1>" has a Username "<iMedidata USER 1 ID>"
    And the Rave User  "<Rave User 1>" has an Email of "<iMedidata User 1 Email>"
    And the Rave User  "<Rave User 1>" has a User Group of "<Modules Role 1>"
    And the Rave User  "<Rave User 1>" has a Password "<Rave Password 1>"
    And there is a Rave Study  "<STUDY B>"
    And there is a Rave Site "<SITE B>" with site number "<TEST123>"
    And my iMedidata User First Name is "<First Name 1>" "<Last Name 1>"
    And my iMedidata User Last Name is "<Last Name 1>"
    And my iMedidata username is "<iMedidata user 1 ID>"
    And my Email is "<iMedidata User 1 Email>"
    And my iMedidata Account is not connected to Rave
    And there is an iMedidata Study  "<study b>"
    And there is an iMedidata Site "<site b>" with site number "<test123>"
    And I have an assignment to the iMedidata Study "<study b>" for App  "<EDC App>" with one Role "<EDC Role 1>" for App  "<Modules App>" with Role "<Modules Role 1>"
    And I am on the iMedidata Home page
	And I follow a "<EDC App>" link for the iMedidata Study "<study b>" 
    And I am on Rave Connection page
    And I enter "<Rave User 1>" password 
    When I select "Link Account" button 
    Then I am on Rave Study Site "<site b>" page
    And I take a screenshot
    And I navigate to the Site Administration module
    And I search for the Site "<site b>"
    And I see the site number "<test123>" for the Site with name "<site b>"
    And I see Source as iMedidata
    And I take a screenshot
    And I navigate to the User Details page in the User Administration module
    And I search for the "<iMedidata user 1 ID>" iMedidata user name
    And I see the username as "<iMedidata User 1 ID>"
    And I see Authenticator:iMedidata on User Details page
    And I see the Email is "<iMedidata User 1 Email>"
    And I take a screenshot
    And I navigate back to User Administration	page 
    And I search for the internal user "<iMedidata User 1 ID>"
    And there is no results for internal user "<iMedidata User 1 ID>"
    And I take a screenshot


@Rave 564 Patch 13
@PB2.6.1.3-04
@Validation
Scenario Outline: If an attribute in an object is copied over to Rave, and the attribute is not required or unique for that object, and the text in the attribute
is longer than the allowable length for the attribute in Rave, then the attribute text is truncated to fit the available space.

Examples:
    | Object                    | Attribute                       | 
    | Study                     | Description                     | 
    | Site                      | Name                            | 
    | User                      | Address Line 1                  | 
    | User                      | City                            | 


    Given I am an iMedidata User
	And I am the Study Group "<Study Group>" Owner
    And I am logged in to iMedidata
	And my email is "<iMedidata User 1 Email>"
	And there is iMedidata Study "<Study A>"
    And there is iMedidata Site  "<Site A>" assigned to Study "<Study A>"
	And I have an assignment to the iMedidata Study "<Study A>" for App  "<EDC App>" with Role "<EDC Role 1>" for App  "<Modules App>" with Role "<Modules Role 1>"
	And I navigate to Manage Study page
	And I update Study "<Study A>" 'Full Descriiption' with text that is longer than the allowable length for the attribute in Rave
	And I select Save button
	And I navigate to the Manage Study-Site page
	And I update Site name "<Site A>" with that is longer than the allowable length for the attribute in Rave
	And I select Save button
	And I navigate to iMedidata Home page
	And I follow link "Account Details"
	And I update "Address Line 1" with text that is longer than the allowable length for the attribute in Rave
	And I update "City" with text that is longer than the allowable length for the attribute in Rave
	And I select Save button
	And I follow a "<Modules App>" link for Study "<Study A>"
	And I am in Rave 
	When I navigate to My profile page
	Then I should see the attribute "Address Line 1" text is truncated to fit the available space
	And I should see the attribute "City" text is truncated to fit the available space
	And I take a screenshot
	And I navigate to Rave Home page 
	And I navigate to User Administration module
	And I navigate to the User Details page for the user "<iMedidata User 1 ID>"
	And I should see the attribute "Address Line 1" text is truncated to fit the available space
	And I should see the attribute "City" text is truncated to fit the available space
	And I take a screenshot
	And I navigate to Architect module
	And I navigate to the Study  "<Study A>"
	And I see the attribute "Description" text is truncated to fit the available space
	And I take a screenshot
    And I navigate to Site Adminstration
	And I Search for Site "<Site A>"
	And I navigate to Site Details page for Site "<Site A>"
	And I should see Attribute "Site Name" text is truncated to fit the available space
	And I take a screenshot

@2012.2.0
@PB2.6.1.3-05
@FUTURE
Scenario Outline: If an attribute in an object is copied over to Rave, and the attribute is required or unique for that object,
                  and there exists a duplicate of that attribute, then Rave should return an error and the object is not created or updated.

Examples:
    | Object                    | Attribute                       | 
    | Study                     | Study Name                      | 
    | Study                     | Protocol Number                 | 
    | Site                      | Number                          | 
    | User                      | Username                        | 
    | User                      | Email                           | 

#Covered by Spigot Script UserAttributes Upgrade564 


@Rave 564 Patch 13
@PB2.7.5.17-01
@Validation
Scenario Outline: The following settings will not apply to externally authenticated users and will be indicated on the core configuration settings page: Min Password Length, Alpha Required in Password, Numeric Required in Password, Special Required in Password, Password ValID Days, Password Reuse Days, NumFailed User Activation Attempts, Send Max Activation Alert, Confirm Activations, Activation Alert Time (Hours)

Examples:
    | Settings                           | 
    | Min Password Length                | 
    | Alpha Required in Password         | 
    | Numeric Required in Password       | 
    | Special Required in Password       | 
    | Password ValID Days                | 
    | Password Reuse Days                | 
    | NumFailed User Activation Attempts |
    | Send Max Activation Alert          | 
    | Confirm Activations                | 
    | Activation Alert Time (Hours)      |
	| *Continuous Esig Session Timeout (Minutes)|
	| *Two Part Esig IDentification Option|      


	Given I am an iMedidata User
    And I am logged in
	And my username is "<iMedidata User 1 ID>"
	And there is iMedidata Study "<Study A>"
    And I have an assignment to the iMedidata Study  "<Study A>" for App  "<EDC App>" with Role "<EDC Role 1>" for App  "<Modules App>" with Role "<Modules Role 1>"
	And I follow "<Modules App>" for Study "<Study A>" 
	And I am in Rave Study "<Study A>" home page
	When I navigate to Configuration Module, Other Settings page
	Then I should see the following settings do not apply to iMedidata users
		| Settings                                   | Result          |
		| *Min Password Length                       | Is not applying |
		| *Alpha Required in Password                | Is not applying |
		| *Numeric Required in Password              | Is not applying |
		| *Special Required in Password              | Is not applying |
		| *Password ValID Days                       | Is not applying |
		| *Password Reuse Days                       | Is not applying |
		| *NumFailed User Activation Attempts        | Is not applying |
		| *Send Max Activation Alert                 | Is not applying |
		| *Confirm Activations                       | Is not applying |
		| *Activation Alert Time (Hours)             | Is not applying |
		| *Continuous Esig Session Timeout (Minutes) | Is not applying |
		| *Two Part Esig IDentification Option       | Is not applying |
	And I take a screenshot


@Rave 564 Patch 13
@PB2.7.2.1-01
@Validation
Scenario Outline: Rave will display a message “These settings will not apply to iMedidata users or users that access Rave directly from a portal” on the Core Configuration Settings page.


    Given I am an iMedidata User
    And I am logged in
	And my username is "<iMedidata User 1 ID>"
	And there is iMedidata Study  "<Study A>"
	And I have an assignment to the iMedidata Study  "<Study A>" for the App  "<EDC App>" with Role "<EDC Role 1>"
	And I have an assignment to the iMedidata Study  "<Study A>" for the App  "<Modules App>" with Role "<Modules Role 1>"
	And I follow a "<Modules App>" link
	And I am in Rave
	And I navigate to the "Configuration" module
	When I navigate to the "Other Settings"
	Then I should see the “These settings will not apply to iMedidata users or users that access Rave directly from a portal” message
	And I take a screenshot



@Rave 564 Patch 13
@PB2.7.1.1-01
@Validation
Scenario: If the user is an iMedidata user, then the system will display a message “(courses taken on iMedidata are not shown)” on the User Details page. 

    Given I am an iMedidata User
    And I am logged in
	And my username is "<iMedidata User 1 ID>"
	And there is iMedidata Study  "<Study A>"
	And I have an assignment to the iMedidata Study  "<Study A>" for the App  "<EDC App>" with Role "<EDC Role 1>"
	And I have an assignment to the iMedidata Study  "<Study A>" for the App  "<Modules App>" with Role "<Modules Role 1>"
	And I follow a "<Modules App>" link
	And I navigate to Rave Home page 
	And I navigate to User Administration module
	When I navigate to the User Details page for the user "<iMedidata User 1 ID>"
	Then I see the message elearning "(courses taken on iMedidata are not shown)"
	And I take a screenshot

@Rave 564 Patch 13
@PB2.7.1.3-01
@Validation
Scenario: If the user is not an iMedidata user, when the course is created and assigned to the user on Rave,
           then the course is displayed in the eLearning section on Rave.

    Given I am not an iMedidata User
	And I am Rave user
    And I am on Rave Home page 
	And my username is "<Rave User Name1>"
	And there is Rave Study  "<Study A>"
	And I have an assignment to the Rave Study "<Study A>" with Role "<EDC Role 1>"
	And I have access to All Modules in Rave
	And I have eLearning Course created
	And I have eLearning Course assigned to the Study "<Study A>" and Role "<EDC Role 1>"
	And I navigate to User Administration module
	When I navigate to the User Details page for the user "<Rave User Name 1>"
	Then I see the course is displayed in the eLearning section on Rave
	And I take a screenshot

@Rave 564 Patch 13
@PB2.7.1.3-02
@Validation
Scenario: If the user is an iMedidata user, that user automatically will have a trained date with training signed, preventing Rave from blocking
           that user from accessing a study in EDC.


    Given I am an iMedidata User
    And I am logged in
	And my username is "<iMedidata User 1 ID>"
	And there is iMedidata Study  "<Study A>"
    And there is iMedidata Site  "<Site A>"
	And I am not connected to Rave
	And there is no user in Rave with Matching User name or Email
	And I have an assignment to the iMedidata Study  "<Study A>" for the App  "<EDC App>" with Role "<EDC Role 1>"
	And I have an assignment to the iMedidata Study  "<Study A>" for the App  "<Modules App>" with Role "<Modules Role 1>"
	And I follow a "<Modules App>" link
	And I am in Rave
	And I am connected to Rave
	And I navigate to User Administration module
	When I navigate to the User Details page for the user "<iMedidata User 1 ID>"
	Then I see the trained date of "<Today>" with training signed checkbox 'checked'
	And I take a screenshot




@Rave 564 Patch 13
@PB2.7.1.3-03
@Validation
Scenario: For both iMedidata and Rave-managed users, if a course is assigned to that user, that course may be taken as normal in Rave.

    Given I am Rave User
	And I am logged in to Rave
    And my Name is "<First Name 1>" "<Last Name 1>"
	And my username is "<Rave User Name 1>"
	And there is Rave Study  "<Study A>"
    And there is Rave Site  "<Site A>"
	And I am not connected to iMedidata
	And I have assigned to the Study
	And I have eLearning course created
	And I have eLearning course assigned to the "<Study A>" and Role "<EDC Role 1>"
	When I navigate to Rave Sudy Home page
	Then I see the "<Study A>" with (eLearning Required) text
	And I take a screenshot
	And I click on "<Study A>" link
	And I see eLearning Courses section
	And I take a screenshot
	And I log out 
	And I log in to iMedidata as New User "<iMedidata User 1 ID>"
    And I have an assignment to a iMedidata Study "<Study A>" for EDC App "<EDC App>" with Role "<EDC Role 1>"
	And I have an assignment to a Study "<Study A>"  for Modules App "<Modules App>" with Role "<Modules Role 1>"
	And I have eLearning course assigned to the "<Study A>" in Rave
	And I follow a "<Modules App>" link
    And I am on Rave Study "<Study A>" page
	And I see the "<Study A>" with (eLearning Required) text
	And I take a screenshot
	And I click on "<Study A>" link
	And I see eLearning Courses section
	And I take a screenshot

	

@Rave 564 Patch 13
@PB2.7.1.3-04
@Validation
Scenario: For both iMedidata and Rave-managed users, if a course is assigned to that user in Rave either directly or through an EDC role
            for a particular EDC study, that course will block the EDC user's access to the Rave study.

#Rave	
	Given I am Rave User
	And I am logged in to Rave
    And my Name is "<First Name 1>" "<Last Name 1>"
	And my username is "<Rave User Name 1>"
	And there is Rave Study  "<Study A>"
    And there is Rave Site  "<Site A>"
	And I have assigned to the Study
	And I am not connected to iMedidata
	And I have eLearning course created
	And I have eLearning course assigned to the "<Study A>" and Role "<EDC Role 1>"
	When I navigate to Rave Sudy Home page
	Then I see the "<Study A>" with (eLearning Required) text
	And I see message 'You must complete the eLearning course(s) listed below in order to gain access to the corresponding studies in Rave EDC.
	    For more help accessing eLearning courses, click on the Rave Help link above'
	And I take a screenshot
	And I log out 
#iMedidata
	And I log in into iMedidata as invated New User "<iMedidata User 1 ID>"
	And I accepted the invitation
	And there is iMedidata Study "<Study A>" linked to Rave Study "<Study A>"
	And there is iMedidata Site "<Site A>" linked to Rave Site "<Site A>"
    And I have an assignment to a iMedidata Study "<Study A>" for EDC App "<EDC App>" with Role "<EDC Role 1>"
	And I have an assignment to a Study "<Study A>"  for Modules App "<Modules App>" with Role "<Modules Role 1>"
	And there is an eLearning course assigned to the linked "<Study A>" in Rave
	And I follow a "<Modules App>" link
    And I am on Rave "eLearning Home" page
	And I see message 'You must complete the eLearning course(s) listed below in order to gain access to the corresponding studies in Rave EDC.
    	For more help accessing eLearning courses, click on the Rave Help link above'
	And I take a screenshot
	

@Rave 564 Patch 13
@PB2.7.1.4-01
@Validation
Scenario: Beneath Add Course link in eLearning page of the Configuration module in Rave, a message will be displayed “Please add
            and assign eLearning courses on iMedidata for users that are accessing Rave through iMedidata. If you have any questions please
			contact your system administrator.” 

	Given I am an iMedidata User
    And I am logged in
	And my username is "<iMedidata User 1 ID>"
	And there is iMedidata Study  "<Study A>"
    And there is iMedidata Site  "<Site A>"
	And I have eLearning course created
	And I have eLearning course assigned to the "<Study A>" and Role "<EDC Role 1>"
	And I have an assignment to the iMedidata Study  "<Study A>" for the App  "<EDC App>" with Role "<EDC Role 1>"
	And I have an assignment to the iMedidata Study  "<Study A>" for the App  "<Modules App>" with Role "<Modules Role 1>"
	And I follow a "<Modules App>" link
	And I am in Rave
	And I navigate to Configuration module
	When I navigate to the eLearning page
	Then I see the message “Please add and assign eLearning courses on iMedidata for users that are accessing Rave through iMedidata. If you have any questions please contact your system administrator.” 
	And I take a screenshot


@Rave 564 Patch 13
@PB2.7.5.2-01
@Validation
Scenario: When ‘End User License Agreement’ checkbox is checked in Configuration and the iMedidata-managed user enters Rave from iMedidata
                 for the first time, then the system will display End User License Agreement page.

	Given I am an iMedidata User
	And I am the Study Group Owner
    And I am not connected to Rave
    And my Name is "<First Name 1>" "<Last Name 1>"
	And my username is "<iMedidata User 1 ID>"
	And my email is "<iMedidata User 1 Email>"
	And there is iMedidata Study  "<Study A>"
    And there is iMedidata Site  "<Site A>"
	And "End User License Agreement" checkbox is checked in Configuration
	And I have an assignment to the iMedidata Study  "<Study A>" for the App  "<EDC App>" with Role "<EDC Role 1>"
	And I have an assignment to the iMedidata Study  "<Study A>" for the App  "<Modules App>" with Role "<Modules Role 1>"
	When I follow a "<Modules App>" link for the first time
	Then  I see End User License Agreement page
	And I take a screenshot

@Rave 564 Patch 13
@PB2.7.5.3-01
@Validation
Scenario: If the iMedidata managed user selects the checkbox and clicks “Continue” button on End User License Agreement page,
             then the system will take the user to relevant study with relevant role.

	Given I am an iMedidata User
    And I am not connected to Rave
	And my username is "<iMedidata User 1 ID>"
	And there is iMedidata Study  "<Study A>"
    And there is iMedidata Site  "<Site A>"
	And "End User License Agreement" checkbox is checked in Rave "Other Settings"page in Configuration Module
	And I have an assignment to the iMedidata Study  "<Study A>" for the App  "<EDC App>" with Role "<EDC Role 1>"
	And I have an assignment to the iMedidata Study  "<Study A>" for the App  "<Modules App>" with Role "<Modules Role 1>"
	And I follow a "<Modules App>" link for the first time
	And I see End User License Agreement page
	When I check the checkbox 
	And I follow “Continue” button on End User License Agreement page
	Then I should be on Rave "<Study A>" home page
	And I take a screenshot

@Rave 564 Patch 13
@PB2.7.5.4-01
@Validation
Scenario: If the iMedidata-managed user clicks “Cancel” button on End User License Agreement page,
            then the system will take the user to the iMedidata login page.

	Given I am an iMedidata User
	And I am the Study Group Owner
    And I am not connected to Rave
	And my username is "<iMedidata User 1 ID>"
	And there is iMedidata Study  "<Study A>"
    And there is iMedidata Site  "<Site A>"
	And "End User License Agreement" checkbox is checked in Rave Other Settings page in Configuration Module
	And I have an assignment to the iMedidata Study  "<Study A>" for the App  "<EDC App>" with Role "<EDC Role 1>"
	And I have an assignment to the iMedidata Study  "<Study A>" for the App  "<Modules App>" with Role "<Modules Role 1>"
	And I follow a "<Modules App>" link for the first time
	And I see End User License Agreement page
	When I select “Cancel” button on End User License Agreement page
	Then I should be on iMedidata Login page
	And I take a screenshot


@Rave 564 Patch 13
@PB2.7.5.16-01
@Validation
Scenario Outline: The following Rave objects will have the capability to store a UUID to ensure globally unique IDentification:
                   Users, Studies (Project + Environment), Sites, Study-Sites, eLearning Courses,User-Study Assignments,
				   User-Study-Site Assignments, EDC Roles, User Groups, Modules.
Examples:
    | Rave Object                 | 


	Given I am an iMedidata User
    And my username is "<iMedidata User 1 ID>"
	And there is iMedidata Study  "<Study A>"
	And I have an assignment to the iMedidata Study  "<Study A>" for the App  "<EDC App>" with Role "<EDC Role 1>"
	And I have an assignment to the iMedidata Study  "<Study A>" for the App  "<Modules App>" with Role "<Modules Role 1>"
	And I have connected to Rave
	And I have access to the Rave testing database
	When I run the SQL queries
	Then UUID is displayed for each object
	And I take a screenshot
	Examples: 
	|SQL Query | Expected Result |
	| SELECT top 1 UUID as 'User UUID' from Users                                         | UUID |
	| SELECT top 1 UUID as 'Study UUID' from Studies                                      | UUID |
	| SELECT top 1 UUID as 'Project UUID' from Projects                                   | UUID |
	| SELECT top 1 UUID as 'Site UUID' from Sites                                         | UUID |
	| SELECT top 1 UUID as 'StudySite UUID' from StudySites                               | UUID |
	| SELECT top 1 UUID as 'eLearningCourse UUID' from eLearningCourses                   | UUID |
	| SELECT top 1 UUID as 'eLearningUserCourse UUID' from eLearningUserCourses           | UUID |
	| SELECT top 1 UUID as 'eLearningCourseStudyRole UUID' from eLearningCourseStudyRoles | UUID |
	| SELECT top 1 UUID as 'UserStudySiteAssignment UUID' from UserStudySites             | UUID |
	| SELECT top 1 UUID as 'UserStudyRole UUID' from UserObjectRole                       | UUID |
	| SELECT top 1 UUID as 'Role UUID' from RolesAllModules                               | UUID |
    | SELECT top 1 UUID as 'UserGroup UUID' from UserGroups                               | UUID |
	
    
@Rave 564 Patch 13
@PB2.7.5.8-01
@Validation
Scenario: Rave will not update external user’s information through the User Loader. Rave will display a message on Upload Users page
 “iMedidata users have not been updated. Modify user information in iMedidata: [USERNAME].”


    Given I am an iMedidata User
	And I am the Study Group Owner
    And I am not connected to Rave
    And my Name is "<First Name 1>" "<Last Name 1>"
	And my username is "<iMedidata User 1 ID>"
	And my email is "<iMedidata User 1 Email>"
	And there is iMedidata Study  "<Study A>"
    And there is iMedidata Site  "<Site A>"
	And "End User License Agreement" checkbox is not checked in Configuration
	And I have an assignment to the iMedidata Study  "<Study A>" for the App  "<EDC App>" with Role "<EDC Role 1>"
	And I have an assignment to the iMedidata Study  "<Study A>" for the App  "<Modules App>" with Role "<Modules Role 1>"
	And I follow a "<Modules App>" link for the first time
	And I am on Rave Study Site page
	And I navigate to Rave Home page
	And I navigate to the User Administration module
	And I select "iMedidata" from the Authenticator dropdown
	And I select "Download" link
	And I save User.zip file on local drive
	And I update "Users.xls" with changes for the iMedidata userm "<iMedidata User 1 ID>"
	And I Save changes
	And I navigate back to User Administration module
	And I select "Upload Users" link from the User Admin Items section
	And I enter updated Users.xls file into the "Select File" field
	And I click on Upload button
	When the transaction completed
	Then I see the messsage “iMedidata users have not been updated. Modify user information in iMedidata: [USERNAME].” on Upload Users page
	And I take a screenshot

@Rave 564 Patch 13
@PB2.5.9.32-01
@Validation
Scenario: Rave will provIDe all Roles to iMedidata as Study Roles for the Rave EDC App on iMedidata.

    Given I am an iMedidata User
	And I am the Study Group Owner
    And I am not connected to Rave
    And my Name is "<First Name 1>" "<Last Name 1>"
	And my username is "<iMedidata User 1 ID>"
	And my email is "<iMedidata User 1 Email>"
	And there is iMedidata Study  "<Study A>"
    And there is iMedidata Site  "<Site A>"
	And "End User License Agreement" checkbox is not checked in Configuration
	And I have an assignment to the iMedidata Study  "<Study A>" for the App  "<EDC App>" with Role "<EDC Role 1>"
	And I have an assignment to the iMedidata Study  "<Study A>" for the App  "<Modules App>" with Role "<Modules Role 1>"
	And I am on Manage Study page
	And I navigate and select "Users" Tab
	When I select assignment link into the  "Apps and Roles" column
	Then I see Change Role dialog
	And I see the all Study Roles for the Rave EDC App listed into the dropdown
	And I take a screenshot 
	And I go back to iMedidata Home page
	And I follow a "<Modules App>" link
	And I am on Rave Study Site page
	And I navigate to Rave Home page
	And I navigate User Administration Module
	And I navigate to the User Details page for the user "<iMedidata User 1 ID>"
	And I select Assign to Study link
	When I expand the "Select Role" dropdown
	Then I see the all Study Roles for the Rave listed into the dropdown
	And I verify that Study Roles listed in iMedidata matches with the Study Roles listed in Rave
	And I take a screenshot 

@Rave 564 Patch 13
@PB2.5.9.33-01
@Validation
Scenario: Rave will provIDe only the Roles that have action Entry checked on the Role Actions page in Rave as Site Roles
             for the Rave EDC App on iMedidata.

	Given I am an iMedidata User
	And I am the Study Group Owner
    And I am not connected to Rave
    And my Name is "<First Name 1>" "<Last Name 1>"
	And my username is "<iMedidata User 1 ID>"
	And my email is "<iMedidata User 1 Email>"
	And there is iMedidata Study  "<Study A>"
    And there is iMedidata Site  "<Site A>"
	And "End User License Agreement" checkbox is not checked in Configuration
	And I have an assignment to the iMedidata Study  "<Study A>" for the App  "<EDC App>" with Role "<EDC Role 1>"
	And I have an assignment to the iMedidata Study  "<Study A>" for the App  "<Modules App>" with Role "<Modules Role 1>"
	And there is a "<EDC Role 4 No Entry>" that  has action Entry not checked on the Role Actions page in Rave
	And I am on Manage Study page
	And I navigate and select "Users" Tabe
	When I select assignment link into the  "Apps and Roles" column
	Then I see Change Role dialog
	And I see only the Roles that have action Entry checked on the Role Actions page in Rave
	And I do not see "<EDC Role 4 No Entry>" role in the list
	And I take a screenshot

@Rave 564 Patch 13
@PB2.5.9.33-02
@Validation
Scenario: The following Message displays in Rave when there is a large amount of activity on the SQS service. "A large amount of activity is occurring on this URL which may cause a short delay in your assignment appearing in Rave. If you do not see what you expect, you may need to refresh your browser. If the condition persists, please contact your Study Coordinator or the MedIData help desk" and User sees Refresh and Close buttons.

	Given there is a large amount of activity on the "<URL>", messages over the threshold
	And I am an iMedidata User
	And I have an assignment to the iMedidata Study  "<Study A>" for the App  "<EDC App>" with Role "<EDC Role 1>"
	And I have an assignment to the iMedidata Study  "<Study A>" for the App  "<Modules App>" with Role "<Modules Role 1>"
	And I follow "<EDC App>" for "<Study A>" 
	When I am on Rave "<Study A>" page
    Then I should see message "A large amount of activity is occurring on this URL which may cause a short delay in your assignment appearing in Rave. If you do not see what you expect, you may need to refresh your browser. If the condition persists, please contact your Study Coordinator or the MedIData help desk"
	And I should see Refresh button 
	And I should see Close button
	And I take a screenshot
	And I click "Refresh" button
	And the messages are over the threshold
	And I should see message "A large amount of activity is occurring on this URL which may cause a short delay in your assignment appearing in Rave. If you do not see what you expect, you may need to refresh your browser. If the condition persists, please contact your Study Coordinator or the MedIData help desk"
	And I take a screenshot
	And I click close button
	And I should not see the message "A large amount of activity is occurring on this URL which may cause a short delay in your assignment appearing in Rave. If you do not see what you expect, you may need to refresh your browser. If the condition persists, please contact your Study Coordinator or the MedIData help desk""
	And I click Home
	And I should see the message "A large amount of activity is occurring on this URL which may cause a short delay in your assignment appearing in Rave. If you do not see what you expect, you may need to refresh your browser. If the condition persists, please contact your Study Coordinator or the MedIData help desk""
	And I take a screenshot


@Rave 564 Patch 13
@PB2.5.9.33-03
@Validation
Scenario: The following message displays in Rave when there is a large amount of activity on the SQS service. "A large amount of activity is occurring on this URL which may cause a short delay in your assignment appearing in Rave. If you do not see what you expect, you may need to refresh your browser. If the condition persists, please contact your Study Coordinator or the MedIData help desk" and if the message thresold goes down and user clicks on Refresh  button then the message goes away.

	Given there is a large amount of activity on the "<URL>", messages over the thresold
	And I am an iMedidata User
	And I have an assignment to the iMedidata Study  "<Study A>" for the App  "<EDC App>" with Role "<EDC Role 1>"
	And I have an assignment to the iMedidata Study  "<Study A>" for the App  "<Modules App>" with Role "<Modules Role 1>"
	And I follow "<EDC App>" for "<Study A>" 
	And I am on Rave "<Study A>" page
    And I should see message "A large amount of activity is occurring on this URL which may cause a short delay in your assignment appearing in Rave. If you do not see what you expect, you may need to refresh your browser. If the condition persists, please contact your Study Coordinator or the MedIData help desk"
	And I should see Refresh button 
	And I should see Close button
	And I take a screenshot
	When the messages are below the threshold
	And I click Refresh Button
	Then I should not see the message "A large amount of activity is occurring on this URL which may cause a short delay in your assignment appearing in Rave. If you do not see what you expect, you may need to refresh your browser. If the condition persists, please contact your Study Coordinator or the MedIData help desk"
	And I take a screenshot

@Rave 564 Patch 13
@PB2.5.9.33-04
@Validation
Scenario: The following message displays in Rave when there is a large amount of activity on the SQS service. "A large amount of activity is occurring on this URL which may cause a short delay in your assignment appearing in Rave. If you do not see what you expect, you may need to refresh your browser. If the condition persists, please contact your Study Coordinator or the MedIData help desk" and if the message thresold goes down and user clicks on Close  button then the message goes away.

	Given there is a large amount of activity on the "<URL>", messages over the thresold
	And I am an iMedidata User
	And I have an assignment to the iMedidata Study  "<Study A>" for the App  "<EDC App>" with Role "<EDC Role 1>"
	And I have an assignment to the iMedidata Study  "<Study A>" for the App  "<Modules App>" with Role "<Modules Role 1>"
	And I follow "<EDC App>" for "<Study A>" 
	And I am on Rave "<Study A>" page
    And I should see message "A large amount of activity is occurring on this URL which may cause a short delay in your assignment appearing in Rave. If you do not see what you expect, you may need to refresh your browser. If the condition persists, please contact your Study Coordinator or the MedIData help desk"
	And I should see Refresh button 
	And I should see Close button
	And I take a screenshot
	When the messages are below the threshold
	And I click Close Button
	Then I should not see the message "A large amount of activity is occurring on this URL which may cause a short delay in your assignment appearing in Rave. If you do not see what you expect, you may need to refresh your browser. If the condition persists, please contact your Study Coordinator or the MedIData help desk"
	And I take a screenshot


@Rave 564 Patch 13
@PB2.5.9.33-05
@Validation	
Scenario: Study-Site assignments should not be sent if parent StudyInvitation was not accepted and Study-Site assignments should be sent if parent StudyInvitation is accepted.
  
  Given I am a iMedidata User "<iMedidata User 1 ID>"
  And there is a Study named "<Study A>"
  And I am an owner of a Study named "<Study A>" 
  And I have assignment to Study "<Study A>" with App "<EDC App>" Role "<EDC Role 1>" App "<Modules App>" with Role "<Modules role 1>"
  And a user exists with User name "<iMedidata user 2 ID>" with email "<iMedidata User 2 Email>"
  And the Site "<Site A1>" is in the Study named "<Study A>" with Site Number "<1873434>"
  And I invite user "<iMedidata User 2 ID>" for App "<EDC App>" with Role "<EDC Role 1>" for app "<modules app>" with Role "<Modules Role 1>"
  And the user "<iMedidata User 2 ID>" has not accepted the invitation to the study "<Study A>"
  And I navigate to Rave by following "<EDC App>" for "<Study A>"
  And I navigate to User Details page for "<iMedidata User 2 ID>"
  And I should see "<Study A>" is not listed in the Studies pane
  And the User has accepted the invitation to the "<Study A>"
  When I navigate to User Details page for "<iMedidata User 2 ID>"
  Then I should see "<Study A>" listed in the Studies Pane
  And I take a screenshot

  
@Rave 564 Patch 13
@PB2.5.9.33-06
@Validation
  Scenario: When user is invited to study for one app, and gets re-invited to a second app then the user should be assigned to the second app appropriately.
  
    Given I am a iMedidata User "<iMedidata User 1 ID>"
	And I am connected to Rave
    And there is a study "<Study A>"
    And I have an assignment to only "<Study A> with app "<EDC App>" with Role "<EDC Role 1>"
	And I follow "<EDC App>" for Study "<Study A>"
	And I should be on Rave "<Study A>" home page
	And I take a screenshot
    And I log out 
	And I log in Rave User "<Rave User Name 1>" with access to User Adminstration
	And I navigate to User Details page for User "<iMedidata User 1 ID>"
	And I should see User Group associated is "<iMedidata EDC>"
    And I take a screenshot
	And I log out
	And I log in to iMedidata as User "<iMedidata User 1 ID>"
	And I am on iMedidata Home page
	And I have a new assignment to "<Study A>" with App "<Modules App>" with Role "<Modules Role 1>"
	And I follow "<EDC App>" for Study "<Study A>"
	And I am on Rave Study "<Study A>" page
	When I click on Home Icon
	Then I should see "All Modules" listed on Left hand pane
	And I take a screenshot
	And I navigate to User Details page for User "<iMedidata User 1 ID>"
	And I should see User Group associated is "<Modules Role 1>"
    And I take a screenshot


@Rave 564 Patch 13
@PB2.5.9.33-07
@BUG
@Validation
  Scenario: When user is invited to a study for one app, and gets re-invited to same app but with different role then the changed role should be assigned to the user appropriately.

	Given I am a iMedidata User "<iMedidata User 1 ID>"
	And I am connected to Rave
    And there is a study "<Study A>"
    And I have an assignment to only "<Study A> with app "<EDC App>" with Role "<EDC Role 1>" App "<Modules App>" with Role "<Modules Role 1>"
	And I am the Study "<Study A>" owner
	And I invite iMedidata User "<iMedidata User 2 ID>" to Study "<Study A>" with App "<EDC App>" with Role "<EDC Role 1>"
	And the User "<iMedidata User 2 ID>" has accepted the invitation
	And I navigate to Rave by following "<Study A>" app "<EDC App>"
	And I navigate to User Details page for User "<iMedidata User 2 ID>"
	And I should see User Group associated is "<iMedidata EDC>"
	And I should see Role "<EDC Role 1>" is assigned to the User
    And I take a screenshot
	And I navigate to iMedidata
	And I am on Manage:Study page for Study "<Study A>"
	And I change role for User "<iMedidata User 2 ID>" from "<EDC Role 1>" to "<EDC Role 2>"
	And I follow "<EDC App>" for Study "<Study A>
	And I am in Rave
	When I navigate to User Details page for User "<iMedidata User 2 ID>"
	Then I should see User Group associated is "<iMedidata EDC>"
	And I should see Role "<EDC Role 2>" is assigned to the User for Study "<study A>"
    And I take a screenshot
	
@Rave 564 Patch 13
@PB2.5.9.33-08
@Validation
Scenario:  When user's invitation is updated with new app/role assignment that blocks them from accessing study then a DELETE invitation message should be generated.
   
    Given I am a iMedidata user "<iMedidata User 1 ID>"
    And I am logged in
    And there is a Course named "<My Course>" with Course File that has a Locale of "eng"
    And there is a study "<Study A>" in iMedidata
	And the Study "<Study A>" has Access to the Course named "<My Course>"
    And I am an Owner of a Study named "<Study A>" 
    And the Course "<My Course>" is mapped as required for App "<Modules App>" with Role "<Modules Role 1>" for Study "<Study A>" 
    And there is an Assignment for the User "<iMedidata User 2 ID>" to the Study named "<Study A>" and the App named "<EDC App>" with Role "<EDC Role 1>"
	And "<iMedidata User 2 ID>" has accepted the invitation to Study "<Study A>
	And I navigate to Rave by following App "<EDC App>" for Study "<Study A>"
	And I navigate to User Details page for User "<iMedidata user 2 ID>"
	And I should see "<EDC Role 1>" assigned to User for Study "<Study A>"
	And the Active Check box is checked
	And I navigate to iMedidata
	And I navigate to Manage Study "<Study A>" Page
	And I invite the User "<iMedidata User 2 ID>" for App "<modules App>" with Role "<Modules Role 1>" for Study "<Study A>"
    And I navigate to Rave by following App "<EDC App>" for Study "<Study A>"
	And I search for User "<iMedidata User 2 ID>" with Authenticator "iMedidata"
	And I should see no search results
	And I check "Include Inactive Records" Check box
	And I search
	And I should see User "<iMedidata User 2 ID>" for "<EDC Role 1>"
	When I navigate to User Details page for User "<iMedidata user 2 ID>"
	Then I should not see Study "<Study A>" assigned to Study in Studies Pane
	And the Active Check box is Unchecked
    And I take a screenshot
	And I log out
	And I log in as User "<iMedidata User 2 ID>" to iMedidata
	And I should see "<My course>" is required for access" message under Study "<Study A>"
	And I take a screenshot
   

@Rave 564 Patch 13
@PB2.5.9.33-09
@Validation
Scenario: When user's role is switched to role that blocks them from study then a DELETE invitation message should be generated
      
    Given I am a iMedidata user "<iMedidata User 1 ID>"
    And I am logged in
    And there is a Course named "<My Course>" with Course File that has a Locale of "eng"
    And there is a study "<Study A>" in iMedidata
	And the Study "<Study A>" has Access to the Course named "<My Course>"
    And I am an Owner of a Study named "<Study A>" 
    And the Course "<My Course>" is mapped as required for App "<EDC App>" with Role "<EDC Role 2>" for Study "<Study A>" 
    And there is an Assignment for the User "<iMedidata User 2 ID>" to the Study named "<Study A>" and the App named "<EDC App>" with Role "<EDC Role 1>", App "<Modules App>" with Role "<Modules Role 1>"
	And "<iMedidata User 2 ID>" has accepted the invitation to Study "<Study A>
	And I navigate to Rave by following App "<EDC App>" for Study "<Study A>"
	And I navigate to User Details page for User "<iMedidata user 2 ID>"
	And I should see "<EDC Role 1>" assigned to User for Study "<Study A>"
	And the Active Check box is checked
	And I navigate to iMedidata
	And I navigate to Manage Study "<Study A>" Page
	And I Change Role for the User "<iMedidata User 2 ID>" for App "<EDC App>" with Role "<EDC Role 2>" for Study "<Study A>"
    And I navigate to Rave by following App "<EDC App>" for Study "<Study A>"
	And I search for User "<iMedidata User 2 ID>" with Authenticator "iMedidata"
	And I should see no search results
	And I check "Include Inactive Records" Check box
	And I search
	And I should see User "<iMedidata User 2 ID>" for "<EDC Role 1>"
	When I navigate to User Details page for User "<iMedidata user 2 ID>"
	Then I should not see Study "<Study A>" assigned to Study in Studies Pane
	And the Active Check box is Unchecked
    And I take a screenshot
	And I log out
	And I log in as User "<iMedidata User 2 ID>" to iMedidata
	And I should see "<My course>" is required for access" message under Study "<Study A>"
	And I take a screenshot
   

@Rave 564 Patch 13
@PB2.5.9.33-10
@Validation
Scenario:  When user's invitation is updated with new app/role assignment that unblocks them from accessing study then a PUT invitation message should be generated
      
    Given I am a iMedidata user "<iMedidata User 1 ID>"
    And I am logged in
    And there is a Course named "<My Course>" with Course File that has a Locale of "eng"
    And there is a study "<Study A>" in iMedidata
	And the Study "<Study A>" has Access to the Course named "<My Course>"
    And I am an Owner of a Study named "<Study A>" 
    And the Course "<My Course>" is mapped as required for App "<EDC App>" with Role "<EDC Role 1>" for Study "<Study A>" 
    And there is an Assignment for the User "<iMedidata User 2 ID>" to the Study named "<Study A>" and the App named "<EDC App>" with Role "<EDC Role 1>"
	And "<iMedidata User 2 ID>" has accepted the invitation to Study "<Study A>
	And I navigate to Rave by following App "<EDC App>" for Study "<Study A>"
	And I navigate to User Adminstration
	And I search for "<iMedidata User 2 ID>" with "Include Inactive Records" checked
	And I should see User "<iMedidata User 2 ID>" for "<EDC Role 1>"
	And I navigate to User Details page for User "<iMedidata user 2 ID>"
	And I should not see Study "<Study A>" assigned to Study in Studies Pane
	And the Active Check box is Unchecked
	And I take a screenshot
	And I navigate to iMedidata
	And I navigate to Manage Study "<Study A>" Page
	And I invite the User "<iMedidata User 2 ID>" for App "<EDC App>" with Role "<EDC Role 2>" for Study "<Study A>"
    And I navigate to Rave by following App "<EDC App>" for Study "<Study A>"
	When I search for User "<iMedidata User 2 ID>" with Authenticator "iMedidata"
	Then I should see "<iMedidata User 2 ID>" with Role "<EDC Role 2>"
	And I should see Study "<Study A>" assigned to Study in Studies Pane
	And the Active Check box is Checked
    And I take a screenshot
	And I log out
	And I log in as User "<iMedidata User 2 ID>" to iMedidata
	And I should see Study "<Study A>"
	And I Follow "<EDC App>" for Study "<Study A>"
	And I am in Rave Study "<Study A>" page
	And I take a screenshot
   

@Rave 564 Patch 13
@PB2.5.9.33-11
@Validation
Scenario: When a user's site assignments are updated through assign sites page and user hasn't accepted parent study invitation then no study_site_assignment message should be generated


	Given I am a iMedidata User "<iMedidata User 1 ID>"
	And I am connected to Rave
    And there is a study "<Study A>"
    And I have an assignment to only "<Study A> with app "<EDC App>" with Role "<EDC Role 1>" App "<Modules App>" with Role "<Modules Role 1>"
	And I am the Study "<Study A>" owner
	And Site "<Site A1>" with Site Number "<Site A1 Number>" "<Site A2>" with Site Number "<Site A2 Number>" are assigned to the Study "<Study A>"
	And "<iMedidata User 2 ID>" is an existing user connected to Rave
	And I invite iMedidata User "<iMedidata User 2 ID>" to Study "<Study A>" with App "<EDC App>" with Role "<EDC Role 1>", App "<Modules Ap>" with Role "<Modules Role 1>"
	And I follow Assign Sites for User "<iMedidata User 2 ID>"
	And I am on Assign Sites for "<iMedidata User 2 ID>" in Study "<Study A>" page
	And I Assign "<iMedidata User 2 ID>" as User for Site "<Site A>"
	And User "<iMedidata user 2 ID>" has not accepted the invitation
	And I navigate to Rave 
	When I navigate to User Details page for User "<iMedidata User 2 ID>"
	Then I should see "<Study A>" is not assigned to the User in Studies Pane
	And I log out
	And I log in to iMedidata as User "<iMedidata User 2 ID>"
	And I accept the invitation to Study "<Study A>"
	And I navigate to Rave by following "<EDC App>" for Study "<Study A>"
	And I am on Rave "<Site A1>" page 
	And I navigate to user details page for User "<iMedidata User 2 ID>"
	And I should see Study "<Study A>" is assigned to the User in Studies Pane
	And I take a screenshot
	  

@Rave 564 Patch 13
@PB2.5.9.33-12
@Validation
Scenario: When a user's site assignments are updated through invitation details and user hasn't accepted parent study invitation then no update study_site_assignment message should be generated


	Given I am a iMedidata User "<iMedidata User 1 ID>"
	And I am connected to Rave
    And there is a study "<Study A>"
    And I have an assignment to only "<Study A> with app "<EDC App>" with Role "<EDC Role 1>" App "<Modules App>" with Role "<Modules Role 1>"
	And I am the Study "<Study A>" owner
	And Site "<Site A1>" with Site Number "<Site A1 Number>" "<Site A2>" with Site Number "<Site A2 Number>" are assigned to the Study "<Study A>"
	And I invite iMedidata User "<iMedidata User 2 ID>" to Study "<Study A>" with App "<EDC App>" with Role "<EDC Role 1>", App "<Modules Ap>" with Role "<Modules Role 1>" with access to Site "<Site A1>" in the same invitation
	And "<iMedidata User 2 ID>" is an existing user connected to Rave
	And User "<iMedidata user 2 ID>" has not accepted the invitation
	And I navigate to Rave 
	When I navigate to User Details page for User "<iMedidata User 2 ID>"
	Then I should see "<Study A>" is not assigned to the User in Studies Pane
	And I log out
	And I log in to iMedidata as User "<iMedidata User 2 ID>"
	And I accept the invitation to Study "<Study A>"
	And I navigate to Rave by following "<EDC App>" for Study "<Study A>"
	And I am on Rave "<Site A1>" page 
	And I navigate to user details page for User "<iMedidata User 2 ID>"
	And I should see Study "<Study A>" is assigned to the User in Studies Pane
	And I take a screenshot


@Rave 564 Patch 13
@PB2.5.9.33-13
@Validation
Scenario Outline: When a user accepts an invitation but has blocking elearning courses then no post invitation message should be created
  
 
	Given I am a iMedidata User "<iMedidata User 1 ID>"
	And I am connected to Rave
    And there is a "<Entity>"
    And I have an assignment to "<Entity>" with app "<EDC App>" with Role "<EDC Role 1>" App "<Modules App>" with Role "<Modules Role 1>"
	And I completed the "<Couse A>" for "<EDC App>" with Role "<EDC Role 1>" for "<Entity>"
	And I am the "<Entity>" owner
	And Course "<Course A>" is required course for "<EDC App>" with Role "<EDC Role 1>" for "<Entity>"
	And I invite iMedidata User "<iMedidata User 2 ID>" to "<Entity>" with App "<EDC App>" with Role "<EDC Role 1>", App "<Modules Ap>" with Role "<Modules Role 1>"
	And I log out
	And I log in to iMedidata as User "<iMedidata User 2 ID>"
	And I accept the invitation to "<Entity>"
	And I should see "<Course A>" required for access
	And I log out 
	And I log in as iMedidata user "<iMedidata User 1 ID>"
	And I navigate to Rave by following App "<EDC App>" with Role "<EDC Role1>"
	And I navigate to User Adminstration
	And I search for User "<iMedidata User 2 ID>" with Authenticator "iMedidata"
	And I should see no search results
	And I take a screenshot

Examples:
    | Entity         |
    | Study          |
    | Study Group    |

@Rave 564 Patch 13
@PB2.5.9.33-14
@Validation
Scenario: When a user accepts an invitation to a study that has elearning block and accepts to a study that has no elearning blocking. Only the invitation that is not blocked should have a message sent for it.

	Given I am a iMedidata User "<iMedidata User 1 ID>"
	And I am connected to Rave
    And there is a "<Study A>", "<Study B>"
    And I have an assignment to "<Study A>" , "<Study B>" with app "<EDC App>" with Role "<EDC Role 1>" App "<Modules App>" with Role "<Modules Role 1>"
	And I am the Study "<Study A>", "<Study B>" owner
	And Course "<Course A>" is required course for "<EDC App>" with Role "<EDC Role 1>" for "<Study A>"
	And I invite iMedidata User "<iMedidata User 2 ID>" to "<Study A>" with App "<EDC App>" with Role "<EDC Role 1>", App "<Modules Ap>" with Role "<Modules Role 1>"
	And I invite iMedidata User "<iMedidata User 2 ID>" to "<Study B>" with App "<EDC App>" with Role "<EDC Role 1>", App "<Modules App>" with Role "<Modules Role 1>"
	And the user "<iMedidata User 2 ID>" has accepted invitation to both Study "<Study A>" ,"<Study B>"
	And I navigate to Rave by following "<EDC App>" for Study "<Study A>"
	And I navigate to User Adminstration
	And I search for User "<iMedidata User 2 ID>" with Authenticator "iMedidata"
	And I should see "<EDC Role 1>" for User "<iMedidata User 2 ID>"
	And I navigate to User Details page for User "<iMedidata User 2 ID>"
	And I should see only "<Study B>" assigned to the user in Studies Pane
	And I should not see "<Study A>" in Studies Pane
	And I log out
	AAnd I log in to iMedidata as User "<iMedidata User 2 ID>"
	And I should see "<Course A>" required for access for Study "<Study A>"
	When I follow "<EDC App>" for "<Study B>"
	Then I am on Rave"<Study B>" page 
	And I take a screenshot


@Rave 564 Patch 13
@PB2.5.9.33-15
@Validation
Scenario:  When removing a course mapping unblocks user then create invitation message should be generated

    Given I am a iMedidata User "<iMedidata User 1 ID>"
	And I am connected to Rave
    And there is a "<Study A>", "<Study B>"
    And I have an assignment to "<Study A>" , "<Study B>" with app "<EDC App>" with Role "<EDC Role 1>" App "<Modules App>" with Role "<Modules Role 1>"
	And I am the Study "<Study A>", "<Study B>" owner
	And Course "<Course A>" is required course for "<EDC App>" with Role "<EDC Role 1>" for "<Study A>"
	And I invite iMedidata User "<iMedidata User 2 ID>" to "<Study A>" with App "<EDC App>" with Role "<EDC Role 1>", App "<Modules Ap>" with Role "<Modules Role 1>"
	And I invite iMedidata User "<iMedidata User 2 ID>" to "<Study B>" with App "<EDC App>" with Role "<EDC Role 1>", App "<Modules App>" with Role "<Modules Role 1>"
	And the user "<iMedidata User 2 ID>" has accepted invitation to both Study "<Study A>" ,"<Study B>"
	And I navigate to Rave by following "<EDC App>" for Study "<Study A>"
	And I navigate to User Adminstration
	And I search for User "<iMedidata User 2 ID>" with Authenticator "iMedidata"
	And I should see "<EDC Role 1>" for User "<iMedidata User 2 ID>"
	And I navigate to User Details page for User "<iMedidata User 2 ID>"
	And I should see only "<Study B>" assigned to the user in Studies Pane
	And I should not see "<Study A>" in Studies Pane
	And I log out
	AAnd I log in to iMedidata as User "<iMedidata User 2 ID>"
	And I should see "<Course A>" required for access for Study "<Study A>"
	When I follow "<EDC App>" for "<Study B>"
	Then I am on Rave "<Study B>" page 
	And I take a screenshot
	And I log out 
	And I log in as "<iMedidata User 1 ID>"
    And I navigate to  Study Users Manage page for the Study named "<Study A>"
    And I follow "eLearning"
    And I follow "Delete" for Course "<Course A>"
    And I press "OK" in the confirmation box
	And I navigate to Rave by following "<EDC App>" for Study "<Study A>"
	And I navigate to User Adminstration
	And I search for User "<iMedidata User 2 ID>" with Authenticator "iMedidata"
	And I should see "<EDC Role 1>" for User "<iMedidata User 2 ID>"
	And I navigate to User Details page for User "<iMedidata User 2 ID>"
	And I should see "<Study A>", "<Study B>" assigned to the user in Studies Pane
	And I take a screenshot
	And I log out
	And I log in to iMedidata as User "<iMedidata User 2 ID>"
	And I should see Study "<Study A>", "<Study B>"
	And I should not see "<Course A>" required for access
	And I follow "<EDC App>" for "<Study A>"
	And I am on Rave "<Study A>" page 
	And I take a screenshot 

 