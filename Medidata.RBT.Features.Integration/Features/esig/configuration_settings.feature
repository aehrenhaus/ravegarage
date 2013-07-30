#2.7.2 Internally authenticated users with permission to access the Configuration module will have read and write permissions for the configuration settings listed in Settings page in the Configuration module.
#Some of these configuration settings will not apply to externally authenticated users. Rave rules concerning authentication will not apply to iMedidata or IDP users. iMedidata will set its own authentication rules, verify user credentials prior to allowing the user to enter Rave and will provide authorization criteria to Rave so that the user permissions are understood by Rave. IDPs will act in a manner similar to iMedidata in that they will control authentication and provide authorization criteria to Rave as well.
#Additionally, both iMedidata and IDP will provide eSignature authorization for users that utilize these methods to authenticate to Rave. Since the eSignature request is being handled outside of Rave, the authentication settings will be handled by the authenticator. Rave eSignature configuration options will not apply to external users.
#The following settings will not apply to externally authenticated users: 
•	Min Password Length
•	Alpha Required In Password
•	Numeric Required In Password
•	Special Required In Password
•	Password Valid Days
•	Password Reuse Days
•	NumbFailed User Activation Attempts 
•	Send Max Activation Alert
•	Confirm Activations
•	Activation Alert Time (Hours)
•	Continuous Esig Session Timeout (Minutes)
•	Two Part Esig Identification Option

@release_564_patch9
@PB_2.7.2.1
@Validation
Scenario: Rave will display a message “*These settings will not apply to iMedidata users or users that access Rave directly from a portal.” on the Settings page

	Background:
	Given I am an iMedidata user
	And my username is <iMedidata User 1>
	And my password is <Password1>
	And I am assigned to a Study Group <Study Group 1>
	And I am assigned to a study <Study A> that is in <Study Group 1>
	And I am assigned to a site <Site A1> that is in <Study A> in <Study Group 1>
	And I have been assigned to the Modules app
	And I have been invited to the All Modules role for site <Site A1> that is in <Study A> in <Study Group 1>
	And I select the Modules app for <Study A>
	And I navigate to "Configuration" module
	When I am on the Other Settings page,
	Then I will see a message, “*These settings will not apply to iMedidata users or users that access Rave directly from a portal.”
	And I will see *Min Password Length
	And I will see *Alpha Required In Password
	And I will see *Numeric Required In Password
	And I will see *Special Required In Password
	And I will see *Password Valid Days
	And I will see *Password Reuse Days
	And I will see *NumFailed User Activation Attempts 
	And I will see *Send Max Activation Alert
	And I will see *Confirm Activations
	And I will see *Activation Alert Time (Hours)
	And I will see *Continuous Esig Session Timeout (Minutes)
	And I will see *Two Part Esig Identification Option
	And I take screenshot
	
	