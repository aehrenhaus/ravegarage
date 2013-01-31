@FT_MCC-42707


Feature: MCC-42707 When configuring Coder settings, the settings are preserved even after changes are made to the data point settings on form designer.


Background:

    #Given role "MCC-42707_SUPERROLE" exists
    #Given xml draft "MCC-42707.xml" is Uploaded
    #Given study "MCC-42707" is assigned to Site "Site 1"
    #Given following Project assignments exist
    #| User         | Project   | Environment | Role               | Site   | SecurityRole          |
    #| SUPER USER 1 | MCC-42707 | Live: Prod  | MCC-42707_SUPERROLE| Site 1 | Project Admin Default | 
    #Given I login to Rave with user "SUPER USER 1"


@Release_2013.1.0
@PBMCC-42707-001
@SJ31.JAN.2013
@Draft

Scenario: PBMCC-42707-001 Verify Coder settings are maintained after changing field format on a Log form designer. 

	Given I login to Rave with user "defuser"
	When I navigate to "Architect"
	And I select "Project" link "MCC-42707" in "Active Projects"
	And I select Draft "Draft 1"
	And I navigate to "Forms"
	And I select Fields for Form "MCC42707"
	And I edit Field "varcheckbx3"
	And I choose "CODER- AZDD" from "Coding Dictionary:"
	And I select link "Save"
	And I click button "Coder Configuration"
	And I enter data in architect coder configuration and save
		| Configuration Name | Data    | Control Type |
		| Coding Level       | PRODUCT | dropdown     |
		| Priority           | 2       | textbox      |
	And I set the coder workflow variables
		| Name               | Value|
		| IsApprovalRequired | True |
		| IsAutoApproval     | True |
	And I add the coder "Supplemental" terms
		| Name |
		| TEST1|
	And I add the coder "Component" terms
		| Name       | Component Name   |
		| VARCHECKBX | DRUGRECORDNUMBER |
	And I take a screenshot
	And I select link "MCC42707"
	And I enter data in Architect Field and save
		| Field | Data | Control Type |
		| Format| $400 | textbox      |
	And I take a screenshot
	And I edit Field "varcheckbx3"
	And I click button "Coder Configuration"
	Then I verify text "PRODUCT" exists in "Coding Level"
	And I verify text "2" exists in "Priority"
	And I verify rows exist in "Workflow Variables" table
		| Name               | Value |
		| IsApprovalRequired | True  |
		| IsAutoApproval     | True  |
	And I verify rows exist in "Supplemental Terms" table
		| Name |
		| TEST1|
	And I verify rows exist in "Component Terms" table
		| Name       | Component Name   |
		| VARCHECKBX | DRUGRECORDNUMBER |
	And I take a screenshot
	And I delete the coder "Supplemental" terms
		| Name |
		| TEST1|
	And I delete the coder "Component" terms
		| Name       | Component Name   |
		| VARCHECKBX | DRUGRECORDNUMBER |
	And I take a screenshot



@Release_2013.1.0
@PBMCC-42707-002
@SJ31.JAN.2013
@Draft


Scenario: PBMCC-42707-002 Verify Coder settings are maintained after changing field format on a standard form designer.

	Given I login to Rave with user "SUPER USER 1"
	When I navigate to "Architect"
	And I select "Project" link "MCC-42707" in "Active Projects"
	And I select Draft "Draft 1"
	And I navigate to "Forms"
	And I select Fields for Form "MCC42707"
	And I edit Field "varcheckbx2"
	And I choose "CODER- AZDD" from "Coding Dictionary:"
	And I select link "Save"
	And I click button "Coder Configuration"
	And I enter data in architect coder configuration and save
		| Configuration Name | Data    | Control Type |
		| Coding Level       | PRODUCT | dropdown     |
		| Priority           | 3       | textbox      |
	And I set the coder workflow variables
		| Name               | Value|
		| IsApprovalRequired | False|
		| IsAutoApproval     | False|
	And I add the coder "Supplemental" terms
		| Name      |
		| VARCHECKBX|
	And I add the coder "Component" terms
		| Name  | Component Name   |
		| TEST1 | DRUGRECORDNUMBER |
	And I take a screenshot
	And I select link "MCC42707"
	And I edit Field "varcheckbx2"
	And I enter data in Architect Field and save
		| Field | Data | Control Type |
		| Format| $400 | textbox      |
	And I take a screenshot
	And I click button "Coder Configuration"
	Then I verify text "PRODUCT" exists in "Coding Level"
	And I verify text "3" exists in "Priority"
	And I verify rows exist in "Workflow Variables" table
		| Name               | Value |
		| IsApprovalRequired | False |
		| IsAutoApproval     | False |
	And I verify rows exist in "Supplemental Terms" table
		| Name      |
		| VARCHECKBX|
	And I verify rows exist in "Component Terms" table
		| Name  | Component Name   |
		| TEST1 | DRUGRECORDNUMBER |
	And I take a screenshot
	And I delete the coder "Supplemental" terms
		| Name      |
		| VARCHECKBX|
	And I delete the coder "Component" terms
		| Name  | Component Name   |
		| TEST1 | DRUGRECORDNUMBER |
	And I take a screenshot

