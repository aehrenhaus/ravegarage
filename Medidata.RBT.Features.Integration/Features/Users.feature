Feature: Users
	In order to update users in Rave,
	I want to be able to process user messages from SQS.

@wip
Scenario: When a User message gets put onto the queue, and the user already exists in Rave, the user is updated.
	Given the User with login "testUser" exists in the Rave database
	When I send the following User message to SQS
	| Email            | Login    | FirstName | MiddleName | LastName | Address1      | City     | State | PostalCode | Country | Telephone  | Locale | TimeZone  | Title | Address2     | Address3 | Institution        | Telephone  | Fax          | Timestamp           |
	| testUser@test.cx | testUser | Test      | J          | User     | 79 5th Avenue | New York | NY    | 10003      | USA     | 1234567890 | eng    | New Delhi | Lord  | New York, NY | 10003    | Beekman University | 1234567890 | 444-555-6666 | 2012-10-12 12:00:00 |
	Then I should see the user in the Rave database
	And the user should exist with the following properties
	| Email            | Login    | FirstName | MiddleName | LastName | Address1      | City     | State | PostalCode | Country | Telephone  | Locale | TimeZone  | Title | Institution        | Address2     | Address3 | Fax          | LastExternalUpdateDate |
	| testUser@test.cx | testUser | Test      | J          | User     | 79 5th Avenue | New York | NY    | 10003      | USA     | 1234567890 | eng    | New Delhi | Lord  | Beekman University | New York, NY | 10003    | 444-555-6666 | 2012-10-12 12:00:00    |


@PB2.5.8.28-04B
Scenario Outline: Operations on studies, sites, studysites, users, study assignments, studysite assignments must be audited in the 'name' 
          of the system user.
	Given the User with login "testUser1" exists in the Rave database
	When I send the following User message to SQS
	| Email   | Login   | FirstName    | LastName    | Address1   | City   | State   | PostalCode    | Country   | Telephone   | Locale   | TimeZone    | Timestamp   |
	| <email> | <login> | <first_name> | <last_name> | <address1> | <city> | <state> | <postal_code> | <country> | <Telephone> | <locale> | <time_zone> | <timestamp> |
	Then I should see the user in the Rave database
	And I should see the user has audits in the Rave database
	And I should see the audits were performed by user "System"
	And I should see the following audits
	| Property               | Value         | ActionType            |
	| AddressLine1           | <address1>    | UpdateGenericProperty |
	| City                   | <city>        | UpdateGenericProperty |
	| State                  | <state>       | UpdateGenericProperty |
	| PostalCode             | <postal_code> | UpdateGenericProperty |
	| Country                | <country>     | UpdateGenericProperty |
	| FirstName              | <first_name>  | UpdateGenericProperty |
	| LastName               | <last_name>   | UpdateGenericProperty |
	| Email                  | <email>       | UpdateGenericProperty |
	| Telephone              | <Telephone>   | UpdateGenericProperty |
	| Localization           | <locale>      | UpdateGenericProperty |
	| ExternalUserName       | <login>       | UpdateGenericProperty |
	| LastExternalUpdateDate | <timestamp>   | UpdateGenericProperty |

	Examples: 
		| email            | login     | first_name | last_name | address1      | city     | state | postal_code | country | Telephone  | locale | time_zone | timestamp           |
		| testUser@test.cx | testUser1 | Test       | User      | 79 5th Avenue | New York | NY    | 10003       | USA     | 1234567890 | eng    | New Delhi | 2012-10-12 12:00:00 |