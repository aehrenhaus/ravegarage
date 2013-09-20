Feature: Studies
	In order to create external studies in Rave,
	I want to be able to process study messages from SQS.

@mytag
Scenario: When a Study POST message gets put onto the queue, the study is created in Rave.
	When I send the following Study message to SQS
	| EventType | Name           | IsProd | Description     | ID   | Timestamp           |
	| POST      | TestSqsStudy29 | true   | TestDescription | 1252 | 2012-10-12 12:00:00 |
	Then I should see the study in the Rave database
	And the study should exist with the following properties
	| Name           | Environment | Description     | LastExternalUpdateDate | TestStudy | ExternalID | 
	| TestSqsStudy29 | Prod        | TestDescription | 2012-10-12 12:00:00    | False     | 1252       |
	
Scenario: When a Study PUT message gets put onto the queue, the study is updated in Rave.
	Given I send the following Study message to SQS
	| EventType | Name                  | IsProd | Description            | ID   | EnrollmentTarget | Timestamp           |
	| POST      | TestSqsStudy30        | true   | TestDescription        | 1253 | 1                | 2012-10-12 12:00:00 |
	When I send the following Study messages to SQS
	| EventType | Name                  | IsProd | Description            | ID   | EnrollmentTarget | Timestamp           |
	| PUT       | TestSqsStudy30Updated | true   | TestDescriptionUpdated | 1253 | 2                | 2012-10-12 14:00:00 |
	Then I should see the study in the Rave database
	And the study should exist with the following properties
	| Name                  | Environment | Description            | LastExternalUpdateDate | TestStudy | ExternalID | EnrollmentTarget |
	| TestSqsStudy30Updated | Prod        | TestDescriptionUpdated | 2012-10-12 14:00:00    | False     | 1253       | 2                |

@PB2.5.8.20-01
Scenario Outline: If I have a project + environment in Rave that is not linked to a study in iMedidata . When the study is created in iMedidata, Rave should link that Project and Environment.
	
	Given the study with name "TestSqsStudy31" and environment "TestEnvironment" with UUID "<RaveUuid>" exists in the Rave database
	When I send the following Study message to SQS
	| EventType | Name                             | IsProd | Description     | ID   | Uuid            | EnrollmentTarget | Timestamp           |
	| POST      | TestSqsStudy31 (TestEnvironment) | false  | TestDescription | 1254 | <iMedidataUuid> | 3                | 2012-10-12 12:00:00 |
	Then I should not see the study with UUID "<RaveUuid>" in the Rave database
	And I should see the study with UUID "<iMedidataUuid>" in the Rave database
	And the study should exist with the following properties
	| Name           | Environment     | Description     | LastExternalUpdateDate | ExternalID | EnrollmentTarget |
	| TestSqsStudy31 | TestEnvironment | TestDescription | 2012-10-12 12:00:00    | 1254       | 3                |
Examples: 
	| RaveUuid                             | iMedidataUuid                        |
	| 7de5c9aa-8484-44f0-ad7a-5682ddc62996 | 81bc2b1f-1cf6-4851-9f98-a4edc609ff46 |

@PB2.5.8.16-01
Scenario: If I have an unlinked study in iMedidata, when the study is created in iMedidata, Rave should do a UUID match, 
			and failing that a name match against the iMedidata study and, on a match against only the project name, 
			link the found project and create the new environment that maps to that study.

	Given the study with name "TestSqsStudy32" and environment "TestEnvironment1" with ExternalId "117" exists in the Rave database
	When I send the following Study message to SQS
	| EventType | Name                              | IsProd | Description     | ID   | EnrollmentTarget | Timestamp           |
	| POST      | TestSqsStudy32 (TestEnvironment2) | false  | TestDescription | 1255 | 4                | 2012-10-12 12:00:00 |
	Then I should see the study in the Rave database
	And the study should exist with the following properties
	| Name           | Environment      | Description     | LastExternalUpdateDate | ExternalID | EnrollmentTarget |
	| TestSqsStudy32 | TestEnvironment2 | TestDescription | 2012-10-12 12:00:00"   | 1255       | 4                |
	And I should see a study named "TestSqsStudy32" with environment "TestEnvironment1" and ExternalId "117" in the Rave database

@PB2.5.8.28-04B
Scenario: Operations on studies, sites, studysites, users, study assignments, studysite assignments must be audited in the 'name' 
          of the system user.

	When I send the following Study message to SQS
	| EventType | Name           | IsProd | Description     | ID   | EnrollmentTarget | Timestamp           |
	| POST      | TestSqsStudy33 | true   | TestDescription | 1256 | 5                | 2012-10-12 12:00:00 |
	Then I should see the study in the Rave database
	And I should see the study has audits in the Rave database
	And I should see the audits were performed by user "System"
	And I should see the audit action type "Created"
	And I should see the audit action "Study created."

@PB2.5.8.7-06
Scenario Outline: If I have a project in Rave that is not linked to study in iMedidata,  when the study is created in iMedidata with spaces after the study name, Rave will link to the matching study name ( with no spaces) in Rave.
	Given the study with name "<RaveStudyName>" and environment "<Environment>" with UUID "<RaveUuid>" exists in the Rave database
	When I send the following Study message to SQS
	| EventType | Name                 | IsProd   | Environment   | Description                 | ID                 | Timestamp            | UUID            |
	| POST      | <iMedidataStudyName> | <IsProd> | <Environment> | <iMedidataStudyDescription> | <iMedidataStudyId> | <LastExternalUpdate> | <iMedidataUuid> |
	#the study uuid should be updated to the value provided by iMedidata
	Then I should not see the study with UUID "<RaveUuid>" in the Rave database
	And I should see the study with UUID "<iMedidataUuid>" in the Rave database
	#test study properties
	And the study should exist with the following properties
	| Name                 | IsProd   | Description                 | ExternalID         | LastExternalUpdateDate | UUID            | TestStudy   | EnvironmentName |
	| <iMedidataStudyName> | <IsProd> | <iMedidataStudyDescription> | <iMedidataStudyId> | <LastExternalUpdate>   | <iMedidataUuid> | <TestStudy> | <Environment>   |
	And the study should have Project Name "<iMedidataStudyName>"
Examples: 
	| RaveStudyName            | iMedidataStudyName              | Environment     | iMedidataStudyDescription        | iMedidataStudyId | IsProd | TestStudy | LastExternalUpdate  | RaveUuid                             | iMedidataUuid                        |
	| TestSqsStudy 2.5.8.7-06A | "TestSqsStudy 2.5.8.7-06A     " | Prod            | TestDescriptioniMedidata 258706A | 258706A          | true   | false     | 2012-10-12 12:00:00 | d0f0330a-fcd4-4cf8-bfc8-cecb44769faa | 7e0db3ef-2d41-4534-96d2-51a362267c0a |
	| TestSqsStudy 2.5.8.7-06B | "TestSqsStudy 2.5.8.7-06B     " | SomeEnvironment | TestDescriptioniMedidata 258706B | 258706B          | false  | true      | 2012-10-13 12:00:00 | b81e3342-685b-46fa-a96b-cfd8a117cc39 | cecb73b6-867b-4f72-9021-cf958d005f21 |