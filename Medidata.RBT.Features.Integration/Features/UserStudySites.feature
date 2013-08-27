Feature: UserStudySites
	In order to update users' study sites in Rave,
	I want to be able to process userstudysite messages from SQS.

@post_test_scenario_1
Scenario: When a UserStudySite message gets put onto the queue, and the user already exists in Rave, the user is updated.
	Given the User with login "testStudySiteUser1" exists in the Rave database
	And the study with name "testStudy1" and environment "prod" with ExternalId "1" exists in the Rave database
	And an EDC Role with Name "roleName1" exists in the Rave database
	And the current User is assigned to the current Study with current Role
	And the Site with site number "1" exists in the Rave database
	And the StudySite with ExternalId "1" exists in the Rave database
	And I send the following UserStudySite message to SQS	
	| EventType | Timestamp           |
	| POST      | 2012-10-12 12:00:00 |
	When the message is successfully processed
	Then I should see the UserStudySite assignment in the Rave database

@delete_test_scenario_2
Scenario: When a UserStudySite delete message gets put onto the queue, and the assignment exists, the assignment is deleted.
	Given the User with login "testStudySiteUser2" exists in the Rave database
	And the study with name "testStudy2" and environment "prod" with ExternalId "2" exists in the Rave database
	And an EDC Role with Name "roleName2" exists in the Rave database
	And the current User is assigned to the current Study with current Role
	And the Site with site number "2" exists in the Rave database
	And the StudySite with ExternalId "2" exists in the Rave database
	And I send the following UserStudySite messages to SQS	
	| EventType | Timestamp           |
	| POST      | 2012-10-12 12:00:00 |
	| DELETE    | 2012-10-12 13:00:00 |
	When the message is successfully processed
	Then The user should not have a UserStudySite assignment in the Rave database