Feature: StudyInvitations
	In order to assign external users to external studies in Rave,
	I want to be able to process study_invitation messages from SQS.

@post_scenario_1
Scenario: When a StudyInvitation POST message gets put onto the queue, the study assignments are created in Rave.
	Given the study with name "Test POST Study" and environment "Prod" with ExternalId "100" exists in the Rave database
	And I have an EDC app assignment with the following role
	| RoleName         |
	| Post1 EDC Role 1 |
	And I have an Architect Security app assignment with the following role
	| RoleName               |
	| Post1 Security Group 1 |
	And I have a Modules app assignment with the following role
	| RoleName          |
	| Post1 All Modules |
	And I send the following StudyInvitation message to SQS
	| EventType | InvitationType  | Email            | Login                       | UserId | FirstName | MiddleName | LastName | Address1      | City     | State | PostalCode | Country | Telephone  | Locale | TimeZone  | Timestamp          |
	| POST      | StudyInvitation | testUser@test.cx | testPOSTstudyInvitationUser | 101    | Test      | J          | User     | 79 5th Avenue | New York | NY    | 10003      | USA     | 1234567890 | eng    | New Delhi | 2013-01-01 12:00PM |
	When the message is successfully processed
	Then I should see the user in the Rave database
	And the user should be assigned to the study with the following EDC role
	| RoleName         |
	| Post1 EDC Role 1 |
	And the user should be assigned to the following SecurityGroup on the study
	| RoleName               |
	| Post2 Security Group 1 |
	And the user should be assigned to the following UserGroup on the study
	| RoleName          |
	| Post1 All Modules |
	
@put_scenario_1
Scenario: When a StudyInvitation PUT message gets put onto the queue, the study assignments are updated in Rave.
	Given the study with name "Test PUT Study" and environment "Prod" with ExternalId "200" exists in the Rave database
	And the User with login "testPUTstudyInvitationUser" exists in the Rave database
	And the user is assigned to the study with the following EDC role
	| RoleName        |
	| Put1 EDC Role 1 |
	And the user is assigned to the following Security Group on the study
	| RoleName              |
	| Put1 Security Group 1 |
	And the User is assigned to the "Put1 All Modules" User Group on the study
	And I have an EDC app assignment with the following role
	| RoleName        |
	| Put1 EDC Role 2 |
	And I have an Architect Security app assignment with the following role
	| RoleName              |
	| Put1 Security Group 2 |
	And I have a Modules app assignment with the following role
	| RoleName        |
	| Put1 User Admin |
	And I send the following StudyInvitation message to SQS
	| EventType | InvitationType  | Email            | Login                      | FirstName | MiddleName | LastName | Address1      | City     | State | PostalCode | Country | Telephone  | Locale | TimeZone  | Timestamp          |
	| PUT       | StudyInvitation | testUser@test.cx | testPUTstudyinvitationuser | Test      | J          | User     | 79 5th Avenue | New York | NY    | 10003      | USA     | 1234567890 | eng    | New Delhi | 2013-01-01 13:00PM |
	When the message is successfully processed
	Then the user should be assigned to the study with the following EDC role
	| RoleName        |
	| Put1 EDC Role 2 |
	And the user should be assigned to the following SecurityGroup on the study
	| RoleName              |
	| Put1 Security Group 2 |
	And the user should be assigned to the following UserGroup on the study
	| RoleName        |
	| Put1 User Admin |
	And the user should not be assigned to the study with the following EDC role
	| RoleName        |
	| Put1 EDC Role 1 |
	And the user should not be assigned to the following SecurityGroup
	| RoleName              |
	| Put1 Security Group 1 |
	And the user should not be assigned to the following UserGroup on the study
	| RoleName         |
	| Put1 All Modules |
	And the Rave user with EDC role "Put1 EDC Role 1" should be inactive

@delete_scenario_1
Scenario: When a StudyInvitation DELETE message gets put onto the queue, the study assignments are removed from Rave.
	Given the study with name "Test DELETE Study" and environment "Prod" with ExternalId "300" exists in the Rave database
	And I have an EDC app assignment with the following role
	| RoleName           |
	| Delete1 EDC Role 1 |
	| Delete1 EDC Role 2 |
	And I have an Architect Security app assignment with the following role
	| RoleName                 |
	| Delete1 Security Group 1 |
	And I have a Modules app assignment with the following role
	| RoleName               |
	| Delete1 Modules Role 1 |
	And I send the following StudyInvitation messages to SQS
	| EventType | InvitationType  | Email            | Login                         | FirstName | MiddleName | LastName | Address1      | City     | State | PostalCode | Country | Telephone  | Locale | TimeZone  | Timestamp          |
	| POST      | StudyInvitation | testUser@test.cx | testDELETEstudyInvitationUser | Test      | J          | User     | 79 5th Avenue | New York | NY    | 10003      | USA     | 1234567890 | eng    | New Delhi | 2013-01-01 12:00PM |
	| DELETE    | StudyInvitation |                  |                               |           |            |          |               |          |       |            |         |            |        |           | 2013-01-01 13:00PM |
	When the message is successfully processed
	Then the user should not be assigned to the study with the following EDC roles
	| RoleName           |
	| Delete1 EDC Role 1 |
	| Delete1 EDC Role 2 |
	And the user should not be assigned to the following SecurityGroup
    | RoleName                 |
    | Delete1 Security Group 1 |
	And the user should have the iMedidataEDC user group assigned

