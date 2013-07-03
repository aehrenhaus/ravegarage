# Users: eSignature Request for Authentication by external user
#Rave allows for eSignatures to be applied to Forms, Folders and Subjects, as well as eLearning confirmation pages. 
#As part of Rave’s current user authentication model, the user submits their eSignature credentials as a binding eSignature in Rave. For all externally authenticated users, the eSignature credentials will be passed to iMedidata CAS for verification. iMedidata CAS will process verification requests for all external users, including those authenticated by independent, third-party Identity Providers (IDP). The PIN Code on iMedidata serves as a PIN on Rave. 
#Note: For the purposes of this feature, an external user is defined as any user that is authenticated by a system other than Rave, including iMedidata and trusted, third-party IDPs (Identity Providers). Tests done for iMedidata users will adequately test the same functionality for an IDP user 1. If any explicit functional differences exist between iMedidata and IDP, they will be explicity called out where they are known to exist.
#Rave supports two types of eSignature methods. The old style eSignature which is built into the eCRF form using an eSig field OID, which is being deprecated beginning in Rave 5.6.4 patch 9. This signature method relies on credentials residing in the Rave database or direct API communication to mimic the credentials being stored in the Rave database for performing the verification to support eSignatures which validate individual datapoints. Old style signature fields will not support external eSignature attempts for IDP user 1s, but iMedidata users will be able to sign these fields individually. Batch signing of old style signatures is not supported for external users, including iMedidata users.
#The new style eSignature, which resides at the form level, offers the flexibility to use iMedidata CAS to authenticate or verify user credentials. These form level verfications provide a more efficient means of bulk signing and do not require individual datapoint verification.
# The new style signatures will leverage the Sign and Save eSignature method of verifying and applying an eSignature to the form (or forms) before saving changes. A modal window will be used to present the signature request and to capture the credentials for verification. If verification succeeds, data is saved and the eSignature is applied to all new style forms. 
#Verification messages between iMedidata and Rave will be goverened by the SAML protocol which will provide either a success message or a lockout message. iMedidata CAS will broker verification attempts for IDP user 1s through SAML requests sent to the IDP. IDP responses will be passed back to Rave through iMedidata CAS.
#Rave will not capture eSignature authentication attempts for external users; the responsibility for tracking verification attempts will lie with the identity provider (iMedidata or IDP) who also determines the verification criteria and the lockout threshold. By default, iMedidata sets a failure threshold of 5 failed attempts before the user is locked out. iMedidata users will now be able to fail 5 signature attempts before hitting the threshold. Each IDP will set its own lockout threshold and that threshold will be respected for signature attempts made in Rave. 
#eSignature failure messages and audit failure messages will be simplified so that users are not given information that would compromise Rave security. Audit success messages will be simplified and unified to match the failure messages and to accurately reflect the message content defined by the SAML protocol. 


Feature: eSignature for external user
	As an externally authenticated user, I want to apply an electronic signature to forms from form level, calendar view and grid view for a study with a mix of Rave old and new style signatures 
	
