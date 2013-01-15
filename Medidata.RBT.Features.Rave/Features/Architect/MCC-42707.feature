@MCC-42707
@ignore
Feature: When configuring Coder settings, the settings are preserved even after changes are made to the data point settings on form designer.


Background:

    Given role "MCC-42707_SUPERROLE" exists
    Given xml draft "MCC-42707.xml" is Uploaded
    Given study "MCC-42707" is assigned to Site "Site 1"
    Given following Project assignments exist
    | User         | Project   | Environment | Role               | Site   | SecurityRole          |
    | SUPER USER 1 | MCC-42707 | Live: Prod  | MCC-42707_SUPERROLE| Site 1 | Project Admin Default | 
    Given I login to Rave with user "SUPER USER 1"


@PBMCC41512-001
@Draft
Scenario: Verify Coder settings are maintained after changing field format on a Log form designer

Given I have congfigured Coder settings for a data point
When I make and save the changes to a Log field
Then the Coder configurations are still maintained

When I navigate to "Architect"
And I select "Project" link "MCC-42707" in "Active Projects"
And I select Draft "Draft 1"
And I navigate to "Forms"
And I select Fields for Form "CARDIOVASCULAR HISTORY AND CARDIOVASCULAR RISK FACTORS"
And I edit Field "varcheckbx3"
And I choose "CODER- AZDD" from "Coding Dictionary:"
And I click save
And I select Button "Coder Configuration"
And I choose "PRODUCT" from "Coding Level"
And I enter data for Priority and save
    | Field   | Data| 
    | Priority| 2   |
And I choose "True" for "IsApprovalRequired"
And I click save
And I choose "True" for "IsAutoApproval" 
And I click save
And I choose "TEST1" for "Supplemental Terms"
And I select button "Add Linked Field"
And I choose "VERCHECKBX" and "DRUGRECORDNUMBER" for "Supplemental Terms" 
And I select button "Add Linked Field"
And I take a screenshot
And I click Tab "CARDIOVASCULAR HISTORY AND CARDIOVASCULAR RISK FACTORS"
And I enter data for Format and save
    | Field | Data|
    | Format| $400| 
And I take a screenshot
And I edit Field "varcheckbx3"
And I select Button "Coder Configuration"
And I verify text "PRODUCT" exists for "Coding Level"
And I verify text "2" exists for "Priority"
And I verify text "True" exists for "IsApprovalRequired"
And I verify text "True" exists for "IsAutoApproval"
And I verify text "TEST1" exists for "Supplemental Terms"
And I verify text "VARCHECKBX" and "DRUGRECORDNUMBER" exists for "Component Terms"
And I take a screenshot


@PBMCC41512-002
@Draft
Scenario: Verify Coder settings are maintained after changing field format on a standard form designer
    
Given I have congfigured Coder settings for a data point
When I make and save the changes to a standard field
Then the Coder configurations are still maintained

When I navigate to "Architect"
And I select "Project" link "MCC-42707" in "Active Projects"
And I select Draft "Draft 1"
And I navigate to "Forms"
And I select Fields for Form "CARDIOVASCULAR HISTORY AND CARDIOVASCULAR RISK FACTORS"
And I edit Field "varcheckbx2"
And I choose "CODER- AZDD" from "Coding Dictionary:"
And I click save
And I select Button "Coder Configuration"
And I choose "PRODUCT" from "Coding Level"
And I enter data for Priority and save
    | Field   | Data| 
    | Priority| 3   |
And I choose "False" for "IsApprovalRequired"
And I click save
And I choose "False" for "IsAutoApproval" 
And I click save
And I choose "VARCHECKBX" for "Supplemental Terms"
And I select button "Add Linked Field"
And I choose "TEST1" and "DRUGRECORDNUMBER" for "Supplemental Terms" 
And I select button "Add Linked Field"
And I take a screenshot
And I click Tab "CARDIOVASCULAR HISTORY AND CARDIOVASCULAR RISK FACTORS"
And I edit Field "varcheckbx2"
And I enter data for Format and save
    | Field | Data|
    | Format| $400| 
And I take a screenshot
And I select Button "Coder Configuration"
And I verify text "PRODUCT" exists for "Coding Level"
And I verify text "3" exists for "Priority"
And I verify text "False" exists for "IsApprovalRequired"
And I verify text "False" exists for "IsAutoApproval"
And I verify text "VARCHECKBX" exists for "Supplemental Terms"
And I verify text "TEST1" and "DRUGRECORDNUMBER" exists for "Component Terms"
And I take a screenshot

