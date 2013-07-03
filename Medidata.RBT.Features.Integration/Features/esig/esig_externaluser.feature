# Users: eSignature Request for Authentication by external user
#Rave allows for eSignatures to be applied to Forms, Folders and Subjects, as well as eLearning confirmation pages. 
#As part of Rave’s current user authentication model, the user submits their eSignature credentials as a binding eSignature in Rave. For all externally authenticated users, the eSignature credentials will be passed to iMedidata CAS for verification. iMedidata CAS will process verification requests for all external users, including those authenticated by independent, third-party Identity Providers (IDP). The PIN Code on iMedidata serves as a PIN on Rave. 
#Note: For the purposes of this feature, an external user is defined as any user that is authenticated by a system other than Rave, including iMedidata and trusted, third-party IDPs (Identity Providers). Tests done for iMedidata users will adequately test the same functionality for an IDP user 1. If any explicit functional differences exist between iMedidata and IDP, they will be explicity called out where they are known to exist.
#Rave supports two types of eSignature methods. The old style eSignature which is built into the eCRF form using an eSig field OID, which is being deprecated beginning in Rave 5.6.4 patch 9. This signature method relies on credentials residing in the Rave database or direct API communication to mimic the credentials being stored in the Rave database for performing the verification to support eSignatures which validate individual datapoints. Old style signature fields will not support external eSignature attempts for IDP user 1s, but iMedidata users will be able to sign these fields individually. Batch signing of old style signatures is not supported for external users, including iMedidata users.
#The new style eSignature, which resides at the form level, offers the flexibility to use iMedidata CAS to authenticate or verify user credentials. These form level verfications provide a more efficient means of bulk signing and do not require individual datapoint verification.
# The new style eSignatures will leverage the Sign and Save eSignature method of verifying and applying an eSignature to the form (or forms) before saving changes. A modal window will be used to present the signature request and to capture the credentials for verification. If verification succeeds, data is saved and the eSignature is applied to all new style forms. 
#Verification messages between iMedidata and Rave will be goverened by the SAML protocol which will provide either a success message or a lockout message. iMedidata CAS will broker verification attempts for IDP user 1s through SAML requests sent to the IDP. IDP responses will be passed back to Rave through iMedidata CAS.
#Rave will not capture eSignature authentication failed attempts for external users on the form level for new style eSignatures; the responsibility for tracking verification attempts will lie with the identity provider (iMedidata or IDP) who also determines the verification criteria and the lockout threshold. By default, iMedidata sets a failure threshold of 5 failed attempts before the user is locked out. iMedidata users will now be able to fail 5 signature attempts before hitting the threshold. Each IDP will set its own lockout threshold and that threshold will be respected for signature attempts made in Rave. 
#eSignature failure messages and audit failure messages will be simplified so that users are not given information that would compromise Rave security. Audit success messages will be simplified and unified to match the failure messages and to accurately reflect the message content defined by the SAML protocol. 


Feature: eSignature for external user
	As an externally authenticated user, I want to apply an electronic signature to forms from form level, calendar view and grid view for a study with only with Rave new style signatures 

	
Background:
	Given I am an iMedidata user
	And my username is <iMedidata User 1>
	And my password is <Password1>
	And I am assigned to a Study Group <Study Group 1>
	And I am assigned to a study <Study A> that is in <Study Group 1>
	And I am assigned to a site <Site A1> that is in <Study A> in <Study Group 1>
	And I have been assigned to the EDC app
	And I have been invited to the Data Manager role for site <Site A1> that is in <Study A> in <Study Group 1>
	And I have been given sign permissions to site <Site A1> that is in <Study A> in <Study Group 1>
	And I have been given batch sign permissions to site <Site A1> that is in <Study A> in <Study Group 1>

#------------------------------------------------------------------------------------------------------------
@release_564_patch9
@2.5.3.1
@Validation
Scenario: As an external user with sign permissions, I can access a subject form that requires eSignature.

	And I login as user "<iMedidata user 1>"
	And I select study "<Study A>"
	And I select app "<App>"
	And I select site "<Site A1>" that is in study "<Study A>"
	And I create a subject
	When I select form "<Form1>"
	Then I see form "<Form1>" displayed
	And I should see button "<Sign and Save>"
	And I take a screenshot 1 of 46
	
