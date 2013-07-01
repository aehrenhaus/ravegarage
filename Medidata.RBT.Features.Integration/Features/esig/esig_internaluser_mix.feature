#Rave allows for eSignatures to be applied to Forms, Folders and Subjects, as well as eLearning confirmation pages. As part of Rave’s current user authentication model, the user submits their eSignature credentials as a binding eSignature in Rave.
#Rave supports two types of eSignature methods. The old style eSignature which is built into the eCRF form using an eSig field OID, which is being deprecated beginning in Rave 5.6.4 patch 9. This signature method relies on credentials residing in the Rave database or direct API communication to mimic the credentials being stored in the Rave database for performing the verification to support eSignatures which validate individual datapoints.
#The new style eSignature, which resides at the form level, offers the flexibility to use iMedidata CAS to authenticate or verify user credentials. These form level verfications provide a more eficient means of bulk signing and do not require individual datapoint verification.
#The new style signatures will leverage the Sign and Save eSignature method of verifying and applying an eSignature to the form (or forms) before saving changes. A modal window will be used to present the signature request and to capture the credentials for verification. If verification succeeds, data is saved and the eSignature is applied to all new style forms. If verification should fail, the signature is not applied, no selections or changes are saved and the modal window can be closed. All selections made prior to the modal opening are persisted and the user may choose to Save or Cancel without applying an eSignature. By default, Rave sets a failure threshold of 3 failed attempts before the user is locked out. This rule remains in effect.
#eSignature failure messages and audit failure messages will be simplified so that users are not given information that would compromise Rave security. Audit success messages will be simplified and unified to match the failure messages and to accurately reflect the message content defined by the SAML protocol. 


Feature: eSignature for Rave
	As an Rave user
	I want to apply signatures to forms that utilize the old signature format from form level, calender view and gridview level for a study with a mix of Rave old and new style signatures
		
Background:
	Given I am a Rave user "<User>" with pin "<PIN>" password "<Password>" and user id "User ID>"
		|User					|PIN					| Password					|User ID				|
		|{RaveUser 1}		|{Rave User PIN}	|{Rave User Password}	|{Rave User ID}	|
	And there exists study "<Study>"
		|Study		|
		|{Study A}	|
		And there exists site "<Site>" in study "<Study>",	
		|Study		|Site		|
		|{Study A}	|{Site A1}	|
	And	user "<User>" has Sign privileges and has access to site "{Site A1}" that is in study "{Study A}" in database "<EDC> Database",
		|User					|
		|{Rave User 1}			|	

#----------------------------------------------------------------------------------------------------------------------
@release_564_patch12
@PB_2.5.1.1
@Validation
Scenario: As a Rave user, I can sign a form using the new Sign and Save sigature format after data has been entered and see a success entry in the audit trail

	And I login as user "<Rave User 1>"
	And I select study "<Study A>"
	And I select site "<Site A1>" that is in study "<Study A>"
	And I create a subject
	And I select form "<Form1>"
	And I enter data in field "<Field 1A>" on "<Form1>" in subject "<Subject>"
	And I enter data in field "<Field 2A>" on "<Form1>" in subject "<Subject>"
	And I click button "Sign and Save"
	And I should see "Pop Up" window
	And in the window I see "|Reason for Signature|"
	And I see my "|Name|"
	And I see the current "|Timestamp|"
	And I enter user name textbox with User ID "<Rave User ID>"
	And I enter password textbox with Password "<Rave User Password>"
	And I click button "Sign and Save"
	When I click icon "Complete" for form "<Form1>" in subject "<Subject>" 
	Then I should see the message "User signature succeeded." on the form level audit for form "<Form1>" in subject "<Subject>"
	And I should see the message "DataPage created." on the form level audit for form "<Form1>" in subject "<Subject>"
	And I take a screenshot 1 of 21
	And I go back to form "<Form1>"
	When I click icon "Complete" on "Field 1A" on form "<Form1>" in subject "<Subject>"
	Then I should see the message "User entered 'data'" on the audit for field "<Field 1A>" on form "<Form1>" in subject "<Subject>"	
	And I should see the message "User signature succeeded." on the audit for field "<Field 1A>" on form "<Form1>" in subject "<Subject>"
	And I take a screenshot 2 of 21
	And I go back to form "<Form1>"
	When I click icon "Complete" on "Field 2A" on form "<Form1>" in subject "<Subject>"
	Then I should see the message "User entered 'data'" on the audit for field "<Field 2A>" on form "<Form1>" in subject "<Subject>"
	And I should see the message "User signature succeeded." on the audit for field "<Field 2A>" on form "<Form1>" in subject "<Subject>"	
	And I take a screenshot	 3 of 21
	
