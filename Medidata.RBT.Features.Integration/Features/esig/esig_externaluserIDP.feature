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
	As an externally authenticated user, I want to apply an electronic signature to forms from form level, calendar view and grid view for a study with only with Rave new style signatures 

	
Background:
	Given I am an IDP user
	And my username is <IDP User 1>
	And my password is <Password1>
	And I am assigned to a Study Group <Study Group 1>
	And I am assigned to a study <Study A> that is in <Study Group 1>
	And I am assigned to a site <Site A1> that is in <Study A> in <Study Group 1>
	And I have been assigned to the EDC app
	And I have been invited to the Data Manager role for site <Site A1> that is in <Study A> in <Study Group 1>
	And I have been given sign permissions to site <Site A1> that is in <Study A> in <Study Group 1>
	And I have been given batch sign permissions to site <Site A1> that is in <Study A> in <Study Group 1>

#------------------------------------------------------------------------------------------------------------	
@release_564_patch12
@2.5.3.1IDP
@Draft
Scenario: As an external user with sign permissions, I can access a subject form that requires eSignature.

	And I login as user "<IDP user 1>"
	And I select study "<Study A>"
	And I select site "<Site A1>" that is in study "<Study A>"
	And I create a subject
	When I select form "<Form 1>"
	Then I see form "<Form 1>" displayed
	And I should see button "<Sign And Save>"
	And I take a screenshot 1 of 
	
#------------------------------------------------------------------------------------------------------------
@release_564_patch12
@PB_2.5.3.2IDP
@Draft
Scenario: As an external user, when I click on the "Sign And Save" button on a form without saved data, I will see the eSignature pop up window
	
	And I login as user "<IDP user 1>"
	And I select study "<Study A>"
	And I select site "<Site A1>" that is in study "<Study A>"
	And I create a subject
	And I select form "<Form 1>"
	When I click button "Sign And Save"	
	Then I should see "Pop Up" window
	And in the window I see "|Reason for Signature|"
	And I see my "|Name|"
	And I see the current "|Timestamp|"
	And I should see "IDP credential validation page"
	And I should see <button> to submit credentials 
	And I take a screenshot 2 of 

|Reason for Signature|Name|Timestamp|
	|As Principle Investigator, I certify that the information provided is true and accurate to the best of my knowledge|John Gold|17-JUN-2012 14:24:51|
	|By signing, I acknowledge that I have reviewed and approved the information on this page|May Singleton|3-OCT-2012 18:01:23|
#------------------------------------------------------------------------------------------------------------
@release_564_patch12
@PB_2.5.3.3IDP
@Draft
Scenario: As an external user, I can click the "Sign And Save" button on a form with saved data and I will see the eSignature pop up window
	
	And I login as user "<IDP user 1>"
	And I select study "<Study A>"
	And I select site "<Site A1>" that is in study "<Study A>"
	And I create a subject
	And I select form "<Form 1>"
	And I enter data in field "<Field 1A>" on "<Form 1>" in subject "<Subject>"
	And I enter data in field "<Field 2A>" on "<Form 1>" in subject "<Subject>"
	And I click button "<Save>"
	And I shoud see icon "Requires Signature" for form "<Form 1>" in subject "<Subject>" 
	And I should see icon "Requires Signature" on "Field 1A" on form "<Form 1>" in subject "<Subject>"
	And I should see icon "Requires Signature" on "Field 2A" on form "<Form1>" in subject "<Subject>"
	And I should see icon "Requires Signature" on "Field 3A" on form "<Form1>" in subject "<Subject>"
	And I take a screenshot 3 of
	When I click button "Sign And Save"	
	Then I should see "Pop Up" window
	And in the window I see "|Reason for Signature|"
	And I see my "|Name|"
	And I see the current "|Timestamp|"
	And I should see "IDP credential validation page"
	And I should see <button> to submit credentials 
	And I take a screenshot 4 of 
	
