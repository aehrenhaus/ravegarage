Feature: US12940_564QueryRefiringLogic8 Edit Checks refire with require response and require manual close.
	As a Rave user
	I want to change data
	So I can see refired queries
	
# Query Issue: Edit Checks with require response and require manual close
#DDE
#Task Summary
#Query Management
#Amendment Manager
#Publish Checks
#Queries on Locked datapoints, Freezed datapoints, Inactive records

Background:
 	Given xml draft "Edit_Check_Study_3_Draft_8.xml" is Uploaded
 	Given xml draft "AM_Edit_Check_Study_Draft_1.xml" is Uploaded
	Given Site "Edit Check Site 1" exists
	Given Site "Edit Check Site 2" exists
	Given Site "Edit Check Site 8" exists
	Given Site "AM Edit Site" exists
	Given study "Edit Check Study 3" is assigned to Site "Edit Check Site 8"
	Given study "Edit Check Study 3" is assigned to Site "Edit Check Site 1"
	Given study "Edit Check Study 3" is assigned to Site "Edit Check Site 2"
	Given study "AM Edit Check Study" is assigned to Site "AM Edit Site"
	Given I publish and push eCRF "Edit_Check_Study_3_Draft_8.xml" to "Version 1"
	Given I publish and push eCRF "AM_Edit_Check_Study_Draft_1.xml" to "Version 2"
	Given Site "Edit Check Site 1" is DDE-enabled
	Given Site "Edit Check Site 8" is DDE-enabled
	Given following Project assignments exist
		| User         | Project             | Environment | Role            | Site              | SecurityRole          |
		| SUPER USER 1 | Edit Check Study 3  | Live: Prod  | Edit Check Role | Edit Check Site 8 | Project Admin Default |
		| SUPER USER 1 | Edit Check Study 3  | Live: Prod  | Edit Check Role | Edit Check Site 1 | Project Admin Default |
		| SUPER USER 1 | Edit Check Study 3  | Live: Prod  | Edit Check Role | Edit Check Site 2 | Project Admin Default |
		| SUPER USER 1 | AM Edit Check Study | Live: Prod  | Edit Check Role | AM Edit Site      | Project Admin Default |
		| SUPER USER 2 | Edit Check Study 3  | Live: Prod  | Edit Check Role | Edit Check Site 8 | Project Admin Default |

    #Given I login to Rave with user "defuser" and password "password"
	#And following Study assignments exist
	# | User      | Study               | Role | Site              | Site Number |
	# | Defuser   | Edit Check Study 3  | cdm1 | Edit Check Site 8 | 80001       |
	# | Defuser01 | Edit Check Study 3  | cdm1 | Edit Check Site 8 | 80001       |
	# | Defuser   | Edit Check Study 3  | cdm1 | Edit Check Site 1 | 10001       |
	# | Defuser   | AM Edit Check Study | cdm1 | AM Edit Site      | 80002       |
	# And role "cdm1" has Query actions
	# And role "cdm2" has Query actions
	# And Draft "Draft 1" in Study "Edit Check Study 8" has been published to CRF Version "<RANDOMNUMBER>" 
	# And CRF Version "<RANDOMNUMBER>" in Study "Edit Check Study 8" has been pushed to Site "Edit Check Site 3" in Environment "Prod"
	# And I set and save "Threshold" in Configuration, Other Settings, Advance Configuration to "Value", from the table below
			# |Threshold					|Value	|
			# |Check Resolution Threshold	|0		|
			# |Check Execution Threshold	|0		|
			# |Custom Function Threshold	|0		|
	# And I do cacheflush
	# And I select Study "Edit Check Study 3" and Site "Edit Check Site 8"
	
