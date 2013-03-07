Feature: Users
	In order to update users in Rave,
	I want to be able to process user messages from SQS.

@wip
Scenario: When a User message gets put onto the queue, and the user already exists in Rave, the user is updated.
	Given the User with login "testUser" exists in the Rave database
	And I send the following User message to SQS

	| Email            | Login    | FirstName | MiddleName | LastName | Address1      | City     | State | PostalCode | Country | Telephone  | Locale | TimeZone  | Title | Address2     | Address3 | Institution        | Telephone    | Fax          | Timestamp           |
	| testUser@test.cx | testUser | Test      | J          | User     | 79 5th Avenue | New York | NY    | 10003      | USA     | 1234567890 | eng    | New Delhi | Lord  | New York, NY | 10003    | Beekman University | 1234567890 | 444-555-6666 | 2012-10-12 12:00:00 |

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
	And the user should have Title "Lord"
	And the user should have Institution "Beekman University"	
	And the user should have Address2 "New York, NY"
	And the user should have Address3 "10003"
	And the user should have Fax "444-555-6666"
	And the user should have LastExternalUpdateDate "2012-10-12 12:00:00"

@PB2.5.8.28-04B
Scenario: Operations on studies, sites, studysites, users, study assignments, studysite assignments must be audited in the 'name' 
          of the system user.
	Given the User with login "testUser1" exists in the Rave database
	And I send the following User message to SQS
	| Email            | Login     | FirstName | LastName | Address1      | City     | State | PostalCode | Country | Telephone  | Locale | TimeZone  | Telephone  | Timestamp           |
	| testUser@test.cx | testUser1 | Test      | User     | 79 5th Avenue | New York | NY    | 10003      | USA     | 1234567890 | eng    | New Delhi | 1234567890 | 2012-10-12 12:00:00 |
	When the message is successfully processed
	Then I should see the user in the Rave database
	And I should see the user has audits in the Rave database
	And I should see the audits were performed by user "System"
	And I should see the audit action type "Created"
	And I should see the audit action "User created."