#------------------------------------------------------------------------------------------------------------
@release_564_patch12
@PB_2.5.3.2
@Validation
Scenario: As an external user, when I click on the "Sign and Save" button on a form without saved data, I will see the eSignature pop up window

	And I login as user "<iMedidata user 1>"
	And I select study "<Study A>"
	And I select app "<App>"
	And I select site "<Site A1>" that is in study "<Study A>"
	And I create a subject
	And I select form "<Form1>"
	When I click button "Sign and Save"	
	Then I should see "Pop Up" window
	And in the window I see "|Reason for Signature|"
	And I see my "|Name|"
	And I see the current "|Timestamp|"
	And I should see textbox with label "Username"
	And I should see textbox with label "Password"
	And I should see button with label "eSign"
	And I take a screenshot 2 of 46
	
#------------------------------------------------------------------------------------------------------------
@release_564_patch12
@PB_2.5.3.3
@Validation
Scenario: As an external user, I can click the "Sign and Save" button on a form with saved data and I will see the eSignature pop up window

	And I login as user "<iMedidata user 1>"
	And I select study "<Study A>"
	And I select app "<App>"
	And I select site "<Site A1>" that is in study "<Study A>"
	And I create a subject
	And I select form "<Form1>"
	And I enter data in field "<Field 1A>" on "<Form1>" in subject "<Subject>"
	And I enter data in field "<Field 2A>" on "<Form1>" in subject "<Subject>"
	And I click button "<Save>"
	And I should see icon "Requires Signature" for form "<Form1>" in subject "<Subject>" 
	And I should see icon "Requires Signature" on "Field 1A" on form "<Form1>" in subject "<Subject>"
	And I should see icon "Requires Signature" on "Field 2A" on form "<Form1>" in subject "<Subject>"
	And I should see icon "Requires Signature" on "Field 3A" on form "<Form1>" in subject "<Subject>"
	And I take a screenshot 3 of 46
	When I click button "Sign and Save"	
	Then I should see "Pop Up" window
	And in the window I see "|Reason for Signature|"
	And I see my "|Name|"
	And I see the current "|Timestamp|"
	And I should see textbox with label "Username"
	And I should see textbox with label "Password"
	And I should see button with label "eSign"
	And I take a screenshot 4 of 46

#------------------------------------------------------------------------------------------------------------
@release_564_patch12
@PB_2.5.3.4
@Validation
Scenario: As an external user with sign privileges, I can successfully sign the form after data has been entered

	And I login as user "<iMedidata user 1>"
	And I select study "<Study A>"
	And I select app "<App>"
	And I select site "<Site A1>" that is in study "<Study A>"
	And I create a subject
	And I select form "<Form1>"
	And I enter data in field "<Field 1A>" on "<Form1>" in subject "<Subject>"
	And I enter data in field "<Field 2A>" on "<Form1>" in subject "<Subject>"
	And I click button "<Save>"
	And I click button "Sign and Save"	
	And I should see "Pop Up" window
	And in the window I see "|Reason for Signature|"
	And I see my "|Name|"
	And I see the current "|Timestamp|"
	And I enter username textbox with User ID "<iMedidata user ID>"
	And I enter password textbox with Password "<iMedidata user Password>"
	When I click button "eSign"
	Then I should see icon "Complete" for form "<Form1>" in subject "<Subject>" 
	And I should see icon "Complete" on "Field 1A" on form "<Form1>" in subject "<Subject>"
	And I should see icon "Complete" on "Field 2A" on form "<Form1>" in subject "<Subject>"
	And I should see icon "Complete" on "Field 3A" on form "<Form1>" in subject "<Subject>"
	And I should see message "First Name Last Name Title (iMedidata user 1) dd Mmm yyyy HH:mm:ss <Time Zone>"
	And I take a screenshot 5 of 46