Background:
	Given I am a iMedidata user "<User>" with pin "<PIN>" password "<Password>" and user id "User ID>"
		|User					|PIN					| Password					|User ID				|
		|{iMedidata User 1}		|{iMedidata User PIN}	|{iMedidata User Password}	|{iMedidata User ID}	|
	And there exists study "<Study>"
		|Study		|
		|{Study A}	|
	And there exists app "<App>" associated with study "<Study>", from the table below	
		|App			|
		|{Edc App}		|
		|{EModules App}	|	
	And there exists site "<Site>" in study "<Study>", from the table below		
		|Study		|Site		|
		|{Study A}	|{Site A1}	|
	And there exists subject "<Subject>" in site "<Site>", from the table below
		|Site		|Subject		|
		|{Site A1}	|{SUB A1001}	|
		|{Site A1}	|{SUB A1002}	|
		|{Site A1}	|{SUB A1003}	|
		|{Site A1}	|{SUB A1004}	|
	And there exists form "<Form>" has signature required "<Signature Required>" in row "<Row>", from the table below
		|Row	|Form		|Signature Required	|
		|1		|{Form1}	|True				|
		|2		|{Form2}	|False				|
		
	And there exists form "<Form>" has fields "<Fields>" has varOID "<VarOID>" has format "<Format>" has field name "<Field Name>" has fied OID "<Field OID>" has active status "<Active>" has visible status "<Is visible fields>" has field label "<Field Label>" has control type "<Control Type>", from the table below
		|Form		|Fields			|VarOID			|Format			|Field Name	|Field OID	|Active	|Is visible fields	|Field Label		|Control Type	|
		|{Form1}	|{Field 1A}		|{FIELD1A}		|$4				|{FIELD1A}	|{FIELD1A}	|True	|True				|{Field 1A}			|Text			|
		|{Form1}	|{Field 2A}		|{FIELD2A}		|$4				|{FIELD2A}	|{FIELD2A}	|True	|True				|{Field 2A}			|Text			|  
	
		|{Form2}	|{Field 1B}		|{FIELD1B}		|$4				|{FIELD1B}	|{FIELD1B}	|True	|True				|{Field 1B}			|Text			| 
		|{Form2}	|{Field 2B}		|{FIELD2B}		|$4				|{FIELD2B}	|{FIELD2B}	|True	|True				|{Field 2B}			|Text			|
		|{Form2}	|{Sign Form2}	|{SIGFORM1}		|eSigPage 		|{SIGFORM2}	|{SIGFORM2}	|True	|True				|{Sign Form2}		|Signature		| 
	And there exists folder "<Folder>" has child folder "<Child Folder>", from the table below
		|Folder		|
		|{Folder A} |
	And there exists matrix "<Matrix>" has folder "<Folder>" has form "<Form>", from the table below
		|Matrix		|Folder		|Form		|
		|{Matrix 1}	|{Folder A}	|{Form1}	|
		|{Matrix 1}	|{Folder A}	|{Form2}	|
		|{Matrix 2}	|{Folder B}	|{Form2}	|
	And there exists form "<Form>" in subject "<Subject>", from the table below
		|Subject		|Form		|
		|{SUB A1001}	|{Form1}	|
		|{SUB A1001}	|{Form2}	|	
		|{SUB A1001}	|{Form3}	|	
	And	user "<User>" has Sign privileges and has access to site "{Site A1}" that is in study "{Study A}" in database "<EDC> Database", from the table below
		|User					|
		|{iMedidata User 1}		|	

#------------------------------------------------------------------------------------------------------------
@release_564_patch9
@v2.5.4.1
@Validation
Scenario: As an iMedidata user, I can sign a form using the new eSig format after data has been entered and I can view the audit trail

	And I login as user "<iMedidata User 1>"
	And I select study "<Study A>"
	And I select app "<App>"
	And I select site "<Site A1>" that is in study "<Study A>"
	And I create a subject
	And I select form "<Form1>"
	And I enter data in field "<Field 1A>" on "<Form1>" in subject "<Subject>"
	And I enter data in field "<Field 2A>" on "<Form1>" in subject "<Subject>"
	And I click button "Sign And Save"
	And I should see "Pop Up" window
	And I enter username textbox with User ID "<iMedidata User ID>"
	And I enter password textbox with Password "<iMedidata User Password>"
	And I click button "eSign"
	When I click icon "Complete" for form "<Form1>" in subject "<Subject>" 
	Then I should see the message "User signature succeeded." on the form level audit for form "<Form1>" in subject "<Subject>"
	And I should see the message "DataPage created." on the form level audit for form "<Form2>" in subject "<Subject>"
	And I take a screenshot
	And I go back to form "<Form1>"
	When I click icon "Complete" on "Field 1A" on form "<Form1>" in subject "<Subject>"
	Then I should see the message "User entered 'data'" on the audit for field "<Field 1A>" on form "<Form1>" in subject "<Subject>"	
	And I should see the message "User signature succeeded." on the audit for field "<Field 1A>" on form "<Form1>"	in subject "<Subject>"
	And I take a screenshot
	And I go back to form "<Form1>"
	When I click icon "Complete" on "Field 2A" on form "<Form1>" in subject "<Subject>"
	Then I should see the message "User entered 'data'" on the audit for field "<Field 2A>" on form "<Form1>" in subject "<Subject>"
	And I should see the message "User signature succeeded." on the audit for field "<Field 2A>" on form "<Form1>" in subject "<Subject>"	
	And I take a screenshot		

