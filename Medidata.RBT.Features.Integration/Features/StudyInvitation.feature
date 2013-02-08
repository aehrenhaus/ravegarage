Feature: StudyInvitations
	In order to assign external users to external studies in Rave,
	I want to be able to process study_invitation messages from SQS.

@post_scenario_1
Scenario: When a StudyInvitation POST message gets put onto the queue, the study assignments are created in Rave.
	Given the study with name "Test POST Study" and environment "Prod" with ExternalId "100" exists in the Rave database
	And I have an EDC app assignment with the following role(s) 
	| RoleName   |
	| EDC Role 1 |
	And I have an Architect Security app assignment with the following role(s)
	| RoleName         |
	| Security Group 1 |
	And I have a Modules app assignment with the following role(s)
	| RoleName    |
	| All Modules |
	And I send the following StudyInvitation message to SQS
	| EventType | InvitationType  | Email            | Login					   | UserId | FirstName | MiddleName | LastName | Address1	     | City     | State | PostalCode | Country | Telephone  | Locale | TimeZone  | Timestamp          |
	| POST      | StudyInvitation | testUser@test.cx | testPOSTstudyInvitationUser | 101    |Test       | J          | User     | 79 5th Avenue | New York | NY    | 10003      | USA     | 1234567890 | eng    | New Delhi | 2013-01-01 12:00PM |
	When the message is successfully processed
	Then I should see the user in the Rave database
	And the user should be assigned to the study with the following EDC role(s)
	| RoleName   |
	| EDC Role 1 |
	And the user should be assigned to the following SecurityGroup(s) on the study
	| RoleName         |
	| Security Group 1 |
	And the user should be assigned to the following UserGroup(s) on the study
	| RoleName    |
	| All Modules |
	
@put_scenario_1
Scenario: When a StudyInvitation PUT message gets put onto the queue, the study assignments are updated in Rave.
	Given the study with name "Test PUT Study" and environment "Prod" with ExternalId "200" exists in the Rave database
	And the User with login "testPUTstudyInvitationUser" exists in the Rave database
	And the user is assigned to the study with the following EDC role(s)
	| RoleName   |
	| EDC Role 1 |
	And the user is assigned to the following Security Group(s) on the study
	| RoleName         |
	| Security Group 1 |
	And the User is assigned to the "All Modules" User Group on the study
	And I have an EDC app assignment with the following role(s) 
	| RoleName   |
	| EDC Role 2 |
	And I have an Architect Security app assignment with the following role(s)
	| RoleName         |
	| Security Group 2 |
	And I have a Modules app assignment with the following role(s)
	| RoleName    |
	| User Admin |
	And I send the following StudyInvitation message to SQS
	| EventType | InvitationType  | Email            | Login					  | FirstName | MiddleName | LastName | Address1	  | City     | State | PostalCode | Country | Telephone  | Locale | TimeZone  | Timestamp          |
	| PUT       | StudyInvitation | testUser@test.cx | testPUTstudyinvitationuser | Test       | J          | User     | 79 5th Avenue | New York | NY    | 10003      | USA     | 1234567890 | eng    | New Delhi | 2013-01-01 13:00PM |
	When the message is successfully processed
	Then the user should be assigned to the study with the following EDC role(s)
	| RoleName   |
	| EDC Role 2 |
	And the user should be assigned to the following SecurityGroup(s) on the study
	| RoleName         |
	| Security Group 2 |
	And the user should be assigned to the following UserGroup(s) on the study
	| RoleName    |
	| User Admin  |
	And the user should not be assigned to the study with the following EDC role(s)
	| RoleName   |
	| EDC Role 1 |
	And the user should not be assigned to the following SecurityGroup(s)
	| RoleName         |
	| Security Group 1 |
	And the user should not be assigned to the following UserGroup(s) on the study
	| RoleName    |
	| All Modules |
	And the Rave user with EDC role "EDC Role 1" should be inactive

@delete_scenario_1
Scenario: When a StudyInvitation DELETE message gets put onto the queue, the study assignments are removed from Rave.
	Given the study with name "Test DELETE Study" and environment "Prod" with ExternalId "300" exists in the Rave database
	And the User with login "testDELETEstudyInvitationUser" exists in the Rave database
	And the user is assigned to the study with the following EDC role(s)
	| RoleName   |
	| EDC Role 1 |
	| EDC Role 2 |
	And the user is assigned to the following Security Group(s) on the study
	| RoleName		   |
	| Security Group 1 |
	And the User is assigned to the "All Modules" User Group on the study
	And I send the following StudyInvitation message to SQS
	| EventType | InvitationType  | Timestamp          |
	| DELETE    | StudyInvitation | 2013-01-01 13:00PM |
	When the message is successfully processed
	Then the user should not be assigned to the study with the following EDC role(s)
	| RoleName   |
	| EDC Role 1 |
	| EDC Role 2 |
	And the user should not be assigned to the following SecurityGroup(s)
    | RoleName         |
    | Security Group 1 |
	And the user should have the iMedidataEDC user group assigned
	