#------------------------------------------------------------------------------------------------------------
@release_564_patch12
@PB_2.5.3.5
@Validation
Scenario: As an external user with access to the audit trail, I can view the audit trail to verify that a form has been successfully signed

	And I login as user "<iMedidata user 1>"
	And I select study "<Study A>"
	And I select app "<App>"
	And I select site "<Site A1>" that is in study "<Study A>"
	And I create a subject
	And I select form "<Form1>"
	And I click button "Sign and Save"
	And I should see "Pop Up" window
	And in the window I see "|Reason for Signature|"
	And I see my "|Name|"
	And I see the current "|Timestamp|"
	And I enter username textbox with User ID "<iMedidata user 1>"
	And I enter password textbox with Password "<Password1>"
	And I click button "eSign"
	When I click icon "Complete" for form "<Form1>" in subject "<Subject>" 
	Then I should see the message "User signature succeeded." on the form level audit on form "<Form1>" in subject "<Subject>"
	And I should see the message "DataPage created." on the form level audit on form "<Form1>" in subject "<Subject>"
	And I should see the username <iMedidata user 1> on the form level audit on form "<Form1>"	in subject "<Subject>"
	And I should see the timestamp <dd MMM yyyy HH:mm:ss> on the form level audit on form "<Form1>" in subject "<Subject>"
	And I take a screenshot 6 of 46

#------------------------------------------------------------------------------------------------------------
@release_564_patch12
@PB_2.5.3.6
@Validation
Scenario: As an iMedidata user with signature permissions, I will see a warning message in the pop up window when I attempt to eSign a form with an incorrect username

	And I login as user "<iMedidata user 1>"
	And I select study "<Study A>"
	And I select app "<App>"
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
	And I enter username textbox with User ID "<iMedidata user ID>XX"
	And I enter password textbox with Password "<iMedidata user Password>"
	When I click button "eSign"
	Then I should see message "You tried to sign with a username and password that is not recognized" on the pop up
	And I take a screenshot 7 of 46
	
#------------------------------------------------------------------------------------------------------------
@release_564_patch12
@PB_2.5.3.7
@Validation
Scenario: As an iMedidata user with signature permissions, I will see a warning message in the pop up window when I attempt to eSign with a bad password

	And I login as user "<iMedidata user 1>"
	And I select study "<Study A>"
	And I select app "<App>"
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
	And I enter username textbox with User ID "<iMedidata user ID>"
	And I enter password textbox with Password "<iMedidata user Password>XX"
	When I click button "eSign"
	Then I should see message "You tried to sign with a username and password that is not recognized" on the pop up
	And I take a screenshot 8 of 46
	
#------------------------------------------------------------------------------------------------------------
@release_564_patch12
@PB_2.5.3.8
@Validation
Scenario: As a external user with access to the audit trail, I will see a simple message "User signature succeeded" for a successful attempt

	And I login as user "<iMedidata user 1>"
	And I select study "<Study A>"
	And I select app "<App>"
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
	And I enter username textbox with User ID "<iMediata user 1>"
	And I enter password textbox with Password "<Password1>"
	And I click button "eSign"
	And I should see icon "Complete" for form "<Form1>"
	When I click on icon "<Complete>" for form "<Form1>"
	Then I should see the message "User signature succeeded." on the form level audit for form "<Form1>" in subject "<Subject>"
	And I should see the message "DataPage created" on the form level audit for form "<Form1>" in subject "<Subject>"
	And I take a screenshot 9 of 46
	And I click tab "<Form1>"
	And I click on icon "<Complete>" for field "Field 1A"
	And I should see the message "User entered 'data'" on the audit for field "<Field 1A>" on form "<Form1>" in subject "<Subject>"	
	And I should see the message "User signature succeeded." on the audit for field "<Field 1A>" on form "<Form1>" in subject "<Subject>"
	And I take a screenshot 10 of 46
	And I click tab "<Form1>"
	And I click on icon "<Complete>" for field "Field 2A"
	And I should see the message "User entered 'data'" on the audit for field "<Field 2A>" on form "<Form1>" in subject "<Subject>"
	And I should see the message "User signature succeeded." on the audit for field "<Field 2A>" on form "<Form1>" in subject "<Subject>"
	And I take a screenshot 11 of 46
	And I click tab "<Form1>"
	And I click on icon "<Complete>" for field "Field 3A"
	And I should see the message "Record created." on the audit for field "<Field 3A>" on form "<Form1>" in subject "<Subject>"
	And I take a screenshot 12 of 46
	And I select link "Children: Data Point - FIELD 3A"
	And I should see the message "User entered empty" on the audit for field "<Field 3A>" on form "<Form1>" in subject "<Subject>"
	And I should see the message "User signature succeeded." on the audit for field "<Field 3A>" on form "<Form1>" in subject "<Subject>"
	And I take a screenshot 13 of 46
	