#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch11
@PB_8.1.1
@Validation
Scenario: PB_8.1.1 As an EDC user, Data setup and verification for query re-firing. Folder "Screening" enter and save data on forms "Informed Consent" and "Concomitant Medications"
	
	Given I login to Rave with user "SUPER USER 1"
	And I navigate to "DDE"
	And I select link "First Pass"
	And I select link "New Batch"
	And I choose "Edit Check Study 3" from "Study"
	#And I choose "Prod" from "Environment"
	And I choose "Edit Check Site 8" from "Site"
	And I type "sub {RndNum<num1>(5)}" in "Subject"
	And I choose "Subject Identification" from "Form"
	And I click button "Locate"
	And I enter data in DDE and save
		| Field            | Data        |
		| Subject Number   | {Var(num1)} |
		| Subject Initials | sub         |	
	And I choose "Screening" from "Folder"
	And I choose "Informed Consent" from "Form"
	And I click button "Locate"
	And I enter data in DDE and save
	    | Field                        | Data        |
	    | Date Informed Consent Signed | 09 Jan 2000 |
	    | End Date                     | 10 Jan 2000 |
	    | Original Distribution Number | 10          |
	    | Current Distribution Number  | 19          |
	And I choose "Concomitant Medications" from "Form"
	And I click button "Locate"	
	And I enter data in DDE log line 1 and save
	    | Field                | Data        |
	    | Start Date           | 08 Jan 2000 |
	    | End Date             | 11 Jan 2000 |
	    | Original Axis Number | 10          |
	    | Current Axis Number  | 20          |
	
	Given I login to Rave with user "SUPER USER 2"
	And I navigate to "DDE"
	And I select link "Second Pass"
	#And I choose "Edit Check Study 3" from "Study"
	#And I choose "Prod" from "Environment"
	And I choose "Edit Check Site 8" from "Site"
	And I choose "sub {Var(num1)}" from "Subject"
	And I choose "Subject Identification" from "Form"
	And I click button "Locate"
	And I enter data in DDE and save
		| Field            | Data        |
		| Subject Number   | {Var(num1)} |
		| Subject Initials | sub         |
	And I choose "Screening" from "Folder"
	And I choose "Informed Consent" from "Form"
	And I click button "Locate"
	And I enter data in DDE and save
	    | Field                        | Data        |
	    | Date Informed Consent Signed | 09 Jan 2000 |
	    | End Date                     | 10 Jan 2000 |
	    | Original Distribution Number | 10          |
	    | Current Distribution Number  | 19          |
	And I choose "Concomitant Medications" from "Form"
	And I click button "Locate"	
	And I enter data in DDE log line 1 and save
	    | Field                | Data        |
	    | Start Date           | 08 Jan 2000 |
	    | End Date             | 11 Jan 2000 |
	    | Original Axis Number | 10          |
	    | Current Axis Number  | 20          |	
	
	And I navigate to "Home"
	And I select Study "Edit Check Study 3" and Site "Edit Check Site 8"
	And I select a Subject "sub{Var(num1)}"
	When I select Form "Concomitant Medications" in Folder "Screening"
	And I open log line 1
	Then I verify Query is displayed
		| Field               | Query Message                                                                                                 | Answered | Closed |
		| Start Date          | 'Date Informed Consent Signed' is greater. Please revise.                                                     | false    | false  |
		| Current Axis Number | Informed Consent 'Current Distribution Number' is not equal to Concomitant Medications 'Current Axis Number'. | false    | false  |
	And I take a screenshot
	And I answer the Query "'Date Informed Consent Signed' is greater. Please revise." on Field "Start Date" with "{answer}"
	And I answer the Query "Informed Consent 'Current Distribution Number' is not equal to Concomitant Medications 'Current Axis Number'." on Field "Current Axis Number" with "{answer}"
	And I save the CRF page
	And I open log line 1
	And I close the Query "'Date Informed Consent Signed' is greater. Please revise." on Field "Start Date"
	And I close the Query "Informed Consent 'Current Distribution Number' is not equal to Concomitant Medications 'Current Axis Number'." on Field "Current Axis Number"
	And I save the CRF page
	And I take a screenshot
	And I open log line 1
	And I enter data in CRF and save
		| Field               | Data        |
		| Start Date          | 09 Jan 2000 |
		| Current Axis Number | 19          |
	And I open log line 1
	And I verify Query is displayed
		| Field               | Query Message                                                                                                 |Answered | Closed |
		| Start Date          | 'Date Informed Consent Signed' is greater. Please revise.                                                     |true     | true   | 
		| Current Axis Number | Informed Consent 'Current Distribution Number' is not equal to Concomitant Medications 'Current Axis Number'. |true     | true   |
	And I take a screenshot
	When I enter data in CRF and save
		| Field               | Data        |
		| Start Date          | 08 Jan 2000 |
		| Current Axis Number | 20          |
	And I open log line 1
	Then I verify Query is displayed
		| Field               | Query Message                                                                                                 | Answered | Closed |
		| Start Date          | 'Date Informed Consent Signed' is greater. Please revise.                                                     | true     | true   |
		| Current Axis Number | Informed Consent 'Current Distribution Number' is not equal to Concomitant Medications 'Current Axis Number'. | true     | true   |
	And I take a screenshot
	
