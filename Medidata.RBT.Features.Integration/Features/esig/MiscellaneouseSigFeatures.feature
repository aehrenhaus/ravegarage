#Miscellaneous eSig Feature scenarios

Feature: eSignature for Rave internal user, iMedidata External user
	As a user,	
	I want to apply an electronic signature to forms from form level, calendar view and grid view for a study
	so that, form, folder, subject is signed
	
Background:

	Given I am a user "<User>" with pin "<PIN>", password "<Password>" and user id "<User ID>", , from the table below
		|User			|PIN	|Password	|User ID				|
		|CDM1<id>	    |12345	|password	|{Rave User ID}	        |
		|esiguser4<id>		|12345	|Password1	|{iMedidata User ID}	|	
	And 'eSig Enhancements Project <id>' study exists
	And 'Lab Project' study exists
	And '<Sites>' site exists, , from the table below
		|Sites					|
		|Miscellaneous Site		|
		|Mix eSig Site 03<id>	|
		|Lab Site				|
	And there exists site "<Site>" in study "<Study>", from the table below
		|Study							|Site					|
		|eSig Enhancements Project <id>	|Miscellaneous Site		|
		|eSig Enhancements Project <id>	|Mix eSig Site 03<id>	|
		|Lab Project					|Lab Site				|
	And there exists "<Rave Apps>", from the table below
		|Apps									|
		|rave564conlabtesting4val Rave EDC		|
		|rave564conlabtesting4val Rave Modules	|

#----------------------------------------------------------------------------------------------------------------------
@release_564_patch9
@PB1-50
@Validation
Scenario Outline: Setting up "Set Form Requires Signature" Edit Check.

	And I am logged in as user "<User>" with password "<Password>" in "<App>"
		|User			|Password	|App		|
		|CDM1<id>		|password	|Rave		|
		|esiguser4<id>	|Password1	|iMedidata	|
	And I navigate to study "eSig Enhancements Project <id>, Prod"
	And I select site "Miscellaneous Site"
	And I create Subject "<Subject 1>"
	And I select form "Form5" on Subject level
	And I enter data in standard fields
	When I select button "Save"
	Then I should see button "Sign and Save"
	And I take Screenshot 1a, 1b
	And I select button "Sign and Save"
	And I enter signature credentials	
	When I select button "<Sign>" for "<user>", from the table below
		|user			|Sign			|
		|CDM1<id>		|Sign and Save	|
		|esiguser4<id>	|eSign			|
	Then I should see "Form5" signed
	And I take Screenshot 2a, 2b
	
	When I select form "Form6" on Subject level
	Then I should not see button "Sign and Save"
	And I take Screenshot 3a, 3b	
	
#----------------------------------------------------------------------------------------------------------------------
@release_564_2013.2.0
@PB1-100
@Validation
Scenario Outline: Setting up "Set Folder Requires Signature" Edit Check.

	And I am logged in as user "<User>" with password "<Password>" in "<App>"
		|User				|Password	|App		|
		|CDM1<id>			|password	|Rave		|
		|esiguser4<id><id>	|Password1	|iMedidata	|
	And I navigate to study "eSig Enhancements Project <id>, Prod"
	And I select site "Miscellaneous Site"
	And I create Subject "<Subject 2>"
	And I select folder "Folder A"
	And I select form "Form6"
	And I should not see button "Sign and Save"		
	And I take Screenshot 4a, 4b
	And I enter data in standard field
	When I select button "Save"
	Then I should see button "Sign and Save"
	And I take Screenshot 5a, 5b
	And I select form "Form7"
	Then I should see button "Sign and Save"
	And I take Screenshot 6a, 6b	 
	
	And I select "Grid View" link on subject calendar page
	And I select link "Folder A" column
	And I select button "Sign and Save"
	And I enter signature credentials	
	When I select button "<Sign>" for "<user>", from the table below
		|user			|Sign			|
		|CDM1<id>		|Sign and Save	|
		|esiguser4<id>	|eSign			|
	Then I should see "Your signature is being applied. You may continue working on other subjects."
	And I take Screenshot 7a, 7b
	And I should see "Form6" signed in "Folder A"
	And I take Screenshot 8a, 8b
	
	And I select folder "Folder A"
	When I select form "Form7"
	Then I should see "Form7" signed
	And I take Screenshot 9a, 9b
	
	And I select folder "Folder A"
	When I select form "Form5"
	Then I should see "Form5" signed
	And I take Screenshot 10a, 10b
	
	When I select form "Form1" on Subject level
	Then I should see button "Sign and Save"
	And I take Screenshot 11a, 11b