#------------------------------------------------------------------------------------------------------------
@release_564_patch12
@PB_2.5.3.9
@Validation
Scenario: As an iMedidata user that failed 5 consecutive signature attempts, my Rave session should be ended and I should be on the iMedidata login page

	And I login as user "<iMedidata user 1>"
	And I select study "<Study A>"
	And I select app "<App>"
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
	And I enter username textbox with User ID "<iMedidata User ID>"
	And I enter password textbox with Password "<Password1xx>"
	And I click button "eSign"
	And I should see message "You tried to sign with a username and password that is not recognized" on the pop up
	And I enter username textbox with User ID "<iMedidata User ID>"
	And I enter password textbox with Password "<Password1xx>"
	And I click button "eSign"
	And I should see message "You tried to sign with a username and password that is not recognized" on the pop up
	And I enter username textbox with User ID "<iMedidata User ID>"
	And I enter password textbox with Password "<Password1xx>"
	And I click button "eSign"
	And I should see message "You tried to sign with a username and password that is not recognized" on the pop up
	And I enter username textbox with User ID "<iMedidata User ID>"
	And I enter password textbox with Password "<Password1xx>"
	And I click button "eSign"
	And I should see message "You tried to sign with a username and password that is not recognized" on the pop up
	And I enter username textbox with User ID "<iMedidata User ID>"
	And I enter password textbox with Password "<Password1xx>"
	When I click button "eSign"
	Then I should see a pop-up window with message to confirm whether the user wants to leave the page and informing the user that the entered data may not be saved.  
	And I take a screenshot 14 of 46
	When I select confirmation button to leave Page
	Then I should see page "iMedidata Login Page"
	When I attmept to log in with Username <iMedidata User 1>
	And password <Password1>
	Then I should see the message "Invalid Login. You have entered an invalid password over the retry limit. Your account will be locked for five (5) minutes."
	And I take a screenshot 15 of 46
	
#------------------------------------------------------------------------------------------------------------
@release_564_patch9
@PB_2.5.3.10
@Validation
Scenario: As a external user with batch sign permissions, I will see the  "Sign and Save" button on the Calender view.

	And I login as user "<iMedidata User 1>"
	And I select study "<Study A>"
	And I select app "<App>"
	And I select site "<Site A1>" that is in study "<Study A>"
	When I create a subject
	Then I should see button "Sign and Save"
	And I take a screenshot 16 of 46
	
#------------------------------------------------------------------------------------------------------------
@release_564_patch12
@PB_2.5.3.11
@Validation
Scenario: As a external user, when I click on the "Sign and Save" button on the subject homepage, I will see an eSignature pop up window

	And I login as user "<iMedidata User 1>"
	And I select study "<Study A>"
	And I select app "<App>"
	And I select site "<Site A1>" that is in study "<Study A>"
	And I create a subject
	When I click button "Sign and Save"
	Then I should see "Pop Up" window
	And in the window I see "|Reason for Signature|"
	And I see my "|Name|"
	And I see the current "|Timestamp|"	
	And I should see textbox with label "Username"
	And I should see textbox with label "Password"
	And I should see button with label "eSign"
	And I take a screenshot 17 of 46
	