#------------------------------------------------------------------------------------------------------------
@release_564_patch9
@PB_2.5.4.2
@Validation
Scenario: As an iMedidata user, I can sign a form using the old esig format after data has been entered and I can view the audit trail

	And I login as user "<iMedidata User 1>"
	And I select study "<Study A>"
	And I select app "<App>"
	And I select site "<Site A1>" that is in study "<Study A>"
	And I create a subject
	And I select form "<Form2>"
	And I enter data in field "<Field 1B>" on "<Form2>" in subject "<Subject>"
	And I enter data in field "<Field 2B>" on "<Form2>" in subject "<Subject>"
	And I enter iMedidata User Name "<iMedidata User ID>" and Password "< iMedidata User Password>" on "<Sign2>" in subject "<Subject>"
	When I click button "<Save>"
	Then I shoud see icon "Complete" for form "<Form2>" in subject "<Subject>" 
	And I should see icon "Complete" on "Field 1B" on form "<Form2>" in subject "<Subject>"
	And I should see icon "Complete" on "Field 2B" on form "<Form2>" in subject "<Subject>"
	And I should see User's Name and Title
	And I should see User's date and timezone
	And I take a screenshot
	When I click icon "Complete" on "Field 1B" on form "<Form2>" in subject "<Subject>"
	Then I should see the message "User entered 'data'" on the audit for field "<Field 1B>" on form "<Form2>" in subject "<Subject>"	
	And I should see the message "User signature succeeded." on the audit for field "<Field 1B>" on form "<Form2>"	in subject "<Subject>"
	And I take a screenshot
	And I go back to form "<Form2>"
	When I click icon "Complete" on "Field 2B" on form "<Form2>" in subject "<Subject>"
	Then I should see the message "User entered 'data'" on the audit for field "<Field 2B>" on form "<Form2>" in subject "<Subject>"
	And I should see the message "User signature succeeded." on the audit for field "<Field 2B>" on form "<Form2>" in subject "<Subject>"	
	And I take a screenshot		
	And I go back to form "<Form2>"
	When I click icon "Complete" on "Sign2" on form "<Form2>" in subject "<Subject>"
	And I should see the message "User signature succeeded." on the audit for field "<Sign2>" on form "<Form2>" in subject "<Subject>"	
	And I go back to form "<Form2>"
	When I click icon "Complete" on "Form" on form "<Form2>" in subject "<Subject>"
	And I should see the message "DataPage created" on the audit for form "<Form2>" in subject "<Subject>"	
	And I should see the message "User signature succeeded." on the audit for form "<Form2>" in subject "<Subject>"	
	And I take a screenshot
		
#------------------------------------------------------------------------------------------------------------
@release_564_patch9
@PB_2.5.4.3
@Validation
Scenario: As an iMedidata user signing with the old esig format with a bad username, I see a warning message on the form

	And I login as user "<iMedidata User 1>"
	And I select study "<Study A>"
	And I select app "<App>"
	And I select site "<Site A1>" that is in study "<Study A>"
	And I create a subject
	And I select form "<Form2>"
	And I enter data in field "<Field 1B>" on "<Form2>" in subject "<Subject>"
	And I enter data in field "<Field 2B>" on "<Form2>" in subject "<Subject>"
	And I enter iMedidata User Name "<iMedidata User ID>xx" and Password "< iMedidata User Password>" on "<Form2>" in subject "<Subject>"
	When I click button "<Save>"
	Then I should see the text "Signature attempt failed"
	Then I shoud see icon "Incomplete" for form "<Form2>" in subject "<Subject>" 
	And I should see icon "Requires Signature" on "Field 1B" on form "<Form2>" in subject "<Subject>"
	And I should see icon "Requires Signature" on "Field 2B" on form "<Form2>" in subject "<Subject>"
	And I should see icon "Never Touched" on "Sign2" on form "<Form2>" in subject "<Subject>"
	And I take a screenshot