#----------------------------------------------------------------------------------------------------------------------
@release_564_2013.2.0
@PB1-150
@Validation
Scenario Outline: Setting up "Set Subject Requires Signature" Edit Check.

	And I am logged in as user "<User>" with password "<Password>" in "<App>"
		|User			|Password	|App		|
		|CDM1<id>		|password	|Rave		|
		|esiguser4<id>	|Password1	|iMedidata	|
	And I navigate to study "eSig Enhancements Project <id>, Prod"
	And I select site "Miscellaneous Site"
	And I create Subject "<Subject 3>"
	And I select form "Form7" on Subject level
	And I should not see button "Sign and Save"	
	And I take Screenshot 12a, 12b	
	And I enter data in standard field
	When I select button "Save"
	Then I should see button "Sign and Save"
	And I take Screenshot 13a, 13b
	
	And I select folder "Folder A"
	When I select form "Form6"
	Then I should see button "Sign and Save"
	And I take Screenshot 14a, 14b	
	
	And I select button "Sign and Save" on subject calendar page
	And I enter signature credentials
	When I select button "<Sign>" for "<user>", from the table below
		|user			|Sign			|
		|CDM1<id>		|Sign and Save	|
		|esiguser4<id>	|eSign			|
	Then I should see "Your signature is being applied. You may continue working on other subjects"
	And I take Screenshot 15a, 15b
		
	When I select form "Form7" on Subject level
	Then I should see "Form7" signed on Subject level
	And I take Screenshot 16a, 16b
	
	When I select form "Form6" on Subject level
	Then I should see "Form6" signed on Subject level
	And I take Screenshot 17a, 17b
	
	When I select form "Form2" on Subject level
	Then I should see "Form2" signed on Subject level
	And I take Screenshot 18a, 18b

	And I select folder "Folder A"
	When I select form "Form6"
	Then I should see "Form6" signed
	And I take Screenshot 19a, 19b

#----------------------------------------------------------------------------------------------------------------------
@release_564_patch9
@PB1-200
@Validation
Scenario Outline: Sign and Save button on Primary form.

	And I am logged in as user "<User>" with password "<Password>" in "<App>"
		|User			|Password	|App		|
		|CDM1<id>		|password	|Rave		|
		|esiguser4<id>	|Password1	|iMedidata	|
	And I navigate to study "eSig Enhancements Project <id>, Prod"
	And I select site "Miscellaneous Site"
	And I select link "Add Subject"
	And I should see button "Sign and Save"	
	And I take Screenshot 20a, 20b	
	And I enter "Data" in "<Fields>", from the table below
		|Fields				|Data				|	
		|Subject Initals	|<Subject Initals>	|
		|Subject Number		|<Subject Number>	|
	And I select button "Sign and Save"
	And I enter signature credentials	
	When I select button "<Sign>" for "<user>", from the table below
		|user			|Sign			|
		|CDM1<id>		|Sign and Save	|
		|esiguser4<id>	|eSign			|
	Then I should see subject created
	And I take Screenshot 21a, 21b
	And I select link "Primary" form
	And I should see "Primary" form signed
	And I take Screenshot 22a, 22b