#------------------------------------------------------------------------------------------------------------
@release_564_2013.2.0
@PB_2.5.3.12
@Validation
Scenario: As a external user with batch sign permissions, when I sign at the Calendar View, all forms requiring signature for that subject are signed 

	And I login as user "<iMedidata User 1>"
	And I select study "<Study A>"
	And I select app "<App>"
	And I select site "<Site A1>" that is in study "<Study A>"
	And I create a subject
	And I select form "<Form1>" which requires signature
	And I enter data in field "<Field 1A>" on "<Form1>" in subject "<Subject>"
	And I enter data in field "<Field 2A>" on "<Form1>" in subject "<Subject>"
	And I click button "Save"
	And I select form "<Form 6>" does not require signature
	And I enter data in field "<Field 1H>" on "<Form 6>" in subject "<Subject>"
	And I enter data in field "<Field 2H>" on "<Form 6>" in subject "<Subject>"
	And I click button "Save"	
	And I select form "<Form 9>" in folder "<Folder A>" which requires signature
	And I enter data in field "<Field 9>" on "<Form 9>" in folder "<Folder A>"
	And I enter data in field "<LogField 9A>" on "<Form 9>" in folder "<Folder A>"
	And I enter data in field "<LogField 9B>" on "<Form 9>" in folder "<Folder A>"	
	And I click button "Save"	
	And I click the "subject tab"
	And I click button "Sign and Save" button
	And I see "Pop Up" window
	And in the window I see "|Reason for Signature|"
	And I see my "|Name|"
	And I see the current "|Timestamp|"		
	And I enter username textbox with User ID "<iMedidata user ID>"
	And I enter password textbox with Password "<iMedidata user Password>"
	When I click button "eSign"
	Then I should see text "Your signature is being applied. You may continue working on other subjects." on subject homepage
	And I take a screenshot 18 of 46
	And I go to form "<Form1>" 
	And I should see icon "Complete" for form "<Form1>" in subject "<Subject>" 
	And I should see icon "Complete" on "Field 1A" on form "<Form1>" in subject "<Subject>"
	And I should see icon "Complete" on "Field 2A" on form "<Form1>" in subject "<Subject>"
	When I click on complete icon on form level for subject "<Subject>"
	Then I should see the message "DataPage created." on the form level audit for form "<Form1>" in subject "<Subject>"	
	And I should see the message "User signature succeeded." on the form level audit for form "<Form1>" in subject "<Subject>"		
	And I take a screenshot 19 of 46
	And I click the tab "Form1"
	When I click on icon for field "<Field 1A>"
	Then I should see the message "User entered 'data'" on the audit for field "<Field 1A>" on form "<Form1>" in subject "<Subject>"	
	And I should see the message "User signature succeeded." on the audit for field "<Field 1A>" on form "<Form1>"	in subject "<Subject>"
	And I take a screenshot 20 of 46
	And I click the tab "Form1"
	When I click on icon for field "<Field 2A>"
	And I should see the message "User entered 'data'" on the audit for field "<Field 2A>" on form "<Form1>" in subject "<Subject>"
	And I should see the message "User signature succeeded." on the audit for field "<Field 2A>" on form "<Form1>" in subject "<Subject>"	
	And I take a screenshot 21 of 46
	And I click the "subject tab"
	And I go to form "<Form 6>"	
	And I should see icon "Complete" for form "<Form 6>" in subject "<Subject>" 
	And I should see icon "Complete" on "Field 1H" on form "<Form 6>" in subject "<Subject>"
	And I should see icon "Complete" on "Field 2H" on form "<Form 6>" in subject "<Subject>"
	And I should see the message "DataPage created." on the form level audit for form "<Form 6>" in subject "<Subject>"	
	And I should not see the message "User signature succeeded." on the form level audit for form "<Form 6>" in subject "<Subject>"		
	And I take a screenshot 22 of 46
	And I click the tab "Form6"
	When I click on icon for field "<Field 1H>"
	Then I should see the message "User entered 'data'" on the audit for field "<Field 1H>" on form "<Form 6>" in subject "<Subject>"	
	And I should not see the message "User signature succeeded." on the audit for field "<Field 1H>" on form "<Form 6>"	in subject "<Subject>"
	And I take a screenshot 23 of 46
	And I click the tab "Form6"
	When I click on icon for field "<Field 2H>"
	Then I should see the message "User entered 'data'" on the audit for field "<Field 2H>" on form "<Form 6>" in subject "<Subject>"
	And I should not see the message "User signature succeeded." on the audit for field "<Field 2H>" on form "<Form 6>" in subject "<Subject>"	
	And I take a screenshot	24 of 46
	And I click the "subject tab"
	And I go to form "<Form 9>" in folder "<Folder A>"
	And I should see icon "Complete" for form "<Form 9>" in subject "<Subject>" 
	And I should see icon "Complete" on "LogField 9A" on form "<Form 9>" in folder "<Folder A>"
	When I click on icon for form "<Form 9>"
	Then I should see the message "DataPage created." on the form level audit for form "<Form 9>" in folder "<Folder A>"	
	And I should see the message "User signature succeeded." on the form level audit for form "<Form 9>" in folder "<Folder A>"		
	And I take a screenshot 25 of 46
	And I click the tab "Form9" in folder "<Folder A>"
	When I click on icon for field "<Field 9>"
	Then I should see the message "User entered 'data'" on the audit for field "<Field 9>" on form "<Form 9>" in folder "<Folder A>"	
	And I should see the message "User signature succeeded." on the audit for field "<Field 9>" on form "<Form 9>"in folder "<Folder A>"
	And I take a screenshot 26 of 46
	And I click the tab "Form9" in folder "<Folder A>"
	And I click the log line link for the field "<Log Field 9A>"
	When I click on icon "Complete" for field "<Log Field 9A>"
	Then I should see the message "User entered 'data'" on the audit for field "<Log Field 9A>" on form "<Form 9>"in folder "<Folder A>"
	And I should see the message "User signature succeeded." on the audit for field "<Log Field 9A>" on form "<Form 9>"in folder "<Folder A>"	
	And I take a screenshot	27 of 46
	And I click the tab "Form9" in folder "<Folder A>"
	And I click the log line link for the field "<Log Field 9B>"
	When I click on icon "Complete" for field "<Log Field 9B>"
	Then I should see the message "User entered 'data'" on the audit for field "<Log Field 9B>" on form "<Form 9>"in folder "<Folder A>"
	And I should see the message "User signature succeeded." on the audit for field "<Log Field 9B>" on form "<Form 9>"in folder "<Folder A>"	
	And I take a screenshot	28 of 46
	
	