@PB2.5.8.28-10
Scenario: If an iMedidata user has a study assignment removed in iMedidata, that study assignment is removed in Rave.
	Given the study with name "Study 2810 A" and environment "Prod" with UUID "A0D8B069-7961-4FA3-A4CE-6ABB5D62E210" exists in the Rave database
	And the study with name "Study 2810 B" and environment "Prod" with UUID "8081E2F5-548F-43AD-A4CB-F90963AB28A4" exists in the Rave database
	And the study with name "Study 2810 C" and environment "Prod" with UUID "62849DCE-6EB8-4BE1-8CE7-CB3CB0F67E9D" exists in the Rave database
	And I have an EDC app assignment with the following role
	| RoleName             |
	| PB2582810 EDC Role 1 |
	| PB2582810 EDC Role 2 |
	| PB2582810 EDC Role 3 |
	And I have an Architect Security app assignment with the following role
	| RoleName                   |
	| PB2582810 Security Group 1 |
	And I have a Modules app assignment with the following role
	| RoleName                 |
	| PB2582810 Modules Role 1 |
	And I send the following StudyInvitation messages to SQS
	| EventType | InvitationType  | StudyUuid                            | Email                 | Login         | UserId | FirstName | MiddleName | LastName | Address1      | City     | State | PostalCode | Country | Telephone  | Locale | TimeZone  | Timestamp          |
	| POST      | StudyInvitation | A0D8B069-7961-4FA3-A4CE-6ABB5D62E210 | pb2582810user@test.cx | pb2582810user | 2810   | Test      | J          | User     | 79 5th Avenue | New York | NY    | 10003      | USA     | 1234567890 | eng    | New Delhi | 2013-01-01 12:00PM |
	| POST      | StudyInvitation | 8081E2F5-548F-43AD-A4CB-F90963AB28A4 | pb2582810user@test.cx | pb2582810user | 2810   | Test      | J          | User     | 79 5th Avenue | New York | NY    | 10003      | USA     | 1234567890 | eng    | New Delhi | 2013-01-01 12:00PM |
	| POST      | StudyInvitation | 62849DCE-6EB8-4BE1-8CE7-CB3CB0F67E9D | pb2582810user@test.cx | pb2582810user | 2810   | Test      | J          | User     | 79 5th Avenue | New York | NY    | 10003      | USA     | 1234567890 | eng    | New Delhi | 2013-01-01 12:00PM |
	When the message is successfully processed
	Then I should see the user in the Rave database
	And the user should have the ExternalSystem iMedidata
	And the user with EDC Role "PB2582810 EDC Role 1" should be assigned to the following studies
	| StudyName    | Uuid                                 |
	| Study 2810 A | A0D8B069-7961-4FA3-A4CE-6ABB5D62E210 |
	| Study 2810 B | 8081E2F5-548F-43AD-A4CB-F90963AB28A4 |
	| Study 2810 C | 62849DCE-6EB8-4BE1-8CE7-CB3CB0F67E9D |
	And the user with EDC Role "PB2582810 EDC Role 1" should be assigned to the following SecurityGroup
	| RoleName                   |
	| PB2582810 Security Group 1 |
	And the user with EDC Role "PB2582810 EDC Role 1" should be assigned to the following UserGroup
	| RoleName                 |
	| PB2582810 Modules Role 1 |
	And the user with EDC Role "PB2582810 EDC Role 2" should be assigned to the following studies
	| StudyName    | Uuid                                 |
	| Study 2810 A | A0D8B069-7961-4FA3-A4CE-6ABB5D62E210 |
	| Study 2810 B | 8081E2F5-548F-43AD-A4CB-F90963AB28A4 |
	| Study 2810 C | 62849DCE-6EB8-4BE1-8CE7-CB3CB0F67E9D |
	And the user with EDC Role "PB2582810 EDC Role 2" should be assigned to the following SecurityGroup
	| RoleName                   |
	| PB2582810 Security Group 1 |
	And the user with EDC Role "PB2582810 EDC Role 2" should be assigned to the following UserGroup
	| RoleName                 |
	| PB2582810 Modules Role 1 |
	And the user with EDC Role "PB2582810 EDC Role 3" should be assigned to the following studies
	| StudyName    | Uuid                                 |
	| Study 2810 A | A0D8B069-7961-4FA3-A4CE-6ABB5D62E210 |
	| Study 2810 B | 8081E2F5-548F-43AD-A4CB-F90963AB28A4 |
	| Study 2810 C | 62849DCE-6EB8-4BE1-8CE7-CB3CB0F67E9D |
	And the user with EDC Role "PB2582810 EDC Role 3" should be assigned to the following SecurityGroup
	| RoleName                   |
	| PB2582810 Security Group 1 |
	And the user with EDC Role "PB2582810 EDC Role 3" should be assigned to the following UserGroup
	| RoleName                 |
	| PB2582810 Modules Role 1 |
	When I send the following StudyInvitation messages to SQS
	| EventType | InvitationType  | StudyUuid                            | Timestamp          |
	| DELETE    | StudyInvitation | A0D8B069-7961-4FA3-A4CE-6ABB5D62E210 | 2013-01-01 13:00PM |
	And the message is successfully processed
	Then the user with EDC Role "PB2582810 EDC Role 1" should not be assigned to the following studies
	| StudyName    | Uuid                                 |
	| Study 2810 A | A0D8B069-7961-4FA3-A4CE-6ABB5D62E210 |
	And the user with EDC Role "PB2582810 EDC Role 1" should be assigned to the following SecurityGroup
	| RoleName                   |
	| PB2582810 Security Group 1 |
	And the user with EDC Role "PB2582810 EDC Role 1" should be assigned to the following UserGroup
	| RoleName                 |
	| PB2582810 Modules Role 1 |
	Then the user with EDC Role "PB2582810 EDC Role 2" should not be assigned to the following studies
	| StudyName    | Uuid                                 |
	| Study 2810 A | A0D8B069-7961-4FA3-A4CE-6ABB5D62E210 |
	And the user with EDC Role "PB2582810 EDC Role 2" should be assigned to the following SecurityGroup
	| RoleName                   |
	| PB2582810 Security Group 1 |
	And the user with EDC Role "PB2582810 EDC Role 2" should be assigned to the following UserGroup
	| RoleName                 |
	| PB2582810 Modules Role 1 |
	Then the user with EDC Role "PB2582810 EDC Role 3" should not be assigned to the following studies
	| StudyName    | Uuid                                 |
	| Study 2810 A | A0D8B069-7961-4FA3-A4CE-6ABB5D62E210 |
	And the user with EDC Role "PB2582810 EDC Role 3" should be assigned to the following SecurityGroup
	| RoleName                   |
	| PB2582810 Security Group 1 |
	And the user with EDC Role "PB2582810 EDC Role 3" should be assigned to the following UserGroup
	| RoleName                 |
	| PB2582810 Modules Role 1 |

@PB2.5.8.28-11
Scenario: If an iMedidata user has a  new study assignment added in iMedidata, that study assignment appears in Rave.
    Given the study with name "Study 2811 A" and environment "Prod" with UUID "835ECE8A-41B0-4A14-9E51-E4DDC5FB7952" exists in the Rave database
	And the study with name "Study 2811 B" and environment "Prod" with UUID "AEF0133F-7BA3-4789-8099-5D99AEEB3DA2" exists in the Rave database
	And the study with name "Study 2811 C" and environment "Prod" with UUID "DACEC000-CD7B-4CD7-B51E-0BA924488FF6" exists in the Rave database
	And I have an EDC app assignment with the following role
	| RoleName             |
	| PB2582811 EDC Role 1 |
	And I have an Architect Security app assignment with the following role
	| RoleName                   |
	| PB2582811 Security Group 1 |
	And I have a Modules app assignment with the following role
	| RoleName                 |
	| PB2582811 Modules Role 1 |
	And I send the following StudyInvitation messages to SQS
	| EventType | InvitationType  | StudyUuid                            | Email                 | Login         | UserId | FirstName | MiddleName | LastName | Address1      | City     | State | PostalCode | Country | Telephone  | Locale | TimeZone  | Timestamp          |
	| POST      | StudyInvitation | 835ECE8A-41B0-4A14-9E51-E4DDC5FB7952 | pb2582811user@test.cx | pb2582811user | 2811   | Test      | J          | User     | 79 5th Avenue | New York | NY    | 10003      | USA     | 1234567890 | eng    | New Delhi | 2013-01-01 12:00PM |
	| POST      | StudyInvitation | AEF0133F-7BA3-4789-8099-5D99AEEB3DA2 | pb2582811user@test.cx | pb2582811user | 2811   | Test      | J          | User     | 79 5th Avenue | New York | NY    | 10003      | USA     | 1234567890 | eng    | New Delhi | 2013-01-01 12:00PM |
	When the message is successfully processed
	Then I should see the user in the Rave database
	And the user should have the ExternalSystem iMedidata
	And the user with EDC Role "PB2582811 EDC Role 1" should be assigned to the following studies
	| StudyName    | Uuid                                 |
	| Study 2811 A | 835ECE8A-41B0-4A14-9E51-E4DDC5FB7952 |
	| Study 2811 B | AEF0133F-7BA3-4789-8099-5D99AEEB3DA2 |
	And the user with EDC Role "PB2582811 EDC Role 1" should be assigned to the following SecurityGroup
	| RoleName                   |
	| PB2582811 Security Group 1 |
	And the user with EDC Role "PB2582811 EDC Role 1" should be assigned to the following UserGroup
	| RoleName                 |
	| PB2582811 Modules Role 1 |
	When I send the following StudyInvitation messages to SQS
    | EventType | InvitationType  | StudyUuid                            | Email                 | Login         | UserId | FirstName | MiddleName | LastName | Address1      | City     | State | PostalCode | Country | Telephone  | Locale | TimeZone  | Timestamp          |
    | POST      | StudyInvitation | DACEC000-CD7B-4CD7-B51E-0BA924488FF6 | pb2582811user@test.cx | pb2582811user | 2811   | Test      | J          | User     | 79 5th Avenue | New York | NY    | 10003      | USA     | 1234567890 | eng    | New Delhi | 2013-01-01 13:00PM |
	And the message is successfully processed
	Then the user with EDC Role "PB2582811 EDC Role 1" should be assigned to the following studies
	| StudyName    | Uuid                                 |
	| Study 2811 A | 835ECE8A-41B0-4A14-9E51-E4DDC5FB7952 |
	| Study 2811 B | AEF0133F-7BA3-4789-8099-5D99AEEB3DA2 |
	| Study 2811 C | DACEC000-CD7B-4CD7-B51E-0BA924488FF6 |

