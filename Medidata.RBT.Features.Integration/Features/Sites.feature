Feature: Sites
	In order to create or update sites in Rave,
	I want to be able to process site messages from SQS.

@site_post_message_scenario_1
Scenario: When a Site POST message gets put onto the queue, and the site does not exist in Rave, the site is created.
	Given I send the following Site message to SQS
	| EventType | Name      | Number |
	| POST      | TestSite1 | 1      |
	When the message is successfully processed
	Then I should see the site in the Rave database
	And the site should have the name "TestSite1"
	And the site should have the SiteNumber "1"
	

@site_put_message_scenario_2
Scenario: When a Site PUT message gets put onto the queue, and the site already exists in Rave, the site is updated.
	Given I send the following Site message to SQS
	| EventType | Address1    | City       | State | PostalCode | Country | Phone      | Name      | Number |
	| POST      | 79 5th Ave  | New York   | NY    | 10003      | USA     | 1234567890 | TestSite2 | 2      |
	| PUT       | 111 5th Ave | New Jersey | NJ    | 10004      | USB     | 1234567    | TestSite3 | 3      |
	When the message is successfully processed
	Then I should see the site in the Rave database
	And the site should have the name "TestSite3"
	And the site should have the SiteNumber "3"
	And the site should have Address1 "111 5th Ave"
	And the site should have City "New Jersey"
	And the site should have State "NJ"
	And the site should have PostalCode "10004"
	And the site should have Country "USB"
	And the site should have Telephone "1234567"
