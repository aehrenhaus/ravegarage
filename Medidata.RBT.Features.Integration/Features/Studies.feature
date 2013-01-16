Feature: Studies
	In order to create external studies in Rave,
	I want to be able to process study messages from SQS.

@mytag
Scenario: When a Study POST message gets put onto the queue, the study is created in Rave.
	Given I send the following Study message to SQS
	| EventType | Name          | IsProd | Description | ID   | Timestamp           |
	| POST      | TestSqsStudy21 | true   | TestDescription | 1244 | 2012-10-12 12:00:00 |
	When the message is successfully processed
	Then I should see the study in the Rave database
	And the study should have Name "TestSqsStudy21"
	And the study should have Environment "Prod"
	And the study should have Description "TestDescription"
	And the study should have LastExternalUpdateDate "2012-10-12 12:00:00"
	And the study should not be TestStudy
	And the study should have ExternalID "1244"
	
Scenario: When a Study PUT message gets put onto the queue, the study is updated in Rave.
	Given I send the following Study messages to SQS
	| EventType | Name                  | IsProd | Description            | ID   | Timestamp           |
	| POST      | TestSqsStudy22        | true   | TestDescription        | 1245 | 2012-10-12 12:00:00 |
	| PUT       | TestSqsStudy22Updated | true   | TestDescriptionUpdated | 1245 | 2012-10-12 14:00:00 |
	When the messages are successfully processed
	Then I should see the study in the Rave database
	And the study should have Name "TestSqsStudy22Updated"
	And the study should have Environment "Prod"
	And the study should have Description "TestDescriptionUpdated"
	And the study should have LastExternalUpdateDate "2012-10-12 14:00:00"
	And the study should not be TestStudy
	And the study should have ExternalID "1245"