#----------------------------------------------------------------------------------------------------------------------
@release_564_patch9
@PB1-250
@Validation
Scenario Outline: Form with Template

	And I am logged in as user "<User>" with password "<Password>" in "<App>"
		|User			|Password	|App		|
		|CDM1<id>		|password	|Rave		|
		|esiguser4<id>	|Password1	|iMedidata	|
	And I navigate to study "eSig Enhancements Project <id>, Prod"
	And I select site "Miscellaneous Site"
	And I create Subject "<Subject 4>"
	When I select form "Template Form"
	Then I should see button "Sign and Save"
	And I take Screenshot 23a, 23b
	
	And I select Link "Modify Template"
	And I create "New Template"
	And I select Fields arrow
	And I Uncheck last two fields
	And I select Update link
	And I select form "Template Form"
	When I select "<New Template>" from Templates Dropdown
	Then I should see button "Sign and Save"
	And I take Screenshot 24a, 24b
	
	And I enter data
	And I select button "Sign and Save"
	And I enter signature credentials
	When I select button "<Sign>" for "<user>", from the table below
		|user			|Sign			|
		|CDM1<id>		|Sign and Save	|
		|esiguser4<id>	|eSign			|
	Then I should see "<New Template>" form signed
	And I take Screenshot 25a, 25b
	
	When I select "..." from Templates Dropdown
	Then I should see button "Sign and Save"
	And I take Screenshot 26a, 26b
	
	And I select button "Sign and Save"
	And I enter signature credentials
	When I select button "<Sign>" for "<user>", from the table below
		|user			|Sign			|
		|CDM1<id>		|Sign and Save	|
		|esiguser4<id>	|eSign			|
	Then I should see "Template Form" form signed
	And I take Screenshot 27a, 27b
	
	When I select datapage audit icon
	Then I should see text "Signature has been broken."
	And I should see text "User signature succeeded."
	And I take Screenshot 28a, 28b

#----------------------------------------------------------------------------------------------------------------------
@release_564_patch9
@PB1-350
@Validation
Scenario Outline: New eSig functionality verification for a field set to "Does not participate in Signature".

	And I am logged in as user "<User>" with password "<Password>" in "<App>"
		|User		|Password	|App		|
		|CDM1<id>	|password	|Rave		|
		|esiguser4<id>	|Password1	|iMedidata	|
	And I navigate to study "eSig Enhancements Project <id>, Prod"
	And I select site "Miscellaneous Site"
	And I create Subject "<Subject 5>"
	And I select form "Form1"
	And I enter data in standard field 'Field 1A'
	And I enter data in standard field 'Field 2A'	
	And I select button "Sign and Save"
	And I enter signature credentials	
	When I select button "<Sign>" for "<user>", from the table below
		|user			|Sign			|
		|CDM1<id>		|Sign and Save	|
		|esiguser4<id>	|eSign			|	
	Then I should see "Form1" signed
	And I take Screenshot 29a, 29b

	And I modify data in standard field 'Field 1A'
	When I select button "Save"
	Then I should not see button "Sign and Save"
	And I should see "Form1" signed
	And I take Screenshot 30a, 30b
	
	And I modify data in standard field 'Field 2A'
	When I select button "Save"
	Then I should see button "Sign and Save"
	And I should see "Form1" not signed
	And I take Screenshot 31a, 31b
	
