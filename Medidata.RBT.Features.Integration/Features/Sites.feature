Feature: Sites
	In order to create or update sites in Rave,
	I want to be able to process site messages from SQS.

@site_post_message_scenario_1
Scenario: When a Site POST message gets put onto the queue, and the site does not exist in Rave, the site is created.
	#should we have a given to make sure the site doesn't exist?
	When I send the following Site message to SQS
	| EventType | Name      | Number |
	| POST      | TestSite1 | 1a     |
	And the message is successfully processed
	Then I should see the site in the Rave database
	And the site should exist with the following properties
	| Name      | Number |
	| TestSite1 | 1a     |
	

@site_put_message_scenario_2
Scenario: When a Site PUT message gets put onto the queue, and the site already exists in Rave, the site is updated.
	Given the following site exists in the rave database:
	| Name      | Number | Address1   | City     | State | PostalCode | Country | Telephone  |
	| TestSite2 | 2      | 79 5th Ave | New York | NY    | 10003      | USA     | 1234567890 |
	When I send the following Site message to SQS
	| EventType | Address1    | City       | State | PostalCode | Country | Telephone      | Name      | Number | Timestamp           |
	| PUT       | 111 5th Ave | New Jersey | NJ    | 10004      | USB     | 1234567    | TestSite3 | 3      | 2013-02-02 13:00:00 |
	And the message is successfully processed
	Then I should see the site in the Rave database
	And the site should exist with the following properties
	| Name      | Number | Address1    | City       | State | PostalCode | Country | Telephone |
	| TestSite3 | 3      | 111 5th Ave | New Jersey | NJ    | 10004      | USB     | 1234567   |


@PB2.5.9.27-01
Scenario Outline: If I create a site in iMedidata, and an unlinked site in Rave (that is not linked to the iMedidata site),
           when Rave receives the site it will link it to the iMedidata site, matching it based on UUID first.
	Given the following site exists in the rave database:
	| Name    | Number           | Uuid   |
	| Site 4a | <RaveSiteNumber> | <Uuid> |
	When I send the following Site message to SQS
	| EventType | Address1    | City       | State | PostalCode | Country | Telephone | Name      | Number				  | Id | Uuid | Timestamp |
	| POST      | 111 5th Ave | New Jersey | NJ    | 10004      | USB     | 1234567   | TestSite4 | <iMedidataSiteNumber> | 4  | <Uuid> | 2013-02-02 12:00:00 |
	And the message is successfully processed
	Then I should see the site in the Rave database
	And the site should exist with the following properties
	| Uuid	 | ExternalID | Source    | LastExternalUpdateDate |
	| <Uuid> | 4          | iMedidata | "2013-02-02 12:00:00"  |
Examples: 
	| Uuid                                 | RaveSiteNumber | iMedidataSiteNumber |
	| f879a85f-2030-4c93-879f-2cc72bbebbc3 | 4a             | 4					  |

@PB2.5.9.27-02
Scenario: If I create a site in iMedidata, and an unlinked site in Rave (that is not linked to the iMedidata site), when Rave receives
          the site it will link it to the iMedidata site, matching it based on UUID first, and failing that site number.
	Given the following site exists in the rave database:
	| Number | Name          |
	| 5      | TestSite5Rave |
	When I send the following Site message to SQS
	| EventType | Name      | Number | Id | Uuid                                 | Timestamp           |
	| POST      | TestSite5 | 5      | 6  | 2fc5e4a8-f117-11e1-b0ce-12313940032d | 2013-02-02 12:00:00 |
	And the message is successfully processed
	Then I should see the site in the Rave database
	And the site should exist with the following properties
	| Uuid                                 | ExternalID | Source   | LastExternalUpdateDate |
	| 2fc5e4a8-f117-11e1-b0ce-12313940032d | 6          | iMedidata | 2013-02-02 12:00:00    |

	
@PB2.5.9.43-01
Scenario: If I have a linked site in iMedidata, and I change the site number in iMedidata, when Rave receives the updated site,
          Rave will update the site number to match with the iMedidata site number.
	Given the following site exists in the rave database:
	| Number | Name      |
	| 6      | TestSite6 |
	When I send the following Site messages to SQS
	| EventType | Name      | Number | Timestamp           |
	| PUT       | TestSite6 | 7      | 2013-02-02 13:00:00 |
	And the message is successfully processed
	Then I should see the site in the Rave database
	And the site should exist with the following properties
	| Number | Source    | LastExternalUpdateDate |
	| 7      | iMedidata | 2013-02-02 13:00:00  |


@PB2.5.9.46-01
Scenario: If I have a linked site in iMedidata, and I change the site name in iMedidata, when Rave receives the updated site,
             Rave will update the site name to match with the iMedidata site name.	
	Given the following site exists in the rave database:
	| Number | Name      |
	| 8      | TestSite8 |
	When I send the following Site message to SQS
	| EventType | Name      | Number | Timestamp           |
	| PUT       | TestSite9 | 8      | 2013-02-02 13:00:00 |
	And the message is successfully processed
	Then I should see the site in the Rave database
	And the site should exist with the following properties
	| Name      | Source    | LastExternalUpdateDate |
	| TestSite9 | iMedidata | 2013-02-02 13:00:00    |


@PB2.5.9.42-02
Scenario: If I update a site in iMedidata, when Rave receives the site it will create a new site and link it to the iMedidata site
           if no matching site exists in Rave
	Given the following site exists in the rave database:
	| Address1    | City       | PostalCode | Country | Name       | Number | Timestamp           |
	| 79 5th Ave  | New York   | 10003      | USA     | TestSite10 | 10     | 2013-02-02 12:00:00 |
	When I send the following Site messages to SQS
	| EventType | Address1    | City       | PostalCode | Country | Name       | Number | Timestamp           |
	| PUT       | 111 5th Ave | New Jersey | 10004      | USB     | TestSite10 | 10     | 2013-02-02 13:00:00 |
	And the message is successfully processed
	Then I should see the site in the Rave database
	And the site should exist with the following properties
	| Address1    | City       | PostalCode | Country | Source    |
	| 111 5th Ave | New Jersey | 10004      | USB     | iMedidata |


@PB2.5.8.28-04B
Scenario: Operations on studies, sites, studysites, users, study assignments, studysite assignments must be audited by System User
	Given I send the following Site message to SQS
	| EventType | Name       | Number | Timestamp           |
	| POST      | TestSite11 | 11     | 2013-02-02 12:00:00 |
	When the message is successfully processed
	Then I should see the site in the Rave database
	And I should see the site has audits in the Rave database
	And I should see the audits were performed by user "System"
	And I should see the audit action type "Activated"
	And I should see the audit action "Site Activated."