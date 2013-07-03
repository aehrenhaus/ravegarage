Feature: General Functionality
	# This feature file will be executed on pre and post pach builds on a iMedidata-Rave site

	Background: 
	Given I am an iMedidata user "<User>" with pin "<PIN>" password "<Password>" and user id "<User Name>"
		|User						|PIN						| Password							|User Name						|Email 							|
		|{iMedidata New User 1}		|iMedidata New User 1 PIN}	|{iMedidata New User 1 Password}	|{iMedidata New User 1 Name}	|{iMedidata New User 1 Email}	|
		|{iMedidata New User 2}		|iMedidata New User 2 PIN}	|{iMedidata New User 2 Password}	|{iMedidata New User 2 Name}	|{iMedidata New User 2 Email}	|
		|{iMedidata New User 3}		|iMedidata New User 3 PIN}	|{iMedidata New User 3 Password}	|{iMedidata New User 3 Name}	|{iMedidata New User 3 Email}	|	
	And there exists a Rave user "<Rave User>" with username <Rave User Name>" and password "<Rave Password>" with "<Email>" and "<Rave First Name>" and "<Rave Last "Nane>"
		|Rave User		|Rave User Name		|Rave Password		|Email			|Rave First Name 	|Rave Last Name 	|
		|{Rave User 1}	|{Rave User Name 1}	|{Rave Password 1}	|{Rave Email 1}	|Rave First Name 1	|Rave Last Name 1	|	
		|{Rave User 2}	|{Rave User Name 2}	|{Rave Password 2}	|{Rave Email 2}	|Rave First Name 2	|Rave Last Name 2	|	
	And there exists Security Group "<Security Group>" that is associated with Security Role "<Role>"
		|Security Group		|Role				|
		|{Security Group 1}	|{security group 1}	|
		|{Security Group 2}	|{Security Role 2}	|
	And there exists study "<Study>" in study group "<Study Group>"
		|Study			|Study Group 	|
		|{Study A}		|{Study Group} 	|
		|{Study E}		|{Study Group} 	|
	And there exists subject <Subject> with eCRF page <eCRF Page>" in Site <Site>
		|Site			|Subject		|eCRF Page		|
		|{New Site A1}	|{Subject 1}	|{eCRF Page 1}	|
	And There exists <eLearning Course> associated with "<Role>"
		|eLearning Course	|
		|{Course 1}			|
	And there exists app "<App>" associated with study "<Study>",
		|App			|
		|{Edc App}		|
		|{Modules App}	|
		|{Security App}	|
	And there exists site "<Site>" in study "<Study>", 		
		|Study			|Site			|
		|{Study A}		|{Site A1}		|
	And there exists role "<Role>" in app "<App>", 		
		|App			|Role					|
		|{Edc App}		|{EDC Role 1}			|
		|{Edc App}		|{EDC Role 2}			|
		|{Edc App}		|{EDC Role 3}			|
		|{Edc App}		|{EDC Role 4}			|
		|{Edc App}		|{EDC Role 5}			|
		|{Edc App}		|{EDC Role 6}			|
		|{Edc App}		|{EDC Role 7}			|
		
# Note: All Scenarios Assignment Integrity need to be started in Patch 12

#------------------------------------------------------#Old Patch with Rave External user----------------------------------------------------------------

@Rave 2013.2.0.
@PB2.5.1.76-88
@Assignment Integrity 1
@Validation
Scenario: I am a Rave External user created from a previous patch.  When the new Patch is applied, I should not loose any of my previous assignments.

#Patch 12
#Rave user assignments
   
   Given I have iMedidata External User "<iMedidata New User 1>" with username "<iMedidata New User 1 Name>" and rave password "<iMedidata New User 1 Password>" and email "<iMedidata New User 1 Email>" 
   And I am assigned to study "<Study A>"  with "<Site A1>" with "<EDC App>" with role "<EDC Role 1>"
   And I am assigned to "<Modules App>" with "<Modules Role 1>"
   And I am assigned to Security App "<Security App>" for Security Role "<Security Group 1>" associated with Study "<Study A>"
   And I navigate to Rave
   And I assign "<iMedidata New User 1> "to Rave Internal Study "<Study E>" with "Prod" and "Dev" environments with "<EDC Role 1">
   And I navigate to the User Details page for "<iMedidata New User 1 Name>"
   And there is an External Study "<Study A>" with "Prod" and "Dev" environments assigned to role "<EDC Role 1>"
   And there is an Rave Internal Study "<Study E>" with "Prod" and "Dev" environments with "<EDC Role 1">
   And I should see "<Security Group 1>" in Other Modules Section
   And I should see "<Default Security Role>" for "<Study A>" "<Study E>"
   And I should see User group "<Modules Role 1>"
   And I see test box "Trained Date" "<Date earlier or equal to today>"
   And Training Signed checkbox is "Checked"
   And I take a screenshot 
   And I should navigate to "Reporter"
   And I am assigned to "Audit Trail" Report"
   And in the Reporter module I am assigned to "Business Objects XI"
   And in the Reporter module I am assigned to "Dynamic Tabulation Engine"
   And in the Reporter module I am assigned to "Dynamic Tabulation Engine for Admins"
   And in the Reporter module I am assigned to "J-Review"
   And in the Reporter module I am assigned to "SAS on Demand"
   And in the Reporter module I am assigned to  "Script Utility" 
   And in the Reporter module I am assigned to  "Targeted SDV Configuration"
   And in the Reporter module I have a User Saved Report 
   And I verify that all the above reports , addons that I am assigned to are functional and working as expected for internal ,external studies assigned
   And I take a screenshot 
  #(Take as many screenshot as required)