#----------------------------------------------------------------------------------------------------------------------
@release_564_patch9
@PB1-400
@Validation
Scenario Outline: New eSig functionality verification for a field with Marking and comments.

	And I am logged in as user "<User>" with password "<Password>" in "<App>"
		|User		|Password	|App		|
		|CDM1<id>	|password	|Rave		|
		|esiguser4<id>	|Password1	|iMedidata	|
	And I navigate to study "eSig Enhancements Project <id>, Prod"
	And I select site "Miscellaneous Site"
	And I create Subject "<Subject 6>"
	And I select form "Form2"
	And I enter data in standard fields
	And I select button "Sign and Save"
	And I enter signature credentials	
	When I select button "<Sign>" for "<user>", from the table below
		|user			|Sign			|
		|CDM1<id>		|Sign and Save	|
		|esiguser4<id>	|eSign			|	
	Then I should see "Form2" signed
	And I take Screenshot 32a, 32b
	
	And I open "Manual Query"
	When I select button "Save"
	Then I should not see button "Sign and Save"
	And I should see "Form2" signed
	And I take Screenshot 33a, 33b
	
	And I cancel "Manual Query"
	When I select button "Save"
	Then I should not see button "Sign and Save"
	And I should see "Form2" signed
	And I take Screenshot 34a, 34b
	
	And I add "Sticky"
	When I select button "Save"
	Then I should not see button "Sign and Save"
	And I should see "Form2" signed
	And I take Screenshot 35a, 35b
	
	And I Acknowledge "Sticky"
	When I select button "Save"
	Then I should not see button "Sign and Save"
	And I should see "Form2" signed
	And I take Screenshot 36a, 36b	

	And I add "Protocol Deviation"
	When I select button "Save"
	Then I should not see button "Sign and Save"
	And I should see "Form2" signed
	And I take Screenshot 37a, 37b
	
	And I Inactivate "Protocol Deviation"
	When I select button "Save"
	Then I should not see button "Sign and Save"
	And I should see "Form2" signed
	And I take Screenshot 38a, 38b
	
	And I select datapoint audit icon
	And I add "Comment"
	When I select button "Submit"
	Then I should not see button "Sign and Save"
	And I should see "Form2" signed
	And I take Screenshot 39a, 39b

	And I Inactivate "Comment"
	When I select button "Save"
	Then I should not see button "Sign and Save"
	And I should see "Form2" signed
	And I take Screenshot 40a, 40b
	
	And I select datapoint audit icon
	And I should not see text "Signature has been broken."	
	And I should see text "User signature succeeded."
	And I take Screenshot 41a, 41b
	
#----------------------------------------------------------------------------------------------------------------------
@release_564_patch9
@PB1-450
@Validation
Scenario Outline: New eSig functionality verification on a Log form (Portrait View).

	And I am logged in as user "<User>" with password "<Password>" in "<App>"
		|User			|Password	|App		|
		|CDM1<id>		|password	|Rave		|
		|esiguser4<id>	|Password1	|iMedidata	|
	And I navigate to study "eSig Enhancements Project <id>, Prod"
	And I select site "Miscellaneous Site"
	And I create Subject "<Subject 7>"
	And I select form "Portrait"
	And I enter data
	And I select button "Sign and Save"
	And I enter signature credentials	
	When I select button "<Sign>" for "<user>", from the table below
		|user			|Sign			|
		|CDM1<id>		|Sign and Save	|
		|esiguser4<id>	|eSign			|	
	Then I should see "Portrait" form signed
	And I should not see button "Sign and Save"	
	And I take Screenshot 42a, 42b	 
	
	And I modify data
	When I select button "Save"
	Then I should see button "Sign and Save"
	And I should see "Portrait" form not signed
	And I take Screenshot 43a, 43b
	
#----------------------------------------------------------------------------------------------------------------------
@release_564_patch9
@PB1-500
@Validation
Scenario Outline: New eSig functionality verification on a Log form (Landscape View).

	And I am logged in as user "<User>" with password "<Password>" in "<App>"
		|User			|Password	|App		|
		|CDM1<id>		|password	|Rave		|
		|esiguser4<id>	|Password1	|iMedidata	|
	And I navigate to study "eSig Enhancements Project <id>, Prod"
	And I select site "Miscellaneous Site"
	And I create Subject "<Subject 8>"
	And I select form "Landscape"
	And I enter data
	And I select button "Sign and Save"
	And I enter signature credentials	
	When I select button "<Sign>" for "<user>", from the table below
		|user			|Sign			|
		|CDM1<id>		|Sign and Save	|
		|esiguser4<id>	|eSign			|	
	Then I should see "Landscape" form signed
	And I should not see button "Sign and Save"	
	And I take Screenshot 44a, 44b	 
	
	And I modify data
	When I select button "Save"
	Then I should see button "Sign and Save"
	And I should see "Landscape" form not signed
	And I take Screenshot 45a, 45b	
		