#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch11
@PB_8.1.2
@Validation
Scenario: PB_8.1.2
	Given I login to Rave with user "SUPER USER 2"
    And I select Study "Edit Check Study 3" and Site "Edit Check Site 8"
    And I select a Subject "sub{Var(num1)}"
	And I select Form "Concomitant Medications" in Folder "Screening"
	And I enter data in CRF on a new log line and save
	    | Field                | Data        |
	    | Start Date           | 07 Jan 2000 |
	    | End Date             | 12 Jan 2000 |
	    | Original Axis Number | 10          |
	    | Current Axis Number  | 18          |
	When I open log line 2
	Then I verify Query is displayed
		| Field               | Query Message                                                                                                 | Answered | Closed |
		| Start Date          | 'Date Informed Consent Signed' is greater. Please revise.                                                     | false    | false  |
		| Current Axis Number | Informed Consent 'Current Distribution Number' is not equal to Concomitant Medications 'Current Axis Number'. | false    | false  |
	And I take a screenshot
	And I answer the Query "'Date Informed Consent Signed' is greater. Please revise." on Field "Start Date" with "{answer}"
	And I answer the Query "Informed Consent 'Current Distribution Number' is not equal to Concomitant Medications 'Current Axis Number'." on Field "Current Axis Number" with "{answer}"
	And I save the CRF page
	And I open log line 2
	And I close the Query "'Date Informed Consent Signed' is greater. Please revise." on Field "Start Date"
	And I close the Query "Informed Consent 'Current Distribution Number' is not equal to Concomitant Medications 'Current Axis Number'." on Field "Current Axis Number"
	And I enter data in CRF
		| Field               | Data        |
		| Start Date          | 09 Jan 2000 |
		| Current Axis Number | 19          |
	And I save the CRF page
	And I take a screenshot
	When I open log line 2
	Then I verify Query is displayed
		| Field               | Query Message                                                                                                 | Answered | Closed |
		| Start Date          | 'Date Informed Consent Signed' is greater. Please revise.                                                     | true     | true   |
		| Current Axis Number | Informed Consent 'Current Distribution Number' is not equal to Concomitant Medications 'Current Axis Number'. | true     | true   |
	And I take a screenshot
	When I enter data in CRF and save
		| Field               | Data        |
		| Start Date          | 07 Jan 2000 |
		| Current Axis Number | 18          |
	And I open log line 2
	Then I verify Query is displayed
		| Field               | Query Message                                                                                                 | Answered | Closed |
		| Start Date          | 'Date Informed Consent Signed' is greater. Please revise.                                                     | true     | true   |
		| Current Axis Number | Informed Consent 'Current Distribution Number' is not equal to Concomitant Medications 'Current Axis Number'. | true     | true   |
	And I take a screenshot
	
#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch11
@PB_8.1.3
@Validation
Scenario: PB_8.1.3
	
	Given I login to Rave with user "SUPER USER 2"
    And I select Study "Edit Check Study 3" and Site "Edit Check Site 8"
    And I select a Subject "sub{Var(num1)}"
	And I select Form "Concomitant Medications" in Folder "Screening"
	And I enter data in CRF on a new log line and save
	    | Field                | Data        |
	    | Start Date           | 07 Jan 2000 |
	    | End Date             | 12 Jan 2000 |
	    | Original Axis Number | 10          |
	    | Current Axis Number  | 18          |
	When I open log line 3
	Then I verify Query is displayed
		| Field               | Query Message                                                                                                 | Answered | Closed |
		| Start Date          | 'Date Informed Consent Signed' is greater. Please revise.                                                     | false    | false  |
		| Current Axis Number | Informed Consent 'Current Distribution Number' is not equal to Concomitant Medications 'Current Axis Number'. | false    | false  |
	And I take a screenshot
	And I cancel the Query "'Date Informed Consent Signed' is greater. Please revise." on Field "Start Date"
	And I cancel the Query "Informed Consent 'Current Distribution Number' is not equal to Concomitant Medications 'Current Axis Number'." on Field "Current Axis Number"
	And I enter data in CRF
		| Field               | Data        |
		| Start Date          | 09 Jan 2000 |
		| Current Axis Number | 19          |
	And I save the CRF page
	And I take a screenshot
	When I open log line 3
	Then I verify Query is not displayed
		| Field               | Query Message                                                                                                 | Answered | Closed |
		| Start Date          | 'Date Informed Consent Signed' is greater. Please revise.                                                     | false    | false  |
		| Current Axis Number | Informed Consent 'Current Distribution Number' is not equal to Concomitant Medications 'Current Axis Number'. | false    | false  |
	And I take a screenshot
	When I enter data in CRF and save
		| Field               | Data        |
		| Start Date          | 07 Jan 2000 |
		| Current Axis Number | 18          |
	And I open log line 3
	Then I verify Query is displayed
		| Field               | Query Message                                                                                                 |
		| Start Date          | 'Date Informed Consent Signed' is greater. Please revise.                                                     |
		| Current Axis Number | Informed Consent 'Current Distribution Number' is not equal to Concomitant Medications 'Current Axis Number'. |
	And I take a screenshot