@PB2.7.5.5-01
Scenario: If a user is only assigned to ‘Rave EDC’ application on iMedidata, then the user will be assigned to ‘iMedidata EDC’ User Group on Rave by default.
    Given the study with name "Study 501 A" and environment "Prod" with UUID "B942ED64-44FE-4C68-A47A-4CB77C2BE5B6" exists in the Rave database
	And I have an EDC app assignment with the following role
	| RoleName            |
	| PB275501 EDC Role 1 |
	And I send the following StudyInvitation message to SQS
	| EventType | InvitationType  | StudyUuid                            | Email                | Login    | UserId | FirstName | MiddleName | LastName | Address1      | City     | State | PostalCode | Country | Telephone  | Locale | TimeZone  | Timestamp          |
	| POST      | StudyInvitation | B942ED64-44FE-4C68-A47A-4CB77C2BE5B6 | pb275501user@test.cx | pb275501 | 275501 | Test      | J          | User     | 79 5th Avenue | New York | NY    | 10003      | USA     | 1234567890 | eng    | New Delhi | 2013-01-01 12:00PM |
	When the message is successfully processed
	Then I should see the user in the Rave database
	And the user should be assigned to the study with the following EDC role
    | RoleName            |
    | PB275501 EDC Role 1 |
	And the user should have the iMedidataEDC user group assigned

@PB2.7.5.28-56
Scenario: If a Users Modules App invitation is changed, then that should be reflected appropriately in Rave.
	Given the study with name "Study 2856 A" and environment "Prod" with UUID "F04C5342-2005-42F6-BE60-21EF67BBAEF0" exists in the Rave database
	And I have a Modules app assignment with the following role
    | RoleName                 |
    | PB2752856 Modules Role 1 |
	And I send the following StudyInvitation message to SQS
	| EventType | InvitationType  | StudyUuid                            | Email                 | Login     | UserId | FirstName | MiddleName | LastName | Address1      | City     | State | PostalCode | Country | Telephone  | Locale | TimeZone  | Timestamp          |
	| POST      | StudyInvitation | F04C5342-2005-42F6-BE60-21EF67BBAEF0 | pb2752856user@test.cx | pb2752856 | 2856   | Test      | J          | User     | 79 5th Avenue | New York | NY    | 10003      | USA     | 1234567890 | eng    | New Delhi | 2013-01-01 12:00PM |
	When the message is successfully processed
    Then I should see the user in the Rave database
    And the user should be assigned to the following UserGroup on the study
    | RoleName                 |
    | PB2752856 Modules Role 1 |
    Given I have a Modules app assignment with the following role
    | RoleName                 |
    | PB2752856 Modules Role 4 |
    And I send the following StudyInvitation message to SQS
	| EventType | InvitationType  | StudyUuid                            | Email                 | Login     | UserId | FirstName | MiddleName | LastName | Address1      | City     | State | PostalCode | Country | Telephone  | Locale | TimeZone  | Timestamp          |
	| PUT       | StudyInvitation | F04C5342-2005-42F6-BE60-21EF67BBAEF0 | pb2752856user@test.cx | pb2752586 | 2856   | Test      | J          | User     | 79 5th Avenue | New York | NY    | 10003      | USA     | 1234567890 | eng    | New Delhi | 2013-01-01 13:00PM |
    When the message is successfully processed
    Then the user should be assigned to the following UserGroup on the study
    | RoleName                 |
    | PB2752856 Modules Role 4 |
    And the user should not be assigned to the following UserGroup on the study
    | RoleName                 |
    | PB2752856 Modules Role 1 |

@PB2.5.8.28-02 
Scenario: If an iMedidata user with one EDC Role1 in a study linked to Rave and has that role changed to Role2, 
            when they access Rave after the role change, they will see that they do not have Role1, but Role2.
    Given the study with name "Study 2802 A" and environment "Prod" with UUID "1D696B2F-947B-40B2-8052-A58E483F6611" exists in the Rave database
    And I have an EDC app assignment with the following role
    | RoleName             |
    | PB2582802 EDC Role 1 |
    And I send the following StudyInvitation message to SQS
    | EventType | InvitationType  | StudyUuid                            | Email                 | Login     | UserId | FirstName | MiddleName | LastName | Address1      | City     | State | PostalCode | Country | Telephone  | Locale | TimeZone  | Timestamp          |
    | POST      | StudyInvitation | 1D696B2F-947B-40B2-8052-A58E483F6611 | pb2582802user@test.cx | pb2582802 | 2802   | Test      | J          | User     | 79 5th Avenue | New York | NY    | 10003      | USA     | 1234567890 | eng    | New Delhi | 2013-01-01 12:00PM |
    When the message is successfully processed
    Then I should see the user in the Rave database
    And the user should be assigned to the study with the following EDC role
    | RoleName             |
    | PB2582802 EDC Role 1 |
    Given I have an EDC app assignment with the following role
    | RoleName             |
    | PB2582802 EDC Role 2 |
    And I send the following StudyInvitation message to SQS
    | EventType | InvitationType  | StudyUuid                            | Email                 | Login     | UserId | FirstName | MiddleName | LastName | Address1      | City     | State | PostalCode | Country | Telephone  | Locale | TimeZone  | Timestamp          |
    | PUT       | StudyInvitation | 1D696B2F-947B-40B2-8052-A58E483F6611 | pb2582802user@test.cx | pb2582802 | 2802   | Test      | J          | User     | 79 5th Avenue | New York | NY    | 10003      | USA     | 1234567890 | eng    | New Delhi | 2013-01-01 13:00PM |
    When the message is successfully processed
    Then I should see the user in the Rave database
    And the user should be assigned to the study with the following EDC role
    | RoleName             |
    | PB2582802 EDC Role 2 |
    And the user should not be assigned to the study with the following EDC role
    | RoleName             |
    | PB2582802 EDC Role 1 |
    And the Rave user with EDC role "PB2582802 EDC Role 1" should be inactive

@PB2.5.8.23-01
Scenario: When an externally authenticated user accesses Rave for the first time with access to the Architect module and EDC provided through iMedidata, 
            Rave will assign that user the default Architect Security Role defined in Rave. 
    Given the study with name "Study 2301 A" and environment "Prod" with UUID "D5815E4F-4746-4EE7-9D25-4FD71F3FE93C" exists in the Rave database
    And a UserGroup Role with Name "PB2582301 Modules Role 1" and Architect permissions exists in the Rave database
    And I have an EDC app assignment with the following role
    | RoleName             |
    | PB2582301 EDC Role 1 |
    And I have a Modules app assignment with the following role
    | RoleName                 |
    | PB2582301 Modules Role 1 |
    And I send the following StudyInvitation message to SQS
    | EventType | InvitationType  | StudyUuid                            | Email                 | Login     | UserId | FirstName | MiddleName | LastName | Address1      | City     | State | PostalCode | Country | Telephone  | Locale | TimeZone  | Timestamp          |
    | POST      | StudyInvitation | D5815E4F-4746-4EE7-9D25-4FD71F3FE93C | pb2582301user@test.cx | pb2582301 | 2301   | Test      | J          | User     | 79 5th Avenue | New York | NY    | 10003      | USA     | 1234567890 | eng    | New Delhi | 2013-01-01 12:00PM |
    When the message is successfully processed
    Then I should see the user in the Rave database 
    And the user should be assigned to the study with the following EDC role
    | RoleName             |
    | PB2582301 EDC Role 1 |
    And the user should be assigned to the following UserGroup on the study
    | RoleName                 |
    | PB2582301 Modules Role 1 |
    And the user should have the default architect security role assigned