#Apply New Patch 13
# iMedidata
	And I am an logged in to iMedidata as iMedidata User "<iMedidata New User 1 Name>"
	And I navigate to Rave
	And I navigate to User Details page for "<iMedidata New User 1 Name>"
	And there is an External Study "<Study A>" with "Prod" and "Dev" environments assigned to role "<EDC Role 1>"
    And there is an Rave Internal Study "<Study E>" with "Prod" and "Dev" environments with "<EDC Role 1">
    And I should see "<Security Group 1>" in Other Modules Section
    And I should see "<Default Security Role>" for "<Study A>" "<Study E>"
    And I should see User group "<Modules Role 1>"
    And I see test box "Trained Date" "<Date earlier than today>"
    And Training Signed checkbox is "Checked"
    And I take a screenshot 
    And I should navigate to "Reporter"
    And I am assigned to "Audit Trail" Report"
    And in the Reporter module I am assigned to "Business Objects XI"
    And in the Reporter module I am assigned to "Dynamic Tabulation Engine"
    And in the Reporter module I am assigned to "Dynamic Tabulation Engine for Admins"
    And in the Reporter module I am assigned to "J-Review"
    And in the Reporter module I am assigned to "SAS on Demand"
    And in the Reporter module I am assigned to  "Script Utility" 
    And in the Reporter module I am assigned to  "Targeted SDV Configuration"
    And in the Reporter module I have a User Saved Report 
    And I verify that all the above reports , addons that I am assigned to are functional and working as expected for internal ,external studies assigned
    And I take a screenshot	
#(Take as many screenshot as required)
	And I log out
	And I log in as iMedidata as Admin "<iMedidata Admin User>"
	And I create a Study "<Study B>"
	And I assign "<S tudy B>" to "<iMedidata New User 1 Name>" with "<EDC App>" with "<EDC Role 1>", "<EDC Role 2>" and "<EDC Role 3>" "<Modules App>" with "<Modules Role 1>" Security App "<Security App>" with "<Security Group1>"
	And I log out 
	And I log in to iMedidata as "<iMedidata New User 1 Name>"
	And I accept the invitation to "<Study B>"
	And I follow the link "<EDC App>" associated with study "<Study B>"
	And I select role "<EDC Role 1>" from the dropdown on the Role Selection page 
	And I am on the Rave "<Study B>" page 
	And I navigate to the "User Adminisration" Module
	And I search for "<iMedidata New User 1 Name>" with Authenticator "iMedidata"
	When I navigate to the 'User Details" page for user "<iMedidata New User 1 Name>" with role "<EDC Role 1>"
	Then I should see study "<Study A>", "<Study E>" with "Prod" and "Dev" environments with role "<EDC Role 1>" in the Studies Pane
	And I should see study "<Study B>" with role "<EDC Role 1>" in the Studies Pane
	And I should see "<Security Group 1>"  in Other Modules Section
	And I should see "<Security Group 2>"  in Other Modules Section
	And I should see "<Default Security Role>" for "<Study A>" ,"<Study B>" and "<Study E>"
    And I should see User group "<Modules Role 1>"
	And I take a screenshot
	And I navigate to the Reporter module
	And I verify that all the above reports , addons that I am assigned to are still displayed
    And I take a screenshot	
	And I select link "iMedidata"
	And I follow the link "<EDC App>" associated with study "<Study B>"
	And I select role "<EDC Role 2>" from the dropdown on the Role selection page 
	And I am on the Rave "<Study B>" page  
	And I navigate to the "User Adminisration" Module
	And I search for "<iMedidata New User 1 Name>" 
	And I navigate to the 'User Details" page for user "<iMedidata New User 1 Name>" with role "<EDC Role 2>"
	And I should see study "<Study B>" with role "<EDC Role 2>" in the Studies pane
	And I should not see study "<Study A>" with role "<EDC Role 2>" in the Studies pane 
	And I should see "<Security Group 1>"  in Other Modules Section
	And I should see "<Security Group 2>"  in Other Modules Section
	And I should see "<Default Security Role>" for "<Study A>" ,"<Study B>" and "<Study E>"
    And I should see User group "<Modules Role 1>"
	And I take a screenshot
	And I navigate to the Reporter module
	And I verify that no reports are assigned for user "<iMedidata New User 1 Name>" with role "<EDC Role 2>"
    And I take a screenshot	
	And I select link "iMedidata"
	And I follow the link "<EDC App>" associated with study "<Study B>"
	And I select role "<EDC Role 3>" from the dropdown on the role selection page 
	And I am on the Rave "<Study B>" page 
	And I navigate to the "User Adminisration" Module
	And I search for "<iMedidata New User 1 Name>" 
	And I navigate to the 'User Details" page for user "<iMedidata New User 1 Name>" with role "<EDC Role 3>"
	And I should see study "<Study B>" with role "<EDC Role 3>" in the Studies pane
	And I should not see study "<Study A>" with role "<EDC Role 3>" in the Studies pane 
	And I should see "<Security Group 1>"  in Other Modules Section
	And I should see "<Security Group 2>"  in Other Modules Section
	And I should see "<Default Security Role>" for "<Study A>" ,"<Study B>" and "<Study E>"
    And I should see User group "<Modules Role 1>"
	And I take a screenshot
	And I navigate to the Reporter module
	And I verify that no reports are assigned for user "<iMedidata New User 1 Name>" with role "<EDC Role 3>"
	And I select link "iMedidata"
	And I logout

	#---------------------------elearning External User Created in iMedidata ---------------------------------------------------------
	

