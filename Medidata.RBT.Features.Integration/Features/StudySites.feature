Feature: StudySites
	In order to create external study sites in Rave,
	I want to be able to process study messages from SQS.

@mytag
Scenario: When a StudySite POST message gets put onto the queue, the studysite is created in Rave.
	Given the study with name "TestStudy" and environment "Prod" exists in the Rave database 
	And  I send the following StudySite message to SQS
	| EventType | StudySiteId | StudySiteName     | StudySiteNumber | StudyId | SiteId     | SiteName     | SiteNumber  | Timestamp           |
	| POST      | 534543      | TestStudySiteName | 5243534         | 565687  | 9834879453 | TestSiteName | 49878567483 | 2012-10-12 12:00:00 |
	When the message is successfully processed
	Then I should see the studysite in the Rave database
	# need to implement verification steps