#----------------------------------------------------------------------------------------------------------------------
@release_564_patch9
@PB1-550
@Validation
Scenario: When "Two Part Esig Identification Option" and "Continuous Esig Session Timeout (Minutes)" is not set in Rave Configuration>Other Settings, new eSig modal should only display 'Password' text field.
	
	And I am logged in as user "<User>" with password "<Password>" in "<App>"
		|User		|Password	|App		|
		|CDM1<id>	|password	|Rave		|
	And I select link "Configuration"
	And I select link "Other Settings"
	And I Uncheck checkbox "Continuous Esig Session Timeout (Minutes)"
	And I take Screenshot 46
	And I select link "Update"
	And I select link "Home"
	And I select study "eSig Enhancements Project <id>, Prod"
	And I select site "Mix eSig Site 03<id>"
	And I create Subject "<Subject 9>"
	When I select button "Sign and Save" on subject calendar page
	Then I should see text field "Password"
	And I should see text "Password"
	And I should not see text field "User Name"
	And I should not see text "User Name"
	And I take Screenshot 47
	And I close eSig Modal
	
	And I select link "Grid View"
	And I select link "All"
	When I select button "Sign and Save"
	Then I should see text field "Password"
	And I should see text "Password"
	And I should not see text field "User Name"
	And I should not see text "User Name"
	And I take Screenshot 48
	And I close eSig Modal
	
	And I select tab "Subject Name"
	And I select link "Form2" on Subject level
	When I select button "Sign and Save"
	Then I should see text field "Password"
	And I should see text "Password"
	And I should not see text field "User Name"
	And I should not see text "User Name"
	And I take Screenshot	49
	And I enter signature credentials		
	When I select button "Sign and Save"	
	Then I should see "Form2" form signed
	And I take Screenshot	50
	
#----------------------------------------------------------------------------------------------------------------------
@release_564_patch9
@PB1-600
@Validation
Scenario: New eSig functionality verification on a form with translated field.

	And I am logged in as user "<User>" with password "<Password>" in "<App>"
		|User		|Password	|App		|
		|CDM1<id>	|password	|Rave		|
	And I update user locale to "Locaization Test" in My Profile
	And I navigate to study "eSig Enhancements Project <id>, Prod"
	And I select site "Miscellaneous Site"
	And I create Subject "<Subject 10>"
	And I select form "Translation" on Subject level
	And I enter data in standard field
	When I select button "Save"
	Then I should see button "Sign and Save"
	And I take Screenshot 51
	And I update user locale to "English" in My Profile
	And I navigate to Subject "<Subject 10>"
	And I select form "Translation" on Subject level
	And I translate field
	And I select button "Sign and Save"
	And I enter signature credentials	
	When I select button "Sign and Save"
	Then I should see "Translation" form signed
	And I should see field translated
	And I take Screenshot 52
	
#----------------------------------------------------------------------------------------------------------------------
@release_564_patch9
@PB1-650
@Validation
Scenario: New eSig functionality verification on a Lab form.

	And I am logged in as user "<User>" with password "<Password>" in "<App>"
		|User		|Password	|App		|
		|CDM1<id>	|password	|Rave		|
	And I navigate to study "Lab Project, Prod"
	And I select site "Lab Site"
	And I create Subject "<Subject 11>"
	And I select form "Lab Demographics" on Subject level
	And I enter "<Data>" in standard field
		|Data		|
		|22			|
		|male		|
		|no			|
	And I select button "Save"
	And I select form "LabForm" on Subject level
	And I should see button "Sign and Save"
	And I take Screenshot 53	
	And I assign lab from lab dropdown
	And I enter data
	And I select button "Sign and Save"
	And I enter signature credentials	
	When I select button "Sign and Save"
	Then I should see "LabForm" signed
	And I should see lab field submitted
	And I take Screenshot 54	