#------------------------------------------------------------------------------------------------------------
@release_564_patch9
@PB_2.5.4.4
@Validation
Scenario: Outline: As an iMedidata user signing with the old esig format with a bad password, I see a warning message on the form

	And I login as user "<iMedidata User 1>"
	And I select study "<Study A>"
	And I select app "<App>"
	And I select site "<Site A1>" that is in study "<Study A>"
	And I create a subject
	And I select form "<Form2>"
	And I enter data in field "<Field 1B>" on "<Form2>" in subject "<Subject>"
	And I enter data in field "<Field 2B>" on "<Form2>" in subject "<Subject>"
	And I enter iMedidata User Name "<iMedidata User ID>" and Password "< iMedidata User Password>xx" on "<Sign2>" in subject "<Subject>"
	When I click button "<Save>"
	Then I should see the text "Signature attempt failed"
	Then I shoud see icon "Incomplete" for form "<Form2>" in subject "<Subject>" 
	And I should see icon "Requires Signature" on "Field 1B" on form "<Form2>" in subject "<Subject>"
	And I should see icon "Requires Signature" on "Field 2B" on form "<Form2>" in subject "<Subject>"
	And I should see icon "Never Touched" on "Sign2" on form "<Form2>" in subject "<Subject>"
	And I take a screenshot
	
#------------------------------------------------------------------------------------------------------------
@release_564_patch9
@PB_2.5.4.5
@Validation
Scenario: As an iMedidata user that collects 3 failed signature attempts on a form using the old style esig format, I see that my Rave session ends and I am on the iMedidata login page

	And I login as user "<iMedidata User 1>"
	And I select study "<Study A>"
	And I select app "<App>"
	And I select site "<Site A1>" that is in study "<Study A>"
	And I create a subject
	And I select form "<Form2>"
	And I enter data in field "<Field 1B>" on "<Form2>" in subject "<Subject>"
	And I enter data in field "<Field 2B>" on "<Form2>" in subject "<Subject>"
	And I enter username textbox with User ID "<iMedidata User ID>"
	And I enter password textbox with Password "<iMedidata User Password>xx"
	When I click the button "Save"
	Then I should see the text "Signature attempt failed"
	And I enter username textbox with User ID "<iMedidata User ID>"
	And I enter password textbox with Password "<iMedidata User Password>xx"
	When I click the button "Save"
	Then I should see the text "Signature attempt failed"
	And I enter username textbox with User ID "<iMedidata User ID>"
	And I enter password textbox with Password "<iMedidata User Password>xx"
	When I click the button "Save"
	Then I should see page "iMedidata Login Page"
	And I should see text "Welcome to iMedidata"
	And I take a screenshot

#------------------------------------------------------------------------------------------------------------
@release_564_patch9
@PB_2.5.4.6
@Validation
Scenario: As an iMedidata user that collects 5 failed signature attempts on a form using the new style esig format, I see that my Rave session ends and I am on the iMedidata login page

	And I login as user "<iMedidata User 1>"
	And I select study "<Study A>"
	And I select app "<App>"
	And I select site "<Site A1>" that is in study "<Study A>"
	And I create a subject
	And I select form "<Form1>"
	And I enter data in field "<Field 1A>" on "<Form1>" in subject "<Subject>"
	And I enter data in field "<Field 2A>" on "<Form1>" in subject "<Subject>"
	And I click button "Sign And Save"
	And I should see "Pop Up" window
	And I enter username textbox with User ID "<iMedidata User ID>"
	And I enter password textbox with Password "<iMedidata User Password>xx"
	And I click button "eSign"
	And I see the message "You tried to sign with a username and password that is not recognized" on the pop up on the pop up
	And I enter username textbox with User ID "<iMedidata User ID>"
	And I enter password textbox with Password "<iMedidata User Password>xx"
	And I click button "eSign"
	And I see the message "You tried to sign with a username and password that is not recognized" on the pop up on the pop up
	And I enter username textbox with User ID "<iMedidata User ID>"
	And I enter password textbox with Password "<iMedidata User Password>xx"
	And I click button "eSign"
	And I see the message "You tried to sign with a username and password that is not recognized" on the pop up on the pop up
	And I enter username textbox with User ID "<iMedidata User ID>"
	And I enter password textbox with Password "<iMedidata User Password>xx"
	And I click button "eSign"
	And I see the message "You tried to sign with a username and password that is not recognized" on the pop up on the pop up
	And I take a screenshot
	And I enter username textbox with User ID "<iMedidata User ID>"
	And I enter password textbox with Password "<iMedidata User Password>xx"
	When I click button "eSign"
	Then I see pop up "Confirm"
	And I take a screenshot
	When I click "OK"
	The I should see page "iMedidata Login Page"
	And I should see text "Welcome to iMedidata"
	And I take a screenshot
	
