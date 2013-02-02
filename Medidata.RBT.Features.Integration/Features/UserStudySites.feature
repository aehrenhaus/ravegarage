Feature: UserStudySites
	In order to update users' study sites in Rave,
	I want to be able to process userstudysite messages from SQS.

@my_test
Scenario: When a UserStudySite message gets put onto the queue, and the user already exists in Rave, the user is updated.
	Given the User with login "testUser" exists in the Rave database
	And the Study with Name "test" and Environment "prod" exists in the Rave database
	And the Site with site number "7" exists in the Rave database
	And the StudySite with ExternalId "21" exists in the Rave database
	And I send the following UserStudySite message to SQS	
	| EventType | Timestamp           |
	| POST      | 2012-10-12 12:00:00 |
	When the message is successfully processed
	Then I should see the UserStudySite assignment in the Rave database
