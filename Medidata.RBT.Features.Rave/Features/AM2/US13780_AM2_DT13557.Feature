#DT 13557 - Object Hierarchy performs incorrect rule operations on repeating instances
#The scenarios described in this feature file go under the assumption that there is at least the following:
# 1. A study design that has matrices which include folder which gets renamed numerically via an edit check ot CF.
# 2. One Source CRF version published to an environment
# 3. One subject has been created in the environment, with a numerically renamed folder and a folder added with an instance number that matches the number #in the renamed folder 
# 4. One Target CRF version published to an environment

Feature: US13780_DT13557 Amendment Manger should not apply the same Object Heirarchy rules on renamed folders and folders that have an instance number which matches the number in the renamed folder.


Background:
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
	

@Rave564_2012.1.1
@DT13626_10
@Draft
Scenario: When a user navigates to Architect, creates a migration plan with a new CRF version as the Target CRF version, adds a Move Element object hierarchy rule with the “Only if target parent exists?box checked, in the Source patch enters "[Subject]/FOLDER:Folder(4)/FOLDER:Folder(1)/FORM:Form(1)" and in the Target Source enters "[Subject]/FOLDER:Folder 3/FOLDER:Folder(1)", and executes the migration then the user will see the form appear only in "Folder(4)"


	Given I am logged in to Rave with default account
	

	And I navigate to "Architect"
	And I select link "AM Edit Check Study" in "Active Projects"
	And I select link "Draft 1" in "CRF Drafts"
	And I publish CRF Version "source {RndNum<TV#>(5)}"
	And I note down "crfversion" to "newversion1#"
	And I select link "AM Edit Check Study" in "Header"
	And I push CRF Version "{Var(newversion1#)}" to "All Sites"

	And I navigate to "Home"	
	And I select Study "AM Edit Check Study" and Site "AM Edit Site"
	And I create a Subject
	| Field            | Data              |
	| Subject Number   | {RndNum<num1>(5)} |
	| Subject Initials | sub               |
	#And I note down "crfversion" to "ver#"
	
	And I navigate to "Home"
	And I navigate to "Architect"
	And I select link "AM Edit Check Study" in "Active Projects"
	And I create Draft "Draft {RndNum<d#>(5)}" from Project "AM Edit Check Study" and Version "{Var(newversion1#)}"
	
	And I publish CRF Version "Target{RndNum<TV#>(3)}"
	And I note down "crfversion" to "newversion2#"
	And I select link "AM Edit Check Study" in "Header"
	And I navigate to "Amendment Manager"
	And I choose "{Var(newversion1#)}" from "Source CRF"
	And I choose "{Var(newversion2#)}" from "Target CRF"
	And I click button "Create Plan"
	And I take a screenshot
	
#Steps to be implemented		
	And I navigate to "Object Hierarchy"
	And I select link "Add Rule"
	And I choose "Create Elements" from "Action"
	And I choose "Screening (TESTA)" from "TargetFolderDropDown"
	And I choose "Subject Identification (PRIMARY)" from "TargetFormDropDown"
	And I choose "(2)" from "TargetRepeatNumber"

	And I select link "Save"
#Till here
	
	And I navigate to "Execute Plan"
	And I migrate all Subjects
	And I select link "Migration Results"
	And I verify Job Status is set to Complete
	And I take a screenshot	
	And I navigate to "Home"
	And I select Study "AM Edit Check Study" and Site "AM Edit Site"
    And I select a Subject "sub{Var(num1)}"
	