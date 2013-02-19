Feature: StudySites
	In order to create external study sites in Rave,
	I want to be able to process study messages from SQS.

@post_scenario_1
Scenario: When a StudySite POST message gets put onto the queue, the studysite is created in Rave.
	Given the study with name "TestStudy" and environment "Prod" with ExternalId "6" exists in the Rave database
	And I send the following StudySite message to SQS
	| EventType | StudySiteId | StudySiteName     | StudySiteNumber | StudyId | SiteId | SiteName     | SiteNumber | Timestamp           |
	| POST      | 33          | TestStudySiteName | 5243534         | 6       | 10     | TestSiteName | post001    | 2012-10-12 12:00:00 |
	When the message is successfully processed
	Then I should see the site in the Rave database
	And I should see the studysite in the Rave database
	And the site should have the ExternalId "10"
	And the site should have the name "TestSiteName"
	And the site should have the SiteNumber "post001"
	And the site should have a LastExternalUpdateDate "2012-10-12 12:00:00"
	And the studysite should have ExternalID "33"
	And the studysite should have the StudySiteName "TestSiteName"
	And the studysite should have the StudySiteNumber "5243534"
	And the studysite should have the ExternalStudyId "6"
	And the studysite should have a LastExternalUpdateDate "2012-10-12 12:00:00"

@put_scenario_1
Scenario: When a StudySite PUT message gets put onto the queue, the studysite is updated in Rave.
	Given the study with name "TestStudy" and environment "Prod" with ExternalId "6" exists in the Rave database
	And I send the following StudySite messages to SQS
	| EventType | StudySiteId | StudySiteName            | StudySiteNumber | StudyId | SiteId | SiteName            | SiteNumber    | Timestamp           |
	| POST      | 33          | TestStudySiteName        | 5243534         | 6       | 10     | TestSiteName        | put001        | 2012-10-12 12:00:00 |
	| PUT       | 33          | TestStudySiteNameUpdated | 5243534updated  | 6       | 10     | TestSiteNameUpdated | put001updated | 2012-10-12 13:00:00 |
	When the messages are successfully processed
	Then I should see the site in the Rave database
	And I should see the studysite in the Rave database
	And the site should have the ExternalId "10"
	And the site should have the name "TestSiteNameUpdated"
	And the site should have the SiteNumber "put001updated"
	And the site should have a LastExternalUpdateDate "2012-10-12 13:00:00"
	And the studysite should have ExternalID "33"
	And the studysite should have the StudySiteName "TestSiteNameUpdated"
	And the studysite should have the StudySiteNumber "5243534updated"
	And the studysite should have the ExternalStudyId "6"
	And the studysite should have a LastExternalUpdateDate "2012-10-12 13:00:00"

@delete_scenario_1
Scenario: When a StudySite DELETE message gets put onto the queue, the studysite is inactivated in Rave.
	Given the study with name "TestStudy" and environment "Prod" with ExternalId "6" exists in the Rave database
	And I send the following StudySite messages to SQS
	| EventType | StudySiteId | StudySiteName     | StudySiteNumber | StudyId | SiteId | SiteName     | SiteNumber | Timestamp           |
	| POST      | 33          | TestStudySiteName | 5243534         | 6       | 10     | TestSiteName | delete001  | 2012-10-12 12:00:00 |
	| DELETE    |             |                   |                 |         |        |              | delete001  | 2012-10-12 13:00:00 |
	When the messages are successfully processed
	Then I should see the site in the Rave database
	And I should see the studysite in the Rave database
	And the studysite should be inactive


@PB2.7.5.13-30
Scenario: When I update a Study site in iMedidata, the linked study site is updated in Rave if the study is connected to iMedidata. The only attribute updated is the study-site number in Rave.	
	Given the study with name "Study A" and environment "Prod" with ExternalId "100" exists in the Rave database
	And I send the following StudySite messages to SQS
	| EventType | StudySiteId | StudySiteName     | StudySiteNumber | StudyId | SiteId | SiteName     | SiteNumber | Timestamp           |
	| POST      | 33          | TestStudySiteName | 123456          | 100     | 10     | TestSiteName | put002     | 2012-10-12 12:00:00 |
	| PUT       | 33          | TestStudySiteName | 9898            | 100     | 10     | TestSiteName | put002     | 2012-10-12 13:00:00 |
	When the messages are successfully processed
	Then I should see the site in the Rave database
	And I should see the studysite in the Rave database
	And the studysite should have the StudySiteNumber "9898"
	And the studysite should have the source iMedidata

@PB2.5.9.38-01
Scenario:  When a Site is added back to a Study in iMedidata, the studysite in Rave should be added back to the Site.
	Given the study with name "Study A" and environment "Prod" with ExternalId "100" exists in the Rave database
	And I send the following StudySite messages to SQS
	| EventType | StudySiteId | StudySiteName     | StudySiteNumber | StudyId | SiteId | SiteName         | SiteNumber | Timestamp           |
	| POST      | 33          | TestStudySiteName | 5243534         | 100     | 10     | Test Delete Site | delete001  | 2012-10-12 12:00:00 |
	| DELETE    |             |                   |                 |         |        |                  | delete001  | 2012-10-12 13:00:00 |
	When the messages are successfully processed
	Then I should see the site in the Rave database
	And I should see the studysite in the Rave database
	And the studysite should be inactive
	When I send the following StudySite message to SQS
	| EventType | StudySiteId | StudySiteName        | StudySiteNumber | StudyId | SiteId | SiteName         | SiteNumber | Timestamp           |
	| POST      | 40          | TestDELETE StudySite | 123456          | 100     | 10     | Test Delete Site | 329843432  | 2012-10-12 13:00:00 |
	And the message is successfully processed
	Then I should see the studysite in the Rave database
	And the studysite should have the source iMedidata