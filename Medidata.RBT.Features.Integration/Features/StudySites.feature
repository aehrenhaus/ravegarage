Feature: StudySites
	In order to create external study sites in Rave,
	I want to be able to process study messages from SQS.

@mytag
Scenario: When a StudySite POST message gets put onto the queue, the studysite is created in Rave.
	Given the study with name "TestStudy" and environment "Prod" with ExternalId "6" exists in the Rave database
	And I send the following StudySite message to SQS
	| EventType | StudySiteId | StudySiteName     | StudySiteNumber | StudyId | SiteId | SiteName     | SiteNumber  | Timestamp           |
	| POST      | 33          | TestStudySiteName | 5243534         | 6       | 10     | TestSiteName | 49878567483 | 2012-10-12 12:00:00 |
	When the message is successfully processed
	Then I should see the site in the Rave database
	And I should see the studysite in the Rave database
	And the site should have the ExternalId "10"
	And the site should have the name "TestSiteName"
	And the site should have the SiteNumber "49878567483"
	And the site should have a LastExternalUpdateDate "2012-10-12 12:00:00"
	And the studysite should have ExternalID "33"
	And the studysite should have the StudySiteName "TestSiteName"
	And the studysite should have the StudySiteNumber "5243534"
	And the studysite should have the ExternalStudyId "6"
	And the studysite should have a LastExternalUpdateDate "2012-10-12 12:00:00"

@mytag
Scenario: When a StudySite PUT message gets put onto the queue, the studysite is updated in Rave.
	Given the study with name "TestStudy" and environment "Prod" with ExternalId "6" exists in the Rave database
	And I send the following StudySite message to SQS
	| EventType | StudySiteId | StudySiteName			 | StudySiteNumber | StudyId | SiteId | SiteName			| SiteNumber         | Timestamp           |
	| POST      | 33          | TestStudySiteName		 | 5243534         | 6       | 10     | TestSiteName		| 49878567483        | 2012-10-12 12:00:00 |
	| PUT       | 33          | TestStudySiteNameUpdated | 5243534updated  | 6       | 10     | TestSiteNameUpdated | 49878567483updated | 2012-10-12 13:00:00 |
	When the message is successfully processed
	Then I should see the site in the Rave database
	And I should see the studysite in the Rave database
	And the site should have the ExternalId "10"
	And the site should have the name "TestSiteNameUpdated"
	And the site should have the SiteNumber "49878567483updated"
	And the site should have a LastExternalUpdateDate "2012-10-12 13:00:00"
	And the studysite should have ExternalID "33"
	And the studysite should have the StudySiteName "TestSiteNameUpdated"
	And the studysite should have the StudySiteNumber "5243534updated"
	And the studysite should have the ExternalStudyId "6"
	And the studysite should have a LastExternalUpdateDate "2012-10-12 13:00:00"

@wip
Scenario: When a StudySite DELETE message gets put onto the queue, the studysite is inactivated in Rave.
	Given the study with name "TestStudy" and environment "Prod" with ExternalId "6" exists in the Rave database
	And I send the following StudySite message to SQS
	| EventType | StudySiteId | StudySiteName			 | StudySiteNumber | StudyId | SiteId | SiteName			| SiteNumber         | Timestamp           |
	| POST      | 33          | TestStudySiteName		 | 5243534         | 6       | 10     | TestSiteName		| 49878567483        | 2012-10-12 12:00:00 |
	| DELETE    |             |                          |                 |         |        |                     |                    | 2012-10-12 13:00:00 |
	When the message is successfully processed
	Then I should see the studysite in the Rave database
	And the studysite should be inactive