#----------------------------------------------------------------------------------------------------------------------
@release_564_patch9
@PB1-700
@Validation
Scenario: Verify Help Contents for new eSig Functionality
	
	And I am logged in as user "CDM1<id>"
	And I select study "eSig Enhancements Project <id>, Prod"
	And I select site "Miscellaneous Site"
	And I create Subject "<Subject 12>"
	And I select form "Form2"
	And I select link "Help"
	And I select link "Cannot find what you are looking for? Search Entire Help."
	And I verify help contents for "<Pages>" under "Data Verification"
     |Pages											    |
     |Investigator Signature							|
     |Batch Signing Folders or Forms from the Grid View	|
     |Batch Signing Subjects from the Calendar View	    |
	And I take Screenshot 55

#----------------------------------------------------------------------------------------------------------------------
@release_564_patch9
@PB1-750
@Validation
Scenario: New eSig functionality verification for Productivity Report.

	And I am logged in as user "<User>" with password "<Password>" in "<App>"
		|User		|Password	|App		|
		|CDM1<id>	|password	|Rave		|
	And I navigate to study "eSig Enhancements Project <id>, Prod"
	And I select site "Miscellaneous Site"
	And I create Subject "<Subject 13>"
	And I select form "Form1"
	And I enter data in standard fields
	And I select button "Sign and Save"
	And I enter signature credentials	
	When I select button "Sign and Save"	
	Then I should see "Form1" signed
	And I take Screenshot 56
	
	And I select link "Home"
	And I select link "Report Administration"
	And I assign report "Productivity" to "CDM1<id>" user
	
	And I select link "Home"
	And I select link "Reporter"
	And I select link "Productivity" report
	And I select "eSig Enhancements Project <id>, Prod"
	When I select button "Submit Report"
	Then I should see "Count" for column "Pgs Signed" in row "Miscellaneous Site" site and "CDM1<id>" user
	And I take Screenshot 57
	And I close report
	
	And I navigate Subject "<Subject 13>" in EDC
	And I select form "Form2"
	And I enter data in standard fields
	And I select button "Sign and Save"
	And I enter signature credentials	
	When I select button "Sign and Save"	
	Then I should see "Form2" signed
	And I take Screenshot 58

	And I select link "Home"
	And I select link "Reporter"
	And I select link "Productivity" report
	And I select "eSig Enhancements Project <id>, Prod"
	When I select button "Submit Report"
	Then I should see "Count+1" for column "Pgs Signed" in row "Miscellaneous Site" site and "CDM1<id>" user
	And I take Screenshot 59
	And I close report

#----------------------------------------------------------------------------------------------------------------------
@release_564_patch9
@PB1-800
@Validation
Scenario: Generating Data PDF for New eSig functionality verification.

	And I am logged in as user "<User>" with password "<Password>" in "<App>"
		|User		|Password	|App		|
		|CDM1<id>	|password	|Rave		|
	And I navigate to study "eSig Enhancements Project <id>, Prod"
	And I select site "Miscellaneous Site"
	And I create Subject "<Subject 14>"
	And I select form "Form1"
	And I enter data in standard fields
	And I select button "Sign and Save"
	And I enter signature credentials	
	When I select button "Sign and Save"	
	Then I should see "Form1" signed
	And I take Screenshot 60
	
	And I select link "Home"
	And I select link "PDF Generator"
	And I select link "Create Data Request"
	And I create data pdf for subject "<Subject 14>"
	And I generate pdf
	And I select link "My PDF Files"
	And I open and view PDF
	When I select form "Form1" in PDF
	Then I should see signature text
	And I take Screenshot 61
	
	And I verify Audits in PDF
	And I take Screenshot 62

