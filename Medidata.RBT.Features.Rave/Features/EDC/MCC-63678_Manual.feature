@FT_MCC-63678_Manual
@ignore
#Selecting Enter Button while applying Batch Signatures on Calendar or Grid View does not sign the Subject.
Feature: MCC_63678_MCC_55695_MCC_59261 Selecting Enter Button while applying Batch Signatures on Calendar or Grid View does not sign the Subject.
	As a Rave user
	When I select enter button
	Then I see no error and signature is applied

Background:
	Given xml Lab Configuration "Lab_MCC-55695.xml" is uploaded
	Given xml draft "MCC-55695.xml" is Uploaded
	Given Site "Site 1" exists
	Given study "MCC-55695" is assigned to Site "Site 1"
	Given following Project assignments exist
		| User         | Project    | Environment | Role        	 | Site   | SecurityRole          |
		| SUPER USER 1 | MCC-55695  | Live: Prod  | SUPER ROLE 1	 | Site 1 | Project Admin Default |
	Given I publish and push eCRF "MCC-55695.xml" to "Version 1"
	Given I login to Rave with user "SUPER USER 1"
	
@release_2013.2.0
@PB_MCC_63678_MCC_55695_MCC_59261_01
@manual
@Validation	
Scenario: PB_MCC_636781_MCC_55695_MCC_59261_01 As an Investigator, when I do batch sign on Subject Calendar page by selecting Enter button, then I verify text "Your signature is being applied. You may continue working on other subjects".
	
	And I create a Subject
		| Field          | Data              | Control Type |
		| Subject Name   | SUB               | textbox      |
		| Subject Number | {RndNum<num1>(5)} | textbox      |
	And I click button "Sign and Save"
	When I sign the subject with username "SUPER USER 1"
	And I select button "Enter" on kyeboard
	Then I verify text "Your signature is being applied. You may continue working on other subjects" exists
	And I take a screenshot	

@release_2013.2.0
@PB_MCC_63678_MCC_55695_MCC_59261_02
@manual
@Validation	
Scenario: PB_MCC_63678_MCC_55695_MCC_59261_02 As an Investigator, when I do batch sign on Grid View page by selecting Enter button, then I verify text "Your signature is being applied. You may continue working on other subjects".
	
	And I create a Subject
		| Field          | Data              | Control Type |
		| Subject Name   | SUB               | textbox      |
		| Subject Number | {RndNum<num1>(5)} | textbox      |
	And I select link "Grid View"		
	And I select link "All"
	And I click button "Sign and Save"
	When I sign the subject with username "SUPER USER 1"
	And I select button "Enter" on kyeboard	
	Then I verify text "Your signature is being applied. You may continue working on other subjects" exists
	And I take a screenshot		