@PB2.5.8.27-01
Scenario: When iMedidata is used to assign specific access to a study, If user is assigned to more than one EDC role, 
            All the User accounts will have all the Architect security Group assignments.       
    Given the study with name "Study 2701 A" and environment "Prod" with UUID "74D2BE66-439C-44D9-B7C9-54DA11DFE25E" exists in the Rave database
    Given the study with name "Study 2701 B" and environment "Prod" with UUID "9A7720C0-D5A6-476A-BBF0-5DB1F2B1D94B" exists in the Rave database
    And I have an EDC app assignment with the following role
    | RoleName             |
    | PB2582701 EDC Role 1 |
    And I have an Architect Security app assignment with the following role
    | RoleName                   |
    | PB2582701 Security Group 1 |
    And I have a Modules app assignment with the following role
    | RoleName                 |
    | PB2582701 Modules Role 1 |
    And I send the following StudyInvitation messages to SQS
    | EventType | InvitationType  | StudyUuid                            | Email                 | Login     | UserId | FirstName | MiddleName | LastName | Address1      | City     | State | PostalCode | Country | Telephone  | Locale | TimeZone  | Timestamp          |
    | POST      | StudyInvitation | 74D2BE66-439C-44D9-B7C9-54DA11DFE25E | pb2582701user@test.cx | pb2582701 | 2701   | Test      | J          | User     | 79 5th Avenue | New York | NY    | 10003      | USA     | 1234567890 | eng    | New Delhi | 2013-01-01 12:00PM |
    | POST      | StudyInvitation | 9A7720C0-D5A6-476A-BBF0-5DB1F2B1D94B | pb2582701user@test.cx | pb2582701 | 2701   | Test      | J          | User     | 79 5th Avenue | New York | NY    | 10003      | USA     | 1234567890 | eng    | New Delhi | 2013-01-01 12:00PM |
    When the message is successfully processed
    Then I should see the user in the Rave database 
    And the user with EDC Role "PB2582701 EDC Role 1" should be assigned to the following studies
    | StudyName    | Uuid                                 |
    | Study 2701 A | 74D2BE66-439C-44D9-B7C9-54DA11DFE25E |
    | Study 2701 B | 9A7720C0-D5A6-476A-BBF0-5DB1F2B1D94B |
    And the user with EDC Role "PB2582701 EDC Role 1" should be assigned to the following SecurityGroup
    | RoleName                   |
    | PB2582701 Security Group 1 |
    And the user with EDC Role "PB2582701 EDC Role 1" should be assigned to the following UserGroup
    | RoleName                 |
    | PB2582701 Modules Role 1 |
    Given I have an EDC app assignment with the following role
    | RoleName             |
    | PB2582701 EDC Role 2 |
    And I have an Architect Security app assignment with the following role
    | RoleName                   |
    | PB2582701 Security Group 2 |
    Then I send the following StudyInvitation message to SQS
    | EventType | InvitationType  | StudyUuid                            | Email                 | Login     | UserId | FirstName | MiddleName | LastName | Address1      | City     | State | PostalCode | Country | Telephone  | Locale | TimeZone  | Timestamp          |
    | PUT       | StudyInvitation | 74D2BE66-439C-44D9-B7C9-54DA11DFE25E | pb2582701user@test.cx | pb2582701 | 2701   | Test      | J          | User     | 79 5th Avenue | New York | NY    | 10003      | USA     | 1234567890 | eng    | New Delhi | 2013-01-01 13:00PM |
    When the message is successfully processed
    Then the user with EDC Role "PB2582701 EDC Role 2" should be assigned to the following studies
    | StudyName    | Uuid                                 |
    | Study 2701 A | 74D2BE66-439C-44D9-B7C9-54DA11DFE25E |
     And the user with EDC Role "PB2582701 EDC Role 1" should be assigned to the following SecurityGroups
    | RoleName                   |
    | PB2582701 Security Group 1 |
    | PB2582701 Security Group 2 |
     And the user with EDC Role "PB2582701 EDC Role 2" should be assigned to the following SecurityGroups
    | RoleName                   |
    | PB2582701 Security Group 1 |
    | PB2582701 Security Group 2 |

