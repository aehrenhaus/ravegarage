#Rave allows for eSignatures to be applied to Forms, Folders and Subjects, as well as eLearning confirmation pages. As part of Rave’s current user authentication model, the user submits their eSignature credentials as a binding eSignature in Rave.
#Rave supports two types of eSignature methods. The old style eSignature which is built into the eCRF form using an eSig field OID, which is being deprecated beginning in Rave 5.6.4 patch 9. This signature method relies on credentials residing in the Rave database or direct API communication to mimic the credentials being stored in the Rave database for performing the verification to support eSignatures which validate individual datapoints.
#The new style eSignature, which resides at the form level, offers the flexibility to use iMedidata CAS to authenticate or verify user credentials. These form level verfications provide a more eficient means of bulk signing and do not require individual datapoint verification.
# The new style signatures will leverage the Sign and Save eSignature method of verifying and applying an eSignature to the form (or forms) before saving changes. A modal window will be used to present the signature request and to capture the credentials for verification. If verification succeeds, data is saved and the eSignature is applied to all new style forms. If verification should fail, the signature is not applied, no selections or changes are saved and the modal window can be closed. All selections made prior to the modal opening are persisted and the user may choose to Save or Cancel without applying an eSignature. By default, Rave sets a failure threshold of 3 failed attempts before the user is locked out. This rule remains in effect.
#eSignature failure messages and audit failure messages will be simplified so that users are not given information that would compromise Rave security. Audit success messages will be simplified and unified to match the failure messages and to accurately reflect the message content defined by the SAML protocol. 


Feature: eSignature for Rave internal user
	As a Rave user,	I want to apply an electronic signature to forms from form level, calendar view and grid view for a study with only with Rave new style signatures 

	
