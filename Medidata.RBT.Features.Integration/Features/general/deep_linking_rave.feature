# Deeplinking capability is supported, allowing a URL deep link for Rave authenticated users to a study, site, subject, eCRF page,
# site administration and reports modules.

Feature: Deep Linking
    In order to access exactly where I want to go in Rave
	As a User
	I need to be able to deep link into studies, sites, eCRFs, and other locations in Rave
	  
  	Background:

	Given I am an Rave user with first name "<Fname>" and last name "<Lname>" with pin "<PIN>" password "<Password>" and user id "<User ID/Name>"
	|Fname								|Lname								|PIN						| Password							|User ID/Name						|Email 							|
	|{First Name 1}						|{Last Name 1}						|Rave User 1 PIN}		|{Rave User 1 Password}		|{Rave User 1 ID}			|{Rave User 1 Email}		|
	|{New User ID}					    |{New User Email}				    |
	And there exists a Rave user "<Rave User>" with username <Rave User Name>" and password "<Rave Password>" with "<Email>" and "<Rave First Name>" and "<Rave Last "Nane>"
		|Rave User		|Rave User Name		|Rave Password		|Email			|Rave First Name 	|Rave Last Name 	|
		|{Rave User 1}	|{Rave User Name 1}	|{Rave Password 1}	|{Rave Email 1}	|Rave First Name 1	|Rave Last Name 1	|
	
	And there exists Rave study "<Rave Study>" 
		|{Rave Study 1}	|
	
	And there exists site "<Site>" in study "<Rave Study 1>", 		
		|Study		|Site		|
		|{Study A}	|{Site A1}	|
	And there exists subject <Subject> with eCRF page <eCRF Page>" in Site <Site>
		|Site		|Subject		|eCRF Page		|
		|{Site A1}	|{Subject 1}	|{eCRF Page 1}	|
			
	And there exist <Rave URL> with <URL Name>
		|Rave URL		|URL Name							|
		|{Rave URL 1}	|{rave564conlabtesting1.mdsol.com	|
		|{Rave URL 2}	|{rave564conlabtesting2.mdsol.com	|
		|{Rave URL 3}	|{rave564conlabtesting3.mdsol.com	|
		|{Rave URL 4}	|{rave564conlabtesting4.mdsol.com	|

	And there exists <eLearning Course> associated with Study "<Study A>"
        |{Study A}  |
    
    And There exists <eLearning Course> associated with "<Role>"
        |eLearning Course  |
        |{Course 1}      |
    
    
    
   
@Release_2013.3.0
@PB2.5.1.74-100
@IZ20.SEP.2013
@Validation  
Scenario: 2.5.1.74-100 If an Rave user with single role subsequently accesses Rave,
then the user will be taken to the page in Rave as specified in the URL.  (Deep linking support)

Examples:
  | Deep Link Type                      | Deep Link URL                                                  | Rave Target Page            | 
  | StudySite Link                      | studies/12412/yyy.zzz                                          | StudySite page              | 
  | Subject Link                        | studies/12412/yyy.zzz                                          | Subject page                | 
  | eCRF Link                           | studies/12412/yyy.zzz                                          | Subject eCRF page           | 
  | Reports Link                        | studies/12412/yyy.zzz                                          | Reports page                | 	

	Given I am an Rave User
    And I am logged in
    And my Name is "<First Name 1>" "<Last Name 1>"
	And my username is "<Rave User 1 ID>"
	And my User Group is "<Modules Role 1>"
    And there is an Rave Study named "<Study A>"
    And there is a Rave Study named "<Study A>"
	And there exists subject <Subject 1> with eCRF page <eCRF Page>" in Site <Site>
    And the Rave Study named "<Study A>" is linked to the Rave Study named "<Study A>"
    And I have an assignment to the Rave Study named "<Study A>" with Role "<EDC Role 1>"
	And I am assigned to the Audit Trail Report
	And I have StudySite ID recorded
	And I have Subject ID recorded
	And I have  CRF DP recorded
	When I pass the  URL <https://<Rave URL>/MedidataRAVE/HandleLink.aspx?page=SitePage.aspx&ID=(Previously recorded StudySite ID)>
	And I take a screenshot 1 of 10
	And I press Enter 
	Then I am on the Rave specified <StudySite> page
	And I take a screenshot 2 of 10
	And I navigate back to Rave Home page
	When I pass the  URL <https://<Rave URL> //MedidataRAVE/HandleLink.aspx?page=SubjectPage.aspx&ID=(previously recorded Subject ID)
	And I take a screenshot 3 of 10
	And I press Enter 
	Then I am on the Rave specified <Subject> page
	And I take a screenshot 4 of 10
	And I navigate back to Rave Home page
	When I pass the  URL < https://<Rave URL> //MedidataRAVE/HandleLink.aspx?page=CRFPage.aspx&DP=(Previously recorded CRF DP ID)
	And I take a screenshot 5 of 10
	And I press Enter
	Then I am on the Rave specified Subject eCRF page
	And I take a screenshot 6 of 10
	When I pass the  URL  <https://<Rave URL> //MedidataRAVE/HandleLink.aspx?page=ReportsPage.aspx
	And I take a screenshot 7 of 10
	And I press Enter 
	Then I am on the Rave specified Reports page
	And I take a screenshot 8 of 10
	When I pass the  URL   <https://<Rave URL> /MedidataRAVE/HandleLink.aspx?page=Sites.aspx>
	And I take a screenshot 9 of 10
	And I press Enter 
	Then I am on the Rave specified Site Administration page
	And I take a screenshot  10 of 10
	
	
@Release_2013.3.0
@PB2.5.1.74-101
@IZ20.SEP.2013
@Validation  
Scenario: 2.5.1.74-101 If an Rave user with single role subsequently accesses Rave,
then the user will be taken to the page in Rave as specified in the URL.  (Deep linking support)

Examples:
  | Deep Link Type                      | Deep Link URL                                                  | Rave Target Page            | 
  | StudySite Link                      | studies/12412/yyy.zzz                                          | StudySite page              | 
  | Subject Link                        | studies/12412/yyy.zzz                                          | Subject page                | 
  | eCRF Link                           | studies/12412/yyy.zzz                                          | Subject eCRF page           | 
  | Reports Link                        | studies/12412/yyy.zzz                                          | Reports page                | 	

	Given I am an Rave User
    And I am not logged in
    And my Name is "<First Name 1>" "<Last Name 1>"
	And my username is "<Rave User 1 ID>"
	And my User Group is "<Modules Role 1>"
    And there is an Rave Study named "<Study A>"
    And there is a Rave Study named "<Study A>"
	And there exists subject <Subject 1> with eCRF page <eCRF Page>" in Site <Site>
    And the Rave Study named "<Study A>" is linked to the Rave Study named "<Study A>"
    And I have an assignment to the Rave Study named "<Study A>" with Role "<EDC Role 1>"
	And I am assigned to the Audit Trail Report
	And I have StudySite ID recorded
	And I have Subject ID recorded
	And I have  CRF DP recorded
	When I pass the  URL <https://<Rave URL>/MedidataRAVE/HandleLink.aspx?page=SitePage.aspx&ID=(Previously recorded StudySite ID)>
	And I take a screenshot 1 of 15
	And I press Enter 
	Then I am on Rave Login page
	And I take a screenshot 2 of 15
	When I enter Rave user credantials 
	And press Enter
	Then I am on the Rave specified <StudySite> page
	And I take a screenshot 3 of 15
	And I log out
	When I pass the  URL <https://<Rave URL> //MedidataRAVE/HandleLink.aspx?page=SubjectPage.aspx&ID=(previously recorded Subject ID)
	And I take a screenshot 4 of 15
	And I press Enter 
	Then I am on Rave Login page
	And I take a screenshot 5 of 15
	When I enter Rave user credantials 
	And press Enter
	Then I am on the Rave specified <SubjectPage> page
	And I take a screenshot 6 of 15
	And I log out
	When I pass the  URL < https://<Rave URL> //MedidataRAVE/HandleLink.aspx?page=CRFPage.aspx&DP=(Previously recorded CRF DP ID)
	And I take a screenshot 7 of 15
	And I press Enter 
	Then I am on Rave Login page
	And I take a screenshot 8 of 15
	When I enter Rave user credantials 
	And press Enter
	Then I am on the Rave specified <CRFPage> page
	And I take a screenshot 9 of 15
	And I log out
	When I pass the  URL  <https://<Rave URL> //MedidataRAVE/HandleLink.aspx?page=ReportsPage.aspx
	And I take a screenshot 10 of 15
	And I press Enter 
	Then I am on Rave Login page
	And I take a screenshot 11 of 15
	When I enter Rave user credantials 
	And press Enter
	Then I am on the Rave specified <ReportsPage> page
	And I take a screenshot 12 of 15
	And I log out
	When I pass the  URL   <https://<Rave URL> /MedidataRAVE/HandleLink.aspx?page=Sites.aspx>
	And I take a screenshot 13 of 15
	And I press Enter 
	Then I am on Rave Login page
	And I take a screenshot 14 of 15
	When I enter Rave user credantials 
	And press Enter
	Then I am on the Rave specified <SiteAdministration> page
	And I take a screenshot 15 of 15
	And I log out
	
		
@Release_2013.3.0
@PB2.5.1.74-102
@IZ20.SEP.2013
@Validation  
Scenario: 2.5.1.74-102 If an Rave user with single role and with restrictions to see subject data, subsequently accesses Rave,
            then the user will be taken to the page in Rave as specified in the URL, but not see restricted
			subject data (fields) because of the restrictions.(Deep linking support)
				  
    Given I am an Rave defuser
    And I am logged in
    And there is an Rave Study named "<Study A>"
    And there exists subject <Subject 1> with eCRF page <eCRF Page>" in Site <Site> for Study "<Study A>"
	And there is a <Form A> that has restriced subject data to "<EDC Role 3>"
    And I take a screenshot 1 of 5
	And I have  CRF DP recorded
	And I Log out
	And there is Rave user "<First Name 1>" "<Last Name 1>"
	And my username is "<Rave User 1 ID>"
    And I logged in as user "<First Name 1>"
	And I have an assignment to the Rave Study named "<Study A>" with Role not see subject data "<EDC Role 3>"
	And I take a screenshot 2 of 5
	And I have an assignment to the Rave Study named "<Study A>" with Role "<Modules Role 1>"
	And I Log out
	When I pass the  URL <https://<Rave URL> /MedidataRAVE/HandleLink.aspx?page=CRFPage.aspx&DP=(previously recorded CRFPage ID)>
	And I take a screenshot 3 of 5
	And I press Enter
	Then I am on Rave Login page
	And I take a screenshot 4 of 5
	And I entered correct Rave user credentials
	When I press Enter
	Then I am on the Rave specified <CRF Form> page
	And restricted subject data (fields) not visible
	And I take a screenshot 5 of 5
	
	
@Release_2013.3.0
@PB2.5.1.74-103
@IZ20.SEP.2013
@Validation  
Scenario: 2.5.1.74-103 If an Rave user with single role and with restrictions to see subject data, subsequently accesses Rave,
            then the user will be taken to the page in Rave as specified in the URL, but not see restricted
			subject data because of the restrictions.(Deep linking support)
				  
    Given I am an Rave defuser
    And I am logged in
    And there is an Rave Study named "<Study A>"
    And there exists subject <Subject 1> with eCRF page <eCRF Page>" in Site <Site> for Study "<Study A>"
	And there is a <Form A> that has restriced subject data to "<EDC Role 3>"
    And I take a screenshot 1 of 4
	And I have  CRF DP recorded
	And I Log out
	And there is Rave user "<First Name 1>" "<Last Name 1>"
	And my username is "<Rave User 1 ID>"
    And I logged in as user "<First Name 1>"
	And I have an assignment to the Rave Study named "<Study A>" with Role not see subject data "<EDC Role 3>"
	And I take a screenshot 2 of 4
	And I have an assignment to the Rave Study named "<Study A>" with Role "<Modules Role 1>"
	When I pass the  URL <https://<Rave URL> /MedidataRAVE/HandleLink.aspx?page=CRFPage.aspx&DP=(previously recorded CRFPage ID)>
	And I take a screenshot 3 of 4
	And I press Enter
	Then I am on the Rave specified <CRF Form> page
	And restricted subject data (fields) not visible
	And I take a screenshot 4 of 4
	
	
	
@Release_2013.3.0
@PB2.5.1.74-104
@IZ20.SEP.2013
@Validation  
Scenario: 2.5.1.74-104 If an Rave user with single role subsequently accesses Rave,but with Rave incorrect credentials,then the user
           will not be taken to the page in Rave as specified in the URL.(Deep linking support)
	
	
	Given I am an Rave User
    And my Name is "<First Name 1>" "<Last Name 1>"
	And my username is "<Rave User 1 ID>"
    And there is an Rave Study named "<Study A>"
    And there exists subject <Subject 1> with eCRF page <eCRF Page>" in Site <Site>
    And I have an assignment to the Rave Study named "<Study A>" with Role "<EDC Role 1>"
	And I have an assignment to the Rave Study named "<Study A>" with Role "<Modules Role 1>"
	And I have StudySite ID recorded
	And I have Subject ID recorded
	And I have  CRF DP recorded
	And I am not logged in
	And I am on Rave Sign In page
	When I pass the  URL <https://<Rave URL> /MedidataRAVE/SelectRole.aspx?page=SitePage.aspx&ID=(Previously recorded StudySite ID)>
	And I take a screenshot 1 of 12
	And I press Enter 
	Then I am not on the Rave specified <StudySite> page
	And I am on Rave Login page
    And I take a screenshot 2 of 12
	When I entered incorrect credentials 
	And I press Enter 
	Then I am not on the Rave specified page
	And I see the message "You tried to log in with a username and password that is not recognized. To continue, type the correct username or password. Otherwise, click I forgot my username or password on the Login page to reset your username."
	And I take a screenshot  3 of 12
	When I entered correct Rave user credentials
	And I press Enter
	Then I am on the Rave specified <StudySite> page
	And I take a screenshot 4 of 12  
	And I am logged out of Rave
	And I am on Rave Sign In page
    And I pass the  URL <And I pass the  URL <https://<Rave URL> /MedidataRAVE/SelectRole.aspx?page=SubjectPage.aspx&ID=(previously recorded Subject ID)>
	And I take a screenshot 5 of 12
	And I press Enter 
	Then I am not on the Rave specified <Subject> page
	And I am on Rave Login page
    And I take a screenshot 6 of 12
	When I entered incorrect credentials 
	And I press Enter 
	Then I am not on the Rave specified page
	And I see the message "You tried to log in with a username and password that is not recognized. To continue, type the correct username or password. Otherwise, click I forgot my username or password on the Login page to reset your username."
	And I take a screenshot  7 of 12
	When I entered correct Rave user credentials
	And I press Enter
	And I am on the Rave specified <Subject> page
	And I take a screenshot 8 of 12
	And I am logged out of Rave
	And I am on Rave Sign In page
    And I pass the  URL <And I pass the  URL <https://<Rave URL> /MedidataRAVE//MedidataRAVE/HandleLink.aspx?page=ReportsPage.aspx
	And I take a screenshot 9 of 12
	And I press Enter 
	Then I am not on the Rave specified <Reports> page
	And I am on Rave Login page
    And I take a screenshot 10 of 12
	When I entered incorrect credentials 
	And I press Enter 
	Then I am not on the Rave specified page
	And I see the message "You tried to log in with a username and password that is not recognized. To continue, type the correct username or password. Otherwise, click I forgot my username or password on the Login page to reset your username."
	And I take a screenshot  11 of 12
	When I entered correct Rave user credentials
	And I press Enter
	And I am on the Rave specified <Reports> page
	And I take a screenshot 12 of 12
	
	
	
@Release_2013.3.0
@PB2.5.1.74-105
@IZ20.SEP.2013
@Validation  
Scenario: 2.5.1.74-105 If an Rave user with single role and with restrictions to access All Modules (No Reports),subsequently accesses Rave, 
                  then the user will not be taken to the page in Rave as specified in the URL, because of the restrictions.(Deep linking support)
				  
				  
	Given I am an Rave User
    And I am logged in
    And my Name is "<First Name 1>" "<Last Name 1>"
	And my username is "<Rave User 1 ID>"
    And my Email is "<Rave User 1 Email>"
    And there is an Rave Study named "<Study A>"
    And I have an assignment to the Rave Study named "<Study A>" with Role "<EDC Role 1>"
	And I have an assignment to the Rave Study named "<Study A>" with Role "<Modules Role 2 No Reports>"
	And I take a screenshot 1 of 4
	And I am log out
	When I pass the  URL  <https://<Rave URL> /MedidataRAVE/HandleLink.aspx?page=ReportsPage.aspx>
	And I take a screenshot 2 of 4
	And I press Enter
	Then I am on Rave Login page
	And I take a screenshot 3 of 4
	And I entered correct Rave user credentials
	When I press Enter
	Then I am not on the Rave specified Reports page
	And I see an error message
	And I take a screenshot 4 of 4

	
@Release_2013.3.0
@PB2.5.1.74-106
@IZ20.SEP.2013
@Validation  
Scenario: 2.5.1.74-106 If an Rave user with single role and with restrictions to access All Modules (No Reports),subsequently accesses Rave, 
                  then the user will not be taken to the page in Rave as specified in the URL, because of the restrictions.(Deep linking support)
				  
				  
	Given I am an Rave User
    And I am logged in
    And my Name is "<First Name 1>" "<Last Name 1>"
	And my username is "<Rave User 1 ID>"
    And my Email is "<Rave User 1 Email>"
    And there is an Rave Study named "<Study A>"
    And I have an assignment to the Rave Study named "<Study A>" with Role "<EDC Role 1>"
	And I have an assignment to the Rave Study named "<Study A>" with Role "<Modules Role 2 No Reports>"
	And I take a screenshot 1 of 3
	When I pass the  URL  <https://<Rave URL> /MedidataRAVE//MedidataRAVE/HandleLink.aspx?page=ReportsPage.aspx>
	And I take a screenshot 2 of 3
	And I press Enter
	Then I am not on the Rave specified Reports page
	And I see an error message
	And I take a screenshot 3 of 3
	
	
	
@Release_2013.3.0
@PB2.5.1.74-107
@IZ20.SEP.2013
@Validation  
Scenario: 2.5.1.74-107 If an Rave user with single role and with restrictions to access all sites,subsequently accesses Rave, 
                  then the user will not be taken to the page in Rave as specified in the URL, because of the restrictions.(Deep linking support)
				  		  
				  
	Given I am an Rave User
    And I am logged in
    And my Name is "<First Name 1>" "<Last Name 1>"
	And my username is "<Rave User 1 ID>"
    And there is a Rave Study named "<Study A>"
	And there exists subject <Subject 1> with eCRF page <eCRF Page>" in Site <Site>
	And there is a <Form 1> that has saved subject data
    And I have an assignment to the Rave Study named "<Study A>" with Role "<EDC Role 1>"
	And I have an assignment to the Rave Study named "<Study A>" with Role "<{Modules Role 3 No Sites}>"
	And I take a screenshot 1 of 3
	When I pass the  URL  "<url>"
	And I take a screenshot 2 of 3
	And I press Enter 
	Then I see an error message
	And I take a screenshot 3 of 3


	Example:

	| Rave Role |iMedidta Module Role           |Rave Condition         |Expected Result| URL  |

1.	| "<EDC Role 1>" |"<{Modules Role 3 No Sites}>"  |assigned Site               |Error           |<https://<Rave URL> /MedidataRAVE/SelectRole.aspx?page=Sites.aspx>|
2.  | "<EDC Role 4>" |"<{Modules Role 1}>"           |unassigned Site             |Error           |<https://<Rave URL> /MedidataRAVE/SelectRole.aspx?page=SitePage.aspx&ID=(Previously recorded StudySite ID)>|


@Release_2013.3.0
@PB2.5.1.74-108
@IZ20.SEP.2013
@Validation  
Scenario: 2.5.1.74-108 If an Rave user with single role and with restrictions to access all sites,subsequently accesses Rave, 
                  then the user will not be taken to the page in Rave as specified in the URL, because of the restrictions.(Deep linking support)
				  		  
				  
	Given I am an Rave User
    And I am logged in
    And my Name is "<First Name 1>" "<Last Name 1>"
	And my username is "<Rave User 1 ID>"
    And there is a Rave Study named "<Study A>"
	And there exists subject <Subject 1> with eCRF page <eCRF Page>" in Site <Site>
	And there is a <Form 1> that has saved subject data
    And I have an assignment to the Rave Study named "<Study A>" with Role "<EDC Role 1>"
	And I have an assignment to the Rave Study named "<Study A>" with Role "<{Modules Role 3 No Sites}>"
	And I take a screenshot 1 of 4
	And I am log out
	When I pass the  URL  "<url>"
	And I take a screenshot 2 of 4
	And I press Enter
	Then I am on Rave Login page
	And I take a screenshot 3 of 4
	And I entered correct Rave user credentials
	When I press Enter
	Then I see an error message
	And I take a screenshot 4 of 4


	Example:

	| Rave Role |iMedidta Module Role           |Rave Condition         |Expected Result| URL  |

1.	| "<EDC Role 1>" |"<{Modules Role 3 No Sites}>"  |assigned Site               |Error           |<https://<Rave URL> /MedidataRAVE/SelectRole.aspx?page=Sites.aspx>|
2.  | "<EDC Role 4>" |"<{Modules Role 1}>"           |unassigned Site             |Error           |<https://<Rave URL> /MedidataRAVE/SelectRole.aspx?page=SitePage.aspx&ID=(Previously recorded StudySite ID)>|



@Release_2013.3.0
@PB2.5.1.74-109
@IZ20.SEP.2013
@BUG_MCC-79931
Scenario: 2.5.1.74-109 An error message will be displayed if an Rave user attempts to navigate to an eCRF page that
                  has been restricted via deep linking (Deep linking support)


	Given I am an Rave defuser
	And I logged in 
	And I create new Project "<Study A>"
	And I create new site <Site A1> assigned to "<Study A>"
	And I create new draft <Draft 1>
	And I create restriction for a <Form 1> for "<EDC Role 2>" in Draft <Draft 1>
	And I take a screenshot 1 of 6
	And I publish and pushing
	And I naviagte to the "<Study A>"
	And I create a subject "<Subject 1>" with entered and saved data in restricted form "<eCRF Page 1>"
	And I take a screenshot 2 of 6
	And I logged out 
	And there is Rave user with username "<Rave User 1 ID>"
	And I am logged in Rave as "<Rave User 1 ID>"
	And there is Rave "<Study A>"
	And Rave "<Study A>" has linked to Rave "<Study A>"
	And I have assigment to study "<Study A>" app link "<EDC App>" with role "<EDC Role 2>"
	And I take a screenshot 3 of 6
	And I have assigment to site <Site A1>
	And I log out of Rave	as "<Rave User 1 ID>"
	When I enter "https://"<Rave URL 1>"/MedidataRAVE/HandleLink.aspx?page=CRFPage.aspx&DP=>
	And I take a screenshot 4 of 6
	And I press Enter
	Then I am on Rave Login page
	And I take a screenshot 5 of 6
	When I enter "<Rave User 1 ID>" credentials
	Then I see an error message
	And I take a screenshot 6 of 6
	
	
@Release_2013.3.0
@PB2.5.1.74-110
@IZ20.SEP.2013
@BUG_MCC-79931
Scenario: 2.5.1.74-110 An error message will be displayed if an Rave user attempts to navigate to an eCRF page that
                  has been restricted via deep linking (Deep linking support)


	Given I am an Rave defuser
	And I logged in 
	And I create new Project "<Study A>"
	And I create new site <Site A1> assigned to "<Study A>"
	And I create new draft <Draft 1>
	And I create restriction for a <Form 1> for "<EDC Role 2>" in Draft <Draft 1>
	And I take a screenshot 1 of 5
	And I publish and pushing
	And I naviagte to the "<Study A>"
	And I create a subject "<Subject 1>" with entered and saved data in restricted form "<eCRF Page 1>"
	And I take a screenshot 2 of 5
	And I logged out 
	And there is Rave user with username "<Rave User 1 ID>"
	And I am logged in Rave as "<Rave User 1 ID>"
	And there is Rave "<Study A>"
	And Rave "<Study A>" has linked to Rave "<Study A>"
	And I have assigment to study "<Study A>" app link "<EDC App>" with role "<EDC Role 2>"
	And I take a screenshot 3 of 5
	And I have assigment to site <Site A1>
	When I enter "https://"<Rave URL 1>"/MedidataRAVE/HandleLink.aspx?page=CRFPage.aspx&DP=>
	And I take a screenshot 4 of 5
	And I press Enter
	Then I see an error message
	And I take a screenshot 5 of 5
	
	
	
@Release_2013.3.0
@PB2.5.1.74-111
@IZ20.SEP.2013
@Validation  
Scenario: 2.5.1.74-111  An error message will be displayed if an Rave user with single role attempts to navigate to subject that has been
                  inactivated via deep linking (Deep linking support)

	Given I am an Rave user with username "<Rave User 1 ID>"
	And I am logged in 
	And I am  assigned only study "<Study A>" with site "<Site A1>" that has subject "<Subject 1>" with ecrf page "<eCRF Page 1>"
	And I am assigned to study "<Study A>" with role "<EDC Role 1>"
	And I am assigned to "<Study A>" with role "<Modules Role 1>"
	And I navigate to Study Dite home page
	And I select subject "<Subject 1>"
	And I note value "<Subject Number>"
	And I select link "Home"
	And I select link "Site Administration" module
	And I select site "<Site 1A>"
	And I inactivate subject "<Subject 1>"
	And I take a screenshot 1 of 4
	And I log out of Rave
	When I enter <https://<Rave URL> /MedidataRAVE/MedidataRAVE/HandleLink.aspx?page=SubjectPage.aspx&ID=(previously recorded Subject ID)>
	And I take a screenshot 2 of 4
	And I press Enter 
	Then I am on Rave Login page
	And I take a screenshot 3 of 4
	When I enter Rave user "<Rave User 1 ID>" correct credentials
	Then I see an error message
	And I take a screenshot 4 of 4
	
	
	
@Release_2013.3.0
@PB2.5.1.74-112
@IZ20.SEP.2013
@Validation  
Scenario: 2.5.1.74-112 An error message will be displayed if an Rave user with single role attempts to navigate to subject that has been
                  inactivated via deep linking (Deep linking support)

	Given I am an Rave user with username "<Rave User 1 ID>"
	And I am logged in 
	And I am  assigned only study "<Study A>" with site "<Site A1>" that has subject "<Subject 1>" with ecrf page "<eCRF Page 1>"
	And I am assigned to study "<Study A>" with role "<EDC Role 1>"
	And I am assigned to "<Study A>" with role "<Modules Role 1>"
	And I navigate to Study Dite home page
	And I select subject "<Subject 1>"
	And I note value "<Subject Number>"
	And I select link "Home"
	And I select link "Site Administration" module
	And I select site "<Site 1A>"
	And I inactivate subject "<Subject 1>"
	And I take a screenshot 1 of 3
	When I enter <https://<Rave URL> /MedidataRAVE/MedidataRAVE/HandleLink.aspx?page=SubjectPage.aspx&ID=(previously recorded Subject ID)>
	And I take a screenshot 2 of 3
	And I press Enter 
	Then I see an error message
	And I take a screenshot 3 of 3
	
	

@Release_2013.3.0
@PB2.5.1.74-113
@IZ20.SEP.2013
@Validation  
Scenario: 2.5.1.74-113 An error message will be displayed if an Rave user  with single role attempts to navigate to studySite to which is not
                  assigned via deep linking (Deep linking support)

	Given I am an Rave user with username "<Rave User 1 ID>"
	And I am logged in
	And I am  assigned only study "<Study A>" with site "<Site A1>" that has subject "<Subject 1>" with ecrf page "<eCRF Page 1>"
	And I am assigned to study "<Study A>" with role "<EDC Role 1>"
	And I take a screenshot 1 of 5
	And I am assigned to "<Study A>" with role "<Modules Role 1>"
	And I navigate to StudySite home page for study "<Study A>" and site "<Site A1>".
	And I note value "<StudySite Number>"
	And I log out of Rave
	And there is Rave user "<Rave User 2>"
	And Rave user "<Rave User 2>" is logged in to Rave
	And Rave user "<Rave User 2>" not assigned to study "<Study A>" with site "<Site A1>" that has subject "<Subject 1>"
	And Rave user "<Rave User 2>" is assigned to study "<Study B> with site "<Site B1>"
	And I take a screenshot 2 of 5
	And Rave user "<Rave User 2>" is logged out of Rave
	When I enter in the URL <https://<Rave URL> /MedidataRAVE/HandleLink.aspx?page=SitePage.aspx&ID=(Previously recorded StudySite ID)>
	And I take a screenshot 3 of 5
	And I press Enter
	Then I am on Rave Login page
	And I take a screenshot 4 of 5
	When I enter Rave user "<Rave User 2 ID>" correct credentials
	And I press enter
	Then I see an error message
	And I take a screenshot 5 of 5

	
@Release_2013.3.0
@PB2.5.1.74-114
@IZ20.SEP.2013
@Validation  
Scenario: 2.5.1.74-114 An error message will be displayed if an Rave user  with single role attempts to navigate to studySite to which is not
                  assigned via deep linking (Deep linking support)

	Given I am an Rave user with username "<Rave User 1 ID>"
	And I am logged in
	And I am  assigned only study "<Study A>" with site "<Site A1>" that has subject "<Subject 1>" with ecrf page "<eCRF Page 1>"
	And I am assigned to study "<Study A>" with role "<EDC Role 1>"
	And I take a screenshot 1 of 4
	And I am assigned to "<Study A>" with role "<Modules Role 1>"
	And I navigate to StudySite home page for study "<Study A>" and site "<Site A1>".
	And I note value "<StudySite Number>"
	And I log out of Rave
	And there is Rave user "<Rave User 2>"
	And I am logged in as Rave user "<Rave User 2>"
	And Rave user "<Rave User 2>" is logged in to Rave
	And Rave user "<Rave User 2>" not assigned to study "<Study A>" with site "<Site A1>" that has subject "<Subject 1>"
	And Rave user "<Rave User 2>" is assigned to study "<Study B> with site "<Site B1>"
	And I take a screenshot 2 of 4
	When I enter in the URL <https://<Rave URL> /MedidataRAVE/HandleLink.aspx?page=SitePage.aspx&ID=(Previously recorded StudySite ID)>
	And I take a screenshot 3 of 4
	And I press Enter
	Then I see an error message
	And I take a screenshot 4 of 4
	
	


@Release_2013.3.0
@PB2.5.1.74-115
@IZ20.SEP.2013
@Validation  
Scenario: 2.5.1.74-115 An Rave user with single role can go directly to the My Reports page in the Reports module
                        if access to the Reports module is granted.
	
	Given I am an Rave user with username "<Rave User 1 ID>"
	And I am logged in
	And I am  assigned only study "<Study A>" with site "<Site A1>" that has subject "<Subject 1>" with ecrf page "<eCRF Page 1>"
	And I am assigned to study "<Study A>" with role "<EDC Role 1>" 
	And I am assigned to "<Study A>" with role "<Modules Role 1>"
	And I take a screenshot 1 of 4
	And I log out from Rave
	When I enter in the URL Address Text Field <https://<Rave URL> /MedidataRAVE/HandleLink.aspx?page=ReportsPage.aspx>
	And I take a screenshot 2 of 4
	And I press Enter 
	Then I am on Rave Login page
	And I take a screenshot 3 of 4
	When I enter Rave user "<Rave User 1 ID>" correct credentials
	And I press enter
	Then I am on the "My Reports " page
	And I take a screenshot 4 of 4


@Release_2013.3.0
@PB2.5.1.74-116
@IZ20.SEP.2013
@Validation  
Scenario: 2.5.1.74-116 An Rave user with single role can go directly to the My Reports page in the Reports module
                        if access to the Reports module is granted.
	
	Given I am an Rave user with username "<Rave User 1 ID>"
	And I am logged in
	And I am  assigned only study "<Study A>" with site "<Site A1>" that has subject "<Subject 1>" with ecrf page "<eCRF Page 1>"
	And I am assigned to study "<Study A>" with role "<EDC Role 1>" 
	And I am assigned to "<Study A>" with role "<Modules Role 1>"
	And I take a screenshot  1 of 3
	When I enter in the URL Address Text Field <https://<Rave URL> /MedidataRAVE/HandleLink.aspx?page=ReportsPage.aspx>
	And I take a screenshot 2 of 3
	And I press Enter 
	Then I am on the "My Reports " page
	And I take a screenshot 3 of 3
	
	

	
@Release_2013.3.0
@PB2.5.1.74-117
@IZ20.SEP.2013
@Validation  
Scenario: 2.5.1.74-117 An Rave user will see an error message if the user attemps to navigate to the "My Reports "page
                        in the "Reporter" module via deep linking if the user does not have access to the Reporter module.

	Given I am an Rave user with username "<Rave User 1 ID>"
	And I am logged in
	And I am  assigned only study "<Study A>" with site "<Site A1>" that has subject "<Subject 1>" with ecrf page "<eCRF Page 1>"
	And I am assigned to study "<Study A>" with role "<EDC Role 1>"
	And I am assigned to study "<Study A>" with role "<Modules Role 2 No Reports>"
	And I take a screenshot 1 of 4
	And I log out from Rave	
	When I enter in the URL Address Text Field <https://<Rave URL> /MedidataRAVE/HandleLink.aspx?page=ReportsPage.aspx>
	And I take a screenshot  2 of 4
	And I press Enter 
	Then I am on Rave Login page
	And I take a screenshot  3 of 4
	When I enter Rave user "<Rave User 1 ID>" correct credentials
	Then I see an error message
	And I take a screenshot	 4 of 4
	
	
@Release_2013.3.0
@PB2.5.1.74-118
@IZ20.SEP.2013
@Validation  
Scenario: 2.5.1.74-118 An Rave user will see an error message if the user attemps to navigate to the "My Reports "page
                        in the "Reporter" module via deep linking if the user does not have access to the Reporter module.

	Given I am an Rave user with username "<Rave User 1 ID>"
	And I am logged in
	And I am  assigned only study "<Study A>" with site "<Site A1>" that has subject "<Subject 1>" with ecrf page "<eCRF Page 1>"
	And I am assigned to study "<Study A>" with role "<EDC Role 1>"
	And I am assigned to study "<Study A>" with role "<Modules Role 2 No Reports>"
	And I take a screenshot 1 of 3
	When I enter in the URL Address Text Field <https://<Rave URL> /MedidataRAVE/HandleLink.aspx?page=ReportsPage.aspx>
	And I take a screenshot  2 of 3
	And I press Enter 
	Then I see an error message
	And I take a screenshot	3 of 3
	
	
	

@Release_2013.3.0
@PB2.5.1.74-119
@IZ20.SEP.2013
@Validation  
Scenario: 2.5.1.74-119 An Rave user with single role can go directly to the Site Administration Page if access is granted 
	
	Given I am an Rave user with username "<Rave User 1 ID>"
	And I am assigned to study "<Study A>" with role "<EDC Role 1>"
	And I am assigned to study "<Study A>" with role "<Modules Role 1>"
	And I take a screenshot 1 of 4
	And I log out from Rave		
	When I pass the  URL   <https://<Rave URL> /MedidataRAVE/HandleLink.aspx?page=Sites.aspx
	And I take a screenshot  2 of 4
	And I press Enter 
	Then I am on Rave Login page
	And I take a screenshot 3 of 4
	When I enter Rave user "<Rave User 1 ID>" correct credentials
	Then I am in the "Site Administration" page
	And I take a screenshot 4 of 4
	
@Release_2013.3.0
@PB2.5.1.74-120
@IZ20.SEP.2013
@Validation  
Scenario: 2.5.1.74-120 An Rave user with single role can go directly to the Site Administration Page if access is granted 
	
	Given I am an Rave user with username "<Rave User 1 ID>"
	And I am logged in
	And I am assigned to study "<Study A>" with role "<EDC Role 1>"
	And I am assigned to study "<Study A>" with role "<Modules Role 1>"
	And I take a screenshot 1 of 3
	When I pass the  URL   <https://<Rave URL> /MedidataRAVE/HandleLink.aspx?page=Sites.aspx
	And I take a screenshot 2 of 3
	And I press Enter 
	Then I am in the "Site Administration" page
	And I take a screenshot 3 of 3

	
	
	
@Release_2013.3.0
@PB2.5.1.74-121
@IZ20.SEP.2013
@Validation  
Scenario: 2.5.1.74-121 An Rave user will see an error message if the user attemps to navigate to the "Site Administration page  via deep linking
                       if the user does not have access to the Site Administration module.

	Given I am an Rave user with username "<Rave User 1 ID>"
	And I am logged in
	And I am assigned to study "<Study A>" with role "<EDC Role 1>"
	And I am assigned to study "<Study A>" with role "<Modules Role 2 No Sites>"
	And I take a screenshot	1 of 4	
	And I log out from Rave		
	When I pass the  URL   <https://<Rave URL> /MedidataRAVE/HandleLink.aspx?page=Sites.aspx
	And I take a screenshot 2 of 4
	And I press Enter 
	Then I am on Rave Login page
	And I take a screenshot 3 of 4
	When I enter Rave user "<Rave User 1 ID>" correct credentials
	Then I see an error message
	And I take a screenshot 4 of 4
	
@Release_2013.3.0
@PB2.5.1.74-122
@IZ20.SEP.2013
@Validation  
Scenario: 2.5.1.74-122 An Rave user will see an error message if the user attemps to navigate to the "Site Administration page  via deep linking
                       if the user does not have access to the Site Administration module.

	Given I am an Rave user with username "<Rave User 1 ID>"
	And I am logged in
	And I am assigned to study "<Study A>" with role "<EDC Role 1>"
	And I am assigned to study "<Study A>" with role "<Modules Role 2 No Sites>"
	And I take a screenshot	1 of 3	 
	When I pass the  URL   <https://<Rave URL> /MedidataRAVE/HandleLink.aspx?page=Sites.aspx
	And I take a screenshot  2 of 3
	And I press Enter 
	Then I see an error message
	And I take a screenshot 3 of 3
	

@Release_2013.3.0
@PB2.5.1.74-123
@IZ20.SEP.2013
@Validation  
Scenario: 2.5.1.74-123  As Internal Rave user that is logged in, I am assigned to eLearning course for a particular edc role which has a status of Completed. When
                        deep link URL, the eLearning course is not required and status should show as "Completed" for that particular assigned role in Rave 

   Given I am an Rave "<Rave User Name 1>" user
   And I am logged in to Rave 
   And a new Rave Study "<Study A>" is created
   And new Rave "<New Site A1>" is created with site name and number "<Unique number1>"
   And I am assigned to study "<Study A>" with  "<New Site A1>" with role "<EDC Role 1>"
   And there is subject "<Subject 1>" with ecrf page "<eCRF Page 1>" 
   And I have assigned Security Role "<Security Role 1>" to Study "<Study A>"
   And I have assigned an eLearning Course "<Course 1>" on Study Role Assignments to "<Study A>" for EDC Role "<EDC Role 1>"
   And I navigate to "User Administration" Module
   And I search for user "<Rave User Name 1>"
   And I go to the User Details page for user "<Rave User Name 1>"
   And I see course status as "Not Started" under eLearning section on User Details page
   And I take a screenshot 1 of 5
   And I select "Home" icon
   And I see the "eLearning Home" page
   And I take a screenshot 2 of 5
   And I select "Start" button to start the eLearning Course "<Course 1>"
   And I have completed and passed the eLearning Course "<Course 1>"
   And I navigate to "User Administration" Module
   And I search for Rave user "<Rave User 1>"
   And I go to the User Details page for user "<Rave User 1>"
   And I see elearning Course status as "Completed" under eLearning section on User Details page 
   And I take a screenshot 3 of 5
   And I select link "Home"
   And I do not see the "eLearning Home" page
   And I see the site "<New Site A1>" home page for "<Study A>"
   When I pass the  URL   <https://<Rave URL> /MedidataRAVE/HandleLink.aspx?page=Sites.aspx
   And I take a screenshot 4 of 5
   And I press Enter 
   Then I see the Site Administration module
   And I take a screenshot 5 of 5
   
@Release_2013.3.0
@PB2.5.1.74-124
@IZ20.SEP.2013
@Validation  
Scenario: 2.5.1.74-124   As Internal Rave user that is not logged in,I am assigned to eLearning course for a particular edc role which has a status of Completed. When
                         deep link URL, the eLearning course is not required and status should show as "Completed" for that particular assigned role in Rave 
			 
			 
   Given I am an Rave "<Rave User Name 1>" user
   And I am logged in to Rave 
   And a new Rave Study "<Study A>" is created
   And new Rave "<New Site A1>" is created with site name and number "<Unique number1>"
   And I am assigned to study "<Study A>" with  "<New Site A1>" with role "<EDC Role 1>"
   And there is subject "<Subject 1>" with ecrf page "<eCRF Page 1>" 
   And I have assigned Security Role "<Security Role 1>" to Study "<Study A>"
   And I have assigned an eLearning Course "<Course 1>" on Study Role Assignments to "<Study A>" for EDC Role "<EDC Role 1>"
   And I navigate to "User Administration" Module
   And I search for user "<Rave User Name 1>"
   And I go to the User Details page for user "<Rave User Name 1>"
   And I see course status as "Not Started" under eLearning section on User Details page
   And I take a screenshot 1 of 6
   And I select "Home" icon
   And I see the "eLearning Home" page
   And I take a screenshot 2 of 6
   And I select "Start" button to start the eLearning Course "<Course 1>"
   And I have completed and passed the eLearning Course "<Course 1>"
   And I navigate to "User Administration" Module
   And I search for Rave user "<Rave User 1>"
   And I go to the User Details page for user "<Rave User 1>"
   And I see elearning Course status as "Completed" under eLearning section on User Details page 
   And I take a screenshot 3 of 6
   And I select link "Home"
   And I do not see the "eLearning Home" page
   And I see the site "<New Site A1>" home page for "<Study A>"
   And I am log out
   When I pass the  URL   <https://<Rave URL> /MedidataRAVE/HandleLink.aspx?page=Sites.aspx
   And I take a screenshot  4 of 6
   And I press Enter 
   Then I am on Rave Login page
   And I take a screenshot 5 of 6
   When I enter Rave user "<Rave User 1 ID>" correct credentials
   Then I see the Site Administration module
   And I take a screenshot 6 of 6
   
   
@Release_2013.3.0
@PB2.5.1.74-125
@IZ20.SEP.2013
@Validation  
Scenario: 2.5.1.74-125 As Internal Rave user that is logged in, I am assigned to eLearning course for a particular edc role which has a status of Incomplete. When
              deep link URL, the eLearning course is still required and status should show as "Incomplete" for that particular assigned role in Rave 
			 
   Given I am an Rave "<Rave User Name 1>" user
   And I am logged in to Rave 
   And a new Rave Study "<Study A>" is created
   And new Rave "<New Site A1>" is created with site name and number "<Unique number1>"
   And I am assigned to study "<Study A>" with  "<New Site A1>" with role "<EDC Role 1>"
   And there is subject "<Subject 1>" with ecrf page "<eCRF Page 1>"
   And I note "<eCRF Page 1>" data page ID
   And I take a screenshot 1 of 7
   And I have assigned Security Role "<Security Role 1>" to Study "<Study A>"
   And I have assigned an eLearning Course "<Course 1>" on Study Role Assignments to "<Study A>" for EDC Role "<EDC Role 1>"
   And I navigate to "User Administration" Module
   And I search for user "<Rave User Name 1>"
   And I go to the User Details page for user "<Rave User Name 1>"
   And I see course status as "Not Started" under eLearning section on User Details page
   And I take a screenshot 2 of 7
   And I select "Home" icon
   And I see the "eLearning Home" page
   And I take a screenshot 3 of 7
   And I select "Start" button to start the eLearning Course "<Course 1>"
   And I have not completed and passed the eLearning Course "<Course 1>"
   And I navigate to "User Administration" Module
   And I search for Rave user "<Rave User 1>"
   And I go to the User Details page for user "<Rave User 1>"
   And I see elearning Course status as ""Incomplete" under eLearning section on User Details page 
   And I take a screenshot 4 of 7
   And I select link "Home"
   And I see the "eLearning Home" page with eLearning Course Status "Incomplete"
   And I take a screenshot 5 of 7
   When I pass the  URL   <https://<Rave URL> /MedidataRAVE/HandleLink.aspx?page=CRFPage.aspx&DP=("<eCRF Page 1>" data page ID)>
   And I take a screenshot  6 of 7
   And I press Enter 
   Then I do not see the "<eCRF Page 1>" data page
   And I see the "eLearning Home" page with eLearning Course Status "Incomplete"
   And I take a screenshot 7 of 7
   
@Release_2013.3.0
@PB2.5.1.74-126
@IZ20.SEP.2013
@Validation  
Scenario: 2.5.1.74-126 As Internal Rave user that is not logged in, I am assigned to eLearning course for a particular edc role which has a status of Incomplete.When
             deep link URL, the eLearning course is still required and status should show as "Incomplete" for that particular assigned role in Rave 
			 
   Given I am an Rave "<Rave User Name 1>" user
   And I am logged in to Rave 
   And a new Rave Study "<Study A>" is created
   And new Rave "<New Site A1>" is created with site name and number "<Unique number1>"
   And I am assigned to study "<Study A>" with  "<New Site A1>" with role "<EDC Role 1>"
   And there is subject "<Subject 1>" with ecrf page "<eCRF Page 1>"
   And I note "<eCRF Page 1>" data page ID
   And I have assigned Security Role "<Security Role 1>" to Study "<Study A>"
   And I have assigned an eLearning Course "<Course 1>" on Study Role Assignments to "<Study A>" for EDC Role "<EDC Role 1>"
   And I navigate to "User Administration" Module
   And I search for user "<Rave User Name 1>"
   And I go to the User Details page for user "<Rave User Name 1>"
   And I see course status as "Not Started" under eLearning section on User Details page
   And I take a screenshot 1 of 7
   And I select "Home" icon
   And I see the "eLearning Home" page
   And I take a screenshot 2 of 7
   And I select "Start" button to start the eLearning Course "<Course 1>"
   And I have not completed and passed the eLearning Course "<Course 1>"
   And I navigate to "User Administration" Module
   And I search for Rave user "<Rave User 1>"
   And I go to the User Details page for user "<Rave User 1>"
   And I see elearning Course status as ""Incomplete" under eLearning section on User Details page 
   And I take a screenshot 3 of 7
   And I select link "Home"
   And I see the "eLearning Home" page with eLearning Course Status "Incomplete"
   And I take a screenshot 4 of 7
   And I am log out
   When I pass the  URL   <https://<Rave URL> /MedidataRAVE/HandleLink.aspx?page=CRFPage.aspx&DP=("<eCRF Page 1>" data page ID)>
   And I take a screenshot 5 of 7
   And I press Enter 
   Then I am on Rave Login page
   And I take a screenshot 6 of 7
   When I enter Rave user "<Rave User 1 ID>" correct credentials
   Then I do not see the "<eCRF Page 1>" data page
   And I see the "eLearning Home" page with eLearning Course Status "Incomplete"
   And I take a screenshot 7 of 7
   
   
   
@Release_2013.3.0
@PB2.5.1.74-127
@IZ20.SEP.2013
@Validation  
Scenario: 2.5.1.74-127   As Internal Rave user that is not logged in, I am assigned to eLearning course for a particular edc role which has a status of Incomplete. When
             deep link URL, the eLearning course is still required and status should show as "Incomplete" for that particular assigned role
			 in Rave and eLearning course not required for the second role,user should be able to access Rave with the second role.
   
   Given I am an Rave defuser user
   And I am logged in to Rave 
   And a new Rave Study "<Study A>" is created
   And new Rave "<New Site A1>" is created with site name and number "<Unique number1>"
   And there are two Rave users "<Rave User Name 1>" and "<Rave User Name 2>"
   And there is subject "<Subject 1>" with ecrf page "<eCRF Page 1>"
   And I note "<eCRF Page 1>" data page ID
   And I have assigned user "<Rave User Name 1>" to study "<Study A>" with role "<EDC Role 1>"
   And I take a screenshot 1 of 13
   And I have assigned user "<Rave User Name 2>" to study "<Study A>" with role "<EDC Role 2>"
   And I take a screenshot 2 of 13
   And I have assigned an eLearning Course "<Course 1>" on Study Role Assignments to "<Study A>" for EDC Role "<EDC Role 1>"
   And I navigate to "User Administration" Module
   And I search for user "<Rave User Name 1>"
   And I go to the User Details page for user "<Rave User Name 1>"
   And I see course status as "Not Started" under eLearning section on User Details page
   And I take a screenshot 3 of 13
   And I navigate to "User Administration" Module
   And I search for user "<Rave User Name 2>"
   And I go to the User Details page for user "<Rave User Name 2>"
   And I do not see eLearning course status as "Not Started" under eLearning section on User Details page
   And I take a screenshot 4 of 13
   And I select "Home" icon
   And I am log out
   And I login as "<Rave User Name 1>"
   And I see the "eLearning Home" page
   And I take a screenshot 5 of 13
   And I select "Start" button to start the eLearning Course "<Course 1>"
   And I have not completed and passed the eLearning Course "<Course 1>"
   And I navigate to "User Administration" Module
   And I search for Rave user "<Rave User Name 1>"
   And I go to the User Details page for user "<Rave User Name 1>"
   And I see elearning Course status as ""Incomplete" under eLearning section on User Details page 
   And I take a screenshot 6 of 13
   And I select link "Home"
   And I see the "eLearning Home" page with eLearning Course Status "Incomplete"
   And I take a screenshot 7 of 13
   And I am log out as "<Rave User Name 1>"
   When I pass the  URL   <https://<Rave URL> /MedidataRAVE/HandleLink.aspx?page=CRFPage.aspx&DP=("<eCRF Page 1>" data page ID)>
   And I take a screenshot 8 of 13
   And I press Enter 
   Then I am on Rave Login page
   And I take a screenshot 9 of 13
   When I enter Rave user "<Rave User 1 ID>" correct credentials
   Then I do not see the "<eCRF Page 1>" data page
   And I see the "eLearning Home" page with eLearning Course Status "Incomplete"
   And I take a screenshot 10 of 13
   And I am log out
   When I pass the  URL   <https://<Rave URL> /MedidataRAVE/HandleLink.aspx?page=CRFPage.aspx&DP=("<eCRF Page 1>" data page ID)>
   And I take a screenshot 11 of 13
   And I press Enter 
   Then I am on Rave Login page
   And I take a screenshot 12 of 13
   When I enter Rave user "<Rave User 2 ID>" correct credentials
   Then I see the "<eCRF Page 1>" data page
   And I do not see the "eLearning Home" page with eLearning Course Status "Incomplete"
   And I take a screenshot 13 of 13
   
@Release_2013.3.0
@PB2.5.1.74-128
@IZ20.SEP.2013
@Validation  
Scenario: 2.5.1.74-128 As Internal Rave user that is logged in, I am assigned to eLearning course for a particular edc role which has a status of Incomplete.When
             deep link URL, the eLearning course is still required and status should show as "Incomplete" for that particular
			 assigned role in Rave and eLearning course not required for the second role,user should be able to access Rave with the second role.
          
   
   Given I am an Rave defuser user
   And I am logged in to Rave 
   And a new Rave Study "<Study A>" is created
   And new Rave "<New Site A1>" is created with site name and number "<Unique number1>"
   And there are two Rave users "<Rave User Name 1>" and "<Rave User Name 2>"
   And there is subject "<Subject 1>" with ecrf page "<eCRF Page 1>"
   And I note "<eCRF Page 1>" data page ID
   And I have assigned user "<Rave User Name 1>" to study "<Study A>" with role "<EDC Role 1>"
   And I take a screenshot 1 of 11
   And I have assigned user "<Rave User Name 2>" to study "<Study A>" with role "<EDC Role 2>"
   And I take a screenshot 2  of 11
   And I have assigned an eLearning Course "<Course 1>" on Study Role Assignments to "<Study A>" for EDC Role "<EDC Role 1>"
   And I navigate to "User Administration" Module
   And I search for user "<Rave User Name 1>"
   And I go to the User Details page for user "<Rave User Name 1>"
   And I see course status as "Not Started" under eLearning section on User Details page
   And I take a screenshot 3 of 11
   And I navigate to "User Administration" Module
   And I search for user "<Rave User Name 2>"
   And I go to the User Details page for user "<Rave User Name 2>"
   And I do not see eLearning course status as "Not Started" under eLearning section on User Details page
   And I take a screenshot 4 of 11
   And I select "Home" icon
   And I am log out
   And I login as "<Rave User Name 1>"
   And I see the "eLearning Home" page
   And I take a screenshot 5 of 11
   And I select "Start" button to start the eLearning Course "<Course 1>"
   And I have not completed and passed the eLearning Course "<Course 1>"
   And I navigate to "User Administration" Module
   And I search for Rave user "<Rave User Name 1>"
   And I go to the User Details page for user "<Rave User Name 1>"
   And I see elearning Course status as ""Incomplete" under eLearning section on User Details page 
   And I take a screenshot 6 of 11
   And I select link "Home"
   And I see the "eLearning Home" page with eLearning Course Status "Incomplete"
   And I take a screenshot 7 of 11
   When I pass the  URL   <https://<Rave URL> /MedidataRAVE/HandleLink.aspx?page=CRFPage.aspx&DP=("<eCRF Page 1>" data page ID)>
   And I take a screenshot  8 of 11
   And I press Enter 
   Then I do not see the "<eCRF Page 1>" data page
   And I see the "eLearning Home" page with eLearning Course Status "Incomplete"
   And I take a screenshot 9 of 11
   And I am log out
   And I login as "<Rave User 2 ID>"
   When I pass the  URL   <https://<Rave URL> /MedidataRAVE/HandleLink.aspx?page=CRFPage.aspx&DP=("<eCRF Page 1>" data page ID)>
   And I take a screenshot 10 of 11
   And I press Enter 
   Then I see the "<eCRF Page 1>" data page
   And I do not see the "eLearning Home" page with eLearning Course Status "Incomplete"
   And I take a screenshot 11  of 11
   
   
  
   
@Release_2013.3.0
@PB2.5.1.74-129
@IZ20.SEP.2013
@Validation  
Scenario: 2.5.1.74-129 As Internal Rave user that is logged in, I am assigned to eLearning course for a particular edc role which has a status of Not Started.When
             deep link URL, the eLearning course is still required and status should show as "Not Started" for that particular assigned role in Rave 
			 
   Given I am an Rave "<Rave User Name 1>" user
   And I am logged in to Rave 
   And a new Rave Study "<Study A>" is created
   And new Rave "<New Site A1>" is created with site name and number "<Unique number1>"
   And I am assigned to study "<Study A>" with  "<New Site A1>" with role "<EDC Role 1>"
   And there is subject "<Subject 1>" with ecrf page "<eCRF Page 1>"
   And I note "<eCRF Page 1>" data page ID
   And I take a screenshot 1 of 7
   And I have assigned Security Role "<Security Role 1>" to Study "<Study A>"
   And I have assigned an eLearning Course "<Course 1>" on Study Role Assignments to "<Study A>" for EDC Role "<EDC Role 1>"
   And I navigate to "User Administration" Module
   And I search for user "<Rave User Name 1>"
   And I go to the User Details page for user "<Rave User Name 1>"
   And I see course status as "Not Started" under eLearning section on User Details page
   And I take a screenshot 2 of 7
   And I select "Home" icon
   And I see the "eLearning Home" page
   And I take a screenshot 3 of 7
   And I navigate to "User Administration" Module
   And I search for Rave user "<Rave User 1>"
   And I go to the User Details page for user "<Rave User 1>"
   And I see elearning Course status as "Not Started" under eLearning section on User Details page 
   And I take a screenshot 4 of 7
   And I select link "Home"
   And I see the "eLearning Home" page with eLearning Course Status "Not Started"
   And I take a screenshot 5 of 7
   When I pass the  URL   <https://<Rave URL> /MedidataRAVE/MedidataRAVE/HandleLink.aspx?page=SitePage.aspx&ID=>
   And I take a screenshot  6  of 7
   And I press Enter 
   Then I do not see the "<StudySite>" page
   And I see the "eLearning Home" page with eLearning Course Status "Not Started"
   And I take a screenshot 7 of 7
   
@Release_2013.3.0
@PB2.5.1.74-130
@IZ20.SEP.2013
@Validation  
Scenario: 2.5.1.74-130 As Internal Rave user that is not logged in,I am assigned to eLearning course for a particular edc role which has a status of Not Started.When 
             deep link URL, the eLearning course is still required and status should show as "Not Started" for that particular assigned role in Rave 
			 
   Given I am an Rave "<Rave User Name 1>" user
   And I am logged in to Rave 
   And a new Rave Study "<Study A>" is created
   And new Rave "<New Site A1>" is created with site name and number "<Unique number1>"
   And I am assigned to study "<Study A>" with  "<New Site A1>" with role "<EDC Role 1>"
   And there is subject "<Subject 1>" with ecrf page "<eCRF Page 1>"
   And I note "<eCRF Page 1>" data page ID
   And I take a screenshot 1 of 8
   And I have assigned Security Role "<Security Role 1>" to Study "<Study A>"
   And I have assigned an eLearning Course "<Course 1>" on Study Role Assignments to "<Study A>" for EDC Role "<EDC Role 1>"
   And I navigate to "User Administration" Module
   And I search for user "<Rave User Name 1>"
   And I go to the User Details page for user "<Rave User Name 1>"
   And I see course status as "Not Started" under eLearning section on User Details page
   And I take a screenshot 2 of 8
   And I select "Home" icon
   And I see the "eLearning Home" page
   And I take a screenshot 3 of 8
   And I navigate to "User Administration" Module
   And I search for Rave user "<Rave User 1>"
   And I go to the User Details page for user "<Rave User 1>"
   And I see elearning Course status as "Not Started" under eLearning section on User Details page 
   And I take a screenshot 4 of 8
   And I select link "Home"
   And I see the "eLearning Home" page with eLearning Course Status "Not Started"
   And I take a screenshot 5 of 8
   And I am log out
   When I pass the  URL   <https://<Rave URL> /MedidataRAVE/MedidataRAVE/HandleLink.aspx?page=SitePage.aspx&ID=>
   And I take a screenshot  6 of 8
   And I press Enter 
   Then I am on Rave Login page
   And I take a screenshot 7 of 8
   When I enter Rave user "<Rave User 1 ID>" correct credentials
   Then I do not see the "<eCRF Page 1>" data page
   And I see the "eLearning Home" page with eLearning Course Status "Not Started"
   And I take a screenshot 8 of 8