#----------------------------------------------------------------------------------------------------------------------
@release_564_patch9
@PB1-300
@Validation
Scenario Outline: Browser testing for new eSig functionality

	And I am logged in as user "<User>" with password "<Password>" in "<App>"
		|User		|Password	|App		|
		|CDM1<id>	|password	|Rave		|
		|esiguser4<id>	|Password1	|iMedidata	|
	And I navigate to study "eSig Enhancements Project <id>, Prod"
	And I select site "Miscellaneous Site"
	And I create Subject "<Subjects>"
		|Subjects		|
		|IE 7			|
		|IE 8			|
		|IE 9			|
		|IE 10			|
		|FF 			|
		|GC 			|
		|Safari			|
	And I select "Form2" link on subject level
	When I select button "Sign and Save" in '<Browser>' for '<Subjects>', from the table below
		|Subjects		|Browser 		|
		|IE 7			|IE7			|
		|IE 8			|IE8			|
		|IE 9			|IE9			|
		|IE 10			|IE10			|
		|FF				|Firefox 		|
		|GC 			|Google Chrome	|
		|Safari			|Safari			|
	Then I should see logo 
	And I should see text field "User Name"
	And I should see text "User Name"
	And I should see text "Password"	
	And I should see text field "Password"
	And I should see button "<Sign>" for "<user>", from the table below
		|user			|Sign			|
		|CDM1<id>		|Sign and Save	|
		|esiguser4<id>	|eSign			|
	And I take Screenshot 63a-63f
	
	And I enter signature credentials
	When I select button "<Sign>" for "<user>", from the table below
		|user			|Sign			|
		|CDM1<id>		|Sign and Save	|
		|esiguser4<id>	|eSign			|
	Then I should see "Form2" signed
	And I take Screenshot 64a-64f
	
	And I select "Grid View" link on subject calendar page
	And I select link "Folder A"
	When I select button "Sign and Save" on subject Grid View page in '<Browser>' for '<Subjects>', from the table below
		|Subjects		|Browser 		|
		|IE 7			|IE7			|
		|IE 8			|IE8			|
		|IE 9			|IE9			|
		|IE 10			|IE10			|
		|FF				|Firefox 		|
		|GC 			|Google Chrome	|
		|Safari			|Safari			|
	Then I should see logo 
	And I should see text field "User Name"
	And I should see text "User Name"
	And I should see text "Password"	
	And I should see text field "Password"
	And I should see button "<Sign>" for "<user>", from the table below
		|user			|Sign			|
		|CDM1<id>		|Sign and Save	|
		|esiguser4<id>	|eSign			|
	And I take Screenshot 65a-65f
	
	And I enter signature credentials
	When I select button "<Sign>" for "<user>", from the table below
		|user			|Sign			|
		|CDM1<id>		|Sign and Save	|
		|esiguser4<id>	|eSign			|
	Then I should see "Your signature is being applied. You may continue working on other subjects."
	And I take Screenshot 66a-66f
	
	When I select button "Sign and Save" on subject calendar page in '<Browser>' for '<Subjects>', from the table below
		|Subjects		|Browser 		|
		|IE 7			|IE7			|
		|IE 8			|IE8			|
		|IE 9			|IE9			|
		|IE 10			|IE10			|
		|FF				|Firefox 		|
		|GC 			|Google Chrome	|
		|Safari			|Safari			|
	Then I should see logo 
	And I should see text field "User Name"
	And I should see text "User Name"
	And I should see text "Password"	
	And I should see text field "Password"
	And I should see button "<Sign>" for "<user>", from the table below
		|user			|Sign			|
		|CDM1<id>		|Sign and Save	|
		|esiguser4<id>	|eSign			|
	And I take Screenshot 67a-67f
	
	And I enter signature credentials
	When I select button "<Sign>" for "<user>", from the table below
		|user			|Sign			|
		|CDM1<id>		|Sign and Save	|
		|esiguser4<id>	|eSign			|
	Then I should see "Your signature is being applied. You may continue working on other subjects."
	And I take Screenshot 68a-68f
	
