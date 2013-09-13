Feature: StudySites
	In order to create external study sites in Rave,
	I want to be able to process study messages from SQS.

@post_scenario_1
Scenario: When a StudySite POST message gets put onto the queue, the studysite is created in Rave.
	Given the study with name "TestPost Study" and environment "Prod" with ExternalId "1" exists in the Rave database
	When I send the following StudySite message to SQS
	| EventType | StudySiteId | StudySiteName         | StudySiteNumber | StudyId | SiteId | SiteName         | SiteNumber | Timestamp           |
	| POST      | 11          | TestPostStudySiteName | post001         | 1       | 10     | TestPostSiteName | post001    | 2012-10-12 12:00:00 |
	And the message is successfully processed
	Then I should see the site in the Rave database
	And I should see the studysite in the Rave database
	And the site should exist with the following properties
	| ExternalId | Name             | SiteNumber | LastExternalUpdateDate |
	| 10         | TestPostSiteName | post001    | 2012-10-12 12:00:00    |
	And the studysite should exist with the following properties
	| ExternalID | StudySiteName    | StudySiteNumber | ExternalStudyId | LastExternalUpdateDate |
	| 11         | TestPostSiteName | post001         | 1               | 2012-10-12 12:00:00    |


@put_scenario_1
Scenario: When a StudySite PUT message gets put onto the queue, the studysite is updated in Rave.
	Given the study with name "TestPut Study" and environment "Prod" with ExternalId "2" exists in the Rave database
	And I send the following StudySite message to SQS
	| EventType | StudySiteId | StudySiteName               | StudySiteNumber | StudyId | SiteId | SiteName               | SiteNumber    | Timestamp           |
	| POST      | 22          | TestPutStudySiteName        | put001          | 2       | 20     | TestPutSiteName        | put001        | 2012-10-12 12:00:00 |
	And the message is successfully processed
	When I send the following StudySite message to SQS
	| EventType | StudySiteId | StudySiteName               | StudySiteNumber | StudyId | SiteId | SiteName               | SiteNumber    | Timestamp           |
	| PUT       | 22          | TestPutStudySiteNameUpdated | put001updated   | 2       | 20     | TestPutSiteNameUpdated | put001updated | 2012-10-12 13:00:00 |
	And the message is successfully processed
	Then I should see the site in the Rave database
	And I should see the studysite in the Rave database
	And the site should exist with the following properties
	| ExternalId | Name                   | SiteNumber    | LastExternalUpdateDate |
	| 20         | TestPutSiteNameUpdated | put001updated | 2012-10-12 13:00:00    |
	And the studysite should exist with the following properties
	| ExternalID | StudySiteName          | StudySiteNumber | ExternalStudyId | LastExternalUpdateDate |
	| 22         | TestPutSiteNameUpdated | put001updated   | 2               | 2012-10-12 13:00:00    |



@delete_scenario_1
Scenario: When a StudySite DELETE message gets put onto the queue, the studysite is inactivated in Rave.
	Given the study with name "TestDelete Study" and environment "Prod" with ExternalId "3" exists in the Rave database
	And I send the following StudySite message to SQS
	| EventType | StudySiteId | StudySiteName           | StudySiteNumber | StudyId | SiteId | SiteName           | SiteNumber | Timestamp           |
	| POST      | 33          | TestDeleteStudySiteName | delete001       | 3       | 30     | TestDeleteSiteName | delete001  | 2012-10-12 12:00:00 |
	And the message is successfully processed
	When I send the following StudySite message to SQS
	| EventType | StudySiteId | StudySiteName           | StudySiteNumber | StudyId | SiteId | SiteName           | SiteNumber | Timestamp           |
	| DELETE    |             |                         |                 |         |        |                    | delete001  | 2012-10-12 13:00:00 |
	And the message is successfully processed
	Then I should see the site in the Rave database
	And I should see the studysite in the Rave database
	And the studysite should exist with the following properties
	| Source    | Active |
	| iMedidata | False  |