#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch11
@PB_8.2.1
@Validation
Scenario: PB_8.2.1 Task Summary

	Given I login to Rave with user "SUPER USER 2"
	And I select Study "Edit Check Study 3" and Site "Edit Check Site 8"
    And I select a Subject "sub{Var(num1)}"
	When I expand "Open Queries" in Task Summary
	Then I should see "Screening-Concomitant Medications" in "Open Queries"
	And I select link "Screening-Concomitant Medications" in "Open Queries"
	When I open log line 3
	Then I verify Query is displayed
		| Field               | Query Message                                                                                                 | Answered | Closed |
		| Start Date          | 'Date Informed Consent Signed' is greater. Please revise.                                                     | false    | false  |
		| Current Axis Number | Informed Consent 'Current Distribution Number' is not equal to Concomitant Medications 'Current Axis Number'. | false    | false  |
	And I take a screenshot
	And I navigate to "Home"
	And I select Study "Edit Check Study 3" and Site "Edit Check Site 8"
    And I select a Subject "sub{Var(num1)}"
	When I expand "Cancel Queries" in Task Summary
	Then I should see "Screening-Concomitant Medications" in "Cancel Queries"
	And I select link "Screening-Concomitant Medications" in "Cancel Queries"
	When I open log line 3
	Then I verify Query is displayed
		| Field               | Query Message                                                                                                 | Answered | Closed |
		| Start Date          | 'Date Informed Consent Signed' is greater. Please revise.                                                     | false    | false  |
		| Current Axis Number | Informed Consent 'Current Distribution Number' is not equal to Concomitant Medications 'Current Axis Number'. | false    | false  |
	And I take a screenshot

#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch11
@PB_8.3.1
@Validation
Scenario: PB_8.3.1 Query Management

	Given I login to Rave with user "SUPER USER 2"
	And I navigate to "Query Management"
	And I choose "Edit Check Study 3 (Prod)" from "Study"
	And I choose "World" from "Site Group"
	And I choose "Edit Check Site 8" from "Site"
	And I choose "sub{Var(num1)}" from "Subject"
	And I click button "Advanced Search"
	And I select link "Concomitant Medications" in "Search Result"
	When I open log line 2
	Then I verify Query is displayed
		| Field               | Query Message                                                                                                 | Answered | Closed |
		| Start Date          | 'Date Informed Consent Signed' is greater. Please revise.                                                     | false    | false  |
		| Current Axis Number | Informed Consent 'Current Distribution Number' is not equal to Concomitant Medications 'Current Axis Number'. | false    | false  |  
	And I take a screenshot
	And I click button "Cancel"
	When I open log line 3
	Then I verify Query is displayed
		| Field               | Query Message                                                                                                 | Answered | Closed |
		| Start Date          | 'Date Informed Consent Signed' is greater. Please revise.                                                     | false    | false  |
		| Current Axis Number | Informed Consent 'Current Distribution Number' is not equal to Concomitant Medications 'Current Axis Number'. | false    | false  |
	And I take a screenshot
	And I click button "Cancel"
	When  I enter data in CRF on a new log line and save and reopen
	    | Field                | Data        |
	    | Start Date           | 07 Jan 2000 |
	    | End Date             | 12 Jan 2000 |
	    | Original Axis Number | 10          |
	    | Current Axis Number  | 20          |
	Then I verify Query is displayed
		| Field               | Query Message                                                                                                 | Answered | Closed |
		| Start Date          | 'Date Informed Consent Signed' is greater. Please revise.                                                     | false    | false  |
		| Current Axis Number | Informed Consent 'Current Distribution Number' is not equal to Concomitant Medications 'Current Axis Number'. | false    | false  |
	And I take a screenshot
	And I enter data in CRF
		| Field               | Data        |
		| Start Date          | 09 Jan 2000 |
		| Current Axis Number | 19          |
	And I cancel the Query "'Date Informed Consent Signed' is greater. Please revise." on Field "Start Date"
	And I cancel the Query "Informed Consent 'Current Distribution Number' is not equal to Concomitant Medications 'Current Axis Number'." on Field "Current Axis Number"
	And I save the CRF page
	And I take a screenshot
	When I open the last log line
	Then I verify Query is not displayed
		| Field               | Query Message                                                                                                 | Answered | Closed |
		| Start Date          | 'Date Informed Consent Signed' is greater. Please revise.                                                     | true     | true   |
		| Current Axis Number | Informed Consent 'Current Distribution Number' is not equal to Concomitant Medications 'Current Axis Number'. | true     | true   |
	And I take a screenshot
	When I enter data in CRF and save
		| Field               | Data        |
		| Start Date          | 07 Jan 2000 |
		| Current Axis Number | 18          |
	And I open the last log line
	Then I verify Query is displayed
		| Field               | Query Message                                                                                                 | Answered | Closed |
		| Start Date          | 'Date Informed Consent Signed' is greater. Please revise.                                                     | false    | false  |
		| Current Axis Number | Informed Consent 'Current Distribution Number' is not equal to Concomitant Medications 'Current Axis Number'. | false    | false  |
	And I take a screenshot
	