#----------------------------------------------------------------------------------------------------------------------
@release_564_patch9
@PB_2.5.1.2
@Validation
#Scenario: As a Rave user, I can sign a form using the old signature format after data has been entered and see a success message in the audit trail

	And I login as user "<Rave User 1>"
	And I select study "<Study A>"
	And I select site "<Site A1>" that is in study "<Study A>"
	And I create a subject
	And I select form "<Form5>"
	And I enter data in field "<Field 1E>" on "<Form5>" in subject "<Subject>"
	And I enter data in field "<Field 2E>" on "<Form5>" in subject "<Subject>"
	And I enter Rave User Name "<Rave User ID>" and Password "<Rave User Password>" on "<Form5>" in subject "<Subject>"
	When I click button "<Save>"
	Then I should see icon "Complete" for form "<Form5>" in subject "<Subject>" 
	And I should see icon "Complete" on "Field 1E" on form "<Form5>" in subject "<Subject>"
	And I should see icon "Complete" on "Field 2E" on form "<Form5>" in subject "<Subject>"
	And I should see User's Name and Title
	And I should see User's date and timezone
	And I take a screenshot 4 of 21
	When I click icon "Complete" on "Field 1E" on form "<Form5>" in subject "<Subject>"
	Then I should see the message "User entered 'data'" on the audit for field "<Field 1E>" on form "<Form5>" in subject "<Subject>"	
	And I should see the message "User signature succeeded." on the audit for field "<Field 1E>" on form "<Form5>"	in subject "<Subject>"
	And I take a screenshot 5 of 21
	And I go back to form "<Form5>"
	When I click icon "Complete" on "Field 2E" on form "<Form5>" in subject "<Subject>"
	Then I should see the message "User entered 'data'" on the audit for field "<Field 2E>" on form "<Form5>" in subject "<Subject>"
	And I should see the message "User signature succeeded." on the audit for field "<Field 2E>" on form "<Form5>" in subject "<Subject>"	
	And I take a screenshot	6 of 21	
	And I go back to form "<Form5>"
	When I click icon "Complete" on "eSigPage" on form "<Form5>" in subject "<Subject>"
	Then I should see the message "User signature succeeded." on the audit for field "<eSigPage>" on form "<Form5>" in subject "<Subject>"	
	And I go back to form "<Form5>"
	When I click icon "Complete" on form "<Form5>" in subject "<Subject>"
	Then I should see the message "DataPage created" on the audit for form "<Form5>" in subject "<Subject>"	
	And I should see the message "User signature succeeded." on the audit for form "<Form5>" in subject "<Subject>"	
	And I take a screenshot	7 of 21
		
