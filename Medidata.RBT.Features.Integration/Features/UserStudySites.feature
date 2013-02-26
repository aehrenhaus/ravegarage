Feature: UserStudySites
	In order to update users' study sites in Rave,
	I want to be able to process userstudysite messages from SQS.

@post_test_scenario_1
Scenario: When a UserStudySite message gets put onto the queue, and the user already exists in Rave, the user is updated.
	Given the User with login "testStudySiteUser1" exists in the Rave database
	And the study with name "testStudy1" and environment "prod" with ExternalId "1" exists in the Rave database
	And an EDC Role with Name "roleName1" exists in the Rave database
	And the current User is assigned to the current Study with current Role
	And the Site with site number "1" exists in the Rave database
	And the StudySite with ExternalId "1" exists in the Rave database
	And I send the following UserStudySite message to SQS	
	| EventType | Timestamp           |
	| POST      | 2012-10-12 12:00:00 |
	When the message is successfully processed
	Then I should see the UserStudySite assignment in the Rave database

@delete_test_scenario_2
Scenario: When a UserStudySite delete message gets put onto the queue, and the assignment exists, the assignment is deleted.
	Given the User with login "testStudySiteUser2" exists in the Rave database
	And the study with name "testStudy2" and environment "prod" with ExternalId "2" exists in the Rave database
	And an EDC Role with Name "roleName2" exists in the Rave database
	And the current User is assigned to the current Study with current Role
	And the Site with site number "2" exists in the Rave database
	And the StudySite with ExternalId "2" exists in the Rave database
	And I send the following UserStudySite message to SQS	
	| EventType | Timestamp           |
	| POST      | 2012-10-12 12:00:00 |
	| DELETE    | 2012-10-12 13:00:00 |
	When the message is successfully processed
	Then The user should not have a UserStudySite assignment in the Rave database

@PB2.5.9.29-03
Scenario: If the user has access to study in Rave that is linked with the study on iMedidata and if the user is unassigned to the site for the study on iMedidata then that site will be accessible in Rave, provided the user has role that has  "ViewAllSitesinSitegroup" action role checked

Given the User with login "testStudySiteUser3" exists in the Rave database
And the study with name "testStudy3" and environment "prod" with ExternalId "3" exists in the Rave database
And an EDC Role with Name "testRole3" and ViewAllSites permission exists in the Rave database
And the Site with site number "3" exists in the Rave database
And the StudySite with ExternalId "3" exists in the Rave database
And the current User is assigned to the current Study with current Role
And the current User is assigned to the the current StudySite
And I send the following UserStudySite message to SQS	
| EventType | Timestamp           |
| DELETE    | 2013-10-12 13:00:00 |
When the message is successfully processed
Then The user should not have a UserStudySite assignment in the Rave database
And the user should have an EDC Role with ViewAllSites permission

@PB2.5.9.35-01
Scenario: If an externally authenticated user does not have access to a particular site in Rave, but has been invited to a Role in Rave that permits them access to all sites, that user will see the sites in Rave in accordance with these Role settings, regardless of the site access set in iMedidata.

Given the User with login "testStudySiteUser4" exists in the Rave database

And the study with name "testStudy4" and environment "prod" with ExternalId "4" exists in the Rave database
And the iMedidata Study named"<Study C>" has Sites "<Site C1>" "<Site C2>" "<Site C3>"
And there is a Rave Study named "<Study C>"
And the Site with site number "4" exists in the Rave database
And the StudySite with ExternalId "4" exists in the Rave database

And I have an assignment to the iMedidata Study named "<Study C>" for the App named "<EDC App>" and the Role "<EDC Role 1>"
And I have an assignment to the iMedidata site named "<Site C1>" for the iMedidata study named "<Study C>"
And I follow "<EDC App>" for "<Study C>"
And I see Rave Home page for "<Site C1>"
And I follow Home Icon
And I should not see "<Site C2>" "<Site C3>"

And I have change Role assignment to the iMedidata Study named "<Study C>" for the App named "<EDC App>"  Role "<EDC Role 4>"
When I follow "<EDC App>" for "<Study C>"
Then I should be on Rave Study Home page for "<Study C>"
And I should see "<Site C1>" 
And I should see "<Site C2>" "<Site C3>"