@Rave 564 Patch 13
@PB2.5.1.76-89
@Assignment Integrity 2
@Validation
Scenario: I am a Rave External user created from a previous patch.  When the new Patch is applied, I should not loose any any status on eLearning courses and am able to take them.

#Patch 12
	Given I am an external authenticated user created in iMedidata
	And I am logged on to iMedidata
	And my username is "<iMedidata New User 2 Name>"
	And I am assigned to study "<Study A>" with "<Site A1>" with app "<Edc App>" with role "<EDC Role 1>", "<EDC Role 2>", "<EDC Role 3>","<EDC Role 4>","<EDC Role 5>", "<EDC Role 6>", "<EDC role 7>"
	And I am assigned to study "<Study A>" with "<Site A1>" with app "<Modules App>" with role "<Modules Role 1>"
	And I am assigned to study "<Study A>" with "<Site A1>" with app "<Security App>" with role "<security group 1>"
	And there is an eLearning course "<Course 1>" assigned to study "<Study A>" with role "<EDC Role 1>"
	And there is an eLearning course "<Course 1>" assigned to study "<Study A>" with role "<EDC Role 2>"
	And there is an eLearning course "<Course 1>" assigned to study "<Study A>" with role "<EDC Role 3>"
	And there is an eLearning course "<Course 1>" assigned to study "<Study A>" with role "<EDC Role 4>"
	And there is an eLearning course "<Course 1>" assigned to study "<Study A>" with role "<EDC Role 5>"
	And there is an eLearning course "<Course 1>" assigned to study "<Study A>" with role "<EDC Role 6>"
	And there is not an eLearning course "<Course 1>" assigned to study "<Study A>" with role "<EDC Role 7>"
# EDC Role 1
	And I follow the EDC App link associated with study "<Study A>"
	And I see the role selection page 
	And I select role "<EDC Role 1>" fronm the dropdown and click "Continue"
	And I should see the eLearning Homepage
	And I should see that the user has not started the course
	And I take a screenshot
	And I navigate to the "User Administration" module
	And I search for user "<iMedidata New User 2 Name>"
	And I select the details icon for row with role "<EDC Role 1>"
    And I am on the User Details page
	And I see that I have elearning course "<Course 1>" assigned and its status is "Not Started"
	And I take a screenshot
	And I select link "iMedidata"
# EDC Role 2
	And  I follow the EDC App link associated with study "<Study A>"
	And I see the role selection page 
	And I select role "<EDC Role 2>" fronm the dropdown and click "Continue"
	And I should see the eLearning Homepage
	And I should see that the course status is "Incomplete"
	And I take a screenshot
	And I navigate to the "User Administration" module
	And I search for user "<iMedidata New User 2 Name>"
	And I select the details icon for row with role "<EDC Role 2>"
	And I am on the User Details page
	And I see that I have elearning course "<Course 1>" assigned and its status is "Incomplete"
	And I take a screenshot
	And I select link "iMedidata"