#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch11
@PB_8.3.2
@ignore
# Failing due to DT 14230
Scenario: PB_8.3.2

	Given I login to Rave with user "SUPER USER 2"
	And I navigate to "Query Management"
	And I choose "Edit Check Study 3 (Prod)" from "Study"
	And I choose "World" from "Site Group"
	And I choose "Edit Check Site 8" from "Site"
	And I choose "sub{Var(num1)}" from "Subject"
	And I click button "Advanced Search"
	And I select link "Concomitant Medications" in "search result"
	And I enter data in CRF on a new log line and save and reopen
	    | Field                | Data        |
	    | Start Date           | 07 Jan 2000 |
	    | End Date             | 12 Jan 2000 |
	    | Original Axis Number | 10          |
	    | Current Axis Number  | 18          |
    And I verify Query is displayed
		| Field               | Query Message                                                                                                 | Answered | Closed |
		| Start Date          | 'Date Informed Consent Signed' is greater. Please revise.                                                     | false    | false  |
		| Current Axis Number | Informed Consent 'Current Distribution Number' is not equal to Concomitant Medications 'Current Axis Number'. | false    | false  |
	And I take a screenshot
	And I answer the Query "'Date Informed Consent Signed' is greater. Please revise." on Field "Start Date" with "{answer}"
	And I answer the Query "Informed Consent 'Current Distribution Number' is not equal to Concomitant Medications 'Current Axis Number'." on Field "Current Axis Number" with "{answer}"
	And I save the CRF page
	And I open the last log line
	And I close the Query "'Date Informed Consent Signed' is greater. Please revise." on Field "Start Date"
	And I close the Query "Informed Consent 'Current Distribution Number' is not equal to Concomitant Medications 'Current Axis Number'." on Field "Current Axis Number"	
	And I enter data in CRF
		| Field               | Data        |
		| Start Date          | 09 Jan 2000 |
		| Current Axis Number | 19          |
	And I save the CRF page
	And I take a screenshot
	And I open the last log line
	And I verify Query is displayed
		| Field               | Query Message                                                                                                 | Answered | Closed |
		| Start Date          | 'Date Informed Consent Signed' is greater. Please revise.                                                     | true     | true   |
		| Current Axis Number | Informed Consent 'Current Distribution Number' is not equal to Concomitant Medications 'Current Axis Number'. | true     | true   |
	And I take a screenshot
	When I enter data in CRF and save
		| Field               | Data        |
		| Start Date          | 07 Jan 2000 |
		| Current Axis Number | 18          |
	And I open the last log line
	Then I verify Query is not displayed
		| Field               | Query Message                                                                                                 | Answered | Closed |
		| Start Date          | 'Date Informed Consent Signed' is greater. Please revise.                                                     | true     | true   |
		| Current Axis Number | Informed Consent 'Current Distribution Number' is not equal to Concomitant Medications 'Current Axis Number'. | true     | true   |
	And I take a screenshot	
	And I verify Query is displayed
		| Field                | Query Message                                                                                                  | Answered | Closed |
		| Start Date           | 'Date Informed Consent Signed' is greater. Please revise.                                                      | false    | false  |
		| Current Axis Number | Informed Consent 'Current Distribution Number' is not equal to Concomitant Medications 'Current Axis Number'. | false    | false  |
	And I take a screenshot
	# ???? Is that correct?