#----------------------------------------------------------------------------------------------------------------------
@release_564_patch9
@PB_2.5.1.3
@Validation
Scenario: If a Rave user attempts to sign an the old esig format eCRF with a bad username, the user will see a warning message on the form that the "Signature Attempt Failed".

	And I login as user "<Rave User 1>"
	And I select study "<Study A>"
	And I select site "<Site A1>" that is in study "<Study A>"
	And I create a subject
	And I select form "<Form5>"
	And I enter data in field "<Field 1E>" on "<Form5>" in subject "<Subject>"
	And I enter data in field "<Field 2E>" on "<Form5>" in subject "<Subject>"
	And I enter Rave User Name "<Rave User ID>xx" and Password "<Rave User Password>" on "<Form5>" in subject "<Subject>"
	When I click button "<Save>"
	Then I should see the text "Signature attempt failed"
	And I should see icon "Incomplete" for form "<Form5>" in subject "<Subject>" 
	And I should see icon "Requires Signature" on "Field 1E" on form "<Form5>" in subject "<Subject>"
	And I should see icon "Requires Signature" on "Field 2E" on form "<Form5>" in subject "<Subject>"
	And I should see icon "Never Touched" on "eSigPage" on form "<Form5>" in subject "<Subject>"
	And I take a screenshot 8 of 21

#----------------------------------------------------------------------------------------------------------------------
@release_564_patch9
@PB_2.5.1.4
@Validation
Scenario: If a Rave user attempts to sign an the old esig format eCRF with a bad PIN, the user will see a warning message on the form that the "Signature Attempt Failed".

	And I login as user "<Rave User 1>"
	And I select study "<Study A>"
	And I select site "<Site A1>" that is in study "<Study A>"
	And I create a subject
	And I select form "<Form5>"
	And I enter data in field "<Field 1E>" on "<Form5>" in subject "<Subject>"
	And I enter data in field "<Field 2E>" on "<Form5>" in subject "<Subject>"
	And I enter Rave User Name "<Rave User PIN>xx" and Password "<Rave User Password>" on "<Form5>" in subject "<Subject>"
	When I click button "<Save>"
	Then I should see the text "Signature attempt failed"
	And I should see icon "Incomplete" for form "<Form5>" in subject "<Subject>" 
	And I should see icon "Requires Signature" on "Field 1E" on form "<Form5>" in subject "<Subject>"
	And I should see icon "Requires Signature" on "Field 2E" on form "<Form5>" in subject "<Subject>"
	And I should see icon "Never Touched" on "eSigPage" on form "<Form5>" in subject "<Subject>"
	And I take a screenshot 9 of 21

#----------------------------------------------------------------------------------------------------------------------
@release_564_patch9
@PB_2.5.1.5
@Validation
Scenario: If a Rave user attempts to sign an the old esig format eCRF with a bad password, the user will see a warning message on the form that the "Signature Attempt Failed".

	And I login as user "<Rave User 1>"
	And I select study "<Study A>"
	And I select site "<Site A1>" that is in study "<Study A>"
	And I create a subject
	And I select form "<Form5>"
	And I enter data in field "<Field 1E>" on "<Form5>" in subject "<Subject>"
	And I enter data in field "<Field 2E>" on "<Form5>" in subject "<Subject>"
	And I enter Rave User Name "<Rave User ID>" and Password "<Rave User Password>xx" on "<Form5>" in subject "<Subject>"
	When I click button "<Save>"
	Then I should see icon "Non-Conformant" for form "<Form5>" in subject "<Subject>" 
	And I should see icon "Requires Signature" on "Field 1E" on form "<Form5>" in subject "<Subject>"
	And I should see icon "Requires Signature" on "Field 2E" on form "<Form5>" in subject "<Subject>"
	And I should see icon "Non-Conformant" on "eSigPage" on form "<Form5>" in subject "<Subject>"
	And I take a screenshot 10 of 21
	