@Release_2013.1.0
@PBMCC-42707-003
@SJ31.JAN.2013
@Draft
Scenario: PBMCC-42707-003 Verify Coder settings are maintained after changing Coding Dictionary on a log form designer.

	Given I login to Rave with user "SUPER USER 1"
	When I navigate to "Architect"
	And I select "Project" link "MCC-42707" in "Active Projects"
	And I select Draft "Draft 1"
	And I navigate to "Forms"
	And I select Fields for Form "MCC42707"
	And I edit Field "varcheckbx"
	And I choose "CODER- AZDD" from "Coding Dictionary:"
	And I select link "Save"
	And I click button "Coder Configuration"
	And I enter data in architect coder configuration and save
		| Configuration Name | Data    | Control Type |
		| Coding Level       | PRODUCT | dropdown     |
		| Priority           | 4       | textbox      |
	And I set the coder workflow variables
		| Name               | Value|
		| IsApprovalRequired | True |
		| IsAutoApproval     | True |
	And I add the coder "Supplemental" terms
		| Name       |
		| VARCHECKBX3|
	And I add the coder "Component" terms
		| Name        | Component Name|
		| VARCHECKBX2 | SOURCE        |
	And I take a screenshot
	And I select link "MCC42707"
	And I edit Field "varcheckbx"
	And I choose "CODER- WHODRUGB2" from "Coding Dictionary:"
	And I select link "Save"
	And I choose "CODER- AZDD" from "Coding Dictionary:"
	And I select link "Save"
	And I click button "Coder Configuration"
	Then I verify text "PRODUCT" exists in "Coding Level"
	And I verify text "4" exists in "Priority"
	And I verify rows exist in "Workflow Variables" table
		| Name               | Value |
		| IsApprovalRequired | True  |
		| IsAutoApproval     | True  |
	And I verify rows exist in "Supplemental Terms" table
		| Name       |
		| VARCHECKBX3|
	And I verify rows exist in "Component Terms" table
		| Name       | Component Name|
		| VARCHECKBX2| SOURCE        |
	And I take a screenshot
	And I delete the coder "Supplemental" terms
		| Name       |
		| VARCHECKBX3|
	And I delete the coder "Component" terms
		| Name        | Component Name|
		| VARCHECKBX2 | SOURCE        |
	And I take a screenshot

@Release_2013.1.0
@PBMCC-42707-004
@SJ31.JAN.2013
@Draft
Scenario: PBMCC-42707-004 Verify local setting in Coder is maintained after changing format on a log form designer.

	Given I login to Rave with user "SUPER USER 1"
	When I navigate to "Architect"
	And I select "Project" link "MCC-42707" in "Active Projects"
	And I select Draft "Draft 1"
	And I navigate to "Forms"
	And I select Fields for Form "ETE2"
	And I edit Field "ETE2"
	And I choose "CODER- MedDRA" from "Coding Dictionary:"
	And I select link "Save"
	And I click button "Coder Configuration"
	And I enter data in architect coder configuration and save
		| Configuration Name | Data    | Control Type |
		| Locale             | jpn     | dropdown     |
		| Coding Level       | SOC     | dropdown     |
		| Priority           | 3       | textbox      |
	And I take a screenshot
	And I select link "ETE2"
	And I edit Field "ETE2"
	And I enter data in Architect Field and save
		| Field | Data | Control Type |
		| Format| $400 | textbox      |
	And I take a screenshot
	And I click button "Coder Configuration"
	Then I verify text "jpn" exists in "Locale"
	And I verify text "SOC" exists in "Coding Level"
	And I verify text "3" exists in "Priority"
	And I take a screenshot

@Release_2013.1.0
@PBMCC-42707-005
@SJ31.JAN.2013
@Draft
Scenario: PBMCC-42707-005 Verify Locale setting in Coder is maintained after changing Coding Dictionary on a log form designer.

	Given I login to Rave with user "SUPER USER 1"
	When I navigate to "Architect"
	And I select "Project" link "MCC-42707" in "Active Projects"
	And I select Draft "Draft 1"
	And I navigate to "Forms"
	And I select Fields for Form "ETE2"
	And I edit Field "LogCompField1"
	And I choose "CODER- MedDRA" from "Coding Dictionary:"
	And I select link "Save"
	And I click button "Coder Configuration"
	And I enter data in architect coder configuration and save
		| Configuration Name | Data    | Control Type |
		| Locale             | jpn     | dropdown     |
		| Coding Level       | SOC     | dropdown     |
		| Priority           | 2       | textbox      |
	And I take a screenshot
	And I select link "ETE2"
	And I edit Field "LogCompField1"
	And I choose "CODER- AZDD" from "Coding Dictionary:"
	And I select link "Save"
	And I choose "CODER- MedDRA" from "Coding Dictionary:"
	And I select link "Save"
	And I take a screenshot
	And I click button "Coder Configuration"
	Then I verify text "jpn" exists in "Locale"
	And I verify text "SOC" exists in "Coding Level"
	And I verify text "2" exists in "Priority"
	And I take a screenshot