#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch11
@PB_8.4.1
@Validation
Scenario: PB_8.4.1 Migrate Subject
	
	Given I login to Rave with user "SUPER USER 1"	
	And I select Study "AM Edit Check Study" and Site "AM Edit Site"
	And I create a Subject
	| Field            | Data              |
	| Subject Number   | {RndNum<num2>(5)} |
	| Subject Initials | sub               |
	And I note down "crfversion" to "ver#"
	And I select Form "Mixed Form"
	And I enter data in CRF and save
	    |Field       |Data |
        |Standard 1  |6    |
	    |Log Field 1 |5    |
	    |Log Field 2 |2    |
	When I open log line 1
	Then I verify Query is displayed
		| Field       | Query Message               | Answered | Closed |
		| Log Field 1 | Query Opened on Log Field 1 | false    | false  |
	And I take a screenshot
	And I answer the Query "Query Opened on Log Field 1" on Field "Log Field 1" with "answer query"
	And I save the CRF page
	And I open log line 1
	And I close the Query "Query Opened on Log Field 1" on Field "Log Field 1"
	And I save the CRF page
	And I take a screenshot	
	And I navigate to "Home"
	And I select Study "AM Edit Check Study" and Site "AM Edit Site"
    And I create a Subject
		| Field            | Data              |
		| Subject Number   | {RndNum<num3>(5)} |
		| Subject Initials | sub               |
	And I select Form "Mixed Form"
	And I enter data in CRF and save
	    |Field       |Data |
        |Standard 1  |6    |
	    |Log Field 1 |5    |
	    |Log Field 2 |2    |
	When I open log line 1
	Then I verify Query is displayed
		| Field       | Query Message               | Answered | Closed |
		| Log Field 1 | Query Opened on Log Field 1 | false    | false  |
	And I take a screenshot
	And I answer the Query "Query Opened on Log Field 1" on Field "Log Field 1" with "answer query"
	And I save the CRF page
	And I open log line 1
	And I enter data in CRF and save
		|Field       |Data |
        |Standard 1  |5    |
	And I open log line 1
	And I close the Query "Query Opened on Log Field 1" on Field "Log Field 1"
	And I save the CRF page
	And I take a screenshot	

	And I navigate to "Home"
	And I navigate to "Architect"
	And I select link "AM Edit Check Study" in "Active Projects"
	And I create Draft "Draft {RndNum<d#>(5)}" from Project "AM Edit Check Study" and Version "Version 2"
	And I navigate to "Edit Checks"
	And I inactivate edit check "Mixed Form Query"
	And I take a screenshot
	And I select link "Draft {Var(d#)}" in "Header"
	And I publish CRF Version "Target{RndNum<TV#>(3)}"
	And I note down "crfversion" to "newversion#"
	And I select link "AM Edit Check Study" in "Header"
	And I navigate to "Amendment Manager"
	And I choose "Version 2" from "Source CRF"
	And I choose "{Var(newversion#)}" from "Target CRF"
	And I click button "Create Plan"
	And I take a screenshot
	And I navigate to "Execute Plan"
	And I migrate all Subjects
	And I select link "Migration Results"
	And I verify Job Status is set to Complete
	And I take a screenshot	
	And I navigate to "Home"
	And I select Study "AM Edit Check Study" and Site "AM Edit Site"
    And I select a Subject "sub{Var(num2)}"
	And I select Form "Mixed Form"
	And I open the last log line
	When I enter data in CRF and save
	    |Field       |Data |
	    |Log Field 1 |4    |
	And I open the last log line	
	Then I verify Query is not displayed
		| Field       | Query Message               | Answered | Closed |
		| Log Field 1 | Query Opened on Log Field 1 | false    | false  |
	And I take a screenshot
	And I click button "Cancel"
	And I add a new log line
	When I enter data in CRF and save
		|Field       |Data |
	    |Log Field 1 |3    |
	    |Log Field 2 |2    |
	And I open the last log line
	Then I verify Query is not displayed
		| Field       | Query Message               | Answered | Closed |
		| Log Field 1 | Query Opened on Log Field 1 | false    | false  |
	And I take a screenshot	
	And I navigate to "Home"
	And I select Study "AM Edit Check Study" and Site "AM Edit Site"
    And I select a Subject "sub{Var(num3)}"
	And I select Form "Mixed Form"
	And I open the last log line
	When I enter data in CRF and save
		|Field       |Data |
        |Standard 1  |8	   |
	And I open the last log line
	Then I verify Query is displayed
		| Field       | Query Message               | Answered | Closed |
		| Log Field 1 | Query Opened on Log Field 1 | true     | true   |
	And I take a screenshot	
	And I click button "Cancel"
	And I add a new log line
	When I enter data in CRF and save
		|Field       |Data |
	    |Log Field 1 |6    |
	    |Log Field 2 |2    |
	And I open the last log line
	Then I verify Query is not displayed
		| Field       | Query Message               | Answered | Closed |
		| Log Field 1 | Query Opened on Log Field 1 | true     | true   |
	And I take a screenshot	
	And I navigate to "Home"
	And I navigate to "Architect"
	And I select link "AM Edit Check Study" in "Active Projects"
	And I select link "Draft {Var(d#)}" in "CRF Drafts"
	And I navigate to "Edit Checks"
	And I activate edit check "Mixed Form Query"
	And I select link "Draft {Var(d#)}" in "Header"
	And I publish CRF Version "Target{RndNum<TV#>(3)}"
	And I note down "crfversion" to "newversion1#"
	And I select link "AM Edit Check Study" in "Header"
	And I navigate to "Amendment Manager"
	And I choose "{Var(newversion#)}" from "Source CRF"
	And I choose "{Var(newversion1#)}" from "Target CRF"
	And I click button "Create Plan"
	And I navigate to "Execute Plan"
	And I migrate all Subjects
	And I select link "Migration Results"
	And I verify Job Status is set to Complete 
	And I take a screenshot	
	And I navigate to "Home"
	And I select Study "AM Edit Check Study" and Site "AM Edit Site"
    And I select a Subject "sub{Var(num2)}"
	And I select Form "Mixed Form"
	When I open log line 1
	Then I verify Query is displayed
		| Field       | Query Message               | Answered | Closed |
		| Log Field 1 | Query Opened on Log Field 1 | false    | false  |
	And I take a screenshot	
	And I click button "Cancel"
	When I open log line 2
	Then I verify Query is displayed
		| Field       | Query Message               | Answered | Closed |
		| Log Field 1 | Query Opened on Log Field 1 | false    | false  |
	And I take a screenshot	
	And I navigate to "Home"
	And I select Study "AM Edit Check Study" and Site "AM Edit Site"
    And I select a Subject "sub{Var(num3)}"
	And I select Form "Mixed Form"
	When I open log line 1
	Then I verify Query is displayed
		| Field       | Query Message               | Answered | Closed |
		| Log Field 1 | Query Opened on Log Field 1 | false    | false  |
	And I take a screenshot
	And I click button "Cancel"
	When I open log line 2
	Then I verify Query is displayed
		| Field       | Query Message               | Answered | Closed |
		| Log Field 1 | Query Opened on Log Field 1 | false    | false  |
	And I take a screenshot
	
