﻿@MCC-52852
Feature: MCC-52852 Landscape forms will show coding result for classic coding dictionaries, but not for coder related dictionary

Background:
Given study "MCC-52852" exists
Given coding dictionary "MedDRA" version "Coder" exists with following coding columns
| Coding Column Name |
| PRODUCT            |
| ATC                |
| SOC                |
Given coding dictionary "MedDRA" coding column "PRODUCT" has following coding level components
| OID              |
| DRUGRECORDNUMBER |
Given following locales exist for the coding dictionary
| Coding Dictionary Name | Locale |
| MedDRA				 | eng	  |
Given following coding dictionary assignments exist
| Project     | Coding Dictionary |
| MCC-52852	  | MedDRA			  |
Given xml draft "MCC-52852.xml" is Uploaded
Given study "MCC-52852" is assigned to Site "Site 1"
Given role "SUPER ROLE 1" exists
Given following Project assignments exist
| User         | Project   | Environment | Role         | Site   | SecurityRole          | ExternalSystem |
| SUPER USER 1 | MCC-52852 | Live: Prod  | SUPER ROLE 1 | Site 1 | Project Admin Default | iMedidata      |
Given I publish and push eCRF "MCC-52852.xml" to "Version 1"
Given I login to Rave with user "SUPER USER 1"
Given I select Study "MCC-52852" and Site "Site 1"
Given I create a Subject
|Field        |Data              |Control Type |
|NAME         |SUB               |textbox      |

@PB_MCC-52852-001
@draft
Scenario: PB_MCC-52852-001 As a Rave user, when I navigate to a landscape log form which has coder coded datapoints, I should see the result of the coding decision on the form.
Given I select Form "CODERFORM_LAND"
And I enter data in CRF and save
| Field  | Data         | Control Type |
| CODE   | code123      | textbox      |
And I take a screenshot
And I code data points
| Project  | Subject         | Field | Uncoded Data | Coded Data | Coding Dictionary | Coding Dictionary Version | Current User |
| MCC-52852| New Subject     | CODE  | code123      | codedxyz   | MedDRA            | Coder                     | SUPER USER 1 |
When I select Form "CODERFORM_LAND"
Then I verify text "codedxyz" exists
And I take a screenshot