# EDC Role 3
	And I follow the EDC App link associated with study "<Study A>"
	And I see the role selection page 
	And I select role "<EDC Role 3>" fronm the dropdown and click "Continue"
	And I should see the Rave site page for site "<Site A>" for study "<Study A>"
	And I navigate to the "User Administration" module
	And I search for user "<iMedidata New User 2 Name>"
	And I select the details icon for row with role "<EDC Role 3>"
	And I am on the User Details page
	And I see that I have elearning course "<Course 1>" assigned and its status is "Complete"
	And I take a screenshot
	And I select link "iMedidata"
# EDC Role 4
	And I follow the EDC App link associated with study "<Study A>"
	And I see the role selection page 
	And I select role "<EDC Role 4>" fronm the dropdown and click "Continue"
	And I should see the Rave site page for site "<Site A>" for study "<Study A>"
	And I navigate to the "User Administration" module
	And I search for user "<iMedidata New User 2 Name>"
	And I select the details icon for row with role "<EDC Role 4>"
	And I am on the User Details page
	And I see that I have elearning course "<Course 1>" assigned and its status is "Incomplete" and the "Override Checkbox" is checked
	And I take a screenshot
	And I select link "iMedidata"
# EDC Role 5
	And I follow the EDC App link associated with study "<Study A>"
	And I see the role selection page 
	And I select role "<EDC Role 5>" fronm the dropdown and click "Continue"
	And I should see the Rave site page for site "<Site A>" for study "<Study A>"
	And I navigate to the "User Administration" module
	And I search for user "<iMedidata New User 2 Name>"
	And I select the details icon for row with role "<EDC Role 5>"
	And I am on the User Details page
	And I see that I have elearning course "<Course 1>" assigned and its status is "Not Started" and the "Override Checkbox" is checked
	And I take a screenshot
	And I select link "iMedidata"
# EDC Role 6
	And I follow the EDC App link associated with study "<Study A>"
	And I see the role selection page 
	And I select role "<EDC Role 6>" fronm the dropdown and click "Continue"
	And I should see the eLearning Homepage
	And I should see that the course status is "Incomplete"
	And I navigate to the "User Administration" module
	And I search for user "<iMedidata New User 2 Name>"
	And I select the details icon for row with role "<EDC Role 6>"
	And I am on the User Details page
	And I see that I have elearning course "<Course 1>" assigned and its status is "Incomplete" 
	And I take a screenshot
	And I select link "iMedidata"
# EDC Role 7
	And I follow the EDC App link associated with study "<Study A>"
	And I see the role selection page 
	And I select role "<EDC Role 7>" fronm the dropdown and click "Continue"
	And I should see the Rave site page for site "<Site A>" for study "<Study A>"
	And I navigate to the "User Administration" module
	And I search for user "<iMedidata New User 2 Name>"
	And I select the details icon for row with role "<EDC Role 7>"
	And I am on the User Details page
	And I see that I have no elearning course "<Course 1>" assigned 
	And I take a screenshot
	And I select link "iMedidata"

#New Patch is Applied Patch 13
	And I am an external authenticated user
	And I am logged on to iMedidata
	And my username is "<iMedidata User 2 ID>"
    And I am assigned to study "<Study A>" with "<Site A1>" with app "<Edc App>" with role "<EDC Role 1>"
	And I am assigned to study "<Study A>" with "<Site A1>" with app "<Edc App>" with role "<EDC Role 2>"
	And I am assigned to study "<Study A>" with "<Site A1>"with app "<Edc App>" with role "<EDC Role 3>"
	And I am assigned to study "<Study A>" with "<Site A1>" with app "<Edc App>" with role "<EDC Role 4>"
	And I am assigned to study "<Study A>" with "<Site A1>" with app "<Edc App>" with role "<EDC Role 5>"
	And I am assigned to study "<Study A>" with "<Site A1>" with app "<Edc App>" with role "<EDC Role 6>"
	And I am assigned to study "<Study A>" with "<Site A1>" with app "<Edc App>" with role "<EDC Role 7>"
	And I am assigned to study "<Study A>" with "<Site A1>" with app "<Modules App>" with role "<Modules Role 1>"
	And I am assigned to study "<Study A>" with "<Site A1>"with app "<Security App>" with role "<security group 1>"
	And there is an eLearning course "<Course 1>" assigned to study "<Study A>" with role "<EDC Role 1>"
	And there is an eLearning course "<Course 1>" assigned to study "<Study A>" with role "<EDC Role 2>"
	And there is an eLearning course "<Course 1>" assigned to study "<Study A>" with role "<EDC Role 3>"
	And there is an eLearning course "<Course 1>" assigned to study "<Study A>" with role "<EDC Role 4>"
	And there is an eLearning course "<Course 1>" assigned to study "<Study A>" with role "<EDC Role 5>"
	And there is an eLearning course "<Course 1>" assigned to study "<Study A>" with role "<EDC Role 6>"
	And there is not an eLearning course "<Course 1>" assigned to study "<Study A>" with role "<EDC Role 7>"