#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch11
@PB_8.5.1
@Validation
# The feature is not implemented in 5.6.3
Scenario: PB_8.5.1 Publish Checks

	Given I login to Rave with user "SUPER USER 1"	
	And I navigate to "Architect"
	And I select link "AM Edit Check Study" in "Active Projects"
	And I select link "Draft 1" in "CRF Drafts"
	And I publish CRF Version "Pub1{RndNum<TV#>(5)}"
	And I note down "crfversion" to "newversion1#"
	And I select link "AM Edit Check Study" in "Header"
	And I push CRF Version "{Var(newversion1#)}" to "All Sites"
	And I select link "AM Edit Check Study" in "Header"
	And I select link "Draft 1" in "CRF Drafts"
	And I publish CRF Version "Pub2{RndNum<TV#>(5)}"
	And I note down "crfversion" to "newversion2#"
	And I publish CRF Version "Pub1{RndNum<TV#>(5)}"
	And I note down "crfversion" to "newversion3#"
	And I navigate to "Home"
	And I select Study "AM Edit Check Study" and Site "AM Edit Site"
    And I create a Subject
		| Field            | Data              |
		| Subject Number   | {RndNum<num4>(5)} |
		| Subject Initials | sub               |
	And I note down "crfversion" to "ver#"
	And I select Form "Mixed Form"
	And I enter data in CRF and save
	    |Field       |Data |
        |Standard 1  |6    |
	    |Log Field 1 |5    |
	    |Log Field 2 |2    |
	And I open the last log line
	Then I verify Query is displayed
		| Field       | Query Message               | Answered | Closed |
		| Log Field 1 | Query Opened on Log Field 1 | false    | false  |
	And I take a screenshot
	And I answer the Query "Query Opened on Log Field 1" on Field "Log Field 1" with "answer query"
	And I save the CRF page
	And I open the last log line
	And I close the Query "Query Opened on Log Field 1" on Field "Log Field 1"
	And I save the CRF page
	And I open the last log line
	And I take a screenshot	
	And I navigate to "Home"
	And I navigate to "Architect"
	And I select link "AM Edit Check Study" in "Active Projects"
	And I select link "Publish Checks"
	And I choose "{Var(newversion1#)}" from "Current CRF Version"
	And I choose "{Var(newversion2#)}" from "Reference CRF Version"
	And I click button "Create Plan"
	And I check "Inactivate" in "Mixed Form Query"
	And I select link "Save"
	And I take a screenshot
	And I select link "Publish"
	#And I accept alert window
	And I select link "Migration Results"
	And I verify Job Status is set to Complete
	And I take a screenshot	
	And I navigate to "Home"
	And I select Study "AM Edit Check Study" and Site "AM Edit Site"
    And I select a Subject "sub{Var(num4)}"
	And I select Form "Mixed Form"
	And I enter data in CRF and save
		|Field       |Data |
        |Standard 1  |7    |
	And I open the last log line
	And I verify Query is displayed
         | Field       | Query Message               | Closed |
         | Log Field 1 | Query Opened on Log Field 1 | true   |
	And I take a screenshot	
	And I navigate to "Home"
	And I navigate to "Architect"
	And I select link "AM Edit Check Study" in "Active Projects"
	And I select link "Publish Checks"
	And I choose "{Var(newversion1#)}" from "Current CRF Version"
	And I choose "{Var(newversion3#)}" from "Reference CRF Version"
	And I click button "Create Plan"
	And I check "Publish" in "Mixed Form Query"
	And I select link "Save"
	And I take a screenshot
	And I select link "Publish"
	#And I accept alert window
	And I select link "Migration Results"
	And I verify Job Status is set to Complete
	And I take a screenshot
	And I navigate to "Home"
	And I select Study "AM Edit Check Study" and Site "AM Edit Site"
    And I select a Subject "sub{Var(num4)}"
	And I select Form "Mixed Form"
	When I open the last log line
	Then I verify Query with message "Query Opened on Log Field 1" is displayed on Field "Log Field 1"
	And I take a screenshot
	And I enter data in CRF and save
		|Field       |Data |
        |Standard 1  |8    |
	When I open the last log line
	Then I verify Query with message "Query Opened on Log Field 1" is displayed on Field "Log Field 1"
	And I answer the Query "Query Opened on Log Field 1" on Field "Log Field 1" with "answer query"
	And I save the CRF page
	And I open the last log line	
	And I take a screenshot	