#------------------------------------------------------------------------------------------------------------	
@release_564_patch12
@PB_2.5.3.4IDP
@Draft
Scenario: As an external user with sign privileges, I can successfully sign the form after data has been entered

	And I login as user "<IDP user 1>"
	And I select study "<Study A>"
	And I select site "<Site A1>" that is in study "<Study A>"
	And I create a subject
	And I select form "<Form 1>"
	And I enter data in field "<Field 1A>" on "<Form 1>" in subject "<Subject>"
	And I enter data in field "<Field 2A>" on "<Form 1>" in subject "<Subject>"
	And I click button "<Save>"
	And I click button "Sign And Save"	
	And I should see "Pop Up" window
	And in the window I see "|Reason for Signature|"
	And I see my "|Name|"
	And I see the current "|Timestamp|"
	And I complete all required verification fields
	When I click button to submit credentials for verification
	Then I shoud see icon "Complete" for form "<Form 1>" in subject "<Subject>" 
	And I should see icon "Complete" on "Field 1A" on form "<Form 1>" in subject "<Subject>"
	And I should see icon "Complete" on "Field 2A" on form "<Form1>" in subject "<Subject>"
	And I should see icon "Complete" on "Field 3A" on form "<Form1>" in subject "<Subject>"
	And I should see "This is the default signature message. - First Name Last Name Title (iMedidata user 1) dd Mmm yyyy HH:mm:ss <Time Zone>
	And I take a screenshot 5 of 

#------------------------------------------------------------------------------------------------------------
@release_564_patch12
@PB_2.5.3.5IDP
@Draft
Scenario: As an external user with access to the audit trail, I can view the audit trail to verify that a form has been successfully signed
	
	And I login as user "<IDP user 1>"
	And I select study "<Study A>"
	AAnd I select site "<Site A1>" that is in study "<Study A>"
	And I create a subject
	And I select form "<Form 1>"
	And I click button "Sign And Save"
	And I should see "Pop Up" window
	And in the window I see "|Reason for Signature|"
	And I see my "|Name|"
	And I see the current "|Timestamp|"
	And I enter username textbox with User ID "<iMedidata user ID>" #this should be like previous
	And I enter password textbox with Password "<iMedidata user Password>" #this should be like previous
	And I click button "eSign" #this should be like previous
	When I click icon "Complete" for form "<Form 1>" in subject "<Subject>" 
	Then I should see the message "User signature succeeded." on the on the form level audit on form "<Form 1>" in subject "<Subject>"
	And I should see the username <iMedidata user> on the form level audit on form "<Form 1>"	in subject "<Subject>
	And I should see the timestamp <dd MMM yyyy HH:mm:ss> "on the "form level audit on form "<Form 1>"	in subject "<Subject>
	And I take a screenshot 6 of 

#------------------------------------------------------------------------------------------------------------
@release_564_patch12
@PB_2.5.3.6 and .7IDP
@Draft
Scenario:As an IDP user 1 with signature permissions, I will see a warning message in the pop up window when I attempt to eSign with an incorrect credential

	And I login as user "<IDP user 1>"
	And I select study "<Study A>"
	And I select site "<Site A1>" that is in study "<Study A>"
	And I create a subject
	And I select form "<Form 1>"
	And I enter data in field "<Field 1A>" on "<Form 1>" in subject "<Subject>"
	And I enter data in field "<Field 2A>" on "<Form 1>" in subject "<Subject>"
	And I click button "Sign And Save"
	And I should see "Pop Up" window
	And in the window I see "|Reason for Signature|"
	And I see my "|Name|"
	And I see the current "|Timestamp|"
	And I complete all required verification fields
	And I enter incorrect data into one of the required fields # this can be 
	When I click button to submit credentials for verification
	Then I should see message <Failure message defined by IDP> on the pop up
	And I take a screenshot 7 of 

