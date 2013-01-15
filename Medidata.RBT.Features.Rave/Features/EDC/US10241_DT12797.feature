# Sometimes, edit checks, that set review requirement for datapoints do not fire correctly.
# What happens internally is that datapoints wind up not requiring review; however, their "object statuses" show that they do require review. Datapoints wind up having a "requires review" icon, but the checkboxes for review are disabled.
# After refreshing object statuses for a given subject, the icon displays as "complete".
@FT_US10241_DT12797
Feature: US10241_DT12797 For a field that has a derivation, edit check does not set it to require review correctly in certain cases.
As a Rave user
Given I enter data
And there is an edit check that sets the data to require review
Then I should see the requires review icon for the data
And I should see the review box enabled for the data

Background:
Given xml draft "DT12797_Draft_1.xml" is Uploaded
Given study "DT12797" is assigned to Site "Site_001"
Given I publish and push eCRF "DT12797_Draft_1.xml" to "Version 1"
Given following Project assignments exist
| User         | Project | Environment | Role         | Site     | SecurityRole          |
| SUPER USER 1 | DT12797 | Live: Prod  | SUPER ROLE 1 | Site_001 | Project Admin Default |
Given review group number "<Numbers>" is active
| Numbers |
| 1       |
Given I login to Rave with user "SUPER USER 1" 


# Edit check exists to set field Visit Date on form Visit Date to require review if field Age has a value less than 18.
# Edit check exists to set field Field 1 on form Form 1 to require review if field Field 1 has a value other than 20.
# Edit check exists to set field DOB on form Form 2 to require review if field Age has a value less than 18.
# Derivation exists to derive field Age on Form 2 from field Visit Date and DOB on Form 2.

@release_2012.1.0
@PB_US10241_DT12797_01
@Validation
Scenario: PB_US10241_DT12797_01 As an EDC user, when I have an edit check fired on one field that sets another field to require review and I see the requires review icon, then I should see the review box enabled.
When I create a Subject
| Field            | Data |
| Subject Number   | 101  |
| Subject Initials | SUBJ |
And I select Form "Visit Date" in Folder "VISIT"
And I enter data in CRF
| Field      | Data        |
| Visit Date | 01 Feb 2011 |
| Age        | 20          |
And I save the CRF page
And I verify data on Fields in CRF
| Field      | Data        | Requires Review |
| Visit Date | 01 Feb 2011 | False           |
| Age        | 20          | False           |
And I enter data in CRF
| Field | Data |
| Age   | 17   |
And I save the CRF page
And I verify data on Fields in CRF
| Field      | Data        | Requires Review | Status Icon     |
| Visit Date | 01 Feb 2011 | True            | Requires Review |
| Age        | 17          | False           | Complete        |
And I verify data on current CRF
| Requires Review |
| True            |
And I take a screenshot

@release_2012.1.0
@PB_US10241_DT12797_02
@Validation
Scenario: PB_US10241_DT12797_02 As an EDC user, when I have an edit check that sets a field to require review and I see the requires review icon, I review the data for the field, and I change the data, then I should see the review box enabled.
When I create a Subject
| Field            | Data |
| Subject Number   | 102  |
| Subject Initials | SUBJ |
And I select Form "Form 1"
And I enter data in CRF
| Field   | Data |
| Field 1 | 19   |
And I save the CRF page
And I verify data on Fields in CRF
| Field   | Data | Requires Review | Status Icon     |
| Field 1 | 19   | True            | Requires Review |
And I verify data on current CRF
| Requires Review |
| True            |
And I take a screenshot
And I edit checkboxes for fields
| Field   | Review |
| Field 1 | True  |
And I save the CRF page
And I take a screenshot
And I enter data in CRF
| Field   | Data |
| Field 1 | 18   |
And I save the CRF page
And I verify data on Fields in CRF
| Field   | Data | Requires Review | Status Icon     |
| Field 1 | 18   | True            | Requires Review |
And I verify data on current CRF
| Requires Review |
| True            |
And I take a screenshot
And I click audit on Field "Field 1"
Then I verify Audits exist
| Audit Type   | Query Message  |
| User entered | '18'           |
| Un-reviewed  | Review Group 1 |
| Reviewed     | Review Group 1 |
| User entered | '19'           |

@release_2012.1.0
@PB_US10241_DT12797_03
@Validation
Scenario: PB_US10241_DT12797_03 As an EDC user, when I have an edit check fired on a field that is derived to sets another field to require review and I see the requires review icon, then I should see the review box enabled.
When I create a Subject
| Field            | Data |
| Subject Number   | 103  |
| Subject Initials | SUBJ |
And I select Form "Form 2"
And I enter data in CRF
| Field      | Data        |
| DOB        | 05 Mar 1995 |
| Visit Date | 10 Dec 2011 |
And I save the CRF page
And I verify data on Fields in CRF
| Field      | Data        | Requires Review | Status Icon     |
| DOB        | 05 Mar 1995 | True            | Requires Review |
| Visit Date | 10 Dec 2011 | False           | Complete        |
| Age        | 16          | False           | Complete        |
And I verify data on current CRF
| Requires Review |
| True            |
And I take a screenshot