# EDC Role 1
	And I follow the EDC App link associated with study "<Study A>"
	And I see the role selection page 
	And I select role "<EDC Role 1>" fronm the dropdown and click "Continue"
	And I should see the eLearning Homepage
	And I should see that the user has not started the course
	And I take a screenshot
	And I navigate to the "User Administration" module
	And I search for user "<iMedidata New User 2 Name>"
	And I select the details icon for row with role "<EDC Role 1>"
	And I am on the User Details page
	And I see that I have elearning course "<Course 1>" assigned and its status is "Not Started"
	And I take a screenshot
	And I select link "Home"
	And I complete the elearning course "<Course 1>"
	And I should see the Rave site page for site "<Site A>" for study "<Study A>"
	And I take a screenshot
	And I navigate to the "User Administration" module
	And I search for user "<iMedidata New User 2 Name>"
	When I select the details icon for row with role "<EDC Role 1>"
	Then I am on the User Details page
	And I see that I have elearning course "<Course 1>" assigned and its status is "Complete"
	And I take a screenshot
	And I select link "iMedidata"
# EDC Role 2
	And  I follow the EDC App link associated with study "<Study A>"
	And I see the role selection page 
	And I select role "<EDC Role 2>" fronm the dropdown and click "Continue"
	And I should see the eLearning Homepage
	And I should see that the course status is "Incomplete"
	And I take a screenshot
	And I navigate to the "User Administration" module
	And I search for user "<iMedidata New User 2 Name>"
	And I select the details icon for row with role "<EDC Role 2>"
	And I am on the User Details page
	And I see that I have elearning course "<Course 1>" assigned and its status is "Incomplete"
	And I take a screenshot
	And I select link "iMedidata"
# EDC Role 3
	And I follow the EDC App link associated with study "<Study A>"
	And I see the role selection page 
	And I select role "<EDC Role 3>" fronm the dropdown and click "Continue"
	And I should see the Rave site page for site "<Site A>" for study "<Study A>"
	And I navigate to the "User Administration" module
	And I search for user "<iMedidata New User 2 Name>"
	And I select the details icon for row with role "<EDC Role 3>"
	And I am on the User Details page
	And I see that I have elearning course "<Course 1>" assigned and its status is "Complete"
	And I take a screenshot
	And I select link "iMedidata"
# EDC Role 4
	And I follow the EDC App link associated with study "<Study A>"
	And I see the role selection page 
	And I select role "<EDC Role 4>" fronm the dropdown and click "Continue"
	And I should see the Rave site page for site "<Site A>" for study "<Study A>"
	And I navigate to the "User Administration" module
	And I search for user "<iMedidata New User 2 Name>"
	And I select the details icon for row with role "<EDC Role 4>"
	And I am on the User Details page
	And I see that I have elearning course "<Course 1>" assigned and its status is "Incomplete" and the "Override Checkbox" is checked
	And I take a screenshot
	And I select link "iMedidata
# EDC Role 5
	And I follow the EDC App link associated with study "<Study A>"
	And I see the role selection page 
	And I select role "<EDC Role 5>" fronm the dropdown and click "Continue"
	And I should see the Rave site page for site "<Site A>" for study "<Study A>"
	And I navigate to the "User Administration" module
	And I search for user "<iMedidata New User 2 Name>"
	And I select the details icon for row with role "<EDC Role 5>"
	And I am on the User Details page
	And I see that I have elearning course "<Course 1>" assigned and its status is "Not Started" and the "Override Checkbox" is checked
	And I take a screenshot
	And I select link "iMedidata"
# EDC Role 6
	And I follow the EDC App link associated with study "<Study A>"
	And I see the role selection page 
	And I select role "<EDC Role 6>" fronm the dropdown and click "Continue"
	And I should see the eLearning Homepage
	And I should see that the course status is "Incomplete"
	And I navigate to the "User Administration" module
	And I search for user "<iMedidata New User 2 Name>"
	And I select the details icon for row with role "<EDC Role 6>"
	And I am on the User Details page
	And I see that I have elearning course "<Course 1>" assigned and its status is "Incomplete" 
	And I take a screenshot
	And I select link "iMedidata"