#----------------------------------------------------------------------------------------------------------------------
@release_564_patch9
@PB_2.5.1.6
@Validation
Scenario: If a Rave user accumulates 3 consecutive failed signature attempts on a form using the old style esig format, the user will be logged out of Rave and placed on the Rave login page

	And I login as user "<Rave User 1>"
	And I select study "<Study A>"
	And I select site "<Site A1>" that is in study "<Study A>"
	And I create a subject
	And I select form "<Form5>"
	And I enter data in field "<Field 1E>" on "<Form5>" in subject "<Subject>"
	And I enter data in field "<Field 2E>" on "<Form5>" in subject "<Subject>"
	And I enter user name textbox with User ID "<RaveUser ID>"
	And I enter password textbox with Password "<Rave User Password>xx"
	When I click the button "Save"
	Then I should see signature attempt failed with icon "Non-Conformant"
	And I enter user name textbox with User ID "<Rave User ID>"
	And I enter password textbox with Password "<Rave User Password>xx"
	When I click the button "Save"
	Then I should see signature attempt failed with icon "Non-Conformant"
	And I enter user name textbox with User ID "<Rave User ID>"
	And I enter password textbox with Password "<Rave User Password>xx"
	When I click the button "Save"
	Then I should see page "Rave Login Page"
	And I see text "Continuous Signature Failures"
	And I take a screenshot	11 of 21

#----------------------------------------------------------------------------------------------------------------------
@release_564_patch12
@PB_2.5.1.7
@Validation
Scenario: If a Rave user accumulates 3 consecutive failed signature attempts on a form using the new style esig format, the user will be logged out of Rave and placed on the Rave login page

	And I login as user "<Rave User 1>"
	And I select study "<Study A>"
	And I select site "<Site A1>" that is in study "<Study A>"
	And I create a subject
	And I select form "<Form1>"
	And I enter data in field "<Field 1A>" on "<Form1>" in subject "<Subject>"
	And I enter data in field "<Field 2A>" on "<Form1>" in subject "<Subject>"
	And I click button "Sign and Save"
	And I should see "Pop Up" window
	And in the window I see "|Reason for Signature|"
	And I see my "|Name|"
	And I see the current "|Timestamp|"
	And I enter user name textbox with User ID "<Rave User ID>"
	And I enter password textbox with Password "<RaveUser Password>xx"
	And I click button "Sign and Save"
	And I should see message "Signature attempt failed."
	And I enter user name textbox with User ID "<Rave User ID>"
	And I enter password textbox with Password "<Rave User Password>xx"
	And I click button "Sign and Save"
	And I should see message "Signature attempt failed."
	And I enter username textbox with User ID "<Rave User ID>"
	And I enter password textbox with Password "<Rave User Password>xx"
	And I click button "Sign and Save"
	Then I should see page "Rave Login Page"
	And I see text "Continuous Signature Failures"
	And I take a screenshot 12 of 21
	
#----------------------------------------------------------------------------------------------------------------------
@release_564_patch9
@PB_2.5.1.8
@Validation
Scenario: When a Rave user with batch sign permissions creates a subject, the user will see the button "Sign and Save" on Calender view.

	And I login as user "<Rave User 1>"
	And I select study "<Study A>"
	And I select site "<Site A1>" that is in study "<Study A>"
	When I create a subject
	Then I should see button "Sign and Save"
	And I take a screenshot 13 of 21

#----------------------------------------------------------------------------------------------------------------------
@release_564_2013.2.0
@PB_2.5.1.9
@Validation
Scenario: When Rave user clicks button "Sign and Save" on the subject homepage a pop up window will be displayed prompting the user to enter Sign and Save credentials for verification.

	And I login as user "<Rave User 1>"
	And I select study "<Study A>"
	And I select site "<Site A1>" that is in study "<Study A>"
	And I create a subject
	And I click button "Sign and Save"
	And I should see "Pop Up" window
	And in the window I see "|Reason for Signature|"
	And I see my "|Name|"
	And I see the current "|Timestamp|"
	And I enter user name textbox with User ID "<Rave User ID>"
	And I enter password textbox with Password "<Rave User Password>"
	When I click button "Sign and Save"
	Then I should see text "Your signature is being applied. You may continue working on other subjects." on the subject homepage
	And I take a screenshot 14 of 21
	And I wait for 20 seconds and Refresh the subject page
	And I should see icon "Incomplete" on Form5
	And I should see icon "Incomplete" on Folder A
	And I should see icon "Incomplete" on Folder B
	And I take a screenshot 15 of 21	
	