#------------------------------------------------------------------------------------------------------------
@release_564_patch12
@PB_2.5.3.8IDP
@Draft
Scenario: As a external user with access to the audit trail, I will see a simple message "User signature succeeded" for a successful attempt

	And I login as user "<IDP user 1>"
	And I select study "<Study A>"
	And I select app "<App>"
	And I select site "<Site A1>" that is in study "<Study A>"
	And I create a subject
	And I select form "<Form 1>"
	And I enter data in field "<Field 1A>" on "<Form 1>" in subject "<Subject>"
	And I enter data in field "<Field 2A>" on "<Form 1>" in subject "<Subject>"
	And I click button "Sign And Save"
	And I should see "Pop Up" window
	And in the window I see "|Reason for Signature|"
	And I see my "|Name|"
	And I see the current "|Timestamp|"
	And I enter username textbox with User ID "<iMediata user 1>" # should be the same as previous
	And I enter password textbox with Password "<Password1>" # should be the same as previous
	And I click button "eSign" # should be the same as previous
	And I should see icon "Complete" for form "<Form1>"
	When I click on icon "<Complete>" for form "<Form1>"
	And I should see the message "User signature succeeded." on the form level audit for form "<Form 1>" in subject "<Subject>"
	And I should see the message "DataPage created" on the form level audit for form "<Form1>" in subject "<Subject>"
	And I take a screenshot 8 of 
	And I click tab "<Form1>"
	And I click on icon "<Complete>" for field "Field 1A"
	And I should see the message "User entered 'data'" on the audit for field "<Field 1A>" on form "<Form1>" in subject "<Subject>"	
	And I should see the message "User signature succeeded." on the audit for field "<Field 1A>" on form "<Form1>" in subject "<Subject>"
	And I take a screenshot 9 of 
	And I click tab "<Form1>"
	And I click on icon "<Complete>" for field "Field 2A"
	And I should see the message "User entered 'data'" on the audit for field "<Field 2A>" on form "<Form1>" in subject "<Subject>"
	And I should see the message "User signature succeeded." on the audit for field "<Field 2A>" on form "<Form1>" in subject "<Subject>"
	And I take a screenshot 10 of 
	And I click tab "<Form1>"
	And I click on icon "<Complete>" for field "Field 3A"
	And I should see the message "Record created." on the audit for field "<Field 3A>" on form "<Form1>" in subject "<Subject>"
	And I take a screenshot 11 of 
	And I select link "Children: Data Point - FIELD 3A"
	And I should see the message "User entered empty" on the audit for field "<Field 3A>" on form "<Form1>" in subject "<Subject>"
	And I should see the message "User signature succeeded." on the audit for field "<Field 3A>" on form "<Form1>" in subject "<Subject>"
	And I take a screenshot 12 of 
	
#------------------------------------------------------------------------------------------------------------
@release_564_patch12
@PB_2.5.3.10IDP
@Validation
Scenario: As a external user with batch sign permissions, I will see the  "Sign and Save" button on the Calender view.

	And I login as user "<IDP User 1>"
	And I select study "<Study A>"
	And I select site "<Site A1>" that is in study "<Study A>"
	When I create a subject
	Then I should see button "Sign And Save"
	And I take a screenshot 13
		
#------------------------------------------------------------------------------------------------------------
@release_564_patch12
@PB_2.5.3.11IDP
@Draft
Scenario: As a external user, when I click on the "Sign and Save" button on the subject homepage, I will see an eSignature pop up window

	And I login as user "<IDP user 1>"
	And I select study "<Study A>"
	And I select site "<Site A1>" that is in study "<Study A>"
	And I create a subject
	When I click button "Sign And Save"
	Then I should see "Pop Up" window
	And in the window I see "|Reason for Signature|"
	And I see my "|Name|"
	And I see the current "|Timestamp|"
	And I should see textbox with label "Username"
	And I should see textbox with label "Password"
	And I should see button with label "eSign"
	And I take a screenshot 14

