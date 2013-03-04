Feature: Studies
	In order to create external studies in Rave,
	I want to be able to process study messages from SQS.

@mytag
Scenario: When a Study POST message gets put onto the queue, the study is created in Rave.
	Given I send the following Study message to SQS
	| EventType | Name          | IsProd | Description | ID   | Timestamp           |
	| POST      | TestSqsStudy29 | true   | TestDescription | 1252 | 2012-10-12 12:00:00 |
	When the message is successfully processed
	Then I should see the study in the Rave database
	And the study should have Name "TestSqsStudy29"
	And the study should have Environment "Prod"
	And the study should have Description "TestDescription"
	And the study should have LastExternalUpdateDate "2012-10-12 12:00:00"
	And the study should not be TestStudy
	And the study should have ExternalID "1252"
	
Scenario: When a Study PUT message gets put onto the queue, the study is updated in Rave.
	Given I send the following Study messages to SQS
	| EventType | Name                  | IsProd | Description            | ID   | EnrollmentTarget | Timestamp           |
	| POST      | TestSqsStudy30        | true   | TestDescription        | 1253 | 1                | 2012-10-12 12:00:00 |
	| PUT       | TestSqsStudy30Updated | true   | TestDescriptionUpdated | 1253 | 2                | 2012-10-12 14:00:00 |
	When the messages are successfully processed
	Then I should see the study in the Rave database
	And the study should have Name "TestSqsStudy30Updated"
	And the study should have Environment "Prod"
	And the study should have Description "TestDescriptionUpdated"
	And the study should have LastExternalUpdateDate "2012-10-12 14:00:00"
	And the study should not be TestStudy
	And the study should have ExternalID "1253"
	And the study should have EnrollmentTarget "2"

@PB2.5.8.20-01
Scenario: If I have a project + environment in Rave that is not linked to a study in iMedidata . When the study is created in iMedidata, Rave should link that Project and Environment.
	
	Given the study with name "TestSqsStudy31" and environment "TestEnvironment" with ExternalId "0" exists in the Rave database
	And I send the following Study messages to SQS
	| EventType | Name                             | IsProd | Description     | ID   | EnrollmentTarget | Timestamp           |
	| POST      | TestSqsStudy31 (TestEnvironment) | false  | TestDescription | 1254 | 3                | 2012-10-12 12:00:00 |
	When the message is successfully processed
	Then I should see the study in the Rave database
	And the study with ExternalId "0" should not be in the Rave database
	And the study should have Name "TestSqsStudy31"
	And the study should have Environment "TestEnvironment"
	And the study should have Description "TestDescription"
	And the study should have LastExternalUpdateDate "2012-10-12 12:00:00"
	And the study should have ExternalID "1254"
	And the study should have EnrollmentTarget "3"

@PB2.5.8.16-01
Scenario: If I have an unlinked study in iMedidata, when the study is created in iMedidata, Rave should do a UUID match, 
			and failing that a name match against the iMedidata study and, on a match against only the project name, 
			link the found project and create the new environment that maps to that study.

	Given the study with name "TestSqsStudy32" and environment "TestEnvironment1" with ExternalId "117" exists in the Rave database
	And I send the following Study messages to SQS
	| EventType | Name                              | IsProd | Description     | ID   | EnrollmentTarget | Timestamp           |
	| POST      | TestSqsStudy32 (TestEnvironment2) | false  | TestDescription | 1255 | 4                | 2012-10-12 12:00:00 |
	When the message is successfully processed
	Then I should see the study in the Rave database
	And the study should have Name "TestSqsStudy32"
	And the study should have Project Name "TestSqsStudy32"
	And the study should have Environment "TestEnvironment2"
	And the study should have Description "TestDescription"
	And the study should have LastExternalUpdateDate "2012-10-12 12:00:00"
	And the study should have ExternalID "1255"
	And the study should have EnrollmentTarget "4"
	And I should see a study named "TestSqsStudy32" with Project Name "TestSqsStudy32" environment "TestEnvironment1" and ExternalId "117" in the Rave database

@PB2.5.8.28-04B
Scenario: Operations on studies, sites, studysites, users, study assignments, studysite assignments must be audited in the 'name' 
          of the system user.

	Given I send the following Study message to SQS
	| EventType | Name           | IsProd | Description     | ID   | EnrollmentTarget | Timestamp           |
	| POST      | TestSqsStudy33 | true   | TestDescription | 1256 | 5                | 2012-10-12 12:00:00 |
	When the message is successfully processed
	Then I should see the study in the Rave database
	And I should see the study has audits in the Rave database
	And I should see the audits were performed by user "System"
	And I should see the audit action type "Created"
	And I should see the audit action "Study created."