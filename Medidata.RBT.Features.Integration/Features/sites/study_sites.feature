# StudySites are the relationship between the Site and the Study.  Users are assigned to StudySites directly, not Sites, to represent work within a Study.

Feature: Rave Integration for StudySites
    In order to create and use studysites in Rave
    As a User
    I want to have my studysites created and synchronized between Rave and iMedidata
	
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
	And there exists site "<Site>" in study "<Study>", 	in iMedidata	
	|Study		|Site		|
	|{Study A}	|{Site A1}	|
	And there exists app "<App>" associated with study in iMedidata
		|App			|
		|{EDC App}		|
		|{Modules App}	|
		|{Security App}	|
	And there exists role "<Role>" in app "<App>", 		
		|App			|Role												|
		|{EDC App}		|{EDC Role 1}										|
		|{EDC App}		|{EDC Role 2}										|
		|{EDC App}		|{EDC Role Data Manager}						    |
		|{EDC App}		|{EDC Role CRA create sub cannot view all sites}	|
		|{EDC App}		|{EDC Role RM Monitor}								|
		|{Modules App}	|{Modules Role 1}									|
		|{Modules App}	|{Modules Role 2 No Reports}						|
		|{Modules App}	|{Modules Role 3 No Sites}	
		|{Modules App}  |{Modules Role 4 All Sites}                         |
		|{Security App}	|{Security Role 1}									|		
	And there exist "<Rave URL>" with "<URL Name>"
		|Rave URL		|URL Name							|
		|{Rave URL 1}	|{rave564conlabtesting1.mdsol.com	|
		
@Rave 564 Patch 13
@PB2.7.5.13-03
@Validation
Scenario: When I create a Study site in iMedidata, a study site is created in Rave if no study site exists for that study and site
           and the study is connected to iMedidata.

    Given I am an iMedidata user
	And I am logged in to iMedidata
    And my Username is "<iMedidata User 1 ID>" in iMedidata
    And I am connected to Rave
    And there is an iMedidata Study named "<Study A>"
	And there is a Rave Study named "<Study A>"
	And there exists no Site "<Site A1>" for "<Study A>" in Rave
	And I am the owner of the Study "<Study A>" in iMedidata
    And the iMedidata Study named "<Study A>" is connected to the Rave Study named "<Study A>"
    And I have an assignment to the iMedidata Study named "<Study A>" for the App named "<EDC App>" and the Role "<EDC Role 1>"
    And I have an assignment to the iMedidata Study named "<Study A>" for the App named "<Modules App>" and the Role "<Modules Role 1>"
	When I create a Site "<Site A1>" with  Site Number "12334" Study Site Number "1234" for Study "<Study A>" in iMedidata
	And I navigate to iMedidata home page
	And I follow "<EDC App>" for Study "<Study A>"
	Then I should be in Rave
	And I navigate to Site Adminstration page
	And I search for Study "<Study A>"
	And I navigate to Site Details page for "<Site A1>""
	And I should see Site "<Site A1>" with  Site Number "12334" Study Site Number "1234"in Study Sites pane
	And I should see Source:iMedidata 
	And I take a Screenshot

@Rave 564 Patch 13
@PB2.7.5.13-31
@Validation
Scenario: When I create a Study site in iMedidata, a study site in Rave is linked to iMedidata if one exists for that study and site with same Site Number and the study is connected to iMedidata.
   
Given I am an iMedidata User
And I am logged in to iMedidata
And my Username is "<iMedidata User 1 ID>" in iMedidata
And I am connected to Rave
And there is an iMedidata Study named "<Study A>"
And there is a Rave Study named "<Study A>"
And there is a Rave Site named "<Site A1>" with Site Number "123232" for "<Study A>"
And I am the owner of the Study "<Study A>" in iMedidata
And the iMedidata Study named "<Study A>" is connected to the Rave Study named "<Study A>"
And I have an assignment to the iMedidata Study named "<Study A>" for the App named "<EDC App>" and the Role "<EDC Role 1>"
And I have an assignment to the iMedidata Study named "<Study A>" for the App named "<Modules App>" and the Role "<Modules Role 1>"
When I create a Site "<Site A1>" with Study Site Number "1234" Site Number "123232" for Study "<Study A>" in iMedidata
And I navigate to iMedidata home page
And I follow "<EDC App>" for Study "<Study A>"
Then I should see Site "<Site A1>" page
And I take a Screenshot
And I navigate to Site Adminstration 
And I search for Study "<Study A>"
And I navigate to Site Details page for "<Site A1>"
And I should see "<Study A>" with Study Site Number "1234" in Study Sites pane
And I should see Source "iMedidata"
And I take a Screenshot

@Rave 564 Patch 13
@PB2.7.5.13-30
@Validation
Scenario: When I update a Study site in iMedidata, the linked study site is updated in Rave if the study is connected to iMedidata.  The only attribute updated is the study-site number in Rave Study Sites Pane.
     
Given I am an iMedidata User
And I am logged in to iMedidata
And my Username is "<iMedidata User 1 ID>" in iMedidata
And I am connected to Rave
And there is an iMedidata Study named "<Study A>"
And there is a Rave Study named "<Study A>"
And there is a Rave Site named "<Site A1>" with Site Number "329843432" for "<Study A>"
And I am the owner of the Study "<Study A>" in iMedidata
And the iMedidata Study named "<Study A>" is connected to the Rave Study named "<Study A>"
And the iMedidata Site named "<Site A1>" is connected to the Rave Site named "<Site A1>"
And I have an assignment to the iMedidata Study named "<Study A>" for the App named "<EDC App>" and the Role "<EDC Role 1>"
And I have an assignment to the iMedidata Study named "<Study A>" for the App named "<Modules App>" and the Role "<Modules Role 1>"
And I navigate to Manage Study-Site page for Site "<Site A1>"
And I update the Study-Site Number to "9898"
And I save
And I follow "<EDC App>" for Study "<Study A>"
And I should see Site "<Site A1>" page
And I navigate to Site Adminstration 
And I search for Study "<Study A>"
When I navigate to Site Details page for "<Site A1>"
Then I should see "<Study A>" with Study Site Number "9898" in Study Sites pane
And I should see Source "iMedidata"
And I take a Screenshot


@Rave 564 Patch 13
@PB2.5.9.36-01
@Validation
Scenario: Study-site information, specifically the Rave study site Number, is synchronized with the iMedidata study site Number for an iMedidata-managed study and site.  The Rave study site Number is not editable and Remove Icon is not available if the study site is managed from iMedidata.

Given I am an iMedidata User
And I am logged in to iMedidata
And my Username is "<iMedidata User 1 ID>" in iMedidata
And I am connected to Rave
And there is an iMedidata Study named "<Study A>"
And there is a Rave Study named "<Study A>"
And there is a Rave Site named "<Site A1>" with Site Number "329843432" for "<Study A>"
And I am the owner of the Study "<Study A>" in iMedidata
And the iMedidata Study named "<Study A>" is connected to the Rave Study named "<Study A>"
And the iMedidata managed Site "<Site A1>" with Site Number "329843432" is connected to the Rave Site named "<Site A1>"
And I have an assignment to the iMedidata Study named "<Study A>" for the App named "<EDC App>" and the Role "<EDC Role 1>"
And I have an assignment to the iMedidata Study named "<Study A>" for the App named "<Modules App>" and the Role "<Modules Role 1>"
And I follow app "<EDC App>" for Study "<Study A>"
And I see Site "<Site A1>" home page in Rave
And I navigate to Site Adminstration 
When I navigate to Site Details page for Site "<Site A1>"
Then I should see the following are not editable
|SiteName|SiteNumber|Address Line 1|Address Line 2|Address Line 3|City|State|Postal Code|Country|Telephone|Facsimile|
And I should see Rave Study Site Number is not editable in Study Sites Pane
And I should see Remove Icon "X" is not available
And I should see Source is iMedidata
And I take a Screenshot

@Rave 564 Patch 13
@PB2.5.9.37-01
@Validation
Scenario: If I have a linked site in iMedidata, and I delete a studysite in iMedidata that is linked to that site, when Rave receives the updated studysite, it will remove the studysite assignment in Rave.
   
Given I am an iMedidata User
And I am logged in to iMedidata
And my Username is "<iMedidata User 1 ID>" in iMedidata
And I am connected to Rave
And there is an iMedidata Study named "<Study A>"
And there is a Rave Study named "<Study A>"
And there is a Rave Site named "<Site A1>" with Site Number "329843432" for "<Study A>"
And I am the owner of the Study "<Study A>" in iMedidata
And I am the owner of the Site "<Site A1>" with Site Number "329843432" for Study "<Study A>" in iMedidata
And the iMedidata Study named "<Study A>" is connected to the Rave Study named "<Study A>"
And the iMedidata managed Site "<Site A1>" is connected to the Rave Site named "<Site A1>"
And I have an assignment to the iMedidata Study named "<Study A>" for the App named "<EDC App>" and the Role "<EDC Role 1>"
And I have an assignment to the iMedidata Study named "<Study A>" for the App named "<Modules App>" and the Role "<Modules Role 1>"
And I follow app "<EDC App>" for Study "<Study A>"
And I am on Site "<Site A1>" home page in Rave
And I navigate to Site Adminstration
And I navigate to Site Details page for Site "<Site A1>" 
And I should see Study "<Study A>" is listed in Study Sites pane
And I follow iMedidata link
And I navigate to Sites in Manage Study: "<Study A>" page
And I follow remove for Site "<Site A1>"
And I follow app "<EDC App>" for Study "<Study A>"
And I navigate to Site Adminstration
When I navigate to Site Details page for Site "<Site A1>" 
Then I should see Study "<Study A>" is not listed in the Study Sites pane
And I should see Source is "iMedidata"
And I take a Screenshot
    
@Rave 564 Patch 13
@PB2.5.9.38-01
@Validation
Scenario:  When a Site is added back to a Study in iMedidata, the studysite in Rave should be added back to the Site.

Given I am an iMedidata User
And I am logged in to iMedidata
And my Username is "<iMedidata User 1 ID>" in iMedidata
And I am connected to Rave
And there is an iMedidata Study named "<Study A>"
And there is a Rave Study named "<Study A>"
And there is a Rave Site named "<Site A1>" with "329843432" for "<Study A>"
And I am the owner of the Study "<Study A>" in iMedidata
And the iMedidata Study named "<Study A>" is connected to the Rave Study named "<Study A>"
And the iMedidata managed Site "<Site A1>" with "329843432" is connected to the Rave Site named "<Site A1>" with Site Number "329843432"
And I have an assignment to the iMedidata Study named "<Study A>" for the App named "<EDC App>" and the Role "<EDC Role 1>"
And I have an assignment to the iMedidata Study named "<Study A>" for the App named "<Modules App>" and the Role "<Modules Role 1>"
And I navigate to Sites in Manage Study: "<Study A>" page
And I follow remove for Site "<Site A1>"
And I follow app "<EDC App>" for Study "<Study A>"
And I navigate to Site Adminstration module
And I navigate to Site Details page for Site "<Site A1>" 
And I should see "<Study A>" is not listed in the Study Sites pane
And I should see Source is "iMedidata" 
And I follow iMedidata link
And I navigate to Sites in Manage Study: "<Study A>" page
And I follow Create New Sites
And I add Site "<Site A1>" with Site Number "329843432" Study Site Number "124656"
And I follow app "<EDC App>" for Study "<Study A>"
And I am on the "<Site A1>" page
And I navigate to Site Adminstration
When I navigate to Site Details page for Site "<Site A1>" 
Then I should see Study "<Study A>" appears in Study Sites pane for Site "<Site A1>"
And I should see Source is "iMedidata" 
And I take a screenshot

@Rave 564 Patch 13
@PB2.5.9.29-02
@Validation
Scenario: If the user has access to study in Rave that is linked with the study on iMedidata and if the user is unassigned to the site for the study on iMedidata then that site will not be accessible in Rave , provided the user has role that has no "ViewAllSitesinSitegroup" action role checked

Given I am an iMedidata User
And I am logged in to iMedidata
And my Username is "<iMedidata User 1 ID>" in iMedidata
And my email is "<iMedidata User 1 ID>"
And there is a Rave User with email "<iMedidata User 1 ID>"
And there is an iMedidata Study named "<Study B>"
And the iMedidata Study named "<Study B>" has Sites "<Site B1>" "<Site B2>
And there is a Rave Study named "<Study B>"
And the iMedidata Study named "<Study B>" is connected to the Rave Study named "<Study B>"
And I have an assignment to the iMedidata Study named "<Study B>" for the App named "<EDC App>" and the Role "<EDC Role 1>" App named "<Modules App>" Role "<Modules Role 1>"
And I have an assignment to the iMedidata site named "<Site B1>" and site named "<Site B2>" for the iMedidata study named "<Study B>"
And I am on iMedidata Home page
And I follow app named "<EDC App>" for "<Study B>"
And I am on Study "<Study B>" home page 
And I see "<Site B1>" "<Site B2>" on the study home page
And I take a screenshot
And I follow iMedidata link
And I am on iMedidata Home page
And I navigate to the  Manage Study page for the "<Study B>"
And my assignment to the iMedidata site named "<Site B1>" for the iMedidata study named "<Study B>" is removed
When I follow the app named "<EDC App>" for "<Study B>"
Then I am on the Rave Study Site Home Page for "<Site B2>"
And I should not see "<Site B1>"
And I take a screenshot

@Rave 564 Patch 13
@PB2.5.9.29-03
@Validation
Scenario: If the user has access to study in Rave that is linked with the study on iMedidata and if the user is unassigned to the site for the study on iMedidata then that site will be accessible in Rave, provided the user has role that has  "ViewAllSitesinSitegroup" action role checked

Given I am an iMedidata User
And I am logged in to iMedidata
And my Username is "<iMedidata User 1 ID>" in iMedidata
And there is a Rave User named "<iMedidata User 1 ID>"
And there is an iMedidata Study named "<Study B>"
And the iMedidata Study named "<Study B>" has Site "<Site B1>" "<Site B2>"
And there is a Rave Study named "<Study B>"
And the iMedidata Study named "<Study B>" is connected to the Rave Study named "<Study B>"
And I have an assignment to the iMedidata Study named "<Study B>" for the App named "<EDC App>" and the Role "<EDC Role 4>" App named "<Modules App>" Role "<Modules Role 1>"
And I have an assignment to the iMedidata site named "<Site B1>" site named "<Site B2>" for the iMedidata study named "<Study B>"
And I follow app named "<EDC App>" for "<Study B>"
And I am on Study "<Study B>" home page 
And I see "<Site B1>" "<Site B2>" on the study home page
And I follow iMedidata link
And I am on iMedidata home page
And my assignment to the iMedidata site named "<Site B1>" for the iMedidata study named "<Study B>" is removed
When I follow the app named "<EDC App>" for "<Study B>"
Then I am on the Rave Home Page for Study "<Study B>"
And I should see "<Site B1>", "<Site B2>"
And I take a screenshot


@Rave 564 Patch 13
@PB2.5.9.29-04
@Validation
Scenario: If the user has access to a Study Site in Rave that is linked with the iMedidata and if the user EDC Role is changed , the Study Site will be accessible to the User on Rave.

Given I am an iMedidata User
And I am logged in to iMedidata
And my Username is "<iMedidata User 1 ID>" in iMedidata
And there is a Rave User named "<iMedidata User 1 ID>"
And there is an iMedidata Study named "<Study B>"
And the iMedidata Study named "<Study B>" has Site "<Site B1>"
And there is a Rave Study named "<Study B>"
And the iMedidata Study named "<Study B>" is connected to the Rave Study named "<Study B>"
And I have an assignment to the iMedidata Study named "<Study B>" for the App named "<EDC App>" and the Role "<EDC Role 1>" App named "<Modules App>" Role "<Modules Role 1>"
And I have an assignment to the iMedidata site named "<Site B1>" for the iMedidata study named "<Study B>"
And I follow app named "<EDC App>" for "<Study B>"
And I am on Study "<Study B>" home page 
And I see "<Site B1>" on the study home page
And I follow iMedidata link
And I am on iMedidata home page
And my role to the iMedidata Study "<Study B>" is changed from "<EDC Role 1>" to "<EDC Role 2>"
When I follow the app named "<EDC App>" for "<Study B>"
Then I am on the Rave Page for "<Site B1>" for Study "<Study B>"
And I take a screenshot
    

@Rave 564 Patch 13
@PB2.5.9.29-05
@Validation 
Scenario: For all iMedidata Authenticated Users ,Study Site Number and remove icon will not be available on Study Sites pane in Site Details page when the Study and Site in Rave is Connected to a Study and Site in iMeiddata.

Given I am an iMedidata User
And I am logged in to iMedidata
And my Username is "<iMedidata User 1 ID>" in iMedidata
And my email is "<iMedidata User 1 ID>"
And there is a Rave User with email "<iMedidata User 1 ID>"
And there is an iMedidata Study named "<Study B>"
And there is a Rave Study named "<Study B>"
And the Rave Study "<Study B>" has Site "<Site B1>" with Site Number "<2434>"
And the iMedidata Study named "<Study B>" is connected to the Rave Study named "<Study B>"
And there is a iMedidata Site named "<Site B1>" with Site Number "<2434>" for Study "<Study B>"
And I have an assignment to the iMedidata Study named "<Study B>" for the App named "<EDC App>" and the Role "<EDC Role 1>" App named "<Modules App>" Role "<Modules Role 1>"
And I am assigned to Site "<Site B1>"
And the iMedidata Site "<Site B1>" is connected to Site "<Site B1>" in Rave
And I am on iMedidata Home page
And I follow "<EDC App>" for "<Study A>"
And I navigate to Site Administration Module
And I search for  Site "<Site B1>"
When I navigate to the Site "<Site B1>" Details Page
Then I should see “Study Site Number” is not editable
And Remove icon "X" is not available
And I should see Source "iMedidata"
And I take a screenshot

@Rave 564 Patch 13
@PB2.5.9.29-06
@Validation 
Scenario: For an Internal Authenticated/Rave Users Study Site Number or Remove Icon in the Study Sites pane will not be available in the Site Details page if the Site is connected to iMedidata.

Given I am an Rave User
And my Rave User Name "<Rave User Name 1>"
And there is an iMedidata Study named "<Study B>"
And the iMedidata Study "<Study B>" is connected to Rave
And the iMedidata Study "<Study B>" has a Site "<Site B1>" with Site Number "<1213>"
And the Site "<Site B1>" is connected to Rave
And I have access to Site Adminstration Module
And I navigate to Site Administration Module
And I search for Study "<Study B>"
And I see "<Site B1>" in search results
When I navigate to the Site "<Site B1>" Details Page
Then I should see “Study Site Number” is not editable in Study Sites pane
And “Remove” icon "X" is not available in Studies Sites Pane
And I should see Source "iMedidata"
And I take a screenshot

@Rave 564 Patch 13
@PB2.5.9.29-08
@Validation 
Scenario: When a user is assigned to Sites on iMedidata for a EDC Role in a Study, the sites should be accessible to the user even when there are EDC Role changes.

Given I am an iMedidata User
And I am logged in to iMedidata
And my Username is "<iMedidata User 1 ID>" in iMedidata
And my email is "<iMedidata User 1 ID>"
And there is an iMedidata Study named "<Study B>"
And there is a iMedidata Site named "<Site B1>" with Site Number "<2434>" for Study "<Study B>"
And there is a iMedidata Site named "<Site B2>" with Site Number "<32343>" for Study "<Study B>"
And I have an assignment to the iMedidata Study named "<Study B>" for the App named "<EDC App>" and the Role "<EDC Role 1>" App named "<Modules App>" Role "<Modules Role 1>"
And I am assigned to Site "<Site B1>" "<Site B2>"
And I am on iMedidata Home page
And I follow "<EDC App>" for "<Study A>"
And I should see "<Site B1>" "<Site B2> in Rave for "<Study B>"
And I navigate to User Details page for User "<iMedidata User 1 ID>"
And I should see "<EDC Role 1>" assigned to  user for "<Study B>"
And I take a screenshot
And I navigate to iMedidata
And I have a new role Assignment to "<Study B>" with "<EDC App>"  with "<EDC Role 2>"
And I follow "<EDC App>" for "<Study A>"
And I select "<EDC Role 2>" on Role Selection page
And I should see "<Site B1>" "<Site B2> in Rave for "<Study B>"
And I navigate to User Details page for User "<iMedidata User 1 ID>" for Role "<EDC Role 2>"
And I should see "<EDC Role 2>" assigned to User for Study "<Study B>"
And I take a screenshot
And I navigate to iMedidata
And I have change role Assignment to "<Study B>" with "<EDC App>"  with "<EDC Role 3>" from "<EDC Role 2>"
And I follow "<EDC App>" for "<Study A>"
And I select "<EDC Role 3>" on Role Selection page
And I should see "<Site B1>" "<Site B2> in Rave for "<Study B>"
And I navigate to User Adminstration
And I search for "<iMedidata User 1 ID>"
And I should see "<EDC Role 1>" "<EDC Role 3>" in search results
And I navigate to User Details page for User "<iMedidata User 1 ID>" for Role "<EDC Role 3>"
And I should see "<EDC Role 3>" assigned to User for Study "<Study B>"
And I take a screenshot
And I navigate to iMedidata
And my EDC role "<EDC Role 1>" , "<EDC Role 3>" for "<Study B>" are removed
And "<EDC Role 2>" is added back to "<Study B>" 
And I follow "<EDC App>" for "<Study A>"
And I should see "<Site B1>" "<Site B2> in Rave for "<Study B>"
And I navigate to User Details page for User "<iMedidata User 1 ID>" for Role "<EDC Role 2>"
And I should see "<EDC Role 2>" assigned to User for Study "<Study B>"
And I take a screenshot
And I navigate to iMedidata
And my EDC role "<EDC Role 2>" for "<Study B>" is removed
And a new "<EDC Role 4>" is added to "<Study B>" 
And I follow "<EDC App>" for "<Study A>"
And I should see "<Site B1>" "<Site B2> in Rave for "<Study B>"
And I navigate to User Details page for User "<iMedidata User 1 ID>" for Role "<EDC Role 4>"
And I should see "<EDC Role 4>" assigned to User for Study "<Study B>"
And I take a screenshot


@release2012.2.0
@PB2.7.5.13-41
@Draft
Scenario: When I update a Study site in iMedidata, if the study site does not exist in Rave and if the study is connected to iMedidata, a study site is created in Rave and linked to iMedidata.

@release2012.2.0
@PB2.5.8.13-01
@Draft
Scenario: When a study on Rave is successfully created and linked with a study on iMedidata, then the associated study sites are created or updated in iMedidata for that study and are sent to Rave and linked or created as needed by Rave.

@release2012.2.0
@PB2.7.5.13-05
@Draft
Scenario: If I have a study site in iMedidata that is not linked to a study site in Rave, when Rave recieves a message to udpate the study site number, then Rave should find the study site by the associations of the related site and study, and link the study site to the iMedidata study site, updating the study site UUID and updating the study site number in Rave to match the UUID and study site number in iMedidata.