#------------------------------------------------------------------------------------------------------------
@release_564_patch9
@PB_2.5.4.7
@Validation
Scenario:When an iMedidata user with batch sign permissions creates a subject, the user will see the button "Sign and Save" on Calendar view.

	And I login as user "<iMedidata User 1>"
	And I select study "<Study A>"
	And I select app "<App>"
	And I select site "<Site A1>" that is in study "<Study A>"
	When I create a subject
	Then I should see button "Sign And Save"
	And I take a screenshot

#------------------------------------------------------------------------------------------------------------
@release_564_patch9
@PB_2.5.4.8
@Validation
Scenario: When an imedidata user clicks the  "Sign and Save" button on the subject homepage a pop up window will be displayed for a Study that has old and new style signatures

	And I login as user "<iMedidata User 1>"
	And I select study "<Study A>"
	And I select app "<App>"
	And I select site "<Site A1>" that is in study "<Study A>"
	And I create a subject
	When I click button "Sign And Save"
	And I should see textbox with label "Username"
	And I should see textbox with label "Password"
	And I should see button with label "eSign"
	And I see message "Some of the Case Report Forms require old style signatures. Case Report Forms with old style signatures can not be signed in batch."
	And I take a screenshot

#------------------------------------------------------------------------------------------------------------
@release_564_patch9
@PB_2.5.4.9
@Validation
Scenario Outline: When an iMedidata user with batch sign permissions creates a subject, the user will see the button "Sign and Save" in the Grid View.

	And I login as user "<iMedidata User 1>"
	And I select study "<Study A>"
	And I select app "<App>"
	And I select site "<Site A1>" that is in study "<Study A>"
	And I create a subject
	And I select link "Grid View"
	When I select link "All"
	Then I should see button "Sign And Save"
	
#------------------------------------------------------------------------------------------------------------
@release_564_patch9
@PB_2.5.4.10
@Validation
Scenario: When an iMedidata user clicks the "Sign and Save" button on the Grid View with old and new style signature forms, a pop up window will be displayed	
	
	And I login as user "<iMedidata User 1>"
	And I select study "<Study A>"
	And I select app "<App>"
	And I select site "<Site A1>" that is in study "<Study A>"
	And I create a subject
	And I select link "Grid View"
	And I click button "Sign And Save"
	Then I should see "Pop Up" window
	And I should see textbox with label "Username"
	And I should see textbox with label "Password"
	And I should see button with label "eSign"
	And I see message "Some of the Case Report Forms require old style signatures. Case Report Forms with old style signatures can not be signed in batch."
	And I take a screenshot