#------------------------------------------------------------------------------------------------------------
@release_564_patch12
@PB_2.5.3.13
@Validation
Scenario: As a external user, I will see a simple error message displayed when I attempt to sign in the Calendar View using an incorrect password.

	And I login as user "<iMedidata User 1>"
	And I select study "<Study A>"
	And I select app "<App>"
	And I select site "<Site A1>" that is in study "<Study A>"
	And I create a subject
	And I select form "<Form1>" which requires signature
	And I enter data in field "<Field 1A>" on "<Form1>" in subject "<Subject>"
	And I enter data in field "<Field 2A>" on "<Form1>" in subject "<Subject>"
	And I click button "Save"
	And I click button "Sign and Save" button
	And I see "Pop Up" window
	And in the window I see "|Reason for Signature|"
	And I see my "|Name|"
	And I see the current "|Timestamp|"		
	And I enter username textbox with User ID "<iMedidata user ID>"
	And I enter password textbox with Password "<Password1>xx"
	When I click button "eSign"
	Then I should see message "You tried to sign with a username and password that is not recognized" on the pop up
	And I take a screenshot 29 of 46
	
#------------------------------------------------------------------------------------------------------------
@release_564_patch9
@PB_2.5.3.14
@Validation
Scenario: As a external user with batch sign permissions, I will see the "Sign and Save" button in the Grid View.

	And I login as user "<iMedidata user 1>"
	And I select study "<Study A>"
	And I select app "<App>"
	And I select site "<Site A1>" that is in study "<Study A>"
	And I create a subject
	And I select link "Grid View"
	When I select link "All"
	Then I should see button "Sign and Save"
	And I take a screenshot 30 of 46
	
