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
Given I login to Rave with user "SUPER USER 1"
Given I select Study "MCC-47502" and Site "Site_A"
Given I create a Subject
|Field               |Data              |Control Type |
|NAME				 |SUB               |textbox      |

@Release_2013.4.0
@PB_MCC47502-001
@PS09.AUG.2013
@Draft
Scenario: PB_MCC47502-001 As a Rave user, when I upload a large Zip file greater than 50mb into the system via the File Upload control on a Standard CRF page, then I should be able to download the file back within a reasonable time.
Given I select Form "FILEUPLOAD"
And I enter data in CRF and save
|Field          |Data           |Control Type				  |
|FILE			|MCC-47502.zip  |browser file upload button   |
And I take a screenshot
When I click the "MCC-47502.zip" button to download
Then I verify file "MCC-47502.zip" was downloaded
And I take a screenshot

@Release_2013.4.0
@PB_MCC47502-002
@PS09.AUG.2013
@Draft
Scenario: PB_MCC47502-002 As a Rave user, when I upload a large Excel file greater than 50mb into the system via the File Upload control on a Portrait Log CRF page, then I should be able to download the file back within a reasonable time.
Given I select Form "FILEUPLOAD_PORTLOG"
And I enter data in CRF and save
|Field          |Data           |Control Type				  |
|FILE			|MCC-47502.xls  |browser file upload button   |
And I take a screenshot
When I click the "MCC-47502.xls" button to download
Then I verify file "MCC-47502.xls" was downloaded
And I take a screenshot

@Release_2013.4.0
@PB_MCC47502-003
@PS09.AUG.2013
@Draft
Scenario: PB_MCC47502-003 As a Rave user, when I upload a large Pdf file greater than 50mb into the system via the File Upload control on a Mixed Log CRF page, then I should be able to download the file back within a reasonable time.
Given I select Form "FILEUPLOAD_MIXED"
And I enter data in CRF and save
|Field          |Data           |Control Type				  |
|FILE			|MCC-47502.pdf  |browser file upload button   |
And I take a screenshot
When I click the "MCC-47502.pdf" button to download
Then I verify file "MCC-47502.pdf" was downloaded
And I take a screenshot

@Release_2013.4.0
@PB_MCC47502-004
@PS09.AUG.2013
@Draft
Scenario: PB_MCC47502-004 As a Rave user, when I upload a large jpg file greater than 50mb into the system via the File Upload control on a Landscape Log CRF page, then I should be able to download the file back within a reasonable time.
Given I select Form "FILEUPLOAD_LANDLOG"
And I enter data in CRF and save
|Field          |Data           |Control Type				  |
|FILE			|MCC-47502.jpg  |browser file upload button   |
And I take a screenshot
When I click the "MCC-47502.jpg" button to download
Then I verify file "MCC-47502.jpg" was downloaded
And I take a screenshot