#------------------------------------------------------------------------------------------------------------
@release_564_patch12
@PB_2.5.3.12IDP
@Draft
Scenario: As a external user with batch sign permissions, when I sign at the Calendar View, all forms requiring signature for that subject are signed 

	And I login as user "<IDP user 1>"
	And I select study "<Study A>"
	And I select site "<Site A1>" that is in study "<Study A>"
	And I create a subject
	And I select form "<Form 1>" which requires signature
	And I enter data in field "<Field 1A>" on "<Form 1>" in subject "<Subject>"
	And I enter data in field "<Field 2A>" on "<Form 1>" in subject "<Subject>"
	And I click button "Save"
	And I select form "<Form 6>" does not require signature
	And I enter data in field "<Field 1H>" on "<Form 6>" in subject "<Subject>"
	And I enter data in field "<Field 2H>" on "<Form 6>" in subject "<Subject>"
	And I click button "Save"	
	And I select form "<Form 9>" which requires signature
	And I enter data in field "<Field 9>" on "<Form 9>" in folder "<Folder A>"
	And I enter data in field "<LogField 9A>" on "<Form 9>" in folder "<Folder A>"
	And I enter data in field "<LogField 9B>" on "<Form 9>" in folder "<Folder A>"	
	And I click button "Save"	
	And I click the "subject tab"
	And I click button "Sign And Save" button
	And I see "Pop Up" window
	And in the window I see "|Reason for Signature|"
	And I see my "|Name|"
	And I see the current "|Timestamp|"
	And I enter username textbox with User ID "<iMedidata user ID>"
	And I enter password textbox with Password "<iMedidata user Password>"
	When I click button "eSign"
	Then I should see text "Signature attempt was successful" on subject homepage
	And I take a screenshot 15
	And I go to form "<Form 1>" 
	And I shoud see icon "Complete" for form "<Form 1>" in subject "<Subject>" 
	And I should see icon "Complete" on "Field 1A" on form "<Form 1>" in subject "<Subject>"
	And I should see icon "Complete" on "Field 1B" on form "<Form 1>" in subject "<Subject>"
	And I should see the message "DataPage created." on the form level audit for form "<Form 1>" in subject "<Subject>"	
	And I should see the message "User signature succeeded." on the form level audit for form "<Form 1>" in subject "<Subject>"		
	And I take a screenshot 16
	And I click the tab "Form1"
	When I click on icon for field "<Field 1A>"
	And I should see the message "User entered 'data'" on the audit for field "<Field 1A>" on form "<Form 1>" in subject "<Subject>"	
	And I should see the message "User signature succeeded." on the audit for field "<Field 1A>" on form "<Form 1>"	in subject "<Subject>"
	And I take a screenshot 17
	And I should see the message "User entered 'data'" on the audit for field "<Field 2A>" on form "<Form 1>" in subject "<Subject>"
	And I should see the message "User signature succeeded." on the audit for field "<Field 2A>" on form "<Form 1>" in subject "<Subject>"	
	And I take a screenshot
	And I go to form "<Form 6>"	
	And I shoud see icon "Complete" for form "<Form 6>" in subject "<Subject>" 
	And I should see icon "Complete" on "Field 1H" on form "<Form 6>" in subject "<Subject>"
	And I should see icon "Complete" on "Field 2H" on form "<Form 6>" in subject "<Subject>"
	And I should see the message "DataPage created." on the form level audit for form "<Form 6>" in subject "<Subject>"	
	And I should not see the message "User signature succeeded." on the form level audit for form "<Form 6>" in subject "<Subject>"		
	And I take a screenshot
	And I should see the message "User entered 'data'" on the audit for field "<Field 1H>" on form "<Form 6>" in subject "<Subject>"	
	And I should see the message "User signature succeeded." on the audit for field "<Field 1H>" on form "<Form 6>"	in subject "<Subject>"
	And I take a screenshot
	And I should see the message "User entered 'data'" on the audit for field "<Field 2H>" on form "<Form 6>" in subject "<Subject>"
	And I should see the message "User signature succeeded." on the audit for field "<Field 2HA>" on form "<Form 6>" in subject "<Subject>"	
	And I take a screenshot	
	And I go to form "<Form 9>"
	And I shoud see icon "Complete" for form "<Form 9>" in subject "<Subject>" 
	And I should see icon "Complete" on "LogField 9A" on form "<Form 9>" in folder "<Folder A>"
	And I should see the message "DataPage created." on the form level audit for form "<Form 9>" in folder "<Folder A>"	
	And I should see the message "User signature succeeded." on the form level audit for form "<Form 9>" in folder "<Folder A>"		
	And I take a screenshot
	And I should see the message "User entered 'data'" on the audit for field "<Field 9>" on form "<Form 9>" in folder "<Folder A>"	
	And I should see the message "User signature succeeded." on the audit for field "<Field 9>" on form "<Form 9>"in folder "<Folder A>"
	And I take a screenshot
	And I should see the message "User entered 'data'" on the audit for field "<Log Field 9A>" on form "<Form 9>"in folder "<Folder A>"
	And I should see the message "User signature succeeded." on the audit for field "<Log Field 9A>" on form "<Form 9>"in folder "<Folder A>"	
	And I take a screenshot	
	And I should see the message "User entered 'data'" on the audit for field "<Log Field 9B>" on form "<Form 9>"in folder "<Folder A>"
	And I should see the message "User signature succeeded." on the audit for field "<Log Field 9B>" on form "<Form 9>"in folder "<Folder A>"	
	And I take a screenshot	
	And I should see the message "User entered 'data'" on the audit for field "<Log Field 9C>" on form "<Form 9>"in folder "<Folder A>"
	And I should see the message "User signature succeeded." on the audit for field "<Log Field 9c>" on form "<Form 9>"in folder "<Folder A>"	
	And I take a screenshot	