#------------------------------------------------------------------------------------------------------------
@release_564_2013.2.0
@PB_2.5.3.15 
@Validation
Scenario: As a external user with batch sign permissions, when I sign in the Grid View, all forms requiring signature for the subject are signed 

	And I login as user "<iMedidata User 1>"
	And I select study "<Study A>"
	And I select app "<App>"
	And I select site "<Site A1>" that is in study "<Study A>"
	And I create a subject
	And I select form "<Form1>"
	And I enter data in field "<Field 1A>" on "<Form1>" in subject "<Subject>"
	And I enter data in field "<Field 2A>" on "<Form1>" in subject "<Subject>"
	And I click button "Save"
	And I select form "<Form 6>"
	And I enter data in field "<Field 1H>" on "<Form 6>" in subject "<Subject>"
	And I enter data in field "<Field 2H>" on "<Form 6>" in subject "<Subject>"
	And I click button "Save"	
	And I select form "<Form 9>" in folder "<Folder A>"
	And I enter data in field "<Field 9>" on "<Form 9>" in folder "<Folder A>"
	And I enter data in field "<LogField 9A>" on "<Form 9>" in folder "<Folder A>"
	And I enter data in field "<LogField 9B>" on "<Form 9>" in folder "<Folder A>"	
	And I click button "Save"	
	And I click the "subject tab"
	And I select link "Grid View"
	And I select link "All"
	And I take a screenshot 31 of 46
	And I click button "Sign and Save" button
	And I see "Pop Up" window
	And in the window I see "|Reason for Signature|"
	And I see my "|Name|"
	And I see the current "|Timestamp|"
	And I enter username textbox with User ID "<iMedidata User ID>"
	And I enter password textbox with Password "<Password1>"
	When I click button "eSign"
	Then I should see text "Your signature is being applied. You may continue working on other subjects." on subject homepage
	And I take a screenshot 32 of 46
	And I go to form "<Form1>"
	And I should see icon "Complete" for form "<Form1>" in subject "<Subject>" 
	And I should see icon "Complete" on "Field 1A" on form "<Form1>" in subject "<Subject>"
	And I should see icon "Complete" on "Field 2A" on form "<Form1>" in subject "<Subject>"
	And I should see the message "DataPage created." on the form level audit for form "<Form1>" in subject "<Subject>"	
	And I should see the message "User signature succeeded." on the form level audit for form "<Form1>" in subject "<Subject>"		
	And I take a screenshot 33 of 46
	And I click the "Form1" tab
	And I should see the message "User entered 'data'" on the audit for field "<Field 1A>" on form "<Form1>" in subject "<Subject>"	
	And I should see the message "User signature succeeded." on the audit for field "<Field 1A>" on form "<Form1>"	in subject "<Subject>"
	And I take a screenshot 34 of 46
	And I click the "Form1" tab
	And I should see the message "User entered 'data'" on the audit for field "<Field 2A>" on form "<Form1>" in subject "<Subject>"
	And I should see the message "User signature succeeded." on the audit for field "<Field 2A>" on form "<Form1>" in subject "<Subject>"	
	And I take a screenshot	35 of 46
	And I click on the subject tab
	And I go to form "<Form 6>
	And I should see icon "Complete" for form "<Form 6>" in subject "<Subject>" 
	And I should see icon "Complete" on "Field 1H" on form "<Form 6>" in subject "<Subject>"
	And I should see icon "Complete" on "Field 2H" on form "<Form 6>" in subject "<Subject>"
	And I should see the message "DataPage created." on the form level audit for form "<Form 6>" in subject "<Subject>"	
	And I should not see the message "User signature succeeded." on the form level audit for form "<Form 6>" in subject "<Subject>"		
	And I take a screenshot 36 of 46
	And I click the "Form6" tab
	And I should see the message "User entered 'data'" on the audit for field "<Field 1H>" on form "<Form 6>" in subject "<Subject>"	
	And I should not see the message "User signature succeeded." on the audit for field "<Field 1H>" on form "<Form 6>"	in subject "<Subject>"
	And I take a screenshot 37 of 46
	And I click the "Form6" tab
	And I should see the message "User entered 'data'" on the audit for field "<Field 2H>" on form "<Form 6>" in subject "<Subject>"
	And I should see not the message "User signature succeeded." on the audit for field "<Field 2H>" on form "<Form 6>" in subject "<Subject>"	
	And I take a screenshot 38 of 46
	And I click on the subject tab
	And I go to form "<Form 9> in folder "<Folder A>"	
	And I should see icon "Complete" for form "<Form 9>" in subject "<Subject>" 
	And I should see icon "Complete" on "LogField 9A" on form "<Form 9>" in folder "<Folder A>"
	And I should see the message "DataPage created." on the form level audit for form "<Form 9>" in folder "<Folder A>"	
	And I should see the message "User signature succeeded." on the form level audit for form "<Form 9>" in folder "<Folder A>"		
	And I take a screenshot 39 of 46
	And I click the "Form9" tab
	And I should see the message "User entered 'data'" on the audit for field "<Field 9>" on form "<Form 9>" in folder "<Folder A>"	
	And I should see the message "User signature succeeded." on the audit for field "<Field 9>" on form "<Form 9>"in folder "<Folder A>"
	And I take a screenshot 40 of 46
	And I click the "Form9" tab
	And I should see the message "User entered 'data'" on the audit for field "<Log Field 9A>" on form "<Form 9>"in folder "<Folder A>"
	And I should see the message "User signature succeeded." on the audit for field "<Log Field 9A>" on form "<Form 9>"in folder "<Folder A>"	
	And I take a screenshot 41 of 46
	And I click the "Form9" tab
	And I should see the message "User entered 'data'" on the audit for field "<Log Field 9B>" on form "<Form 9>"in folder "<Folder A>"
	And I should see the message "User signature succeeded." on the audit for field "<Log Field 9B>" on form "<Form 9>"in folder "<Folder A>"	
	And I take a screenshot	42 of 46
		