@PBMCC41512-003
@Draft
Scenario: Verify Coder settings are maintained after changing Coding Dictionary on a log form designer
    
Given I have congfigured Coder settings for a data point
When I make and save the changes to a standard field
Then the Coder configurations are still maintained

When I navigate to "Architect"
And I select "Project" link "MCC-42707" in "Active Projects"
And I select Draft "Draft 1"
And I navigate to "Forms"
And I select Fields for Form "CARDIOVASCULAR HISTORY AND CARDIOVASCULAR RISK FACTORS"
And I edit Field "varcheckbx"
And I choose "CODER-AZDD" from "Coding Dictionary:"
And I click Save
And I select Button "Coder Configuration"
And I choose "PRODUCT" from "Coding Level"
And I enter data for Priority and save
    | Field   | Data| 
    | Priority| 4   |
And I choose "True" for "IsApprovalRequired"
And I click save
And I choose "True" for "IsAutoApproval" 
And I click save
And I choose "VARCHECKBX3" for "Supplemental Terms"
And I select button "Add Linked Field"
And I choose "VARCHECKBX2" and "SOURCE" for "Supplemental Terms" 
And I select button "Add Linked Field"
And I take a screenshot
And I click Tab "CARDIOVASCULAR HISTORY AND CARDIOVASCULAR RISK FACTORS"
And I edit Field "varcheckbx"
And I choose "CODER-WHODRUGB2" from "Coding Dictionary:"
And I click Save
And I choose "CODER-AZDD" from "Coding Dictionary:"
And I click Save
And I select Button "Coder Configuration"
And I verify text "PRODUCT" exists for "Coding Level"
And I verify text "4" exists for "Priority"
And I verify text "True" exists for "IsApprovalRequired"
And I verify text "True" exists for "IsAutoApproval"
And I verify text "VARCHECKBX3" exists for "Supplemental Terms"
And I verify text "VARCHECKBX2" and "SOURCE" exists for "Component Terms"
And I take a screenshot

@PBMCC41512-04
@Draft
Scenario: Verify local setting in Coder is maintained after changing format on a log form designer

Given I have congfigured Coder settings for a data point
When I make and save the changes to a standard field
Then the Coder configurations are still maintained

When I navigate to "Architect"
And I select "Project" link "MCC-42707" in "Active Projects"
And I select Draft "Draft 1"
And I navigate to "Forms"
And I select Fields for Form "ETE2"
And I edit Field "ETE2"
And I choose "CODER-MedDRA" from "Coding Dictionary:"
And I click save
And I select Button "Coder Configuration"
And I choose "jpn" from "Locale"
And I choose "SOC" from "Coding Level"
And I enter data for Priority and save
    | Field   | Data| 
    | Priority| 3   |
And I take a screenshot
And I click Tab "ETE2"
And I edit Field "ETE2"
And I enter data for Format and save
    | Field | Data|
    | Format| $400| 
And I take a screenshot
And I select Button "Coder Configuration"
Then I verify text "jpn" exists for "Locale"
And I verify text "SOC" exists for "Coding Level"
And I verify text "3" exists for "Priority"
And I take a screenshot

@PBMCC41512-05
@Draft
Scenario: Verify Locale setting in Coder is maintained after changing Coding Dictionary on a log form designer

Given I have congfigured Coder settings for a data point
When I make and save the changes to a standard field
Then the Coder configurations are still maintained

When I navigate to "Architect"
And I select "Project" link "MCC-42707" in "Active Projects"
And I select Draft "Draft 1"
And I navigate to "Forms"
And I select Fields for Form "ETE2"
And I edit Field "LogCompField1"
And I choose "CODER-MedDRA" from "Coding Dictionary:"
And I click save
And I select Button "Coder Configuration"
And I choose "jpn" from "Locale"
And I choose "SOC" from "Coding Level"
And I enter data for Priority and save
    | Field   | Data| 
    | Priority| 2   |
And I take a screenshot
And I click Tab "ETE2"
And I edit Field "LogCompField1"
And I choose "CODER-AZDD" from "Coding Dictionary:"
And I click Save
And I choose "CODER-MedDRA" from "Coding Dictionary:"
And I click Save
And I take a screenshot
And I select Button "Coder Configuration"
Then I verify text "jpn" exists for "Locale"
And I verify text "SOC" exists for "Coding Level"
And I verify text "2" exists for "Priority"
And I take a screenshot