@PB2.5.1.76-12
Scenario: If an existing iMedidata user is invited to a new Study Group without studies, a duplicate user is not created in Rave (DT # 14191)
    Given the study with name "Study 7612 A" and environment "Prod" with UUID "E8CA5368-62C6-40AC-8465-22668BD89291" exists in the Rave database
    And I have an EDC app assignment with the following roles
    | RoleName             |
    | PB2517612 EDC Role 2 |
    And I send the following StudyInvitation message to SQS
    | EventType | InvitationType  | StudyUuid                            | Email                 | Login     | UserId | FirstName | MiddleName | LastName | Address1      | City     | State | PostalCode | Country | Telephone  | Locale | TimeZone  | Timestamp          |
    | POST      | StudyInvitation | E8CA5368-62C6-40AC-8465-22668BD89291 | pb2517612user@test.cx | pb2517612 | 7612   | Test      | J          | User     | 79 5th Avenue | New York | NY    | 10003      | USA     | 1234567890 | eng    | New Delhi | 2013-01-01 12:00PM |
    When the message is successfully processed
    Then I should see the user in the Rave database
    And the user should have the ExternalSystem iMedidata
    And there should be 1 active internal user for the external user
    Given I have an EDC app assignment with the following roles
    | RoleName             |
    | PB2517612 EDC Role 1 |
    And I send the following StudyInvitation message to SQS
    | EventType | InvitationType       | StudyUuid                            | Email                 | Login     | UserId | FirstName | MiddleName | LastName | Address1      | City     | State | PostalCode | Country | Telephone  | Locale | TimeZone  | Timestamp          |
    | POST      | StudyGroupInvitation | D7797EED-6598-4FA5-AFE2-46A340F5BD12 | pb2517612user@test.cx | pb2517612 | 7612   | Test      | J          | User     | 79 5th Avenue | New York | NY    | 10003      | USA     | 1234567890 | eng    | New Delhi | 2013-01-01 13:00PM |
    When the message is successfully processed
    Then there should be 1 active internal user for the external user

@PB2.7.5.13-20
Scenario: When a user is created in iMedidata with EDC roles, one and only one user account is created in Rave automatically for each role.
	Given the study with name "Study 1320 A" and environment "Prod" with UUID "45D66EC9-2EF3-44F2-B3B5-4BECAB61F8B7" exists in the Rave database
    And I have an EDC app assignment with the following roles
    | RoleName             |
    | PB2751320 EDC Role 1 |
    | PB2751320 EDC Role 2 |
    | PB2751320 EDC Role 3 |
    And I have an Architect Security app assignment with the following role
    | RoleName                   |
    | PB2751320 Security Group 1 |
    And I have a Modules app assignment with the following role
    | RoleName                 |
    | PB2751320 Modules Role 1 |
    And I send the following StudyInvitation message to SQS
    | EventType | InvitationType  | StudyUuid                            | Email                 | Login     | UserId | FirstName | MiddleName | LastName | Address1      | City     | State | PostalCode | Country | Telephone  | Locale | TimeZone  | Timestamp          |
    | POST      | StudyInvitation | 45D66EC9-2EF3-44F2-B3B5-4BECAB61F8B7 | pb2751320user@test.cx | pb2751320 | 1320   | Test      | J          | User     | 79 5th Avenue | New York | NY    | 10003      | USA     | 1234567890 | eng    | New Delhi | 2013-01-01 12:00PM |
    When the message is successfully processed
    Then I should see the user in the Rave database
    And an internal user with role "PB2751320 EDC Role 1" exists
    And the user with EDC Role "PB2751320 EDC Role 1" should be assigned to the following studies
    | StudyName    | Uuid                                 |
    | Study 1320 A | 45D66EC9-2EF3-44F2-B3B5-4BECAB61F8B7 |
    And an internal user with role "PB2751320 EDC Role 2" exists
    And the user with EDC Role "PB2751320 EDC Role 2" should be assigned to the following studies
    | StudyName    | Uuid                                 |
    | Study 1320 A | 45D66EC9-2EF3-44F2-B3B5-4BECAB61F8B7 |
    And an internal user with role "PB2751320 EDC Role 3" exists
    And the user with EDC Role "PB2751320 EDC Role 3" should be assigned to the following studies
    | StudyName    | Uuid                                 |
    | Study 1320 A | 45D66EC9-2EF3-44F2-B3B5-4BECAB61F8B7 |
	
@PB2.5.7.5-03
Scenario: When a user is removed from a Study Group and re invited to a study with EDC App only, 
        then the user should be able to navigate to Rave and account should be created appropriately in Rave.
    Given the study with name "Study 503 A" and environment "Prod" with UUID "72CF3768-402F-4EA7-8262-01D1AC323133" exists in the Rave database
    And the study with name "Study 503 B" and environment "Prod" with UUID "D760A54B-0881-427A-8FE7-60E60F3DF1D3" exists in the Rave database
    And the study with name "Study 503 C" and environment "Prod" with UUID "8763D802-29D6-4936-9DA9-BA8282D90FA8" exists in the Rave database
    And I have an EDC app assignment with the following role
    | RoleName            |
    | PB257503 EDC Role 1 |
    And I have a Modules app assignment with the following role
    | RoleName                |
    | PB257503 Modules Role 1 |
    And I send the following StudyInvitation messages to SQS
    | EventType | InvitationType       | StudyUuid                            | Email                 | Login    | UserId | FirstName | MiddleName | LastName | Address1      | City     | State | PostalCode | Country | Telephone  | Locale | TimeZone  | Timestamp          |
    | POST      | StudyGroupInvitation | FF4C1246-857E-4A45-B312-8C6AF6BE30E1 | pb257503user@test.cx  | pb257503 | 503    | Test      | J          | User     | 79 5th Avenue | New York | NY    | 10003      | USA     | 1234567890 | eng    | New Delhi | 2013-01-01 12:00PM |
    | POST      | StudyInvitation      | 72CF3768-402F-4EA7-8262-01D1AC323133 | pb257503user@test.cx  | pb257503 | 503    | Test      | J          | User     | 79 5th Avenue | New York | NY    | 10003      | USA     | 1234567890 | eng    | New Delhi | 2013-01-01 12:00PM |
    | POST      | StudyInvitation      | D760A54B-0881-427A-8FE7-60E60F3DF1D3 | pb257503user@test.cx  | pb257503 | 503    | Test      | J          | User     | 79 5th Avenue | New York | NY    | 10003      | USA     | 1234567890 | eng    | New Delhi | 2013-01-01 12:00PM |
    | POST      | StudyInvitation      | 8763D802-29D6-4936-9DA9-BA8282D90FA8 | pb257503user@test.cx  | pb257503 | 503    | Test      | J          | User     | 79 5th Avenue | New York | NY    | 10003      | USA     | 1234567890 | eng    | New Delhi | 2013-01-01 12:00PM |
    When the messages are successfully processed
    Then I should see the user in the Rave database
    And the user with EDC Role "PB257503 EDC Role 1" should be assigned to the following studies
    | StudyName   | Uuid                                 |
    | Study 503 A | 72CF3768-402F-4EA7-8262-01D1AC323133 |
    | Study 503 B | D760A54B-0881-427A-8FE7-60E60F3DF1D3 |
    | Study 503 C | 8763D802-29D6-4936-9DA9-BA8282D90FA8 |
    And the user with EDC Role "PB257503 EDC Role 1" should be assigned to the following UserGroup
    | RoleName                |
    | PB257503 Modules Role 1 |
    Given I send the following StudyInvitation messages to SQS
    | EventType | InvitationType       | StudyUuid                            | Timestamp          |
    | DELETE    | StudyGroupInvitation | FF4C1246-857E-4A45-B312-8C6AF6BE30E1 | 2013-01-01 13:00PM |
    | DELETE    | StudyInvitation      | 72CF3768-402F-4EA7-8262-01D1AC323133 | 2013-01-01 13:00PM |
    | DELETE    | StudyInvitation      | D760A54B-0881-427A-8FE7-60E60F3DF1D3 | 2013-01-01 13:00PM |
    | DELETE    | StudyInvitation      | 8763D802-29D6-4936-9DA9-BA8282D90FA8 | 2013-01-01 13:00PM |
    When the messages are successfully processed
    Then the user with EDC Role "PB257503 EDC Role 1" should not be assigned to the following studies
    | StudyName   | Uuid                                 |
    | Study 503 A | 72CF3768-402F-4EA7-8262-01D1AC323133 |
    | Study 503 B | D760A54B-0881-427A-8FE7-60E60F3DF1D3 |
    | Study 503 C | 8763D802-29D6-4936-9DA9-BA8282D90FA8 |
    And the user should have the iMedidataEDC user group assigned
    Given I have an EDC app assignment only with the following role
    | RoleName            |
    | PB257503 EDC Role 1 |
    And I send the following StudyInvitation message to SQS
    | EventType | InvitationType       | StudyUuid                            | Email                 | Login    | UserId | FirstName | MiddleName | LastName | Address1      | City     | State | PostalCode | Country | Telephone  | Locale | TimeZone  | Timestamp          |
    | POST      | StudyInvitation      | 72CF3768-402F-4EA7-8262-01D1AC323133 | pb257503user@test.cx  | pb257503 | 503    | Test      | J          | User     | 79 5th Avenue | New York | NY    | 10003      | USA     | 1234567890 | eng    | New Delhi | 2013-01-01 14:00PM |
    When the message is successfully processed
    Then the user with EDC Role "PB257503 EDC Role 1" should be assigned to the following studies
    | StudyName   | Uuid                                 |
    | Study 503 A | 72CF3768-402F-4EA7-8262-01D1AC323133 |
    And the user with EDC Role "PB257503 EDC Role 1" should not be assigned to the following studies
    | StudyName   | Uuid                                 |
    | Study 503 B | D760A54B-0881-427A-8FE7-60E60F3DF1D3 |
    | Study 503 C | 8763D802-29D6-4936-9DA9-BA8282D90FA8 |

@PB2.5.9.33-06
  Scenario: When user is invited to study for one app, and gets re-invited to a second app then the user should be 
            assigned to the second app appropriately.  
    Given the study with name "Study 3306 A" and environment "Prod" with UUID "9E26D64B-474D-4DD4-A368-F3EC82E505B3" exists in the Rave database
    And I have an EDC app assignment with the following role
    | RoleName             |
    | PB2593306 EDC Role 1 |
    And I send the following StudyInvitation message to SQS
    | EventType | InvitationType  | StudyUuid                            | Email                 | Login     | UserId | FirstName | MiddleName | LastName | Address1      | City     | State | PostalCode | Country | Telephone  | Locale | TimeZone  | Timestamp          |
    | POST      | StudyInvitation | 9E26D64B-474D-4DD4-A368-F3EC82E505B3 | pb2593306user@test.cx | pb2593306 | 3306   | Test      | J          | User     | 79 5th Avenue | New York | NY    | 10003      | USA     | 1234567890 | eng    | New Delhi | 2013-01-01 12:00PM |
    When the message is successfully processed
    Then I should see the user in the Rave database
    And the user should be assigned to the study with the following EDC role
    | RoleName             |
    | PB2593306 EDC Role 1 |
    And the user should have the iMedidataEDC user group assigned
    Given I have an EDC app assignment with the following role
    | RoleName             |
    | PB2593306 EDC Role 1 |
    And I have a Modules app assignment with the following role
    | RoleName                 |
    | PB2593306 Modules Role 1 |
    And I send the following StudyInvitation message to SQS
    | EventType | InvitationType  | StudyUuid                            | Email                 | Login     | UserId | FirstName | MiddleName | LastName | Address1      | City     | State | PostalCode | Country | Telephone  | Locale | TimeZone  | Timestamp          |
    | PUT       | StudyInvitation | 9E26D64B-474D-4DD4-A368-F3EC82E505B3 | pb2593306user@test.cx | pb2593306 | 3306   | Test      | J          | User     | 79 5th Avenue | New York | NY    | 10003      | USA     | 1234567890 | eng    | New Delhi | 2013-01-01 13:00PM |
    When the message is successfully processed
    Then the user should be assigned to the following UserGroup on the study
    | RoleName                 |
    | PB2593306 Modules Role 1 |
    And the user should be assigned to the study with the following EDC role
    | RoleName             |
    | PB2593306 EDC Role 1 |
	
@PB2.5.9.33-07
  Scenario: When user is invited to a study for one app, and gets re-invited to same app but with different role then the 
            changed role should be assigned to the user appropriately.
    Given the study with name "Study 3307 A" and environment "Prod" with UUID "217B8DB6-CA4D-4839-837A-A78BB229D321" exists in the Rave database
    And I have an EDC app assignment with the following role
    | RoleName             |
    | PB2593307 EDC Role 1 |
    And I send the following StudyInvitation message to SQS
    | EventType | InvitationType  | StudyUuid                            | Email                 | Login     | UserId | FirstName | MiddleName | LastName | Address1      | City     | State | PostalCode | Country | Telephone  | Locale | TimeZone  | Timestamp          |
    | POST      | StudyInvitation | 217B8DB6-CA4D-4839-837A-A78BB229D321 | pb2593307user@test.cx | pb2593307 | 3307   | Test      | J          | User     | 79 5th Avenue | New York | NY    | 10003      | USA     | 1234567890 | eng    | New Delhi | 2013-01-01 12:00PM |
    When the message is successfully processed
    Then I should see the user in the Rave database
    And the user should be assigned to the study with the following EDC role
    | RoleName             |
    | PB2593307 EDC Role 1 |
    And the user should have the iMedidataEDC user group assigned
    Given I have an EDC app assignment with the following role
    | RoleName             |
    | PB2593307 EDC Role 2 |
    And I send the following StudyInvitation message to SQS
    | EventType | InvitationType  | StudyUuid                            | Email                 | Login     | UserId | FirstName | MiddleName | LastName | Address1      | City     | State | PostalCode | Country | Telephone  | Locale | TimeZone  | Timestamp          |
    | PUT       | StudyInvitation | 217B8DB6-CA4D-4839-837A-A78BB229D321 | pb2593307user@test.cx | pb2593307 | 3307   | Test      | J          | User     | 79 5th Avenue | New York | NY    | 10003      | USA     | 1234567890 | eng    | New Delhi | 2013-01-01 13:00PM |
    When the message is successfully processed
    Then the user should be assigned to the study with the following EDC role
    | RoleName             |
    | PB2593307 EDC Role 2 |
    And the user should not be assigned to the study with the following EDC role
    | RoleName             |
    | PB2593307 EDC Role 1 |
    And the user should have the iMedidataEDC user group assigned
	
@PB2.5.9.29-04
Scenario: If the user has access to a Study Site in Rave that is linked with iMedidata and the users EDC Role is changed, 
        the Study Site will be accessible to the User on Rave.
	Given the study with name "Study 2904 B" and environment "Prod" with UUID "4DCFC098-13CA-46D3-8148-2EEA10923872" exists in the Rave database
    And the Site with name "Site 2904 B1" and site number "2592904B1" exists in the Rave database
    And the StudySite with ExternalId "2904" exists in the Rave database
    And I have an EDC app assignment with the following role
    | RoleName             |
    | PB2593307 EDC Role 1 |
    And I have a Modules app assignment with the following role
    | RoleName                 |
    | PB2593307 Modules Role 1 |
    And I send the following StudyInvitation message to SQS
    | EventType | InvitationType  | StudyUuid                            | Email                 | Login     | UserId | FirstName | MiddleName | LastName | Address1      | City     | State | PostalCode | Country | Telephone  | Locale | TimeZone  | Timestamp          |
    | POST      | StudyInvitation | 4DCFC098-13CA-46D3-8148-2EEA10923872 | pb2592904user@test.cx | pb2592904 | 2904   | Test      | J          | User     | 79 5th Avenue | New York | NY    | 10003      | USA     | 1234567890 | eng    | New Delhi | 2013-01-01 12:00PM |   
    When the message is successfully processed
    Then an internal user with role "PB2593307 EDC Role 1" exists
    Given I send the following UserStudySite message to SQS
    | EventType | Timestamp          |
    | POST      | 2013-01-01 13:00PM |
    When the message is successfully processed
    Then I should see the UserStudySite assignment in the Rave database
    Given I have an EDC app assignment with the following role
    | RoleName             |
    | PB2593307 EDC Role 2 |
    And I send the following StudyInvitation message to SQS
    | EventType | InvitationType  | StudyUuid                            | Email                 | Login     | UserId | FirstName | MiddleName | LastName | Address1      | City     | State | PostalCode | Country | Telephone  | Locale | TimeZone  | Timestamp          |
    | POST      | StudyInvitation | 4DCFC098-13CA-46D3-8148-2EEA10923872 | pb2592904user@test.cx | pb2592904 | 2904   | Test      | J          | User     | 79 5th Avenue | New York | NY    | 10003      | USA     | 1234567890 | eng    | New Delhi | 2013-01-01 13:00PM |  
    When the message is successfully processed
    Then an internal user with role "PB2593307 EDC Role 2" exists
    And I should see the UserStudySite assignment in the Rave database

@PB2.5.8.28-04Bwip
Scenario: Operations on studies, sites, studysites, users, study assignments, studysite assignments must be audited in the 'name' 
          of the user that did the original action in iMedidata.

	#Given I am an existing iMedidata User "<iMedidata User 1 ID>"
	#And I am a Study Group owner
	#And I am logged in
	#And I created a new Study named "<Study A>"
	#And I created a new Site named  "<Site A>"
	#And I created a new Site named  "<Site B>"
	#And I have invited a new iMedidata user with Email "<iMedidata User 2 Email>"
	#And new iMedidata username is "<iMedidata User 2 ID>"
    #And new iMedidata username "<iMedidata User 2 ID>" is invited to the Study "<Study A>" for App "<EDC App>" with Role "<EDC Role 1>" for App "<Modules App>" with Role "<Modules Role 1>" as Study owner
	#And the new iMedidata username "<iMedidata User 2 ID>" accept the invitation
	#And I am login as iMedidata username "<iMedidata User 2 ID>" 
	#And I assigned to iMedidata Study named "<Study A>"
    #And I assigned to iMedidata Site named "<Site A>"
	#And I assigned to iMedidata Site named "<Site B>"
	#And I access the "<Modules App>" for Study "<Study A>
	#And I am on Rave Study "<Study A>" home Page
	#And I see Sites "<Site A>" and "<Site B>"
	#And I navigate to "<Site A>"
	#And I create a new subject "New Subject A"
	#And I navigate to Reporter Module
	#And I am assigned to the "Audit Trail Report" in Rave
	#And I navigate to the Rave Home page
	#And I select "Reporter" link from the Installed Modules section
	#And I should be on "My Reports" page
	#And I select "Audit Trail Report" report link
	#And I select Rave Study named "<Study A>" from Report Parameters section
	#And I select Rave study Site "<Site A>"
	#And I select Rave study Site "<Site B>"
	#And I click on Submit Report button
	#When "Audit Trail Report" for "<Study A>" opened
	#Then I should see that the original actions in iMedidata are audited
	#And I should see iMedidata Study named "<Study A>" is displayed on the report page 
	#And I should see iMedidata Site named "<Site A>" on the report
	#And I should see iMedidata Site named "<Site B>" on the report
	#And I should see a audit data in "Audit Action Type" column
	#And I should see a audit data in "Audit Action" column
	#And I should see a data for the created subject "New Subject A" on the report
	#And I take a screenshot (take as many screenshots as needed)
	#And I close the Audit Trail Report" report
	#And I navigate to the subject "New Subject A" home page
	#And I update subject name to "Updated Subject A"
	#And I save changes
	#And I select link iMedidata
	#And I am back on iMedidata Home page
	#And I navigate to Manage Study "<Study A>"page
	#And I have updated iMedidata Study named "<Study Azz>"
    #And I have updated iMedidata Site named "<Site Azz>"
	#And I have updated iMedidata Site named "<Site Bzz>"
	#And I change the EDC Role assignment to with Role "<EDC Role 2>"
	#And save changes
	#And I navigate to iMedidata Home page
	#And I access the "<Modules App>" App through iMedidata
	#And I am on Rave Home page
	#And I should see Site named "<Site Azz>" and  Site named "<Site Bzz>"
	#And I have assigned to the "Audit Trail Report"
	#And I select "Reporter" link from the Installed Modules section
	#And I select "Audit Trail Report" report link
	#And I select Rave Study named "<Study Azz>" from Report Parameters section
	#And I select Rave study Site "<Site Azz>"
	#And I select Rave study Site "<Site Bzz>"
	#And I click on Submit Report button
	#And I should see the "Audit Trail Report" for "<Study Azz>"
	#And I should see iMedidata Study named "<Study Azz>" is displayed on the report page 
	#And I should see iMedidata Site named "<Site Azz>" on the report
	#And I should see iMedidata Site named "<Site Bzz>" on the report
	#And I should see a audit data in "Audit Action Type" column
	#And I should see a audit data in "Audit Action" column
	#And I take a screenshot (take as many screenshots as needed)
	#And I close the Audit Trail Report" report

@PB2.5.1.74-02(B)
Scenario: When merging iMedidata created and non-transitioned accounts, all Rave user Saved Report assignments of that internal user account should be
          copied to newly created external user role in Rave.  The handling of account data should be fully transparent to the user.	 

    Given the study with name "Study 7402B A" and environment "Prod" with UUID "39CCB4A6-D154-43CB-A235-16CAAFC0E890" exists in the Rave database
    And the internal User with login "pb2517402Buser" exists in the Rave database
    And an EDC Role with Name "PB2517402B EDC Role 1" exists in the Rave database
    And the current User is assigned to the current Study with current Role
    And the internal user is assigned to the Audit Trail report
    And I have an EDC app assignment with the following role
    | RoleName             |
    | PB2517402 EDC Role 1 |
    And I send the following StudyInvitation message to SQS
    | EventType | InvitationType  | StudyUuid                            | Email                  | Login      | UserId | FirstName | MiddleName | LastName | Address1      | City     | State | PostalCode | Country | Telephone  | Locale | TimeZone  | Timestamp          |
    | POST      | StudyInvitation | 39CCB4A6-D154-43CB-A235-16CAAFC0E890 | pb2592904Buser@test.cx | pb2592904B | 2904   | Test      | J          | User     | 79 5th Avenue | New York | NY    | 10003      | USA     | 1234567890 | eng    | New Delhi | 2013-01-01 12:00PM |
    When the message is successfully processed
    And the iMedidata user links their account to the Rave User
    Then the iMedidata User should have the Audit Trail report assigned

@PB2.5.1.74-02(C)
Scenario: When merging iMedidata created and non-transitioned accounts, all Rave user Saved Report assignments of that internal 
            user account should be copied to newly created external user role in Rave. The Study assigned to the User Saved Report 
            in Rave will not be copied over if the study is not a linked study, when user is transitioned to iMedidata. 	 
    
    Given the internal study with name "Study 7402C B" and environment "Prod" exists
    And the internal User with login "pb2517402Cuser" exists in the Rave database
    And an EDC Role with Name "PB2517402C EDC Role 1" exists in the Rave database
    And the current User is assigned to the current Study with current Role
    And the internal user is assigned to the Audit Trail report
    And the iMedidata study with name "Study 7402C A" and environment "Prod" with UUID "4F7E9F24-FB97-47EC-8D49-19953EED5E1A" exists in the Rave database
	And I have an EDC app assignment with the following role
    | RoleName              |
    | PB2517402C EDC Role 1 |
    And I send the following StudyInvitation message to SQS
    | EventType | InvitationType  | StudyUuid                            | Email                  | Login      | UserId | FirstName | MiddleName | LastName | Address1      | City     | State | PostalCode | Country | Telephone  | Locale | TimeZone  | Timestamp          |
    | POST      | StudyInvitation | 4F7E9F24-FB97-47EC-8D49-19953EED5E1A | pb2517402Cuser@test.cx | pb2517402C | 7402   | Test      | J          | User     | 79 5th Avenue | New York | NY    | 10003      | USA     | 1234567890 | eng    | New Delhi | 2013-01-01 12:00PM |
    When the message is successfully processed
    And the iMedidata user links their account to the Rave User
    Then the iMedidata User should have the Audit Trail report assigned
    And the user with EDC Role "PB2517402C EDC Role 1" should not be assigned to the following internal studies
    | StudyName     | Environment |
    | Study 7402C B | Prod        |

@PB2.5.1.76-92
Scenario: As a Rave user I complete an eLearning course and my account is merged with iMedidata,then the course should be still shown as completed

    Given the iMedidata study with name "Study 7692 A" and environment "Prod" with UUID "FF1DDBF2-7661-4471-B521-41C75A35283C" exists in the Rave database
    And the internal User with login "pb2517692user" exists in the Rave database
    And an EDC Role with Name "PB2517692 EDC Role 1" exists in the Rave database
    And the current User is assigned to the current Study with current Role
    And an eLearning Course with name "PB2517692 eLearning A" exists and is assigned to the user with current study and role
    And the user completed the eLearning Course
    And I have an EDC app assignment with the following role
    | RoleName             |
    | PB2517692 EDC Role 1 |
    And I send the following StudyInvitation message to SQS
    | EventType | InvitationType  | StudyUuid                            | Email                 | Login     | UserId | FirstName | MiddleName | LastName | Address1      | City     | State | PostalCode | Country | Telephone  | Locale | TimeZone  | Timestamp          |
    | POST      | StudyInvitation | FF1DDBF2-7661-4471-B521-41C75A35283C | pb2517692user@test.cx | pb2517692 | 7692   | Test      | J          | User     | 79 5th Avenue | New York | NY    | 10003      | USA     | 1234567890 | eng    | New Delhi | 2013-01-01 12:00PM |  
    When the message is successfully processed
    And the iMedidata user links their account to the Rave User
    Then the iMedidata user with EDC Role "PB2517692 EDC Role " should be assigned to the eLearning Course
    And the course should be marked as "Completed" for the iMedidata user

@PB2.5.1.76-93
Scenario: If Internal Rave user has not completed an eLearning course and account is merged with iMedidata,then the course is required for Access.

    Given the iMedidata study with name "Study 7693 A" and environment "Prod" with UUID "6DC4FEA8-F783-44D0-9668-D806A25D23E2" exists in the Rave database
    And the internal User with login "pb2517693user" exists in the Rave database
    And an EDC Role with Name "PB2517693 EDC Role 1" exists in the Rave database
    And the current User is assigned to the current Study with current Role
    And an eLearning Course with name "PB2517693 eLearning A" exists and is assigned to the user with current study and role
    And the user did not complete the eLearning Course
    And I have an EDC app assignment with the following role
    | RoleName             |
    | PB2517693 EDC Role 1 |
    And I send the following StudyInvitation message to SQS
    | EventType | InvitationType  | StudyUuid                            | Email                 | Login     | UserId | FirstName | MiddleName | LastName | Address1      | City     | State | PostalCode | Country | Telephone  | Locale | TimeZone  | Timestamp          |
    | POST      | StudyInvitation | 6DC4FEA8-F783-44D0-9668-D806A25D23E2 | pb2517693user@test.cx | pb2517693 | 7693   | Test      | J          | User     | 79 5th Avenue | New York | NY    | 10003      | USA     | 1234567890 | eng    | New Delhi | 2013-01-01 12:00PM |  
    When the message is successfully processed
    And the iMedidata user links their account to the Rave User
    Then the iMedidata user with EDC Role "PB2517693 EDC Role " should be assigned to the eLearning Course
	
@PB2.5.1.76-94
Scenario: If internal Rave user does not start an eLearning course and account is merged with iMedidata,
          then the course is still shown as "Not Started"

    Given the iMedidata study with name "Study 7694 A" and environment "Prod" with UUID "6FFCC5D7-D2D7-4602-AA97-865FAF48E42A" exists in the Rave database
    And the internal User with login "pb2517694user" exists in the Rave database
    And an EDC Role with Name "PB2517694 EDC Role 1" exists in the Rave database
    And the current User is assigned to the current Study with current Role
    And an eLearning Course with name "PB2517694 eLearning A" exists and is assigned to the user with current study and role
    And the user did not start the eLearning Course
    And I have an EDC app assignment with the following role
    | RoleName             |
    | PB2517694 EDC Role 1 |
    And I send the following StudyInvitation message to SQS
    | EventType | InvitationType  | StudyUuid                            | Email                 | Login     | UserId | FirstName | MiddleName | LastName | Address1      | City     | State | PostalCode | Country | Telephone  | Locale | TimeZone  | Timestamp          |
    | POST      | StudyInvitation | 6FFCC5D7-D2D7-4602-AA97-865FAF48E42A | pb2517694user@test.cx | pb2517694 | 7694   | Test      | J          | User     | 79 5th Avenue | New York | NY    | 10003      | USA     | 1234567890 | eng    | New Delhi | 2013-01-01 12:00PM |  
    When the message is successfully processed
    And the iMedidata user links their account to the Rave User
    Then the iMedidata user with EDC Role "PB2517694 EDC Role " should be assigned to the eLearning Course
    And the course should be marked as "Not Started" for the iMedidata user
   
@PB2.5.1.76-95
Scenario: As Internal Rave user I am assigned to eLearning course for a particular edc role which has a status of Not Started. 
            If my account is merged with iMedidata, the eLearning course is still required and status should show as "Not Started" 
            for that particular assigned role in Rave and eLearning course not required for the second role, 
            user should be able to access Rave with the second role.

    Given the iMedidata study with name "Study 7695 A" and environment "Prod" with UUID "9DC317CE-3FE6-443A-A987-5C59B5BA5E48" exists in the Rave database
    And the internal User with login "pb2517695user" exists in the Rave database
    And an EDC Role with Name "PB2517695 EDC Role 1" exists in the Rave database
    And the current User is assigned to the current Study with current Role
    And an eLearning Course with name "PB2517695 eLearning A" exists and is assigned to the user with current study and role
    And the user did not start the eLearning Course
    And I have an EDC app assignment with the following role
    | RoleName             |
    | PB2517695 EDC Role 1 |
    | PB2517695 EDC Role 2 |
    And I send the following StudyInvitation message to SQS
    | EventType | InvitationType  | StudyUuid                            | Email                 | Login     | UserId | FirstName | MiddleName | LastName | Address1      | City     | State | PostalCode | Country | Telephone  | Locale | TimeZone  | Timestamp          |
    | POST      | StudyInvitation | 9DC317CE-3FE6-443A-A987-5C59B5BA5E48 | pb2517695user@test.cx | pb2517695 | 7695   | Test      | J          | User     | 79 5th Avenue | New York | NY    | 10003      | USA     | 1234567890 | eng    | New Delhi | 2013-01-01 12:00PM |  
    When the message is successfully processed
    And the iMedidata user links their account to the Rave User
    Then the iMedidata user with EDC Role "PB2517695 EDC Role 1" should be assigned to the eLearning Course
    And the course should be marked as "Not Started" for the iMedidata user
    And the iMedidata user with EDC Role "PB2517695 EDC Role 2" should not be assigned to the eLearning Course
   
@PB2.5.1.76-96
Scenario: If internal Rave user has not started eLearning course and the course is overriden, when account is merged with iMedidata,
          then the course should not be shown as "Not Started" and not required.

    Given the iMedidata study with name "Study 7696 A" and environment "Prod" with UUID "A01A0BA9-2B88-430F-9FC8-1D9C9903F8F2" exists in the Rave database
    And the internal User with login "pb2517696user" exists in the Rave database
    And an EDC Role with Name "PB2517696 EDC Role 1" exists in the Rave database
    And the current User is assigned to the current Study with current Role
    And an eLearning Course with name "PB2517696 eLearning A" exists and is assigned to the user with current study and role
    And the user did not start the eLearning Course
    And the eLearning course assignment is overridden
    And I have an EDC app assignment with the following role
    | RoleName             |
    | PB2517696 EDC Role 1 |
    And I send the following StudyInvitation message to SQS
    | EventType | InvitationType  | StudyUuid                            | Email                 | Login     | UserId | FirstName | MiddleName | LastName | Address1      | City     | State | PostalCode | Country | Telephone  | Locale | TimeZone  | Timestamp          |
    | POST      | StudyInvitation | A01A0BA9-2B88-430F-9FC8-1D9C9903F8F2 | pb2517696user@test.cx | pb2517696 | 7696   | Test      | J          | User     | 79 5th Avenue | New York | NY    | 10003      | USA     | 1234567890 | eng    | New Delhi | 2013-01-01 12:00PM |  
    When the message is successfully processed
    And the iMedidata user links their account to the Rave User
    Then the iMedidata user with EDC Role "PB2517696 EDC Role 1" should not be assigned to the eLearning Course
   
@PB2.5.1.76-97
Scenario: If Internal Rave user has not completed (Incomplete) an eLearning course and override the course,when account is merged
           with iMedidata,then the course is not required

    Given the iMedidata study with name "Study 7697 A" and environment "Prod" with UUID "A0CC794C-9F02-4F5D-A0D7-85B2A8F12D08" exists in the Rave database
    And the internal User with login "pb2517697user" exists in the Rave database
    And an EDC Role with Name "PB2517697 EDC Role 1" exists in the Rave database
    And the current User is assigned to the current Study with current Role
    And an eLearning Course with name "PB2517697 eLearning A" exists and is assigned to the user with current study and role
    And the user did not complete the eLearning Course
    And the eLearning course assignment is overridden
    And I have an EDC app assignment with the following role
    | RoleName             |
    | PB2517697 EDC Role 1 |
    And I send the following StudyInvitation message to SQS
    | EventType | InvitationType  | StudyUuid                            | Email                 | Login     | UserId | FirstName | MiddleName | LastName | Address1      | City     | State | PostalCode | Country | Telephone  | Locale | TimeZone  | Timestamp          |
    | POST      | StudyInvitation | A0CC794C-9F02-4F5D-A0D7-85B2A8F12D08 | pb2517697user@test.cx | pb2517697 | 7697   | Test      | J          | User     | 79 5th Avenue | New York | NY    | 10003      | USA     | 1234567890 | eng    | New Delhi | 2013-01-01 12:00PM |  
    When the message is successfully processed
    And the iMedidata user links their account to the Rave User
    Then the iMedidata user with EDC Role "PB2517697 EDC Role 1" should be assigned to the eLearning Course
    And the course should be marked as "Incomplete" for the iMedidata user
    And the course should be marked overridden

@PB2.5.8.29-01wip
Scenario: When a user in iMedidata has multiple accounts in Rave and is assigned to a security group in iMedidata,
           then all user accounts for the iMedidata user are updated with the security group assignment.
 
	#Given I am an iMedidata User
	#And I am logged in
	#And my Username is "<iMedidata User 1 ID>" in iMedidata
	#And there is an iMedidata Study Group  "<Study Group>"
	#And there is an iMedidata Study  "<Study A>" in the Study Group  "<Study Group>"
	#And I have an assignment to Study "<Study A>" for App "<Edc App>" Role "<EDC Role 1>" "<EDC Role 2>"
	#And I have an assignment to Study "<Study A>" for App "<Modules App>" Role "<Modules Role 1>"
	#And I have an assignment to Study "<Study A>" for App "<Security App>" Role "<Security Group 1>"
	#And I follow app "<EDC App>" for study "<Study A>"
	#And I on Role Selection page
	#And I select the Role "<EDC Role 1>" 
	#And I click on Continue button
	#And I am on Rave Study Home page
	#When I navigate to User Adminstration
	#And I search for user"<iMedidata User 1 ID>" Authenticator "iMedidata"
	#Then I should see 2 search results for "<iMedidata User 1 ID>"
	#And I navigate to User Details page for Edc Role "<EDC Role 1>"
	#And I should see "<Security Group 1>"
	#And I take a Screenshot
	#And I select "Go Back" Lik
	#And I navigate to User Details page for EDC Role "<EDC Role 2>"
	#And I should see "<Security Group 1>"
	#And I take a Screenshot