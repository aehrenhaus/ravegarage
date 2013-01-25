Feature: UserStudySites
	In order to update users' study sites in Rave,
	I want to be able to process userstudysite messages from SQS.

@wip
Scenario: When a UserStudySite message gets put onto the queue, and the user already exists in Rave, the user is updated.
	Given the User with login "testUser" exists in the Rave database
	And the StudySite with ID "23" exists in the Rave database
	And I send the following UserStudySite message to SQS	
	| EventType | Timestamp           |
	| POST      | 2012-10-12 12:00:00 |

	#@And I have entered 70 into the calculator
	#@When I press add
	#Then the result should be 120 on the screen