# EDC Role 7
	And I follow the EDC App link associated with study "<Study A>"
	And I see the role selection page 
	And I select role "<EDC Role 7>" fronm the dropdown and click "Continue"
	And I should see the Rave site page for site "<Site A>" for study "<Study A>"
	And I navigate to the "User Administration" module
	And I search for user "<iMedidata New User 2 Name>"
	And I select the details icon for row with role "<EDC Role 7>"
	And I am on the User Details page
	And I see that I have no elearning course "<Course 1>" assigned 
	And I take a screenshot
	And I select link "iMedidata"

	
	#---------------------------elearning External User merged with a Rave user---------------------------------------------------------
	

@Rave 564 Patch 13
@PB2.5.1.76-90
@Assignment Integrity 3
@Validation
Scenario: I am a Rave External user created and merged with a Rave user from a previous patch.  When the new Patch is applied, I should not loose any any status on eLearning courses and am able to take them.

#Patch 12
	Given I am an external authenticated user merged with a Rave user from a previous patch
	And I am logged on to iMedidata
	And my username is "<iMedidata New User 3 Name>"
	And I am assigned to study "<Study A>" with "<Site A1>" with app "<Edc App>" with role "<EDC Role 1>"
	And I am assigned to study "<Study A>" with "<Site A1>" with app "<Edc App>" with role "<EDC Role 2>"
	And I am assigned to study "<Study A>" with "<Site A1>"with app "<Edc App>" with role "<EDC Role 3>"
	And I am assigned to study "<Study A>" with "<Site A1>" with app "<Edc App>" with role "<EDC Role 4>"
	And I am assigned to study "<Study A>" with "<Site A1>" with app "<Edc App>" with role "<EDC Role 5>"
	And I am assigned to study "<Study A>" with "<Site A1>" with app "<Edc App>" with role "<EDC Role 6>"
	And I am assigned to study "<Study A>" with "<Site A1>" with app "<Edc App>" with role "<EDC Role 7>"
	And I am assigned to study "<Study A>" with "<Site A1>" with app "<Modules App>" with role "<Modules Role 1>"
	And I am assigned to study "<Study A>" with "<Site A1>"with app "<Security App>" with role "<security group 1>"
	And there is an eLearning course "<Course 1>" assigned to study "<Study A>" with role "<EDC Role 1>"
	And there is an eLearning course "<Course 1>" assigned to study "<Study A>" with role "<EDC Role 2>"
	And there is an eLearning course "<Course 1>" assigned to study "<Study A>" with role "<EDC Role 3>"
	And there is an eLearning course "<Course 1>" assigned to study "<Study A>" with role "<EDC Role 4>"
	And there is an eLearning course "<Course 1>" assigned to study "<Study A>" with role "<EDC Role 5>"
	And there is an eLearning course "<Course 1>" assigned to study "<Study A>" with role "<EDC Role 6>"
	And there is not an eLearning course "<Course 1>" assigned to study "<Study A>" with role "<EDC Role 7>"
# EDC Role 1
	And I follow the EDC App link associated with study "<Study A>"
	And I see the role selection page 
	And I select role "<EDC Role 1>" fronm the dropdown and click "Continue"
	And I should see the eLearning Homepage
	And I should see that the status is "Incomplete"
	And I take a screenshot
	And I navigate to the "User Administration" module
	And I search for user "<iMedidata New User 3 Name>"
	And I select the details icon for row with role "<EDC Role 1>"
	And I am on the User Details page
	And I see that I have elearning course "<Course 1>" assigned and its status is "Incomplete"
	And I take a screenshot
	And I select link "iMedidata"
# EDC Role 2	
	And I follow the EDC App link associated with study "<Study A>"
	And I see the role selection page 
	And I select role "<EDC Role 2>" fronm the dropdown and click "Continue"
	And I should see the Rave site page for site "<Site A>" for study "<Study A>"
	And I take a screenshot
	And I navigate to the "User Administration" module
	And I search for user "<iMedidata New User 3 Name>"
	And I select the details icon for row with role "<EDC Role 2>"
	And I am on the User Details page
	And I see that I have elearning course "<Course 1>" assigned and its status is "Incomplete" and the "Override Checkbox" is checked.
	And I take a screenshot
	And I select link "iMedidata"
# EDC Role 3
	And I follow the EDC App link associated with study "<Study A>"
	And I see the role selection page 
	And I select role "<EDC Role 3>" fronm the dropdown and click "Continue"
	And I should see the eLearning Homepage
	And I should see that the user has not started the course
	And I take a screenshot
	And I navigate to the "User Administration" module
	And I search for user "<iMedidata New User 3 Name>"
	And I select the details icon for row with role "<EDC Role 3>"
	And I am on the User Details page
	And I see that I have elearning course "<Course 1>" assigned and its status is "Not Started"
	And I take a screenshot
	And I select link "iMedidata"
