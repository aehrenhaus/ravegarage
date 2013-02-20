Feature: Sites
	In order to create or update sites in Rave,
	I want to be able to process site messages from SQS.

@site_post_message_scenario_1
Scenario: When a Site POST message gets put onto the queue, and the site does not exist in Rave, the site is created.
	Given I send the following Site message to SQS
	| EventType | Name      | Number |
	| POST      | TestSite1 | 1a     |
	When the message is successfully processed
	Then I should see the site in the Rave database
	And the site should have the name "TestSite1"
	And the site should have the SiteNumber "1a"
	

@site_put_message_scenario_2
Scenario: When a Site PUT message gets put onto the queue, and the site already exists in Rave, the site is updated.
	Given I send the following Site message to SQS
	| EventType | Address1    | City       | State | PostalCode | Country | Phone      | Name      | Number | Timestamp           |
	| POST      | 79 5th Ave  | New York   | NY    | 10003      | USA     | 1234567890 | TestSite2 | 2      | 2013-02-02 12:00:00 |
	| PUT       | 111 5th Ave | New Jersey | NJ    | 10004      | USB     | 1234567    | TestSite3 | 3      | 2013-02-02 13:00:00 |
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

@PB2.5.9.27-01
Scenario: If I create a site in iMedidata, and an unlinked site in Rave (that is not linked to the iMedidata site),
           when Rave receives the site it will link it to the iMedidata site, matching it based on UUID first.
	Given the Site with site number "4" exists in the Rave database
	And I send the following Site message to SQS
	| EventType | Address1    | City       | State | PostalCode | Country | Phone   | Name      | Number | Id |
	| PUT       | 111 5th Ave | New Jersey | NJ    | 10004      | USB     | 1234567 | TestSite4 | 4      | 4  |
	When the message is successfully processed
	Then I should see the site in the Rave database
    And the site should have the ExternalId "4"
	And and the site should have ExternalSystemName "iMedidata"

@PB2.5.9.27-02
Scenario: If I create a site in iMedidata, and an unlinked site in Rave (that is not linked to the iMedidata site), when Rave receives
          the site it will link it to the iMedidata site, matching it based on UUID first, and failing that site number.
	Given I send the following Site message to SQS
	| EventType | Name      | Number | Id | Uuid                                 | Timestamp           |
	| POST      | TestSite5 | 5      | 0  | 2fc5e4a8-f117-11e1-b0ce-12313940032z | 2013-02-02 12:00:00 |
	| PUT       | TestSite6 | 5      | 6  | 2fc5e4a8-f117-11e1-b0ce-12313940032d | 2013-02-02 13:00:00 |
	When the message is successfully processed
	Then I should see the site in the Rave database
	And the site should have the UUID "2fc5e4a8-f117-11e1-b0ce-12313940032d"
    And the site should have the ExternalId "6"
	And and the site should have ExternalSystemName "iMedidata"
	And the site should have a LastExternalUpdateDate "2013-02-02 13:00:00"

@PB2.5.9.43-01
Scenario: If I have a linked site in iMedidata, and I change the site number in iMedidata, when Rave receives the updated site,
          Rave will update the site number to match with the iMedidata site number.
	Given the Site with site number "6" exists in the Rave database
	And I send the following Site message to SQS
	| EventType | Name      | Number | Timestamp           |
	| POST      | TestSite6 | 6      | 2013-02-02 12:00:00 |
	| PUT       | TestSite6 | 7      | 2013-02-02 13:00:00 |
	When the message is successfully processed
	Then I should see the site in the Rave database
	And the site should have the SiteNumber "7"
	And and the site should have ExternalSystemName "iMedidata"
	And the site should have a LastExternalUpdateDate "2013-02-02 13:00:00"

@PB2.5.9.46-01
Scenario: If I have a linked site in iMedidata, and I change the site name in iMedidata, when Rave receives the updated site,
             Rave will update the site name to match with the iMedidata site name.
	
	Given the Site with site number "8" exists in the Rave database
	Given I send the following Site message to SQS
	| EventType | Name      | Number | Timestamp           |
	| POST      | TestSite8 | 8      | 2013-02-02 12:00:00 |
	| PUT       | TestSite9 | 9      | 2013-02-02 13:00:00 |
	When the message is successfully processed
	Then I should see the site in the Rave database
	And the site should have the name "TestSite9"
	And and the site should have ExternalSystemName "iMedidata"
	And the site should have a LastExternalUpdateDate "2013-02-02 13:00:00"

@PB2.5.9.42-02
Scenario: If I update a site in iMedidata, when Rave receives the site it will create a new site and link it to the iMedidata site
           if no matching site exists in Rave
	Given I send the following Site message to SQS
	| EventType | Address1    | City       | PostalCode | Country | Name       | Number | Timestamp           |
	| POST      | 79 5th Ave  | New York   | 10003      | USA     | TestSite10 | 10     | 2013-02-02 12:00:00 |
	| PUT       | 111 5th Ave | New Jersey | 10004      | USB     | TestSite10 | 10     | 2013-02-02 13:00:00 |
	When the message is successfully processed
	Then I should see the site in the Rave database
	And the site should have Address1 "111 5th Ave"
	And the site should have City "New Jersey"
	And the site should have PostalCode "10004"
	And the site should have Country "USB"
	And and the site should have ExternalSystemName "iMedidata"

@PB2.5.8.28-04B
Scenario: Operations on studies, sites, studysites, users, study assignments, studysite assignments must be audited in the 'name' 
          of the user that did the original action in iMedidata.

	Given I send the following Site message to SQS
	| EventType | Name       | Number | Timestamp           |
	| POST      | TestSite11 | 11     | 2013-02-02 12:00:00 |
	When the message is successfully processed
	Then I should see the site in the Rave database
	And I should see the site has audits in the Rave database
	And I should see the audits were performed by user "System"
	And I should see the audit action type "Activated"
	And I should see the audit action "Site Activated."