#------------------------------------------------------------------------------------------------------------
@release_564_patch9
@PB_US2.5.4.11
@Validation
Scenario: iMedidata user successfully batch signs and adds other forms to the subject in the calendar view via Subject Administration

	And I login as user "<iMedidata User 1>"
	And I select study "<Study A>"
	And I select app "<App>"
	And I select site "<Site A1>" that is in study "<Study A>"
	And I create a subject
	And I select form "<Form2>"
	And I enter data in field "<Field 1B>" on "<Form2>" in subject "<Subject>"
	And I enter data in field "<Field 2B>" on "<Form2>" in subject "<Subject>"
	And I click button "<Save>"
	And I go to the subject homepage
	And I select form "<Form1>"
	And I enter data in field "<Field 1A>" on "<Form1>" in subject "<Subject>"
	And I enter data in field "<Field 2A>" on "<Form1>" in subject "<Subject>"
	And I click button "<Save>"
	And I go to the subject homepage
	And I click button "Sign And Save"
	And I should see "Pop Up" window
	And I enter username textbox with User ID "<iMedidata User ID>"
	And I enter password textbox with Password "<iMedidata User Password>"
	When I click button "eSign"
	Then I should see text "Signature attempt was successful" on the subject homepage
	And I should see the icon "Complete" for form "<Form1>" in subject "<Subject>" 
	And I should see the icon "Requires Signature" for form "<Form2>" in subject "<Subject>" 
	And I take a screenshot
	And I follow link "Subject Administration"
	And I select "Form1" from dropdown "Add Form"
	And I click icon "Add" next to dropdown "Add Form"
	And I select "Form2" from dropdown "Add Form"
	And I click icon "Add" next to dopdown "Add Form"
	And I click on button "Save"
	When I navigate to the subject homepage
	Then I see form "<Form1>" added to the subject with no status icon
	And I see form "<Form1>" on the subject with icon "Complete"
	And I see form "<Form2>" added to the subject with no status icon
	And I see form "<Form2>" on the subject with icon "Requires Signature"
	And I take a screenshot
	And I follow link "Form1" in subject with no status icon 
	And I should not see the message "User signature succeeded." on the form level audit for form "<Form1>" in subject "<Subject>"
	And I should see the message "DataPage created." on the form level audit for form "<Form1>" in subject "<Subject>"
	And I take a screenshot	
	And I navigate to the subject homepage
	And I follow link "Form1" in subject with icon "Complete"
	And I should see the message "User signature succeeded." on the form level audit for form "<Form1>" in subject "<Subject>"
	And I should see the message "DataPage created." on the form level audit for form "<Form1>" in subject "<Subject>"	
	And I take a screenshot
	And I navigate to the subject homepage	
	And I follow link "Form2" in subject with no status icon 
	And I should not see the message "User signature succeeded." on the form level audit for form "<Form2>" in subject "<Subject>"
	And I should see the message "DataPage created." on the form level audit for form "<Form2>" in subject "<Subject>"
	And I take a screenshot	
	And I navigate to the subject homepage
	And I follow link "Form2" in subject with icon "Requires Signature"
	And I should not see the message "User signature succeeded." on the form level audit for form "<Form2>" in subject "<Subject>"
	And I should see the message "DataPage created." on the form level audit for form "<Form2>" in subject "<Subject>"	
	And I take a screenshot

#------------------------------------------------------------------------------------------------------------
@release_564_patch9
@PB_2.5.4.12
@Validation
Scenario: As an iMedidata user, I can successfully batch sign and add other forms to the subject in the grid view via Subject Administration

	And I login as user "<iMedidata User 1>"
	And I select study "<Study A>"
	And I select app "<App>"
	And I select site "<Site A1>" that is in study "<Study A>"
	And I create a subject
	And I select form "<Form2>"
	And I enter data in field "<Field 1B>" on "<Form2>" in subject "<Subject>"
	And I enter data in field "<Field 2B>" on "<Form2>" in subject "<Subject>"
	And I click button "<Save>"
	And I go to the subject homepage
	And I select form "<Form1>"
	And I enter data in field "<Field 1A>" on "<Form1>" in subject "<Subject>"
	And I enter data in field "<Field 2A>" on "<Form1>" in subject "<Subject>"
	And I click button "<Save>"
	And I go to the subject homepage
	And I click link "Grid View"
	And I click "All"
	And I click button "Sign And Save"
	And I should see "Pop Up" window
	And I enter username textbox with User ID "<iMedidata User ID>"
	And I enter password textbox with Password "<iMedidata User Password>"
	When I click button "eSign"
	Then I should see text "Signature attempt was successful" on the subject homepage
	And I should see the icon "Complete" for form "<Form1>" in subject "<Subject>" 
	And I should see the icon "Requires Signature" for form "<Form2>" in subject "<Subject>" 
	And I take a screenshot
	And I follow link "Subject Administration"
	And I select "Form1" from dropdown "Add Form"
	And I click icon "Add" next to dropdown "Add Form"
	And I select "Form2" from dropdown "Add Form"
	And I click icon "Add" next to dopdown "Add Form"
	And I click on button "Save"
	When I navigate to the subject homepage
	And I select link "Grid View"
	Then I see form "<Form1>" added to the subject with no status icon
	And I see form "<Form1>" on the subject with icon "Complete"
	And I see form "<Form2>" added to the subject with no status icon
	And I see form "<Form2>" on the subject with icon "Requires Signature"
	And I take a screenshot
	And I follow link "Form1" in subject with no status icon 
	And I should not see the message "User signature succeeded." on the form level audit for form "<Form1>" in subject "<Subject>"
	And I should see the message "DataPage created." on the form level audit for form "<Form1>" in subject "<Subject>"
	And I take a screenshot	
	And I navigate to the subject homepage
	And I follow link "Form1" in subject with icon "Complete"
	And I should see the message "User signature succeeded." on the form level audit for form "<Form1>" in subject "<Subject>"
	And I should see the message "DataPage created." on the form level audit for form "<Form1>" in subject "<Subject>"	
	And I take a screenshot
	And I navigate to the subject homepage	
	And I follow link "Form2" in subject with no status icon 
	And I should not see the message "User signature succeeded." on the form level audit for form "<Form2>" in subject "<Subject>"
	And I should see the message "DataPage created." on the form level audit for form "<Form2>" in subject "<Subject>"
	And I take a screenshot	
	And I navigate to the subject homepage
	And I follow link "Form2" in subject with icon "Requires Signature"
	And I should not see the message "User signature succeeded." on the form level audit for form "<Form2>" in subject "<Subject>"
	And I should see the message "DataPage created." on the form level audit for form "<Form2>" in subject "<Subject>"	
	And I take a screenshot
	
