Feature: Studies
	In order to create external studies in Rave,
	I want to be able to process study messages from SQS.

@mytag
Scenario: When a Study POST message gets put onto the queue, the study is created in Rave.
	Given I send the following Study messages to SQS
	| EventType | Name      | IsProd | Description | UUID                                 | Timestamp           | MessageId                            |
	| POST      | TestStudy | true   | Description | 3d827459-6744-4766-9530-28238606e678 | 2012-10-12 12:00:00 | 1867e3e7-56bb-432e-b899-ca025889c606 |
	When the message is successfully processed
	Then I should see the study with UUID "3d827459-6744-4766-9530-28238606e678" in the Rave database
	And the study should have Name "TestStudy"
	And the study should have Environment "Prod"
	