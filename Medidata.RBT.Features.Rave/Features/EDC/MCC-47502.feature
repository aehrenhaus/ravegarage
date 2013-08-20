@MCC-47502
Feature: MCC-47502 Large files cannot be downloaded via the fileupload control, and gets timed out

Background:
Given xml draft "MCC-47502.xml" is Uploaded
Given Site "Site_A" exists
Given study "MCC-47502" is assigned to Site "Site_A"
Given role "SUPER ROLE 1" exists
Given I publish and push eCRF "MCC-47502.xml" to "Version 1"
Given following Project assignments exist
| User          | Project   | Environment | Role         | Site   | SecurityRole          |
| SUPER USER 1  | MCC-47502 | Live: Prod  | SUPER ROLE 1 | Site_A | Project Admin Default |

@PB_MCC47502-001
Scenario: PB_MCC47502-001 As a Rave user, when I upload a large file greater than 50mb into the system via the File Upload control on a CRF page, then I should be able to download the file back within a reasonable time.
Given I login to Rave with user "SUPER USER 1"
And I select Study "MCC-47502" and Site "Site_A"
And I create a Subject
|Field               |Data              |Control Type |
|NAME				 |SUB               |textbox      |
And I select Form "FILEUPLOAD"
And I enter data in CRF and save
|Field          |Data           |Control Type				  |
|FILE			|MCC-47502.zip  |browser file upload button   |
And I take a screenshot
When I click the "MCC-47502.zip" button to download
Then I verify file "MCC-47502.zip" was downloaded
And I take a screenshot