#------------------------------------------------------------------------------------------------------------
@release_564_patch9
@PB_2.5.4.13
@Validation
Scenario: As an iMedidata user with batch sign permissions, I see a warning message in the pop up when I attempt to batch sign a mix of forms with new and old styles signatures from the Calendar view

	And I login as user "<iMedidata User 1>"
	And I select study "<Study A>"
	And I select app "<App>"
	And I select site "<Site A1>" that is in study "<Study A>"
	And I create a subject
	When I click button "Sign And Save"
	Then I should see text "Some of the Case Report Forms require old style signatures. Case Report Forms with old style signatures can not be signed in batch."
	And I should see textbox with label "Username"
	And I should see textbox with label "Password"
	And I should see button with label "eSign"
	And I take a screenshot

#------------------------------------------------------------------------------------------------------------
@release_564_patch9
@PB_2.5.4.14
@Validation
Scenario: As an iMedidata user with batch sign permissions, I see a warning message in the pop up when I attempt to batch sign a mix of forms with new and old styles signatures from the Grid view	
	
	And I login as user "<iMedidata User 1>"
	And I select study "<Study A>"
	And I select app "<App>"
	And I select site "<Site A1>" that is in study "<Study A>"
	And I create a subject
	And I select link "Grid View"
	And i select "All"
	And I click button "Sign And Save"
	Then I should see text "Some of the Case Report Forms require old style signatures. Case Report Forms with old style signatures can not be signed in batch."
	Then I should see "Pop Up" window
	And I should see textbox with label "Username"
	And I should see textbox with label "Password"
	And I should see button with label "eSign

#------------------------------------------------------------------------------------------------------------
@release_564_patch9
@PB_2.5.4.15
@Validation
Scenario: As an iMedidata user with batch sign permissions, I see a warning message in the pop up when I attempt to batch sign a mix of forms with new and old styles signatures from the Subject homepage

	And I login as user "<iMedidata User 1>"
	And I select study "<Study A>"
	And I select app "<App>"
	And I select site "<Site A1>" that is in study "<Study A>"
	And I create a subject
	When I click button "Sign And Save"
	Then I should see text "Some of the Case Report Forms require old style signatures. Case Report Forms with old style signatures can not be signed in batch."
	And I should see textbox with label "Username"
	And I should see textbox with label "Password"
	And I should see button with label "eSign"
	And I take a screenshot
	
