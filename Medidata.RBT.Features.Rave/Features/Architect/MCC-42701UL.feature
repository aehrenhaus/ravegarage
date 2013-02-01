@FT_MCC-42701
@ignore
Feature: MCC_42701 Architect download will contain Coder settings and Architect upload will save Coder settings

Background:

    Given role "SUPER ROLE 1" exists
    Given study "MCC-42701-001" exists
	Given coding dictionary "AZDD" version "Coder" exists
	Given coding dictionary "JDrug" version "Coder" exists
	Given coding dictionary "MedDRA" version "Coder" exists
	Given coding dictionary "WHODRUGB2" version "Coder" exists
	Given following coding dictionary assignments exist
		| Project       | Coding Dictionary |
		| MCC-42701-001 | AZDD              |
		| MCC-42701-001 | JDrug             |
		| MCC-42701-001 | MedDRA            |
		| MCC-42701-001 | WHODRUGB2         |
    Given study "MCC-42701-001" is assigned to Site "Site 1"
    Given following Project assignments exist
		| User         | Project       | Environment | Role         | Site   | SecurityRole          |
		| SUPER USER 1 | MCC-42701-001 | Live: Prod  | SUPER ROLE 1 | Site 1 | Project Admin Default |
 
    Given I login to Rave with user "SUPER USER 1"


@Release_2013.1.0
@PBMCC-42701-001
@SJ01.FEB.2013
@Draft

Scenario: PBMCC-42701-001 When uploading an architect spreadsheet that contains Coder settings and the URL has Coder registered, the Coder settings will be saved and the upload will be successfull
	
	When xml draft "MCC-42701-001.xml" is Uploaded
	And I take a screenshot
	And I navigate to "Architect"
	And I select "Project" link "MCC-42701-001" in "Active Projects"
	And I select Draft "Draft 001" 
	And I navigate to "Forms"
	And I select Fields for Form "MCC42701-001"
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


@Release_2013.1.0
@PBMCC-42701-003
@SJ01.FEB.2013
@Draft
Scenario: PBMCC-42701-003 When uploading an architect spreadsheet that does not contain Coder settings including coder in field level and the URL has Coder registered, the upload will be successfull
	

	When xml draft "MCC-42701-003.xml" is Uploaded without redirecting
	Then I verify text "Save successful" exists
	And I take a screenshot


@Release_2013.1.0
@PBMCC-42701-004
@SJ01.FEB.2013
@Draft
Scenario: PBMCC-42701-004When uploading an architect spreadsheet that contain same Field OID and same name for Supplemental Terms and Component Terms and the URL has Coder registered, the upload will fail and user will be provided with appropriate message

 	When xml draft "MCC-42701-004.xml" is Uploaded without redirecting
	Then I verify text "Transaction rolled back." exists
	And I verify text "Component term Field OID 'VARCHECKBX' is already configured as Supplemental term" exists
	And I take a screenshot


@Release_2013.1.0
@PBMCC-42701-005
@SJ01.FEB.2013
@Draft
Scenario: PBMCC-42701-005 When uploading an architect spreadsheet that contain name and component name for Component Terms and the URL has Coder registered, the upload will be successfull

	
	When xml draft "MCC-42701-005.xml" is Uploaded without redirecting
	And I verify text "Save successful" exists
	And I take a screenshot
	And I navigate to "Architect"
	And I select "Project" link "MCC-42701-001" in "Active Projects"
	And I select Draft "Draft 005"
	And I navigate to "Forms"
	And I select Fields for Form "MCC42701-001"
	And I edit Field "varcheckbx3"
	And I click button "Coder Configuration"
	Then I verify text "PRODUCT" exists in "Coding Level"
	And I verify text "2" exists in "Priority"
	And I verify rows exist in "Workflow Variables" table
		| Name               | Value |
		| IsApprovalRequired | True  |
		| IsAutoApproval     | True  |
		And I verify rows exist in "Component Terms" table
		| Name       | Component Name   |
		| VARCHECKBX | DRUGRECORDNUMBER |
	And I take a screenshot