Background:
	Given I am a Rave user "<User>" with pin "<PIN>" password "<Password>" and user id "User ID>"
		|User				|PIN				| Password				|User ID				|
		|{Rave User 1}		|{Rave User PIN}	|{Rave User Password}	|{Rave User ID}	|
	And there exists study "<Study>"
		|Study		|
		|{Study A}	|
	And there exists app "<App>" associated with study "<Study>",
		|App			|
		|{Edc App}		|
		|{EModules App}	|	
	And there exists site "<Site>" in study "<Study>", 		
		|Study		|Site		|
		|{Study A}	|{Site A1}	|
	And there exists subject "<Subject>" in site "<Site>", 
		|Site		|Subject		|
		|{Site A1}	|{SUB A1001}	|
		|{Site A1}	|{SUB A1002}	|
		|{Site A1}	|{SUB A1003}	|
		|{Site A1}	|{SUB A1004}	|
	And there exists form "<Form>" has signature required "<Signature Required>" in row "<Row>", 
		|Row	|Form		|Signature Required	|
		|1		|{Form1}	|True				|
		|2		|{FORM 2}	|True				|
		|3		|{FORM 3}	|True				|
		|4		|{FORM 4}	|True				|
		|5		|{FORM 5}	|True				|
		|6		|{Form6}	|False				|
		|7		|{FORM 7}	|False				|
		|8		|{FORM 8}	|False				|
		|9		|{Form9}	|True				|
		|10		|{Form10}	|False				|	
		
	And there exists form "<Form>" with field "<Fields>", varOID "<VarOID>", format "<Format>",  field name "<Field Name>", field OID "<Field OID>", active status "<Active>", visible status "<Is visible fields>", field label "<Field Label>", and control type "<Control Type>",
		|Form		|Fields		|VarOID		|Format	|Field Name	|Field OID	|Active	|Is visible fields	|Field Label	|Control Type	|
		|{Form1}	|{Field 1A}	|{FIELD1A}	|$4		|{{FIELD1A}	|{{FIELD1A}	|True	|True				|{Field 1A}		|Text			|
		|{Form1}	|{Field 2A}	|{FIELD2A}	|$4		|{{FIELD2A}	|{{FIELD2A}	|True	|True				|{Field 2A}		|Text			|               
		|{FORM 2}	|{Field 1B}	|{FIELD1B}	|$4		|{{FIELD1B}	|{{FIELD1B}	|True	|True				|{Field 1B}		|Text			| 
		|{FORM 2}	|{Field 2B}	|{FIELD2B}	|$4		|{{FIELD2B}	|{{FIELD2B}	|True	|True				|{Field 2B}		|Text			|
		|{FORM 3}	|{Field 1C}	|{FIELD1C}	|$4		|{{FIELD1C}	|{{FIELD1C}	|True	|True				|{Field 1C}		|Text			| 
		|{FORM 3}	|{Field 2C}	|{FIELD2C}	|$4 	|{{FIELD2C}	|{{FIELD2C}	|True	|True				|{Field 2C}		|Text			|
		|{FORM 4}	|{Field 1D}	|{FIELD1D}	|$4		|{{FIELD1D}	|{{FIELD1D}	|True	|True				|{Field 1D}		|Text			| 
		|{FORM 4}	|{Field 2D}	|{FIELD2D}	|$4 	|{{FIELD2D}	|{{FIELD2D}	|True	|True				|{Field 2D}		|Text			|
		|{FORM 5}	|{Field 1E}	|{FIELD1E}	|$4		|{{FIELD1E}	|{{FIELD1E}	|True	|True				|{Field 1E}		|Text			| 
		|{FORM 5}	|{Field 1E}	|{FIELD2E}	|$4		|{{FIELD2E}	|{{FIELD2E}	|True	|True				|{Field 2E}		|Text			|
		|{Form6}	|{Field 1H}	|{FIELD1H}	|$4		|{{FIELD1H}	|{{FIELD1H}	|True	|True				|{Field 1H}		|Text			| 
		|{Form6}	|{Field 2H}	|{FIELD2H}	|$4 	|{{FIELD2H}	|{{FIELD2H}	|True	|True				|{Field 2H}		|Text			|
		|{FORM 7}	|{Field 1F}	|{FIELD1F}	|$4		|{{FIELD1F}	|{{FIELD1F}	|True	|True				|{Field 1F}		|Text			| 
		|{FORM 7}	|{Field 2F}	|{FIELD2F}	|$4 	|{{FIELD2F}	|{{FIELD2F}	|True	|True				|{Field 2F}		|Text			|
		|{FORM 8}	|{Field 1G}	|{FIELD1G}	|$4		|{{FIELD1G}	|{{FIELD1G}	|True	|True				|{Field 1G}		|Text			| 
		|{FORM 8}	|{Field 1G}	|{FIELD2G}	|$4		|{{FIELD2G}	|{{FIELD2G}	|True	|True				|{Field 2G}		|Text			|
		|{Form9}	|{Field 1G}	|{FIELD1G}	|$4		|{{FIELD1G}	|{{FIELD1G}	|True	|True				|{Field 1G}		|Text			| 
		|{Form10}	|{Field 1G}	|{FIELD2G}	|$4		|{{FIELD2G}	|{{FIELD2G}	|True	|True				|{Field 2G}		|Text			|
		
	And there exists folder "<Folder>" with child folder "<Child Folder>", from the table below
		|Folder		|
		|{Folder A} |
		|{Folder B} |
	And there exists matrix "<Matrix>" with folder "<Folder>" and form "<Form>",
		|Matrix		|Folder		|Form		|
		|{Matrix 1}	|{Folder A}	|{Form1}	|
		|{Matrix 1}	|{Folder A}	|{FORM 2}	|
		|{Matrix 1}	|{Folder A}	|{FORM 3}	|
		|{Matrix 1}	|{Folder A}	|{FORM 4}	|
		|{Matrix 1}	|{Folder A}	|{FORM 5}	|
		|{Matrix 1} |{Folder A}	|{Form6}	|
		|{Matrix 1} |{Folder A}	|{FORM 7}	|
		|{Matrix 1} |{Folder A}	|{FORM 8}	|
		|{Matrix 1} |{Folder A}	|{Form9}	|
		|{Matrix 1} |{Folder A}	|{Form10}	|
		|{Matrix 1}	|{Folder B}	|{FORM 2}	|
		|{Matrix 1}	|{Folder B}	|{FORM 3}	|
		|{Matrix 1}	|{Folder B}	|{FORM 4}	|
		|{Matrix 1}	|{Folder B}	|{FORM 7}	|
		|{Matrix 1}	|{Folder B}	|{FORM 8}	|
		|{Matrix 1} |{Folder B}	|{Form10}	|
	And there exists form "<Form>" in subject "<Subject>", 
		|Subject		|Form		|
		|{SUB A1001}	|{Form1}	|
		|{SUB A1001}	|{FORM 2}	|	
		|{SUB A1001}	|{Form6}	|
		|{SUB A1001}	|{Form9}	|
	And	user "<User>" has Sign privileges and has access to site "{Site A1}" that is in study "{Study A}" in database "<EDC> Database",
		|User				|
		|{Rave User 1}		|
		
#----------------------------------------------------------------------------------------------------------------------
@release_564_patch9
@PB_2.5.2.1
@Validation
Scenario: As a Rave user with sign permissions, I can access a subject form that requires eSignature.

	And I login as user "<Rave User 1>"
	And I select study "<Study A>"
	And I select site "<Site A1>" that is in study "<Study A>"
	And I create a subject
	When I select form "<Form1>"
	Then I see form "<Form1>" displayed
	And I should see button "<Sign and Save>"
	And I take a screenshot 1 of 38
	
#----------------------------------------------------------------------------------------------------------------------
@release_564_patch12
@PB_2.5.2.2
@Validation
Scenario: As a Rave user, when I click on the "Sign and Save" button on a form without saved data, I will see the eSignature pop up window

	And I login as user "<Rave User 1>"
	And I select study "<Study A>"
	And I select site "<Site A1>" that is in study "<Study A>"
	And I create a subject
	And I select form "<Form1>"
	When I click button "Sign and Save"	
	Then I should see "Pop Up" window
	And I should see textbox with label "User Name"
	And I should see textbox with label "Password"
	And I should see button with label "Sign and Save"
	And in the window I see "|Reason for Signature|"
	And I see my "|Name|"
	And I see the current "|Timestamp|"
	And I take a screenshot 2 of 38

#----------------------------------------------------------------------------------------------------------------------
@release_564_patch12
@PB_2.5.2.3
@Validation
Scenario: As a Rave user, I can click the "Sign and Save" button on a form with saved data and I will see the eSignature pop up window

	And I login as user "<Rave User 1>"
	And I select study "<Study A>"
	And I select site "<Site A1>" that is in study "<Study A>"
	And I create a subject
	And I select form "<Form1>"
	And I enter data in field "<Field 1A>" on "<Form1>" in subject "<Subject>"
	And I enter data in field "<Field 2A>" on "<Form1>" in subject "<Subject>"
	And I click button "<Save>"
	When I click button "Sign and Save"	
	Then I should see "Pop Up" window
	And I should see textbox with label "User Name"
	And I should see textbox with label "Password"
	And I should see button with label "Sign and Save"
	And in the window I see "|Reason for Signature|"
	And I see my "|Name|"
	And I see the current "|Timestamp|"
	And I take a screenshot 3 of 38

#----------------------------------------------------------------------------------------------------------------------
@release_564_patch12
@PB_2.5.2.4
@Validation
Scenario: As a Rave user with sign privileges, I can successfully sign the form after data has been entered

	And I login as user "<Rave User 1>"
	And I select study "<Study A>"
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
	And I enter user name textbox with User ID "<RaveUser ID>"
	And I enter password textbox with Password "<Rave User Password>"
	When I click button "Sign and Save"
	Then I should see icon "Complete" for form "<Form1>" in subject "<Subject>" 
	And I should see icon "Complete" on "Field 1A" on form "<Form1>" in subject "<Subject>"
	And I should see icon "Complete" on "Field 2A" on form "<Form1>" in subject "<Subject>"
	And I should see User's Name and Title
	And I should see User's date and timezone
	And I take a screenshot 4 of 38

#----------------------------------------------------------------------------------------------------------------------
@release_564_patch12
@PB_2.5.2.5
@Validation
Scenario: As a Rave user with access to the audit trail, I can view the audit trail to verify that a form has been successfully signed

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
	And I take a screenshot 5 of 38
	And I go back to form "<Form1>"
	When I click icon "Complete" on "Field 1A" on form "<Form1>" in subject "<Subject>"
	Then I should see the message "User entered 'data'" on the audit for field "<Field 1A>" on form "<Form1>" in subject "<Subject>"	
	And I should see the message "User signature succeeded." on the audit for field "<Field 1A>" on form "<Form1>"	in subject "<Subject>"
	And I take a screenshot 6 of 38
	And I go back to form "<Form1>"
	When I click icon "Complete" on "Field 2A" on form "<Form1>" in subject "<Subject>"
	Then I should see the message "User entered 'data'" on the audit for field "<Field 2A>" on form "<Form1>" in subject "<Subject>"
	And I should see the message "User signature succeeded." on the audit for field "<Field 2A>" on form "<Form1>" in subject "<Subject>"	
	And I take a screenshot 7 of 38	
	
#----------------------------------------------------------------------------------------------------------------------
@release_564_patch12
@PB_2.5.2.6
@Validation
Scenario: As a Rave user with signature permissions, I will see a warning message in the pop up window when I attempt to sign with a bad username

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
	And I enter user name textbox with User ID "<Rave User ID>XX"
	And I enter password textbox with Password "<Rave User Password>"
	When I click button "Sign and Save"
	Then I should see message "Signature attempt failed" on the pop up
	And I take a screenshot 8 of 38

#----------------------------------------------------------------------------------------------------------------------
@release_564_patch12
@PB_2.5.2.7
@Validation
Scenario: As a Rave user with signature permissions, I will see a warning message in the pop up window when I attempt to Sign and Save with a bad password

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
	When I click button "Sign and Save"
	Then I should see message "Signature attempt failed" on the pop up
	And I take a screenshot 9 of 38

#----------------------------------------------------------------------------------------------------------------------
@release_564_patch12
@PB_2.5.2.8
@Validation
Scenario: As a Rave user with access to the audit trail, I will see a simple message "Signature attempt failed" in the audit trail for a failed signature attempt or "Signature attempt succeeded" for a successful attempt

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
	And I enter user name textbox with User ID "<Rave User ID>XX"
	And I enter password textbox with Password "<Rave User Password>"
	And I click button "Sign and Save"
	And I should see message "Signature attempt failed" on the pop up
	And I enter username textbox with User ID "<Rave User ID>"
	And I enter password textbox with Password "<Rave User Password>"
	When I click button "Sign and Save"
	Then I should see icon "Complete" for form "<Form1>" in subject "<Subject>" 
	And I should see icon "Complete" on "Field 1A" on form "<Form1>" in subject "<Subject>"
	And I should see icon "Complete" on "Field 2A" on form "<Form1>" in subject "<Subject>"
	And I should see the message "DataPage created." on the form level audit for form "<Form1>" in subject "<Subject>"	
	And I should see the message "User signature failed." on the form level audit for form "<Form1>" in subject "<Subject>"
	And I should see the message "User signature succeeded." on the form level audit for form "<Form1>" in subject "<Subject>"
	And I take a screenshot 10 of 38
	And I should see the message "User entered 'data'" on the audit for field "<Field 1A>" on form "<Form1>" in subject "<Subject>"	
	And I should see the message "User signature succeeded." on the audit for field "<Field 1A>" on form "<Form1>"	in subject "<Subject>"
	And I should not see the message "User signature failed." on the audit for field "<Field 1A>" on form "<Form1>"	in subject "<Subject>"
	And I take a screenshot 11 of 38
	And I should see the message "User entered 'data'" on the audit for field "<Field 2A>" on form "<Form1>" in subject "<Subject>"
	And I should see the message "User signature succeeded." on the audit for field "<Field 2A>" on form "<Form1>" in subject "<Subject>"
	And I should not see the message "User signature failed." on the audit for field "<Field 2A>" on form "<Form1>" in subject "<Subject>"	
	And I take a screenshot 12 of 38
	
#----------------------------------------------------------------------------------------------------------------------
@release_564_patch12
@PB_2.5.2.9
@Validation
Scenario: As a Rave user that failed 3 consecutive signature attempts, my Rave session should be ended and I should be on Rave login page

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
	And I enter user name textbox with User ID "<Rave  User ID>"
	And I enter password textbox with Password "<Rave  User Password>xx"
	And I click button "Sign and Save"
	And I should see message "Signature attempt failed." on the pop up
	And I enter user name textbox with User ID "<Rave  User ID>"
	And I enter password textbox with Password "<Rave  User Password>xx"
	And I click button "Sign and Save"
	And I should see message "Signature attempt failed." on the pop up
	And I enter user name textbox with User ID "<Rave  User ID>"
	And I enter password textbox with Password "<Rave  User Password>xx"
	When I click button "Sign and Save"
	Then I should see page "Rave Login Page"
	And I should see text "Continuous Signature Failures"
	And I take a screenshot 13 of 38
	
#----------------------------------------------------------------------------------------------------------------------
@release_564_patch9
@PB_2.5.2.10
@Validation
Scenario: As a Rave user with batch sign permissions, I will see the  "Sign and Save" button on the Calender view.

	And I login as user "<Rave  User 1>"
	And I select study "<Study A>"
	And I select site "<Site A1>" that is in study "<Study A>"
	When I create a subject
	Then I should see button "Sign and Save"
	And I take a screenshot 14 of 38

#----------------------------------------------------------------------------------------------------------------------
@release_564_patch12
@PB_2.5.2.11
@Validation
Scenario: As a Rave user, when I click on the "Sign and Save" button on the subject homepage, I will see an eSignature pop up window

	And I login as user "<Rave  User 1>"
	And I select study "<Study A>"
	And I select site "<Site A1>" that is in study "<Study A>"
	And I create a subject
	When I click button "Sign and Save"
	Then I should see "Pop Up" window
	And I should see textbox with label "User Name"
	And I should see textbox with label "Password"
	And I should see button with label "Sign and Save"
	And in the window I see "|Reason for Signature|"
	And I see my "|Name|"
	And I see the current "|Timestamp|"
	And I take a screenshot 15 of 38
	
#----------------------------------------------------------------------------------------------------------------------
@release_564_patch12
@PB_2.5.2.12
@Validation
Scenario: As a Rave user with batch sign permissions, when I sign at the Calendar View, all forms requiring signature for that subject are signed 

	And I login as user "<Rave  User 1>"
	And I select study "<Study A>"
	And I select site "<Site A1>" that is in study "<Study A>"
	And I create a subject
	And I select form "<Form1>" which requires signature
	And I enter data in field "<Field 1A>" on "<Form1>" in subject "<Subject>"
	And I enter data in field "<Field 2A>" on "<Form1>" in subject "<Subject>"
	And I click button "Save"
	And I select form "<Form6>" does not require signature
	And I enter data in field "<Field 1H>" on "<Form6>" in subject "<Subject>"
	And I enter data in field "<Field 2H>" on "<Form6>" in subject "<Subject>"
	And I click button "Save"	
	And I select form "<Form9>" which requires signature in folder "<Folder A>"
	And I enter data in field "<Field 9>" on "<Form9>" in folder "<Folder A>"
	And I enter data in field "<Log Field 9A>" on "<Form9>" in folder "<Folder A>"
	And I enter data in field "<Log Field 9B>" on "<Form9>" in folder "<Folder A>"	
	And I click button "Save"	
	And I click the "subject tab"
	And I click button "Sign and Save" button
	And I see "Pop Up" window
	And in the window I see "|Reason for Signature|"
	And I see my "|Name|"
	And I see the current "|Timestamp|"
	And I enter user name textbox with User ID "<Rave User ID>"
	And I enter password textbox with Password "<Rave User Password>"
	When I click button "Sign and Save"
	Then I should see text "Signature attempt was successful" on subject homepage
	And I go to form "<Form1>" 
	And I should see icon "Complete" for form "<Form1>" in subject "<Subject>" 
	And I should see icon "Complete" on "Field 1A" on form "<Form1>" in subject "<Subject>"
	And I should see icon "Complete" on "Field 2A" on form "<Form1>" in subject "<Subject>"
	And I should see the message "DataPage created." on the form level audit for form "<Form1>" in subject "<Subject>"	
	And I should see the message "User signature succeeded." on the form level audit for form "<Form1>" in subject "<Subject>"		
	And I take a screenshot 16 of 38
	And I should see the message "User entered 'data'" on the audit for field "<Field 1A>" on form "<Form1>" in subject "<Subject>"	
	And I should see the message "User signature succeeded." on the audit for field "<Field 1A>" on form "<Form1>"	in subject "<Subject>"
	And I take a screenshot 17 of 38
	And I should see the message "User entered 'data'" on the audit for field "<Field 2A>" on form "<Form1>" in subject "<Subject>"
	And I should see the message "User signature succeeded." on the audit for field "<Field 2A>" on form "<Form1>" in subject "<Subject>"	
	And I take a screenshot 18 of 38
	And I go to form "<Form6>"	
	And I should see icon "Complete" for form "<Form6>" in subject "<Subject>" 
	And I should see icon "Complete" on "Field 1H" on form "<Form6>" in subject "<Subject>"
	And I should see icon "Complete" on "Field 2H" on form "<Form6>" in subject "<Subject>"
	And I should see the message "DataPage created." on the form level audit for form "<Form6>" in subject "<Subject>"	
	And I should not see the message "User signature succeeded." on the form level audit for form "<Form6>" in subject "<Subject>"		
	And I take a screenshot 19 of 38
	And I should see the message "User entered 'data'" on the audit for field "<Field 1H>" on form "<Form6>" in subject "<Subject>"	
	And I should not see the message "User signature succeeded." on the audit for field "<Field 1H>" on form "<Form6>"	in subject "<Subject>"
	And I take a screenshot 20 of 38
	And I should see the message "User entered 'data'" on the audit for field "<Field 2H>" on form "<Form6>" in subject "<Subject>"
	And I should not see the message "User signature succeeded." on the audit for field "<Field 2H>" on form "<Form6>" in subject "<Subject>"	
	And I take a screenshot 21 of 38
	And I go to form "<Form9>" in folder "<Folder A>"
	And I should see icon "Complete" for form "<Form9>" in subject "<Subject>" in folder "<Folder A>"
	And I should see icon "Complete" on "Log Field 9A" on form "<Form9>" in folder "<Folder A>"
	And I should see icon "Complete" on "Log Field 9B" on form "<Form9>" in folder "<Folder A>"
	And I should see the message "DataPage created." on the form level audit for form "<Form9>" in folder "<Folder A>"	
	And I should see the message "User signature succeeded." on the form level audit for form "<Form9>" in folder "<Folder A>"		
	And I take a screenshot 22 of 38
	And I should see the message "User entered 'data'" on the audit for field "<Field 9>" on form "<Form9>" in folder "<Folder A>"	
	And I should see the message "User signature succeeded." on the audit for field "<Field 9>" on form "<Form9>"in folder "<Folder A>"
	And I take a screenshot 23 of 38
	And I should see the message "User entered 'data'" on the audit for field "<Log Field 9A>" on form "<Form9>"in folder "<Folder A>"
	And I should see the message "User signature succeeded." on the audit for field "<Log Field 9A>" on form "<Form9>"in folder "<Folder A>"	
	And I take a screenshot 24 of 38	
	And I should see the message "User entered 'data'" on the audit for field "<Log Field 9B>" on form "<Form9>"in folder "<Folder A>"
	And I should see the message "User signature succeeded." on the audit for field "<Log Field 9B>" on form "<Form9>"in folder "<Folder A>"	
	And I take a screenshot	25 of 38
	
#----------------------------------------------------------------------------------------------------------------------
@release_564_patch12
@PB_2.5.2.13
@Validation
Scenario: As a Rave user, I will see a simple error message displayed when I attempt to sign in the Calendar View using an incorrect password.

	And I login as user "<Rave  User 1>"
	And I select study "<Study A>"
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
	And I enter user name textbox with User ID "<Rave User ID>"
	And I enter password textbox with Password "<Rave User Password>xx"
	When I click button "Sign and Save"
	Then I should see text "Signature attempt failed" on the pop up
	And I take a screenshot	26 of 38
	
#----------------------------------------------------------------------------------------------------------------------
@release_564_patch9
@PB_2.5.2.14
@Validation
Scenario: As a Rave user with batch sign permissions, I will see the "Sign and Save" button in the Grid View.

	And I login as user "<Rave User 1>"
	And I select study "<Study A>"
	And I select site "<Site A1>" that is in study "<Study A>"
	And I create a subject
	And I select link "Grid View"
	When I select link "All"
	Then I should see button "Sign and Save"
	And I take a screenshot 27 of 38
	
#----------------------------------------------------------------------------------------------------------------------
@release_564_patch12
@PB_2.5.2.15 
@Validation
Scenario: As a Rave user with batch sign permissions, when I sign in the Grid View, all forms requiring signature for the subject are signed 

	And I login as user "<Rave  User 1>"
	And I select study "<Study A>"
	And I select site "<Site A1>" that is in study "<Study A>"
	And I create a subject
	And I select form "<Form1>"
	And I enter data in field "<Field 1A>" on "<Form1>" in subject "<Subject>"
	And I enter data in field "<Field 2A>" on "<Form1>" in subject "<Subject>"
	And I click button "Save"
	And I select form "<Form6>"
	And I enter data in field "<Field 1H>" on "<Form6>" in subject "<Subject>"
	And I enter data in field "<Field 2H>" on "<Form6>" in subject "<Subject>"
	And I click button "Save"	
	And I select form "<Form9>" in folder "<Folder A>"
	And I enter data in field "<Field 9>" on "<Form9>" in folder "<Folder A>"
	And I enter data in field "<Log Field 9A>" on "<Form9>" in folder "<Folder A>"
	And I enter data in field "<Log Field 9B>" on "<Form9>" in folder "<Folder A>"	
	And I click button "Save"	
	And I click the "subject tab"
	And I select link "Grid View"
	And I select link "All"
	And I click button "Sign and Save" button
	And I see "Pop Up" window
	And in the window I see "|Reason for Signature|"
	And I see my "|Name|"
	And I see the current "|Timestamp|"
	And I enter username textbox with User ID "<Rave  User ID>"
	And I enter password textbox with Password "<Rave User Password>"
	When I click button "Sign and Save"
	Then I should see text "Signature attempt was successful" on subject homepage
	And I go to form "<Form1>"
	And I should see icon "Complete" for form "<Form1>" in subject "<Subject>" 
	And I should see icon "Complete" on "Field 1A" on form "<Form1>" in subject "<Subject>"
	And I should see icon "Complete" on "Field 2A" on form "<Form1>" in subject "<Subject>"
	And I should see the message "DataPage created." on the form level audit for form "<Form1>" in subject "<Subject>"	
	And I should see the message "User signature succeeded." on the form level audit for form "<Form1>" in subject "<Subject>"		
	And I take a screenshot 28 of 38
	And I should see the message "User entered 'data'" on the audit for field "<Field 1A>" on form "<Form1>" in subject "<Subject>"	
	And I should see the message "User signature succeeded." on the audit for field "<Field 1A>" on form "<Form1>"	in subject "<Subject>"
	And I take a screenshot 29 of 38
	And I should see the message "User entered 'data'" on the audit for field "<Field 2A>" on form "<Form1>" in subject "<Subject>"
	And I should see the message "User signature succeeded." on the audit for field "<Field 2A>" on form "<Form1>" in subject "<Subject>"	
	And I take a screenshot	30 of 38
	And I go to form "<Form6>
	And I should see icon "Complete" for form "<Form6>" in subject "<Subject>" 
	And I should see icon "Complete" on "Field 1H" on form "<Form6>" in subject "<Subject>"
	And I should see icon "Complete" on "Field 2H" on form "<Form6>" in subject "<Subject>"
	And I should see the message "DataPage created." on the form level audit for form "<Form6>" in subject "<Subject>"	
	And I should not see the message "User signature succeeded." on the form level audit for form "<Form6>" in subject "<Subject>"		
	And I take a screenshot 31 of 38
	And I should see the message "User entered 'data'" on the audit for field "<Field 1H>" on form "<Form6>" in subject "<Subject>"	
	And I should not see the message "User signature succeeded." on the audit for field "<Field 1H>" on form "<Form6>"	in subject "<Subject>"
	And I take a screenshot 32 of 38
	And I should see the message "User entered 'data'" on the audit for field "<Field 2H>" on form "<Form6>" in subject "<Subject>"
	And I should not see the message "User signature succeeded." on the audit for field "<Field 2H>" on form "<Form6>" in subject "<Subject>"	
	And I take a screenshot 33 of 38	
	And I go to form "<Form9> in folder "<Folder A>"
	And I should see icon "Complete" for form "<Form9>" in subject "<Subject>" in folder "<Folder A>"
	And I should see icon "Complete" on "Log Field 9A" on form "<Form9>" in folder "<Folder A>"
	And I should see icon "Complete" on "Log Field 9B" on form "<Form9>" in folder "<Folder A>"
	And I should see the message "DataPage created." on the form level audit for form "<Form9>" in folder "<Folder A>"	
	And I should see the message "User signature succeeded." on the form level audit for form "<Form9>" in folder "<Folder A>"		
	And I take a screenshot 34 of 38
	And I should see the message "User entered 'data'" on the audit for field "<Field 9>" on form "<Form9>" in folder "<Folder A>"	
	And I should see the message "User signature succeeded." on the audit for field "<Field 9>" on form "<Form9>"in folder "<Folder A>"
	And I take a screenshot 35 of 38
	And I should see the message "User entered 'data'" on the audit for field "<Log Field 9A>" on form "<Form9>"in folder "<Folder A>"
	And I should see the message "User signature succeeded." on the audit for field "<Log Field 9A>" on form "<Form9>"in folder "<Folder A>"	
	And I take a screenshot	36 of 38
	And I should see the message "User entered 'data'" on the audit for field "<Log Field 9B>" on form "<Form9>"in folder "<Folder A>"
	And I should see the message "User signature succeeded." on the audit for field "<Log Field 9B>" on form "<Form9>"in folder "<Folder A>"	
	And I take a screenshot 37 of 38	

	
#----------------------------------------------------------------------------------------------------------------------
@release_564_patch12
@PB_2.5.2.16
@Validation
Scenario: As a Rave user, I will see a simple error message displayed when I attempt to sign a form that was populated with data from the Grid View using an incorrect password.

	And I login as user "<Rave  User 1>"
	And I select study "<Study A>"
	And I select site "<Site A1>" that is in study "<Study A>"
	And I create a subject
	And I select link "Grid View"
	And I select form "<Form1>" which requires signature
	And I enter data in field "<Field 1A>" on "<Form1>" in subject "<Subject>"
	And I enter data in field "<Field 2A>" on "<Form1>" in subject "<Subject>"
	And I click button "Save"
	And I click button "Sign and Save" button
	And I see "Pop Up" window
	And in the window I see "|Reason for Signature|"
	And I see my "|Name|"
	And I see the current "|Timestamp|"
	And I enter user name textbox with User ID "<Rave User ID>"
	And I enter password textbox with Password "<Rave User Password>xx"
	When I click button "Sign and Save"
	Then I should see text "Signature attempt failed" on the pop up
	And I take a screenshot 38 of 38

#----------------------------------------------------------------------------------------------------------------------	