#------------------------------------------------------------------------------------------------------------
@release_564_patch9
@PB_2.5.4.16
@Validation
Scenario: As an iMedidata user with batch sign permissions, I see a warning message in the pop up when I attempt to batch sign a mix of forms where all new style forms have been singed and only old style signatures remain in the Calendar view

	And I login as user "<iMedidata User 1>"
	And I select study "<Study A>"
	And I select app "<App>"
	And I select site "<Site A1>" that is in study "<Study A>"
	And I create a subject
	And I enter data in field "<Field 1A>" on "<Form1>" in subject "<Subject>"
	And I enter data in field "<Field 2A>" on "<Form1>" in subject "<Subject>"
	And I click button "Sign And Save"
	And I enter username textbox with User ID "<iMedidata User ID>"
	And I enter password textbox with Password "<iMedidata User Password>"
	And I click button "eSign"
	And I enter data in field "<Field 1A>" on "<Form1>" in folder "<Folder A>"
	And I enter data in field "<Field 2A>" on "<Form1>" in folder "<Folder A>"
	And I click button "Sign And Save"
	And I enter username textbox with User ID "<iMedidata User ID>"
	And I enter password textbox with Password "<iMedidata User Password>"
	And I click button "eSign"
	And I navigate to the subject homepage
	And I take a screenshot
	When I click button "Sign And Save"
	Then I should see text "All of the Case Report Forms require old style signatures. Case Report Forms with old style signatures can not be signed in batch."
	And I take a screenshot

#------------------------------------------------------------------------------------------------------------
@release_564_patch9
@PB_2.5.4.17
@Validation
Scenario: As an iMedidata user with batch sign permissions, I see a warning message in the pop up when I attempt to batch sign a mix of forms where all new style forms have been singed and only old style signatures remain in the Grid view	
	
		And I login as user "<iMedidata User 1>"
	And I select study "<Study A>"
	And I select app "<App>"
	And I select site "<Site A1>" that is in study "<Study A>"
	And I create a subject
	And I enter data in field "<Field 1A>" on "<Form1>" in subject "<Subject>"
	And I enter data in field "<Field 2A>" on "<Form1>" in subject "<Subject>"
	And I click button "Sign And Save"
	And I enter username textbox with User ID "<iMedidata User ID>"
	And I enter password textbox with Password "<iMedidata User Password>"
	And I click button "eSign"
	And I enter data in field "<Field 1A>" on "<Form1>" in folder "<Folder A>"
	And I enter data in field "<Field 2A>" on "<Form1>" in folder "<Folder A>"
	And I click button "Sign And Save"
	And I enter username textbox with User ID "<iMedidata User ID>"
	And I enter password textbox with Password "<iMedidata User Password>"
	And I click button "eSign"
	And I navigate to the subject homepage
	And I select link "Grid View"
	And I select "All"
	And I take a screenshot
	When I click button "Sign And Save"
	Then I should see text "All of the Case Report Forms require old style signatures. Case Report Forms with old style signatures can not be signed in batch."
	And I take a screenshot


#------------------------------------------------------------------------------------------------------------
@release_564_patch9
@PB_2.5.4.18
@Validation
Scenario: As an iMedidata user with batch sign permissions, I see a warning message in the pop up when I attempt to batch sign a mix of forms where all new style forms have been singed and only old style signatures remain on the Subject homepage

	And I login as user "<iMedidata User 1>"
	And I select study "<Study A>"
	And I select app "<App>"
	And I select site "<Site A1>" that is in study "<Study A>"
	And I create a subject
	And I enter data in field "<Field 1A>" on "<Form1>" in subject "<Subject>"
	And I enter data in field "<Field 2A>" on "<Form1>" in subject "<Subject>"
	And I click button "Sign And Save"
	And I enter username textbox with User ID "<iMedidata User ID>"
	And I enter password textbox with Password "<iMedidata User Password>"
	And I click button "eSign"
	And I enter data in field "<Field 1A>" on "<Form1>" in folder "<Folder A>"
	And I enter data in field "<Field 2A>" on "<Form1>" in folder "<Folder A>"
	And I click button "Sign And Save"
	And I enter username textbox with User ID "<iMedidata User ID>"
	And I enter password textbox with Password "<iMedidata User Password>"
	And I click button "eSign"
	And I navigate to the subject homepage
	And I take a screenshot
	When I click button "Sign And Save"
	Then I should see text "All of the Case Report Forms require old style signatures. Case Report Forms with old style signatures can not be signed in batch."
	And I take a screenshot