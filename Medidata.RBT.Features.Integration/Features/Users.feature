Feature: Users
	In order to update users in Rave,
	I want to be able to process user messages from SQS.

@wip
Scenario: When a User message gets put onto the queue, and the user already exists in Rave, the user is updated.
	Given the User with login "testUser" exists in the Rave database
	And I send the following User message to SQS

	| Email            | Login    | FirstName | MiddleName | LastName | Address1      | City     | State | PostalCode | Country | Telephone  | Locale | TimeZone  |
	| testUser@test.cx | testUser | Test      | J          | User     | 79 5th Avenue | New York | NY    | 10003      | USA     | 1234567890 | eng    | New Delhi |

	When the message is successfully processed
	Then I should see the user in the Rave database
	And the user should have Email "testUser@test.cx"
	And the user should have Login "testUser"
	And the user should have FirstName "Test"
	And the user should have MiddleName "J"
	And the user should have LastName "User"
	And the user should have Address1 "79 5th Avenue"
	And the user should have City "New York"
	And the user should have State "NY"
	And the user should have PostalCode "10003"
	And the user should have Country "USA"
	And the user should have Telephone "1234567890"
	And the user should have Locale "eng"
	And the user should have TimeZone "New Delhi"