@Release_2013.1.0
@PBMCC-42701-006
@SJ01.FEB.2013
@Draft
Scenario: PBMCC-42701-006 When uploading an architect spreadsheet that contain name and no component name in Component Terms and the URL has Coder registered, the upload will fail and user will be provided with appropriate message
	

	When xml draft "MCC-42701-006.xml" is Uploaded without redirecting
	Then I verify text "Transaction rolled back." exists
	And I verify text "Both Component Name and Component Term is required" exists
	And I take a screenshot

	

@Release_2013.1.0
@PBMCC-42701-007
@SJ01.FEB.2013
@Draft
Scenario: PBMCC-42701-007 When uploading an architect spreadsheet after updating coding level in coder configuration and the URL has Coder registered, upload will be successfull and updated coding level will show on Coder configuration page with the intial coding level.

	
	When xml draft "MCC-42701-007A.xml" is Uploaded without redirecting
	Then I verify text "Save successful" exists
	And I take a screenshot
	And I navigate to "Architect"
	And I select "Project" link "MCC-42701-001" in "Active Projects"
	And I select Draft "Draft 007"
	And I navigate to "Forms"
	And I select Fields for Form "MCC42701-001"
	And I edit Field "varcheckbx3"
	And I click button "Coder Configuration"
	Then I verify text "PRODUCT" exists in "Coding Level"
	And I verify text "2" exists in "Priority"
	And I verify rows exist in "Workflow Variables" table
		| Name               | Value |
		| IsApprovalRequired | False |
		| IsAutoApproval     | False |
	And I take a screenshot
	And xml draft "MCC-42701-007B.xml" is Uploaded without redirecting
	Then I verify text "Save successful" exists
	And I take a screenshot
	And I navigate to "Architect"
	And I select "Project" link "MCC-42701-001" in "Active Projects"
	And I select Draft "Draft 007"
	And I navigate to "Forms"
	And I select Fields for Form "MCC42701-001"
	And I edit Field "varcheckbx3"
	And I click button "Coder Configuration"
	And I verify text "ATC" exists in "Coding Level"
	And I verify text "2" exists in "Priority"
	And I verify rows exist in "Workflow Variables" table
		| Name               | Value |
		| IsApprovalRequired | True  |
		| IsAutoApproval     | True  |
	And I take a screenshot


@Release_2013.1.0
@PBMCC-42701-008
@SJ01.FEB.2013
@Draft
Scenario: PBMCC-42701-008 When uploading an architect spreadsheet that assigned coder dictionary to a field and have no Coder settings for the URL which Coder registered, the upload will fail and user will be provided with appropriate message
	
	
	When xml draft "MCC-42701-008.xml" is Uploaded without redirecting
	Then I verify text "Transaction rolled back." exists
	And I verify text "Field with OID 'VARCHECKBX3' is configured to use coding dictionary but coder configuration for this field was not found." exists
	And I take a screenshot


@Release_2013.1.0
@PBMCC-42701-009
@SJ01.FEB.2013
@Draft
Scenario: PBMCC-42701-009 When uploading an architect spreadsheet that assigned coder dictionary to a field and does not contain Coder settings for CoderConfiguration tab and have Coder settings for the URL which Coder is registered, the upload will fail and user will be provided with appropriate message


	When xml draft "MCC-42701-009.xml" is Uploaded without redirecting
	Then I verify text "Transaction rolled back." exists
	And I verify text "Field with OID 'CODERTERM1' is configured to use coding dictionary but coder configuration for this field was not found." exists
	And I verify text "CoderConfiguration not found for Field OID 'VARCHECKBX3'" exists
	And I verify text "CoderConfiguration not found for Field OID 'VARCHECKBX3'" exists
	And I take a screenshot


