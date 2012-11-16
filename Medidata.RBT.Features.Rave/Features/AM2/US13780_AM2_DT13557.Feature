@ignore
Feature: US13780_DT13557 
  As a data manager
  I want to be able to apply rules in AM Object Heirarchy
  So that I can Move Elements in AM Object Heirarchy
  I want to be able to see the correct number of elements moved

#Amendment Manger should not apply the same Object Heirarchy rules on renamed folders and folders that have an instance number which matches the number in the renamed folder.
#DT 13557 - Object Hierarchy performs incorrect rule operations on repeating instances
#The scenarios described in this feature file go under the assumption that there is at least the following:
# 1. A study design that has matrices which include folder which gets renamed numerically via an edit check ot CF.
# 2. One Source CRF version published to an environment
# 3. One subject has been created in the environment, with a numerically renamed folder and a folder added with an instance number that matches the number #in the renamed folder 
# 4. One Target CRF version published to an environment


Background:
	Given xml draft "US13780_DT13557_Draft_1.xml" is Uploaded
	Given Site "Site 1" exists
	Given study "US13780_DT13557" is assigned to Site "Site 1"
	Given I publish and push eCRF "US13780_DT13557_Draft_1.xml" to "Version 1"
	Given following Project assignments exist
		| User 		   | Project 		 | Environment| Role         | Site  | SecurityRole 		 |
		| SUPER USER 1 | US13780_DT13557 | Live: Prod | SUPER ROLE 1 | Site 1| Project Admin Default |
	#Given I am logged in as a Rave user "User1" 
	#And I have access as Rave user "User2"
	#And I have access to "Architect"
	#And I have access to "EDC"
	#And I have access to Amendment Manager
	#And I have access to Study "Study_001"
	#And I have access to Site "Site_001"
    #And I have access to Subject "Subject001"
	#And I have access to folder "Folder"
	#And I have access to folder "Folder 1"
	#And I have access to folder "Folder 2"
	#And I have access to folder "Folder 3"
	#And I have access to folder "Folder 4"
	#And I have access to folder "Folder (4)"
	#And I have access to form "Form (1)"
	
#----------------------------------------------------------------------------------------------------------------------------------------
@Rave564_2012.1.1
@PB_US13780_AM2_DT13557_01
@Draft
Scenario: US13780_AM2_DT13557_01 When a user navigates to Architect, creates a migration plan with a new CRF version as the Target CRF version, adds a Move Element object hierarchy rule with the “Only if target parent exists?box checked, in the Source patch enters "[Subject]/FOLDER:Folder(4)/FOLDER:Folder(1)/FORM:Form(1)" and in the Target Source enters "[Subject]/FOLDER:Folder 3/FOLDER:Folder(1)", and executes the migration then the user will see the form appear only in "Folder(4)"

	Given I login to Rave with user "defuser" and password "password"
	And I navigate to "Architect"
	And I select "Study" link "*US13780_DT13557" in "Active Projects"
	And I select link "Draft 1" in "CRF Drafts"
	And I publish CRF Version "Source {RndNum<TV#>(5)}"
	And I note down "crfversion" to "newversion1#"
	And I select "Study" link "*US13780_DT13557" in "Header"
	And I push CRF Version "{Var(newversion1#)}" to "All Sites"

	And I navigate to "Home"	
	And I select Study "*US13780_DT13557" and Site "Site 1"
	And I create a Subject
	| Field          | Data              | Control Type |
	| Subject Name   | SUB               | text         |
	| Subject Number | {RndNum<num1>(3)} | text         |
	And I select Form "Demographics" in Folder "Baseline"
	And I enter data in CRF and save
	    | Field  | Data | Control Type |
	    | Gender | Male | DropDownList |
	And I select link "SUB{Var(num1)}"
	And I select Form "Demographics" in Folder "CYCLE (1)"
	And I enter data in CRF and save
	    | Field       | Data | Control Type |
	    | Derived Age | 3    | text         |
	And I take a screenshot
	And I select link "SUB{Var(num1)}"
	And I choose "Add Matrix" from "Add Event"
	And I click button "Add"
	And I choose "Add Matrix" from "Add Event"
	And I click button "Add"
	And I choose "Add Matrix" from "Add Event"
	And I click button "Add"
	And I take a screenshot

	And I navigate to "Home"
	And I navigate to "Architect"
	And I select "Study" link "*US13780_DT13557" in "Active Projects"
	And I select link "Draft 1" in "CRF Drafts"
	And I publish CRF Version "Target {RndNum<TV#>(5)}"
	And I note down "crfversion" to "newversion2#"
	And I select link "*US13780_DT13557" in "Header"
	And I navigate to "Amendment Manager"
	And I choose "{Var(newversion1#)}" from "Source CRF"
	And I choose "{Var(newversion2#)}" from "Target CRF"
	And I click button "Create Plan"
	And I take a screenshot
	
	And I navigate to "Object Hierarchy"
	And I select link "Add Rule"
	And I choose "Move Elements" from "Action Dropdown"
	And I check "Only if target parent exists"
	And I choose "CYCLE (CYC)" from "SourceFolderDropDown"
	And I choose "(3)" from "SourceRepeatNumber"
	And I choose "Demographics (DEMOGRAPHICS)" from "SourceFormDropDown"
	And I choose "Screening (SCRN)" from "TargetFolderDropDown"
	And I choose "Demographics (DEMOGRAPHICS)" from "TargetFormDropDown"
	And I select link "Save"
	And I take a screenshot
		
	And I navigate to "Execute Plan"
	And I migrate all Subjects
	And I select link "Migration Results"
	And I verify Job Status is set to Complete
	And I take a screenshot	
	And I navigate to "Home"
	And I select Study "*US13780_DT13557" and Site "Site 1"
    And I select a Subject "SUB{Var(num1)}"
	And I select Folder "Screening"
	And I verify only "1" Form "Demographics" is displayed
	And I take a screenshot

#----------------------------------------------------------------------------------------------------------------------------------------	