# EDC Role 4
	And I follow the EDC App link associated with study "<Study A>"
	And I see the role selection page 
	And I select role "<EDC Role 4>" fronm the dropdown and click "Continue"
	And I should see the eLearning Homepage
	And I should see that the status is "Incomplete"
	And I take a screenshot
	And I navigate to the "User Administration" module
	And I search for user "<iMedidata New User 3 Name>"
	And I select the details icon for row with role "<EDC Role 4>"
	And I am on the User Details page
	And I see that I have elearning course "<Course 1>" assigned and its status is "Incomplete"
	And I take a screenshot
	And I select link "iMedidata"
# EDC Role 5
	And I follow the EDC App link associated with study "<Study A>"
	And I see the role selection page 
	And I select role "<EDC Role 5>" fronm the dropdown and click "Continue"
	And I should see the Rave site page for site "<Site A>" for study "<Study A>"
	And I navigate to the "User Administration" module
	And I search for user "<iMedidata New User 2 Name>"
	And I select the details icon for row with role "<EDC Role 5>"
	And I am on the User Details page
	And I see that I have elearning course "<Course 1>" assigned and its status is "Complete" 
	And I take a screenshot
	And I select link "iMedidata"
# EDC Role 6
	And I follow the EDC App link associated with study "<Study A>"
	And I see the role selection page 
	And I select role "<EDC Role 6>" fronm the dropdown and click "Continue"
	And I should see the Rave site page for site "<Site A>" for study "<Study A>"
	And I take a screenshot
	And I navigate to the "User Administration" module
	And I search for user "<iMedidata New User 3 Name>"
	And I am on the User Details page
	And I see that I have elearning course "<Course 1>" assigned and its status is "Not Started""
	And I navigate to the "User Administration" module
	And I search for user "<iMedidata New User 2 Name>"
	And I select the details icon for row with role "<EDC Role 6>"
	And I am on the User Details page
	And I see that I have elearning course "<Course 1>" assigned and its status is "Not Started" and the "Override Checkbox" is checked.
	And I take a screenshot
	And I select link "iMedidata"
# EDC Role 7
	And I follow the EDC App link associated with study "<Study A>"
	And I see the role selection page 
	And I select role "<EDC Role 7>" fronm the dropdown and click "Continue"
	And I should see the Rave site page for site "<Site A>" for study "<Study A>"
	And I navigate to the "User Administration" module
	And I search for user "<iMedidata New User 2 Name>"
	And I select the details icon for row with role "<EDC Role 7>"
	And I am on the User Details page
	And I see that I have no elearning course "<Course 1>" assigned 
	And I take a screenshot
	And I select link "iMedidata"

#New Patch is Applied Patch 13
    And I am an external authenticated user created in iMedidata
	And I am logged on to iMedidata
	And my username is "<iMedidata New User 3 Name>"
	And I am assigned to study "<Study A>" with "<Site A1>" with app "<Edc App>" with role "<EDC Role 1>"
	And I am assigned to study "<Study A>" with "<Site A1>" with app "<Edc App>" with role "<EDC Role 2>"
	And I am assigned to study "<Study A>" with "<Site A1>"with app "<Edc App>" with role "<EDC Role 3>"
	And I am assigned to study "<Study A>" with "<Site A1>" with app "<Edc App>" with role "<EDC Role 4>"
	And I am assigned to study "<Study A>" with "<Site A1>" with app "<Edc App>" with role "<EDC Role 5>"
	And I am assigned to study "<Study A>" with "<Site A1>" with app "<Edc App>" with role "<EDC Role 6>"
	And I am assigned to study "<Study A>" with "<Site A1>" with app "<Edc App>" with role "<EDC Role 7>"
	And I am assigned to study "<Study A>" with "<Site A1>" with app "<Modules App>" with role "<Modules Role 1>"
	And I am assigned to study "<Study A>" with "<Site A1>"with app "<Security App>" with role "<security group 1>"
	And there is an eLearning course "<Course 1>" assigned to study "<Study A>" with role "<EDC Role 1>"
	And there is an eLearning course "<Course 1>" assigned to study "<Study A>" with role "<EDC Role 2>"
	And there is an eLearning course "<Course 1>" assigned to study "<Study A>" with role "<EDC Role 3>"
	And there is an eLearning course "<Course 1>" assigned to study "<Study A>" with role "<EDC Role 4>"
	And there is an eLearning course "<Course 1>" assigned to study "<Study A>" with role "<EDC Role 5>"
	And there is an eLearning course "<Course 1>" assigned to study "<Study A>" with role "<EDC Role 6>"
	And there is not an eLearning course "<Course 1>" assigned to study "<Study A>" with role "<EDC Role 7>"
