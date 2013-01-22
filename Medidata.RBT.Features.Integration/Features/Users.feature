Feature: Users
	In order to create users in Rave,
	I want to be able to process user messages from SQS.

@wip
Scenario: When a User message gets put onto the queue, and the user does not already exist in Rave, the user is created.
	Given I send the following User message to SQS
	| Field       | Value            |
	| Email       | testUser@test.cx |
	| Login       | testUser         |
	| ID          | 2326             |
	| FirstName   | Test             |
	| MiddleName  | J                |
	| LastName    | User             |
	| Address1    | 79 5th Avenue    |
	| City        | New York         |
	| State       | NY               |
	| PostalCode  | 10003            |
	| Country     | USA              |
	| Telephone   | 1234567890       |
	| Locale      | eng              |
	| TimeZone    | GMT-05:00        |
	When the message is successfully processed
	Then I should see the user in the Rave database