@PB2.7.5.13-30
Scenario: When I update a Study site in iMedidata, the linked study site is updated in Rave if the study is connected to iMedidata. The only attribute updated is the study-site number in Rave.	
	Given the study with name "Study 1330 A" and environment "Prod" with ExternalId "1330" exists in the Rave database
	And I send the following StudySite message to SQS
	| EventType | StudySiteId | StudySiteName       | StudySiteNumber  | StudyId | SiteId | SiteName       | SiteNumber | Timestamp           |
	| POST      | 44          | PB2751330 StudySite | PB2751330        | 1330    | 40     | PB2751330 Site | PB2751330  | 2012-10-12 12:00:00 |
	And the message is successfully processed
	When I send the following StudySite message to SQS
	| EventType | StudySiteId | StudySiteName       | StudySiteNumber  | StudyId | SiteId | SiteName       | SiteNumber | Timestamp           |
	| PUT       | 44          | PB2751330 StudySite | PB2751330updated | 1330    | 40     | PB2751330 Site | PB2751330  | 2012-10-12 13:00:00 | 
	And the message is successfully processed
	Then I should see the site in the Rave database
	And I should see the studysite in the Rave database
	And the studysite should exist with the following properties
	| StudySiteNumber  | Source    |
	| PB2751330updated | iMedidata |

@PB2.5.9.38-01
Scenario:  When a Site is added back to a Study in iMedidata, the studysite in Rave should be added back to the Site.
	Given the study with name "Study 3801 A" and environment "Prod" with ExternalId "3801" exists in the Rave database
	And I send the following StudySite message to SQS
	| EventType | StudySiteId | StudySiteName       | StudySiteNumber | StudyId | SiteId | SiteName       | SiteNumber | Timestamp           |
	| POST      | 55          | PB2593801 StudySite | PB2593801       | 3801    | 50     | PB2593801 Site | PB2593801  | 2012-10-12 12:00:00 |
	And the message is successfully processed
	When I send the following StudySite message to SQS
	| EventType | StudySiteId | StudySiteName       | StudySiteNumber | StudyId | SiteId | SiteName       | SiteNumber | Timestamp           |
	| DELETE    |             |                     |                 |         |        |                | PB2593801  | 2012-10-12 13:00:00 |
	And the message is successfully processed
	Then I should see the site in the Rave database
	And I should see the studysite in the Rave database
	And the studysite should be inactive
	When I send the following StudySite message to SQS
	| EventType | StudySiteId | StudySiteName       | StudySiteNumber | StudyId | SiteId | SiteName       | SiteNumber | Timestamp           |
	| POST      | 55          | PB2593801 StudySite | PB2593801       | 3801    | 50     | PB2593801 Site | PB2593801  | 2012-10-12 14:00:00 |
	And the message is successfully processed
	Then I should see the studysite in the Rave database
	And the studysite should have the source iMedidata

@PB2.5.9.37-01
Scenario: If I have a linked site in iMedidata, and I delete a studysite in iMedidata that is linked to that site, when Rave receives the updated studysite, it will inactivate the studysite in Rave.
	Given the study with name "Study 3701 A" and environment "Prod" with ExternalId "3701" exists in the Rave database
	And I send the following StudySite message to SQS
	| EventType | StudySiteId | StudySiteName       | StudySiteNumber | StudyId | SiteId | SiteName       | SiteNumber | Timestamp           |
	| POST      | 66          | PB2693701 StudySite | PB2693701       | 3701    | 60     | PB2693701 Site | PB2693701  | 2012-10-12 12:00:00 |
	When the messages are successfully processed
	Then I should see the site in the Rave database
	And I should see the studysite in the Rave database
	And the studysite should be active
	When I send the following StudySite message to SQS
	| EventType | StudySiteId | StudySiteName | StudySiteNumber | StudyId | SiteId | SiteName | SiteNumber | Timestamp           |
	| DELETE    |             |               |                 |         |        |          | PB2693701  | 2012-10-12 13:00:00 |
	And the messages are successfully processed
	Then I should see the site in the Rave database
	And I should see the studysite in the Rave database
	And the studysite should be inactive