#------------------------------------------------------------------------------------------------------------
@release_564_patch12
@PB_2.5.3.13IDP
@Draft
Scenario: As a external user, I will see a simple error message displayed when I attempt to sign in the Calendar View using an incorrect password.

	And I login as user "<IDP user 1>"
	And I select study "<Study A>"
	And I select site "<Site A1>" that is in study "<Study A>"
	And I create a subject
	And I select form "<Form 1>" which requires signature
	And I enter data in field "<Field 1A>" on "<Form 1>" in subject "<Subject>"
	And I enter data in field "<Field 2A>" on "<Form 1>" in subject "<Subject>"
	And I click button "Save"
	And I click button "Sign And Save" button
	And I see "Pop Up" window
	And in the window I see "|Reason for Signature|"
	And I see my "|Name|"
	And I see the current "|Timestamp|"
	And I enter username textbox with User ID "<iMedidata user ID>"
	And I enter password textbox with Password "<Password1>xx"
	When I click button "eSign"
	Then I should see message "<Failure message defined by IDP>" on the popup
	And I take a screenshot

#------------------------------------------------------------------------------------------------------------
@release_564_patch12
@PB_2.5.3.14
@Draft
Scenario: As a external user with batch sign permissions, I will see the "Sign and Save" button in the Grid View.

	And I login as user "<IDP user 1>"
	And I select study "<Study A>"
	And I select site "<Site A1>" that is in study "<Study A>"
	And I create a subject
	And I select link "Grid View"
	When I select link "All"
	Then I should see button "Sign And Save"
	And I take a screenshot