#------------------------------------------------------------------------------------------------------------
@release_564_patch12
@PB_2.5.3.16
@Validation
Scenario: As a external user, I will see a simple error message displayed when I attempt to sign in the Grid View using an incorrect password.

	And I login as user "<iMedidata User 1>"
	And I select study "<Study A>"
	And I select app "<App>"
	And I select site "<Site A1>" that is in study "<Study A>"
	And I create a subject
	And I select form "<Form1>" which requires signature
	And I enter data in field "<Field 1A>" on "<Form1>" in subject "<Subject>"
	And I enter data in field "<Field 2A>" on "<Form1>" in subject "<Subject>"
	And I click button "Save"
	And I click the subject tab
	And I select link "Grid View"
	And I take a screenshot 43 of 46
	And I select form "<Form1>" which requires signature
	And I click button "Sign and Save" button
	And I see "Pop Up" window
	And in the window I see "|Reason for Signature|"
	And I see my "|Name|"
	And I see the current "|Timestamp|"	
	And I enter username textbox with User ID "<external user ID>"
	And I enter password textbox with Password "<external user Password>xx"
	When I click button "eSign"
	Then I should see message "You tried to sign with a username and password that is not recognized" on the pop up
	And I take a screenshot 44 of 46

#------------------------------------------------------------------------------------------------------------
@release_564_patch12
@PB_2.5.3.17
@Validation
Scenario: When an iMedidata user enters other user credential, then form is not signed and message stating that 'Previous operation did not succeed. Please reload the page and try again.' is displayed on the modal.

	And I login as user "<iMedidata User 1>"
	And I select study "<Study A>"
	And I select app "<App>"
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
	And I enter username textbox with existing other  User ID "<iMedidata User ID1>"
	And I enter password textbox with existing other Password "<iMedidata User Password>"
	When I click button "eSign"
	Then I should see message "Previous operation did not succeed. Please reload the page and try again."
	And I take a screenshot 45 of 46

#------------------------------------------------------------------------------------------------------------
@release_564_patch9
@PB_2.5.3.18
@Validation
Scenario: If the iMedidata session times out before the Rave session and the externally authenticated user submits valid eSignature credentials on Rave, then iMedidata will return “valid”. 

	And I login as user "<iMedidata user 1>"
	And I select study "<Study A>"
	And I select app "<App>"
	And I select site "<Site A1>" that is in study "<Study A>"
	And I create a subject
	And I select form "<Form1>"
	And I enter data in field "<Field 1A>" on "<Form1>" in subject "<Subject>"
	And I enter data in field "<Field 2A>" on "<Form1>" in subject "<Subject>"
	And I click button "<Save>"
	And I click button "Sign and Save"	
	And I should see "Pop Up" window
	And in the window I see "|Reason for Signature|"
	And I see my "|Name|"
	And I see the current "|Timestamp|"	
	And I wait until the iMedidata timeout period has passed
	And I enter username textbox with User ID "<iMedidata user ID>"
	And I enter password textbox with Password "<iMedidata user Password>"
	When I click button "eSign"
	Then I should see icon "Complete" for form "<Form1>" in subject "<Subject>" 
	And I should see icon "Complete" on "Field 1A" on form "<Form1>" in subject "<Subject>"
	And I should see icon "Complete" on "Field 2A" on form "<Form1>" in subject "<Subject>"
	And I should see message "First Name Last Name Title (iMedidata user 1) dd Mmm yyyy HH:mm:ss <Time Zone>"
	And I take a screenshot 46 of 46