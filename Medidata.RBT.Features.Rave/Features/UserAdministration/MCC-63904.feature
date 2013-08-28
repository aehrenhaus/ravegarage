﻿@MCC-63904
Feature: MCC-63904 User Loader fails completely if project name (excluding environment) includes parenthesis
	
Background:
Given role "SUPER ROLE 1" exists

@Release_2013.4.0
@PB_MCC63904-001
@PS28.AUG.2013
@Draft
Scenario: PB_MCC63904-001 As a Rave user, when I download a user loader file where one of the project names has parenthesis in it, uploading the same file back should be successful.
Given study "MCC-63904 (test)" exists
Given study "MCC-63904 (test)" is assigned to Site "Site_A"
And following Project assignments exist
| User         | Project          | Environment | Role         | Site   | SecurityRole		   |
| SUPER USER 1 | MCC-63904 (test) | Live: Prod  | SUPER ROLE 1 | Site_A |Project Admin Default |
And I login to Rave with user "SUPER USER 1"
And I navigate to "User Administration"
And I search User by seeded login
| Login            |
| SUPER USER 1	   |
And I take a screenshot
And I click the "Download" button to download
When I select link "Upload Users"
And I upload the User file that I last downloaded
Then I verify text "Upload successful." exists in "log"
And I take a screenshot



@Release_2013.4.0
@PB_MCC63904-002
@PS28.AUG.2013
@Draft
Scenario: PB_MCC63904-002 As a Rave user, when I download a user loader file where one of the project names has parenthesis in it which is the same as the target environment name, uploading the same file back should be successful.
Given study "MCC-63904 (Prod)" exists
Given study "MCC-63904 (Prod)" is assigned to Site "Site_A"
And following Project assignments exist
| User         | Project          | Environment | Role         | Site   | SecurityRole		   |
| SUPER USER 1 | MCC-63904 (Prod) | Live: Prod  | SUPER ROLE 1 | Site_A |Project Admin Default |
And I login to Rave with user "SUPER USER 1"
And I navigate to "User Administration"
And I search User by seeded login
| Login            |
| SUPER USER 1	   |
And I take a screenshot
And I click the "Download" button to download
When I select link "Upload Users"
And I upload the User file that I last downloaded
Then I verify text "Upload successful." exists in "log"
And I take a screenshot

@Release_2013.4.0
@PB_MCC63904-003
@PS28.AUG.2013
@Draft
Scenario: PB_MCC63904-003 As a Rave user, when I download a user loader file where one of the project names has multiple groups of parenthesis in it, uploading the same file back should be successful.
Given study "MCC-63904 (test) (test2)" exists
Given study "MCC-63904 (test) (test2)" is assigned to Site "Site_A"
And following Project assignments exist
| User         | Project				  | Environment | Role         | Site   | SecurityRole		   |
| SUPER USER 1 | MCC-63904 (test) (test2) | Live: Prod  | SUPER ROLE 1 | Site_A |Project Admin Default |
And I login to Rave with user "SUPER USER 1"
And I navigate to "User Administration"
And I search User by seeded login
| Login            |
| SUPER USER 1	   |
And I take a screenshot
And I click the "Download" button to download
When I select link "Upload Users"
And I upload the User file that I last downloaded
Then I verify text "Upload successful." exists in "log"
And I take a screenshot

@Release_2013.4.0
@PB_MCC63904-004
@PS28.AUG.2013
@Draft
Scenario: PB_MCC63904-004 As a Rave user, when I download a user loader file where one of the project names has multiple groups of parenthesis in it, and at least one is a reference to the current environment, uploading the same file back should be successful.
Given study "MCC-63904 (test) (Prod)" exists
Given study "MCC-63904 (test) (Prod)" is assigned to Site "Site_A"
And following Project assignments exist
| User         | Project				 | Environment | Role         | Site   | SecurityRole		   |
| SUPER USER 1 | MCC-63904 (test) (Prod) | Live: Prod  | SUPER ROLE 1 | Site_A |Project Admin Default |
And I login to Rave with user "SUPER USER 1"
And I navigate to "User Administration"
And I search User by seeded login
| Login            |
| SUPER USER 1	   |
And I take a screenshot
And I click the "Download" button to download
When I select link "Upload Users"
And I upload the User file that I last downloaded
Then I verify text "Upload successful." exists in "log"
And I take a screenshot

@Release_2013.4.0
@PB_MCC63904-005
@PS28.AUG.2013
@Draft
Scenario: PB_MCC63904-005 As a Rave user, when I download a user loader file where one of the project names have no groups of parenthesis in it, uploading the same file back should be successful.
Given study "MCC-63904" exists
Given study "MCC-63904" is assigned to Site "Site_A"
And following Project assignments exist
| User         | Project				 | Environment | Role         | Site   | SecurityRole		   |
| SUPER USER 1 | MCC-63904				 | Live: Prod  | SUPER ROLE 1 | Site_A |Project Admin Default  |
And I login to Rave with user "SUPER USER 1"
And I navigate to "User Administration"
And I search User by seeded login
| Login            |
| SUPER USER 1	   |
And I take a screenshot
And I click the "Download" button to download
When I select link "Upload Users"
And I upload the User file that I last downloaded
Then I verify text "Upload successful." exists in "log"
And I take a screenshot