#------------------------------------------------------------------------------------------------------------
@release_564_patch12
@PB_2.5.3.15 
@Draft
Scenario: As a external user with batch sign permissions, when I sign in the Grid View, all forms requiring signature for the subject are signed.
	
	And I login as user "<IDP user 1>"
	And I select study "<Study A>"
	And I select site "<Site A1>" that is in study "<Study A>"
	And I create a subject
	And I select form "<Form 1>"
	And I enter data in field "<Field 1A>" on "<Form 1>" in subject "<Subject>"
	And I enter data in field "<Field 2A>" on "<Form 1>" in subject "<Subject>"
	And I click button "Save"
	And I select form "<Form 6>"
	And I enter data in field "<Field 1H>" on "<Form 6>" in subject "<Subject>"
	And I enter data in field "<Field 2H>" on "<Form 6>" in subject "<Subject>"
	And I click button "Save"	
	And I select form "<Form 9>"
	And I enter data in field "<Field 9>" on "<Form 9>" in folder "<Folder A>"
	And I enter data in field "<LogField 9A>" on "<Form 9>" in folder "<Folder A>"
	And I enter data in field "<LogField 9B>" on "<Form 9>" in folder "<Folder A>"	
	And I enter data in field "<LogField 9c>" on "<Form 9>" in folder "<Folder A>"
	And I click button "Save"	
	And I click the "subject tab"
	And I select link "Grid View"
	And I select link "All"
	And I click button "Sign And Save" button
	And I see "Pop Up" window
	And I enter username textbox with User ID "<iMedidata User ID>"
	And I enter password textbox with Password "<Password1>"
	When I click button "eSign"
	Then I should see text "Signature attempt was successful" on subject homepage
	And I go to form "<Form 1>"
	And I shoud see icon "Complete" for form "<Form 1>" in subject "<Subject>" 
	And I should see icon "Complete" on "Field 1A" on form "<Form 1>" in subject "<Subject>"
	And I should see icon "Complete" on "Field 1B" on form "<Form 1>" in subject "<Subject>"
	And I should see the message "DataPage created." on the form level audit for form "<Form 1>" in subject "<Subject>"	
	And I should see the message "User signature succeeded." on the form level audit for form "<Form 1>" in subject "<Subject>"		
	And I take a screenshot
	And I should see the message "User entered 'data'" on the audit for field "<Field 1A>" on form "<Form 1>" in subject "<Subject>"	
	And I should see the message "User signature succeeded." on the audit for field "<Field 1A>" on form "<Form 1>"	in subject "<Subject>"
	And I take a screenshot
	And I should see the message "User entered 'data'" on the audit for field "<Field 2A>" on form "<Form 1>" in subject "<Subject>"
	And I should see the message "User signature succeeded." on the audit for field "<Field 2A>" on form "<Form 1>" in subject "<Subject>"	
	And I take a screenshot	
	And I go to form "<Form 6>
	And I shoud see icon "Complete" for form "<Form 6>" in subject "<Subject>" 
	And I should see icon "Complete" on "Field 1H" on form "<Form 6>" in subject "<Subject>"
	And I should see icon "Complete" on "Field 2H" on form "<Form 6>" in subject "<Subject>"
	And I should see the message "DataPage created." on the form level audit for form "<Form 6>" in subject "<Subject>"	
	And I should not see the message "User signature succeeded." on the form level audit for form "<Form 6>" in subject "<Subject>"		
	And I take a screenshot
	And I should see the message "User entered 'data'" on the audit for field "<Field 1H>" on form "<Form 6>" in subject "<Subject>"	
	And I should see the message "User signature succeeded." on the audit for field "<Field 1H>" on form "<Form 6>"	in subject "<Subject>"
	And I take a screenshot
	And I should see the message "User entered 'data'" on the audit for field "<Field 2H>" on form "<Form 6>" in subject "<Subject>"
	And I should see the message "User signature succeeded." on the audit for field "<Field 2HA>" on form "<Form 6>" in subject "<Subject>"	
	And I take a screenshot	
	And I go to form "<Form 9>
	And I shoud see icon "Complete" for form "<Form 9>" in subject "<Subject>" 
	And I should see icon "Complete" on "LogField 9A" on form "<Form 9>" in folder "<Folder A>"
	And I should see the message "DataPage created." on the form level audit for form "<Form 9>" in folder "<Folder A>"	
	And I should see the message "User signature succeeded." on the form level audit for form "<Form 9>" in folder "<Folder A>"		
	And I take a screenshot
	And I should see the message "User entered 'data'" on the audit for field "<Field 9>" on form "<Form 9>" in folder "<Folder A>"	
	And I should see the message "User signature succeeded." on the audit for field "<Field 9>" on form "<Form 9>"in folder "<Folder A>"
	And I take a screenshot
	And I should see the message "User entered 'data'" on the audit for field "<Log Field 9A>" on form "<Form 9>"in folder "<Folder A>"
	And I should see the message "User signature succeeded." on the audit for field "<Log Field 9A>" on form "<Form 9>"in folder "<Folder A>"	
	And I take a screenshot	
	And I should see the message "User entered 'data'" on the audit for field "<Log Field 9B>" on form "<Form 9>"in folder "<Folder A>"
	And I should see the message "User signature succeeded." on the audit for field "<Log Field 9B>" on form "<Form 9>"in folder "<Folder A>"	
	And I take a screenshot	
	And I should see the message "User entered 'data'" on the audit for field "<Log Field 9C>" on form "<Form 9>"in folder "<Folder A>"
	And I should see the message "User signature succeeded." on the audit for field "<Log Field 9c>" on form "<Form 9>"in folder "<Folder A>"	
	And I take a screenshot	

