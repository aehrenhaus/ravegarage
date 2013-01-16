Feature: Studies
	In order to create external studies in Rave,
	I want to be able to process study messages from SQS.

@mytag
Scenario: When a Study POST message gets put onto the queue, the study is created in Rave.
	Given I send the following Study messages to SQS
	| EventType | Name          | IsProd | Description | ID   | Timestamp           |
	| POST      | TestSqsStudy7 | true   | Description | 1235 | 2012-10-12 12:00:00 |
	When the message is successfully processed
	Then I should see the study in the Rave database
	And the study should have Name "TestSqsStudy7"
	And the study should have Environment "Prod"
	