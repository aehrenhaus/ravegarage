Feature: Studies
	In order to create external studies in Rave,
	I want to be able to process study messages from SQS.

@mytag
Scenario: When a Study POST message gets put onto the queue, the study is created in Rave.
	Given I send the following Study POST message to SQS
	| Name      | IsProd | Description	 | UUID									| Timestamp  | MessageId							|
	| TestStudy	| true   | Description	 | 3d827459-6744-4766-9530-28238606e678	| 2012-10-12 | 1867e3e7-56bb-432e-b899-ca025889c606 |
	When the message is successfully processed
	Then I should see the study in the Rave database.