#----------------------------------------------------------------------------------------------------------------------
@release_564_patch9
@PB1-850
@Validation
Scenario:  Mixed form with 1 standard Signature field with and 3 log fields will have correct record and correct datapoints on form submission

	And I am logged in as user "<User>" with password "<Password>" in "<App>"
		|User		|Password	|App		|
		|CDM1<id>	|password	|Rave		|
	And I create Subject "Mixed FRM Signature Subject1"
	And I select form "SIGNATURE" in folder "SIGNATURE"
	And I note datapageid "DatapageID"
	And I add new log lines
	And I sign the Signature field
	And I select button "Save"
	And I take Screenshot 69
	When I execute sql query "<SQL 1>"
	Then I should see entries located in "Records" table, from the table below 
		|Row|RecordPosition	|IsHidden	|ChangeCount	|ChangeCode	|DataActive	|IsVisible	|IsTouched	|
		|1	|0				|0			|1				|0			|1			|1			|1			|
		|2	|0				|1			|0				|0			|1			|1			|0			|
		|3	|0				|1			|0				|0			|1			|1			|0			|
		|4	|0				|1			|0				|0			|1			|1			|0			|
		|5	|1				|1			|1				|0			|1			|1			|1		 	|
		|6	|1				|0			|0				|0			|1			|1			|0		 	|
		|7	|1				|0			|0				|0			|1			|1			|0			|
		|8	|1				|0			|0				|0			|1			|1			|0			|
		|9	|2				|1			|1				|NULL		|1			|1			|1			|
		|10	|2				|0			|1				|NULL		|1			|1			|1			|
		|11	|2				|0			|1				|NULL		|1			|1			|1		 	|
		|12	|2				|0			|1				|NULL		|1			|1			|1		 	|
	And I verify entered "Data"		
	And I take Screenshot 70
	And I select form "SIGNATURE" in "EDC"
	And I modify log field
	And I sign the Signature field
	And I select button "Save"
	And I take Screenshot 71
	When I execute sql query "<SQL 1>"
	Then I should see entries located in "Records" table, from the table below 
		|Row|RecordPosition	|IsHidden	|ChangeCount	|ChangeCode	|DataActive	|IsVisible	|IsTouched	|
		|1	|0				|0			|2				|NULL		|1			|1			|1			|
		|2	|0				|1			|0				|0			|1			|1			|0			|
		|3	|0				|1			|0				|0			|1			|1			|0			|
		|4	|0				|1			|0				|0			|1			|1			|0			|
		|5	|1				|1			|3				|NULL		|1			|1			|1		 	|
		|6	|1				|0			|1				|NULL		|1			|1			|1		 	|
		|7	|1				|0			|1				|NULL		|1			|1			|1			|
		|8	|1				|0			|1				|NULL		|1			|1			|1			|
		|9	|2				|1			|3				|NULL		|1			|1			|1			|
		|10	|2				|0			|2				|NULL		|1			|1			|1			|
		|11	|2				|0			|2				|NULL		|1			|1			|1		 	|
		|12	|2				|0			|2				|NULL		|1			|1			|1		 	|
	And I verify entered "Data"
	And I take Screenshot 72		
	When I execute sql query "<SQL 2>"
	Then I should see entries, from the table below
		|RecordPosition	|
		|1				|
		|2				|
	And I verify submitted "Data"
	And I take Screenshot 73a , 73b, 73c, 73d
	When I execute sql query "<SQL 3>"
	Then I verify audits in column "Readable"
	And I take Screenshot  74a, 74b		
	When I open "Data Listing Report" in "Rave"
	Then I verify entered "Data" in column "Data"
	And I take Screenshot 75a , 75b
	
#------------------------------------------------------------------------------------------------------------