# EDC Role 1
	And I follow the EDC App link associated with study "<Study A>"
	And I see the role selection page 
	And I select role "<EDC Role 1>" fronm the dropdown and click "Continue"
	And I should see the eLearning Homepage
	And I should see that the status is "Incomplete"
	And I take a screenshot
	And I navigate to the "User Administration" module
	And I search for user "<iMedidata New User 3 Name>"
	And I select the details icon for row with role "<EDC Role 1>"
	And I am on the User Details page
	And I see that I have elearning course "<Course 1>" assigned and its status is "Incomplete"
	And I take a screenshot
	And I select link "Home"
	And I complete the elearning course "<Course 1>"
	And I select link "Home"
	And I should see the Rave site page for site "<Site A>" for study "<Study A>"
	And I take a screenshot
	When I navigate to the "User Administration" module
	And I search for user "<iMedidata New User 3 Name>"
	And I select the details icon for row with role "<EDC Role 1>"
	And I am on the User Details page
	Then I see that I have elearning course "<Course 1>" assigned and its status is "Complete"
	And I take a screenshot
	And I select link "iMedidata"
# EDC Role 2
	And I follow the EDC App link associated with study "<Study A>"
	And I see the role selection page 
	And I select role "<EDC Role 2>" fronm the dropdown and click "Continue"
	And I should see the Rave site page for site "<Site A>" for study "<Study A>"
	And I take a screenshot
	And I navigate to the "User Administration" module
	And I search for user "<iMedidata New User 3 Name>"
	And I select the details icon for row with role "<EDC Role 2>"
	And I am on the User Details page
	And I see that I have elearning course "<Course 1>" assigned and its status is "Incomplete" and the "Override Checkbox" is checked.
	And I take a screenshot
	And I select link "iMedidata"
# EDC Role 3
	And I follow the EDC App link associated with study "<Study A>"
	And I see the role selection page 
	And I select role "<EDC Role 3>" fronm the dropdown and click "Continue"
	And I should see the eLearning Homepage
	And I should see that the user has not started the course
	And I navigate to the "User Administration" module
	And I search for user "<iMedidata New User 3 Name>"
	And I select the details icon for row with role "<EDC Role 3>"
	And I am on the User Details page
	And I see that I have elearning course "<Course 1>" assigned and its status is "Not Started"
	And I take a screenshot
	And I select link "iMedidata"
# EDC Role 4
	And I follow the EDC App link associated with study "<Study A>"
	And I see the role selection page 
	And I select role "<EDC Role 4>" fronm the dropdown and click "Continue"
	And I should see the eLearning Homepage
	And I should see that the status is "Incomplete"
	And I take a screenshot
	And I navigate to the "User Administration" module
	And I search for user "<iMedidata New User 3 Name>"
	And I select the details icon for row with role "<EDC Role 4>"
	And I am on the User Details page
	And I see that I have elearning course "<Course 1>" assigned and its status is "Incomplete"
	And I take a screenshot
	And I select link "iMedidata"
# EDC Role 5
	And I follow the EDC App link associated with study "<Study A>"
	And I see the role selection page 
	And I select role "<EDC Role 5>" fronm the dropdown and click "Continue"
	And I should see the Rave site page for site "<Site A>" for study "<Study A>"
	And I navigate to the "User Administration" module
	And I search for user "<iMedidata New User 3 Name>"
	And I select the details icon for row with role "<EDC Role 5>"
	And I am on the User Details page
	And I see that I have elearning course "<Course 1>" assigned and its status is "Complete" 
	And I take a screenshot
	And I select link "iMedidata"
# EDC Role 6
	And I follow the EDC App link associated with study "<Study A>"
	And I see the role selection page 
	And I select role "<EDC Role 6>" fronm the dropdown and click "Continue"
	And I should see the Rave site page for site "<Site A>" for study "<Study A>"
	And I take a screenshot
	And I navigate to the "User Administration" module
	And I search for user "<iMedidata New User 3 Name>"
	And I select the details icon for row with role "<EDC Role 6>"
	And I am on the User Details page
	And I see that I have elearning course "<Course 1>" assigned and its status is "Not Started" and the "Override Checkbox" is checked.
	And I take a screenshot
	And I select link "iMedidata"
# EDC Role 7
	And I follow the EDC App link associated with study "<Study A>"
	And I see the role selection page 
	And I select role "<EDC Role 7>" fronm the dropdown and click "Continue"
	And I should see the Rave site page for site "<Site A>" for study "<Study A>"
	And I navigate to the "User Administration" module
	And I search for user "<iMedidata New User 2 Name>"
	And I select the details icon for row with role "<EDC Role 7>"
	And I am on the User Details page
	And I see that I have no elearning course assigned 
	And I take a screenshot