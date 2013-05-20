@FT_MCC-46847
@ignore
Feature: MCC-46847 Annotated PDFs cannot display all dictionary entries for Dictionaries with a large Number of Entries.
As a Rave User with access to PDF generator and a study with a log form in the PDF generator
I want to have the option to generate the PDFs
so that I can verify Annotated PDFs display all dictionary entries for Dictionaries with a large Number of Entries

Background:
	Given xml draft "MCC-46847_Draft_1.xml" is Uploaded
	Given following PDF Configuration Profile Settings exist
		| Profile Name |
		| MCC46847PDF  |	
	Given Site "Site_A" exists
	Given study "MCC-46847" is assigned to Site "Site_A"
	Given role "SUPER ROLE 1" exists
	Given I publish and push eCRF "MCC-46847_Draft_1.xml" to "Version 1"
	Given following Project assignments exist
		| User         | Project   | Environment | Role         | Site   | SecurityRole          |
		| SUPER USER 1 | MCC-46847 | Live: Prod  | SUPER ROLE 1 | Site_A | Project Admin Default |
		
@release_2013.2.0
@PB_MCC_46847_01
@VR20.MAY.2013
@Validation
Scenario: PB_MCC_46847_01, A blank Annotated PDF that is generated should properly display all dictionary entries for Dictionaries with a large Number of Entries.

	Given I login to Rave with user "SUPER USER 1"
	And I navigate to "PDF Generator" module
	When I create Blank PDF
		| Name                         | Profile     | Study     | Role         | Locale  | CRFVersion |
		| Blank PDF A{RndNum<num5>(3)} | MCC46847PDF | MCC-46847 | SUPER ROLE 1 | English | Version 1  |
	And I take a screenshot
	And I generate Blank PDF "Blank PDF A{Var(num5)}"
	And I wait for PDF "Blank PDF A{Var(num5)}" to complete
	And I take a screenshot
	When I View Blank PDF "Blank PDF A{Var(num5)}"
	Then the verify annotations "Values" column is displayed correctly without overlapping for form "Medical History1" and field "Body System:"
	And I take a screenshot 	
	Then the verify annotations "Values" column is displayed correctly without space for form "Medical History2" and field "Body System:"
	And I take a screenshot
	Then the verify annotations "Values" column is displayed correctly without space for form "Medical History3" and field "Body System:"
	And I take a screenshot
	Then the verify annotations "Values" column is displayed correctly without space for form "Medical History4" and field "Body System:"	
	And I take a screenshot