#----------------------------------------------------------------------------------------------------------------------
@release_564_patch9
@PB_2.5.1.10
@Validation
Scenario: When a Rave user with batch sign permissions creates a subject, the user will see the button "Sign and Save" in the Grid View.

	And I login as user "<Rave User 1>"
	And I select study "<Study A>"
	And I select site "<Site A1>" that is in study "<Study A>"
	And I create a subject
	And I select link "Grid View"
	When I select link "All"
	Then I should see button "Sign and Save"
	And I take a screenshot 16 of 21

#----------------------------------------------------------------------------------------------------------------------
@release_564_patch12
@PB_2.5.1.11
@Validation
Scenario: When a Rave user clicks the "Sign and Save" button on the Grid View, a pop up window will be displayed prompting the user to enter Sign and Save credentials for verification.

	And I login as user "<Rave User 1>"
	And I select study "<Study A>"
	And I select site "<Site A1>" that is in study "<Study A>"
	And I create a subject
	And I select link "Grid View"
	And I select link "All"
	When I click button "Sign and Save"
	Then I should see "Pop Up" window
	And I should see textbox with label "User Name"
	And I should see textbox with label "Password"
	And I should see button with label "Sign and Save"
	And in the window I see "|Reason for Signature|"
	And I see my "|Name|"
	And I see the current "|Timestamp|"
	And I take a screenshot 17 of 21

#----------------------------------------------------------------------------------------------------------------------
@release_564_2013.2.0
@PB_2.5.1.12
@Validation
Scenario: Rave user successfully batch signs and adds other forms to the subject via Subject Administration.

	And I login as user "<Rave User 1>"
	And I select study "<Study A>"
	And I select site "<Site A1>" that is in study "<Study A>"
	And I create a subject
	And I select form "<Form1>"
	And I enter data in field "<Field 1A>" on "<Form1>" in subject "<Subject>"
	And I enter data in field "<Field 2A>" on "<Form1>" in subject "<Subject>"
	And I click button "<Save>"
	And I go to the subject homepage
	And I select form "<Form5>"
	And I enter data in field "<Field 1E>" on "<Form5>" in subject "<Subject>"
	And I enter data in field "<Field 2E>" on "<Form5>" in subject "<Subject>"
	And I click button "<Save>"
	And I go to the subject homepage
	And I click button "Sign and Save"
	And I should see "Pop Up" window
	And in the window I see "|Reason for Signature|"
	And I see my "|Name|"
	And I see the current "|Timestamp|"
	And I enter user name textbox with User ID "<Rave User ID>"
	And I enter password textbox with Password "<Rave User Password>"
	When I click button "Sign and Save"
	Then I should see text "Your signature is being applied. You may continue working on other subjects." on the subject homepage
	And I take a screenshot 18 of 21
	And I wait for 20 seconds and Refresh the subject page
	And I should see the icon "Complete" for form "<Form1>" in subject "<Subject>" 
	And I should see the icon "Complete" for form "<Form5>" in subject "<Subject>" 
	And I take a screenshot 19 of 21
	And I select link "Subject Administration"
	And I select "Form1" from dropdown "Add Form"
	And I click icon "Add" next to dropdown "Add Form"
	And I select "Form1" from dropdown "Add Form"
	And I click icon "Add" next to dropdown "Add Form"
	And I click on button "Save"
	When I navigate to the subject homepage
	Then I see form "<Form1>" add to the subject with no status icon
	And I take a screenshot 20 of 21
	And I select link "Form1" in subject with no status icon 
	And I enter data
	And I select button "Save"
	And I should see button "Sign and Save"
	And I take a screenshot 21 of 21

#----------------------------------------------------------------------------------------------------------------------
