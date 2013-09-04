@MCC-66846
Feature: MCC-66846 disallow user access to Global Library (Not a Real Project)

Background:
Given role "SUPER ROLE 1" exists
Given study "MCC-66846" exists
Given study "MCC-66846" is assigned to Site "Site_A"
And following Project assignments exist
| User         | Project   | Environment | Role         | Site   | SecurityRole		    |
| SUPER USER 1 | MCC-66846 | Live: Prod  | SUPER ROLE 1 | Site_A |Project Admin Default |

@Release_2013.4.0
@PB_MCC66846-001
@PS28.AUG.2013
@Draft
Scenario: PB_MCC66846-001 As a Study Builder, if I have permission to see all Rave studies, and I navigate to architect, I should not be able to see Global Library (Not a Real Project) in my inactive study list.
Given I login to Rave with user "SUPER USER 1"
When I navigate to "Architect" module
Then I verify text "Global Library (Not a Real Project)" does not exist
And I take a screenshot

@Release_2013.4.0
@PB_MCC66846-002
@PS28.AUG.2013
@Draft
Scenario: PB_MCC66846-002 As a Study Builder, if I have permission to see all Rave studies, and I try to go to Global Library (Not a Real Project) by direct link, I should see an error and not be allowed.
Given I login to Rave with user "SUPER USER 1"
When I navigate to "Architect" module
And I take a screenshot
And I force navigate to the Library Page for study "Global Library (Not a Real Project)"
Then I verify link "Click here to show Error details" exists
And I select link "Click here to show Error details"
And I take a screenshot