#------------------------------------------------------------------------------------------------------------
@release_564_patch12
@PB_2.5.3.16
@Draft
Scenario: As a external user, I will see a simple error message displayed when I attempt to sign in the Grid View using an incorrect password.

	And I login as user "<IDP user 1>"
	And I select study "<Study A>"
	And I select site "<Site A1>" that is in study "<Study A>"
	And I create a subject
	And I select form "<Form 1>" which requires signature
	And I enter data in field "<Field 1A>" on "<Form 1>" in subject "<Subject>"
	And I enter data in field "<Field 2A>" on "<Form 1>" in subject "<Subject>"
	And I click button "Save"
	And I click button "Sign And Save" button
	And I see "Pop Up" window
	And I enter username textbox with User ID "<external user ID>"
	And I enter password textbox with Password "<external user Password>xx"
	When I click button "eSign"
	Then I should see message "<Failure message defined by IDP>" on the popup
	And I take a screenshot
	
	
#------------------------------------------------------------------------------------------------------------
@release_564_patch12
@PB_2.5.3.17
@Draft
Scenario: As an IDP user that failed 5 consecutive signature attempts (when the IDP owner has set the lockout limit at 5 failed attempts), my Rave session should be ended and I should be on the IDP portal login page

	And I login as user "<iMedidata user 1>"
	And I select study "<Study A>"
	And I select site "<Site A1>" that is in study "<Study A>"
	And I create a subject
	And I select form "<Form1>"
	And I enter data in field "<Field 1A>" on "<Form1>" in subject "<Subject>"
	And I enter data in field "<Field 2A>" on "<Form1>" in subject "<Subject>"
	And I click button "Sign And Save"
	And I should see "Pop Up" window
	And I enter username textbox with User ID "<IDP User ID>"
	And I enter password textbox with Password "<Password1xx>"
	And I click button "eSign"
	And I should see message "You tried to sign with a username and password that is not recognized" on the pop up
	And I enter username textbox with User ID "<IDP User ID>"
	And I enter password textbox with Password "<Password1xx>"
	And I click button "eSign"
	And I should see message "You tried to sign with a username and password that is not recognized" on the pop up
	And I enter username textbox with User ID "<IDP User ID>"
	And I enter password textbox with Password "<Password1xx>"
	And I click button "eSign"
	And I should see message "You tried to sign with a username and password that is not recognized" on the pop up
	And I enter username textbox with User ID "<IDP User ID>"
	And I enter password textbox with Password "<Password1xx>"
	And I click button "eSign"
	And I should see message "You tried to sign with a username and password that is not recognized" on the pop up
	And I enter username textbox with User ID "<IDP User ID>"
	And I enter password textbox with Password "<Password1xx>"
	When I click button "eSign"
	Then I should see page "IDP Login Page"
	And I should see text "<Lockout message deined by IDP>"
	And I take a screenshot
	
	