@Release_2013.1.0
@PBMCC-42701-010
@SJ01.FEB.2013
@Draft
Scenario: PBMCC-42701-010 When uploading an architect spreadsheet which contains same field name for SupplementalTerms and ComponentTerms and the URL has Coder registered, the upload will fail and user will be provided with appropriate message

	
	When xml draft "MCC-42701-010A.xml" is Uploaded without redirecting
	Then I verify text "Save successful" exists
	And I take a screenshot
	And I navigate to "Architect"
	And I select "Project" link "MCC-42701-001" in "Active Projects"
	And I select Draft "Draft 010"
	And I navigate to "Forms"
	And I select Fields for Form "MCC42701-001"
	And I edit Field "varcheckbx3"
	And I click button "Coder Configuration"
	Then I verify text "PRODUCT" exists in "Coding Level"
	And I verify text "3" exists in "Priority"
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
	When xml draft "MCC-42701-010B.xml" is Uploaded without redirecting
	Then I verify text "Transaction rolled back." exists
	And I verify text "Supplemental term Field OID 'VARCHECKBX' is already configured as Component term" exists
	And I take a screenshot


@Release_2013.1.0
@PBMCC-42701-011
@SJ01.FEB.2013
@Draft
Scenario: PBMCC-42701-011 When uploading an architect spreadsheet by changing Coding Level and the URL has Coder registered, the upload will fail and user will be provided with appropriate message


	When xml draft "MCC-42701-011A.xml" is Uploaded without redirecting
	Then I verify text "Save successful" exists
	And I take a screenshot
	And I navigate to "Architect"
	And I select "Project" link "MCC-42701-001" in "Active Projects"
	And I select Draft "Draft 011"
	And I navigate to "Forms"
	And I select Fields for Form "MCC42701-001"
	And I edit Field "varcheckbx3"
	And I click button "Coder Configuration"
	Then I verify text "PRODUCT" exists in "Coding Level"
	And I verify text "2" exists in "Priority"
	And I verify rows exist in "Workflow Variables" table
		| Name               | Value |
		| IsApprovalRequired | False |
		| IsAutoApproval     | False |
	And I verify rows exist in "Supplemental Terms" table
		| Name  |
		| TEST1 |
	And I verify rows exist in "Component Terms" table
		| Name       | Component Name   |
		| VARCHECKBX | DRUGRECORDNUMBER |
	And I take a screenshot
	When xml draft "MCC-42701-011B.xml" is Uploaded without redirecting
	Then I verify text "Transaction rolled back." exists
	And I verify text "Please remove all supplemental and component linked fields before changing coding level to 'ATC'." exists
	And I take a screenshot
	

@Release_2013.1.0
@PBMCC-42701-012
@SJ01.FEB.2013
@Draft
	Scenario: PBMCC-42701-012 When uploading an architect spreadsheet where a field does not have VarOID and assigned to coding dictionary and the URL has Coder registered, the upload will fail and user will be provided with appropriate message


	When xml draft "MCC-42701-012.xml" is Uploaded without redirecting
	Then I verify text "Transaction rolled back." exists
	And I verify text "Error while reading row 47. Field OID 'FIELDNOVAR' in form OID 'TESTFORM' : Label fields (those that do not reference a variable) must not reference a data dictionary, unit dictionary or coding dictionary, and must not define data format" exists
	And I verify text "Field OID 'FIELDNOVAR' is invalid." exists
	And I take a screenshot


@Release_2013.1.0
@PBMCC-42701-013
@SJ01.FEB.2013
@Draft
	Scenario: @PBMCC-42701-013 When uploading an architect spreadsheet where a field does not have VarOID,format and field is not assign to coding dictionary and the URL has Coder registered, the upload will fail and user will be provided with appropriate message


	When xml draft "MCC-42701-013.xml" is Uploaded without redirecting
	Then I verify text "Transaction rolled back." exists
	And I verify text "The Field OID 'VARCHECKBX3' has not been set up as coding dictionary field" exists
	And I take a screenshot