#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch11
@PB_8.6.1
@Validation
Scenario: PB_8.6.1 Queries verification on data points with Freeze, Hard lock and Inactive records

	Given I login to Rave with user "SUPER USER 1"
	And I select Study "Edit Check Study 3" and Site "Edit Check Site 2"
    And I create a Subject
		| Field            | Data              |
		| Subject Number   | {RndNum<num1>(5)} |
		| Subject Initials | sub               |
	And I select Form "Mixed Form"
	And I enter data in CRF and save
	    |Field       |Data |
        |Standard 1  |6    |
	    |Log Field 1 |5    |
	    |Log Field 2 |2    |
	When I open the last log line
	Then I verify Query is displayed
         | Field       | Query Message               | Answered | Closed |
         | Log Field 1 | Query Opened on Log Field 1 | false    | false  |
	And I take a screenshot
	And I answer the Query "Query Opened on Log Field 1" on Field "Log Field 1" with "answered"
	And I save the CRF page
	And I open the last log line
	And I close the Query "Query Opened on Log Field 1" on Field "Log Field 1"
	And I enter data in CRF
	    |Field       |Data |
	    |Log Field 1 |6    |
	And I save the CRF page
	And I open the last log line
	And I take a screenshot
	And I check "Freeze" in "Log Field 1"
	And I save the CRF page
	And I open the last log line
	And I take a screenshot
	And I click button "Cancel"
	And I add a new log line
	And I enter data in CRF and save
	    |Field       |Data |
	    |Log Field 1 |5    |
	    |Log Field 2 |2    |
	When I open the last log line
	Then I verify Query is displayed
         | Field       | Query Message               | Answered | Closed |
         | Log Field 1 | Query Opened on Log Field 1 | false    | false  |
	And I take a screenshot
	And I answer the Query "Query Opened on Log Field 1" on Field "Log Field 1" with "answered"
	And I save the CRF page
	And I open the last log line
	And I close the Query "Query Opened on Log Field 1" on Field "Log Field 1"
	And I enter data in CRF
	    |Field       |Data |
	    |Log Field 1 |6    |
	And I save the CRF page
	And I open the last log line
	And I take a screenshot
	And I check "Hard Lock" in "Log Field 1"
	And I save the CRF page
	And I open the last log line
	And I take a screenshot
	And I click button "Cancel"
	And I add a new log line
	And I enter data in CRF and save
	    |Field       |Data |
	    |Log Field 1 |5    |
	    |Log Field 2 |2    |
	When I open the last log line
	Then I verify Query is displayed
         | Field       | Query Message               | Answered | Closed |
         | Log Field 1 | Query Opened on Log Field 1 | false    | false  |
	And I take a screenshot
	And I answer the Query "Query Opened on Log Field 1" on Field "Log Field 1" with "answered"
	And I save the CRF page
	And I open the last log line
	And I close the Query "Query Opened on Log Field 1" on Field "Log Field 1"
	And I enter data in CRF
	    |Field       |Data |
	    |Log Field 1 |6    |
	And I save the CRF page
	And I open the last log line
	And I take a screenshot
	And I click button "Cancel"
	And I select link "Inactivate"
	And I choose "3" from "Inactivate"
	And I click button "Inactivate"
	And I take a screenshot
	When I enter data in CRF and save
		|Field       |Data |
        |Standard 1  |7    |
	And I open log line 1
	Then I verify Query is displayed
		| Field       | Query Message               | Answered | Closed |
		| Log Field 1 | Query Opened on Log Field 1 | false    | false  |
	And I take a screenshot
	And I click button "Cancel"
	And I open log line 2
	And I verify Query is not displayed
		| Field       | Query Message               | Answered | Closed |
		| Log Field 1 | Query Opened on Log Field 1 | false    | false  |
	And I take a screenshot
	And I click button "Cancel"
	And I select link "Reactivate"
	And I choose "3" from "Reactivate"
	And I click button "Reactivate"
	And I take a screenshot
	And I open log line 3
	And I verify Query is displayed
		| Field       | Query Message               | Answered | Closed |
		| Log Field 1 | Query Opened on Log Field 1 | false    | false  |
	And I take a screenshot
	
#----------------------------------------------------------------------------------------------------------------------------------------