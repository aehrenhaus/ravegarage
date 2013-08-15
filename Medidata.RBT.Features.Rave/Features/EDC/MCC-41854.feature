@ignore
@FT_MCC-41854

Feature: MCC-41854 Signature break from log line inactivation not audited record positions >1

Background:

Given xml draft "MCC41854.xml" is Uploaded
Given Site "Site_A" exists
Given study "MCC41854" is assigned to Site "Site_A"
Given role "SUPER ROLE 1" exists
Given I publish and push eCRF "MCC41854.xml" to "Version 1"
Given following Project assignments exist
| User          | Project   | Environment | Role         | Site   | SecurityRole          |
| SUPER USER 1  | MCC41854  | Live: Prod  | SUPER ROLE 1 | Site_A | Project Admin Default |

#Note: 1) ECGLogLandscape - log form with "Signature Required" in Landscape direction
#Note: 2) ECGLogPortrait - log form with "Signature Required" in Portrait direction 
#Note: 3) ECGMixedLandscape - mixed form with "Signature Required" in Landscape direction 
#Note: 4) ECGMixedPortrait - mixed form with "Signature Required" in Portrait direction 

@Release_2013.2.0
@PB_MCC41854-001
@RR28.MAR.2013
@Draft
Scenario: MCC41854-001 Log form in Landscape direction - verify signature is not broken incorrectly from log line inactivation and audited correctly on log lines.

#Given I have a log form with "Signature Required" in landscape direction 
#And I submit 5 log lines and sign the form
#When I inactivate log line 5
#Then I should not see signature broken for log line 1
#And I should see correct audits for log lines

Given I login to Rave with user "SUPER USER 1"
And I select Study "MCC41854" and Site "Site_A"
And I create a Subject
  | Field            | Data              | Control Type |
  | Subject Initials | SUB               | textbox      |
  | Subject Number   | {RndNum<num1>(3)} | textbox      |
  | Subject ID       | SUB {Var(num1)}   | textbox      |
And I take a screenshot 
And I select Form "ECGLogLandscape"
And I take a screenshot
And I enter data in CRF and save 
  |Field        |Data         |Control Type  |
  |Actual date  |01 Jan 2011  |datetime      |
  |Actual time  |10 10        |datetime      |
  |Test name    |test1        |textbox       |     	
  |Result       |1.1	      |textbox       | 
And I enter data in CRF on a new log line and save
  |Field        |Data         |Control Type  |
  |Actual date  |02 Jan 2011  |datetime      |
  |Actual time  |10 11        |datetime      |
  |Test name    |test2        |textbox       |     	
  |Result       |1.2	      |textbox       | 
And I enter data in CRF on a new log line and save
  |Field        |Data         |Control Type  |
  |Actual date  |03 Jan 2011  |datetime      |
  |Actual time  |10 12        |datetime      |
  |Test name    |test3        |textbox       |     	
  |Result       |1.3	      |textbox       | 
And I enter data in CRF on a new log line and save
  |Field        |Data         |Control Type  |
  |Actual date  |04 Jan 2011  |datetime      |
  |Actual time  |10 13        |datetime      |
  |Test name    |test4        |textbox       |     	
  |Result       |1.4	      |textbox       | 
And I enter data in CRF on a new log line and save
  |Field        |Data         |Control Type  |
  |Actual date  |05 Jan 2011  |datetime      |
  |Actual time  |10 14        |datetime      |
  |Test name    |test5        |textbox       |     	
  |Result       |1.5	      |textbox       |
And I verify data on Fields in CRF
  | Field       | Record | Status Icon        |
  | Actual date | 1      | Requires Signature |
  | Actual date | 2      | Requires Signature |
  | Actual date | 3      | Requires Signature |
  | Actual date | 4      | Requires Signature |
  | Actual date | 5      | Requires Signature |
And I take a screenshot
And I click button "Sign and Save"
And I sign the form with username "SUPER USER 1"
And I verify text "Please Sign - Default User  (SUPER USER 1)" with username "SUPER USER 1" exists
And I verify data on Fields in CRF
  | Field       | Record | Status Icon |
  | Actual date | 1      | Complete    |
  | Actual date | 2      | Complete    |
  | Actual date | 3      | Complete    |
  | Actual date | 4      | Complete    |
  | Actual date | 5      | Complete    |
And I take a screenshot  
And I select link "Inactivate"
And I choose "5" from "Inactivate"
When I click button "Inactivate"
And I verify data on Fields in CRF
  | Field       | Record | Status Icon |
  | Actual date | 1      | Complete    |
  | Actual date | 2      | Complete    |
  | Actual date | 3      | Complete    |
  | Actual date | 4      | Complete    |
  | Actual date | 5      | Inactive    |
And I can see "Sign and Save" button
And I take a screenshot
And I click audit on Field "Actual date" log line "1"
And I choose "Data Point - Actual date" from "Siblings Dropdown"
Then I verify Audits exist
  |Audit Type           |Query Message |User                               |Time                 |
  |Signature Succeeded  |              |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss |
  |User entered         |'01 Jan 2011' |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss |
And I take a screenshot
And I choose "Data Point - Actual time" from "Siblings Dropdown"
And I verify Audits exist
  |Audit Type          |Query Message |User                               |Time                 |
  |Signature Succeeded |              |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss |
  |User entered        |'10:10'       |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss |
And I take a screenshot
And I choose "Data Point - Test name" from "Siblings Dropdown"
And I verify Audits exist
  |Audit Type          |Query Message |User                               |Time                 |
  |Signature Succeeded |              |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss |
  |User entered        |'test1'       |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss |
And I take a screenshot
And I choose "Data Point - Result" from "Siblings Dropdown"
And I verify Audits exist
 |Audit Type          |Query Message |User                               |Time                 |
 |Signature Succeeded |              |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss |
 |User entered        |'1.1'         |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss |
And I take a screenshot
And I select link "ECGLogLandscape" in "Header"
And I click audit on Field "Actual date" log line "5"
And I choose "Data Point - Actual date" from "Siblings Dropdown"
Then I verify Audits exist
 |Audit Type          |Query Message |User                               |Time                 |
 |Signature Broken    |              |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss |
 |DataPoint           |Inactivated.  |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss | 
 |Signature Succeeded |              |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss |
 |User entered        |'05 Jan 2011' |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss |
And I take a screenshot
And I choose "Data Point - Actual time" from "Siblings Dropdown"
And I verify Audits exist
 |Audit Type          |Query Message |User                               |Time                 |
 |Signature Broken    |              |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss |
 |DataPoint           |Inactivated.  |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss | 
 |Signature Succeeded |              |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss |
 |User entered        |'10:14'       |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss |
And I take a screenshot
And I choose "Data Point - Test name" from "Siblings Dropdown"
And I verify Audits exist
 |Audit Type          |Query Message |User                               |Time                 |
 |Signature Broken    |              |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss |
 |DataPoint           |Inactivated.  |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss | 
 |Signature Succeeded |              |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss |
 |User entered        |'test5'       |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss |
And I take a screenshot
And I choose "Data Point - Result" from "Siblings Dropdown"
And I verify Audits exist
 |Audit Type          |Query Message |User                               |Time                 |
 |Signature Broken    |              |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss |
 |DataPoint           |Inactivated.  |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss | 
 |Signature Succeeded |              |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss |
 |User entered        |'1.5'         |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss |
And I take a screenshot

@Release_2013.2.0
@PB_MCC41854-002
@RR28.MAR.2013
@Draft
Scenario: MCC41854-002 Log form in Portrait direction - verify signature is not broken incorrectly from log line inactivation and audited correctly on log lines.

#Given I have a log form with "Signature Required" in Portrait direction 
#And I submit 5 log lines and sign the form
#When I inactivate log line 4
#Then I should not see signature broken for log line 1
#And I should see correct audits for log lines

Given I login to Rave with user "SUPER USER 1"
And I select Study "MCC41854" and Site "Site_A"
And I create a Subject
  | Field            | Data              | Control Type |
  | Subject Initials | SUB               | textbox      |
  | Subject Number   | {RndNum<num1>(3)} | textbox      |
  | Subject ID       | SUB {Var(num1)}   | textbox      |
And I take a screenshot 
And I select Form "ECGLogPortrait"
And I take a screenshot
And I enter data in CRF and save 
  |Field        |Data         |Control Type  |
  |Actual date  |01 Feb 2011  |datetime      |
  |Actual time  |11 10        |datetime      |
  |Test name    |test6        |textbox       |     	
  |Result       |1.6	      |textbox       | 
And I enter data in CRF on a new log line and save
  |Field        |Data         |Control Type  |
  |Actual date  |02 Feb 2011  |datetime      |
  |Actual time  |11 11        |datetime      |
  |Test name    |test7        |textbox       |     	
  |Result       |1.7	      |textbox       | 
And I enter data in CRF on a new log line and save
  |Field        |Data         |Control Type  |
  |Actual date  |03 Feb 2011  |datetime      |
  |Actual time  |11 12        |datetime      |
  |Test name    |test8        |textbox       |     	
  |Result       |1.8	      |textbox       |  
And I enter data in CRF on a new log line and save
  |Field        |Data         |Control Type  |
  |Actual date  |04 Feb 2011  |datetime      |
  |Actual time  |11 13        |datetime      |
  |Test name    |test9        |textbox       |     	
  |Result       |1.9	      |textbox       | 
And I enter data in CRF on a new log line and save
  |Field        |Data         |Control Type  |
  |Actual date  |05 Feb 2011  |datetime      |
  |Actual time  |11 14        |datetime      |
  |Test name    |test10       |textbox       |     	
  |Result       |1.10	      |textbox       |  
And I verify data on Fields in CRF
  | Field       | Record | Status Icon        |
  | Actual date | 1      | Requires Signature |
  | Actual date | 2      | Requires Signature |
  | Actual date | 3      | Requires Signature |
  | Actual date | 4      | Requires Signature |
  | Actual date | 5      | Requires Signature |
And I take a screenshot
And I click button "Sign and Save"
And I sign the form with username "SUPER USER 1"
And I verify text "Please Sign - Default User  (SUPER USER 1)" with username "SUPER USER 1" exists
And I verify data on Fields in CRF
  | Field       | Record | Status Icon |
  | Actual date | 1      | Complete    |
  | Actual date | 2      | Complete    |
  | Actual date | 3      | Complete    |
  | Actual date | 4      | Complete    |
  | Actual date | 5      | Complete    |
And I take a screenshot  
And I select link "Inactivate"
And I choose "4" from "Inactivate"
When I click button "Inactivate"
And I verify data on Fields in CRF
  | Field       | Record | Status Icon |
  | Actual date | 1      | Complete    |
  | Actual date | 2      | Complete    |
  | Actual date | 3      | Complete    |
  | Actual date | 4      | Inactive    |
  | Actual date | 5      | Complete    |
And I can see "Sign and Save" button
And I take a screenshot
And I click audit on Field "Actual date" log line "1"
And I choose "Data Point - Actual date" from "Siblings Dropdown"
Then I verify Audits exist
  |Audit Type           |Query Message |User                               |Time                 |
  |Signature Succeeded  |              |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss |
  |User entered         |'01 Feb 2011' |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss |
And I take a screenshot
And I choose "Data Point - Actual time" from "Siblings Dropdown"
And I verify Audits exist
  |Audit Type          |Query Message |User                               |Time                 |
  |Signature Succeeded |              |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss |
  |User entered        |'11:10'       |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss |
And I take a screenshot
And I choose "Data Point - Test name" from "Siblings Dropdown"
And I verify Audits exist
  |Audit Type          |Query Message |User                               |Time                 |
  |Signature Succeeded |              |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss |
  |User entered        |'test6'       |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss |
And I take a screenshot
And I choose "Data Point - Result" from "Siblings Dropdown"
And I verify Audits exist
 |Audit Type          |Query Message |User                               |Time                 |
 |Signature Succeeded |              |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss |
 |User entered        |'1.6'         |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss |
And I take a screenshot
And I select link "ECGLogPortrait" in "Header"
And I click audit on Field "Actual date" log line "4"
And I choose "Data Point - Actual date" from "Siblings Dropdown"
Then I verify Audits exist
 |Audit Type          |Query Message |User                               |Time                 |
 |Signature Broken    |              |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss |
 |DataPoint           |Inactivated.  |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss | 
 |Signature Succeeded |              |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss |
 |User entered        |'04 Feb 2011' |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss |
And I take a screenshot
And I choose "Data Point - Actual time" from "Siblings Dropdown"
And I verify Audits exist
 |Audit Type          |Query Message |User                               |Time                 |
 |Signature Broken    |              |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss |
 |DataPoint           |Inactivated.  |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss | 
 |Signature Succeeded |              |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss |
 |User entered        |'11:13'       |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss |
And I take a screenshot
And I choose "Data Point - Test name" from "Siblings Dropdown"
And I verify Audits exist
 |Audit Type          |Query Message |User                               |Time                 |
 |Signature Broken    |              |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss |
 |DataPoint           |Inactivated.  |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss | 
 |Signature Succeeded |              |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss |
 |User entered        |'test9'       |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss |
And I take a screenshot
And I choose "Data Point - Result" from "Siblings Dropdown"
And I verify Audits exist
 |Audit Type          |Query Message |User                               |Time                 |
 |Signature Broken    |              |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss |
 |DataPoint           |Inactivated.  |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss | 
 |Signature Succeeded |              |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss |
 |User entered        |'1.9'         |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss |
And I take a screenshot

@Release_2013.2.0
@PB_MCC41854-003
@RR28.MAR.2013
@Draft
Scenario: MCC41854-003 Mixed form in Landscape direction - verify signature is not broken incorrectly from log line inactivation and audited correctly on log lines.

#Given I have a mixed form with "Signature Required" in landscape direction 
#And I submit 5 log lines and sign the form
#When I inactivate log line 5
#Then I should not see signature broken for standard field
#When I inactivate log line 3
#Then I should not see signature broken for log line 1
#And I should see correct audits for standard field and log lines

Given I login to Rave with user "SUPER USER 1"
And I select Study "MCC41854" and Site "Site_A"
And I create a Subject
  | Field            | Data              | Control Type |
  | Subject Initials | SUB               | textbox      |
  | Subject Number   | {RndNum<num1>(3)} | textbox      |
  | Subject ID       | SUB {Var(num1)}   | textbox      |
And I take a screenshot 
And I select Form "ECGMixedLandscape"
And I take a screenshot
And I enter data in CRF and save 
  |Field        |Data         |Control Type  |
  |Number       |1            |textbox       |
  |Actual date  |01 Mar 2011  |datetime      |
  |Actual time  |12 10        |datetime      |
  |Test name    |testA        |textbox       |     	
  |Result       |2.1	      |textbox       | 
And I enter data in CRF on a new log line and save
  |Field        |Data         |Control Type  |
  |Actual date  |02 Mar 2011  |datetime      |
  |Actual time  |12 11        |datetime      |
  |Test name    |testB        |textbox       |     	
  |Result       |2.2	      |textbox       | 
And I enter data in CRF on a new log line and save
  |Field        |Data         |Control Type  |
  |Actual date  |03 Mar 2011  |datetime      |
  |Actual time  |12 12        |datetime      |
  |Test name    |testC        |textbox       |     	
  |Result       |2.3	      |textbox       | 
And I enter data in CRF on a new log line and save
  |Field        |Data         |Control Type  |
  |Actual date  |04 Mar 2011  |datetime      |
  |Actual time  |12 13        |datetime      |
  |Test name    |testD        |textbox       |     	
  |Result       |2.4	      |textbox       | 
And I enter data in CRF on a new log line and save
  |Field        |Data         |Control Type  |
  |Actual date  |05 Mar 2011  |datetime      |
  |Actual time  |12 14        |datetime      |
  |Test name    |testE        |textbox       |     	
  |Result       |2.5	      |textbox       | 
And I verify data on Fields in CRF
  | Field  | Data | Status Icon        |
  | Number | 1    | Requires Signature |
And I verify data on Fields in CRF
  | Field       | Record | Status Icon        |
  | Actual date | 1      | Requires Signature |
  | Actual date | 2      | Requires Signature |
  | Actual date | 3      | Requires Signature |
  | Actual date | 4      | Requires Signature |
  | Actual date | 5      | Requires Signature |
And I take a screenshot
And I click button "Sign and Save"
And I sign the form with username "SUPER USER 1"
And I verify text "Please Sign - Default User  (SUPER USER 1)" with username "SUPER USER 1" exists
And I verify data on Fields in CRF
  | Field  | Data | Status Icon        |
  | Number | 1    | Requires Signature |
And I verify data on Fields in CRF
  | Field       | Record | Status Icon |
  | Actual date | 1      | Complete    |
  | Actual date | 2      | Complete    |
  | Actual date | 3      | Complete    |
  | Actual date | 4      | Complete    |
  | Actual date | 5      | Complete    |
And I take a screenshot  
And I select link "Inactivate"
And I choose "5" from "Inactivate"
When I click button "Inactivate"
Then I verify data on Fields in CRF
  | Field  | Data | Status Icon        |
  | Number | 1    | Requires Signature |  
And I verify data on Fields in CRF
  | Field       | Record | Status Icon |
  | Actual date | 1      | Complete    |
  | Actual date | 2      | Complete    |
  | Actual date | 3      | Complete    |
  | Actual date | 4      | Complete    |
  | Actual date | 5      | Inactive    |
And I can see "Sign and Save" button
And I take a screenshot  
And I select link "Inactivate"
And I choose "3" from "Inactivate"
When I click button "Inactivate"
Then I verify data on Fields in CRF
  | Field  | Data | Status Icon        |
  | Number | 1    | Requires Signature |
And I verify data on Fields in CRF
  | Field       | Record | Status Icon |
  | Actual date | 1      | Complete    |
  | Actual date | 2      | Complete    |
  | Actual date | 3      | Inactive    |
  | Actual date | 4      | Complete    |
  | Actual date | 5      | Inactive    |
And I can see "Sign and Save" button
And I take a screenshot
And I click audit on Field "Number"
Then I verify Audits exist
 | Audit Type         |Query Message |User                               |Time                 |
 |Signature Succeeded |              |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss |
 |User entered        |'1'           |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss |
And I select link "ECGMixedLandscape" in "Header"
And I click audit on Field "Actual date" log line "1"
And I choose "Data Point - Actual date" from "Siblings Dropdown"
Then I verify Audits exist
  |Audit Type           |Query Message |User                               |Time                 |
  |Signature Succeeded  |              |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss |
  |User entered         |'01 Mar 2011' |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss |
And I take a screenshot
And I choose "Data Point - Actual time" from "Siblings Dropdown"
And I verify Audits exist
  |Audit Type          |Query Message |User                               |Time                 |
  |Signature Succeeded |              |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss |
  |User entered        |'12:10'       |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss |
And I take a screenshot
And I choose "Data Point - Test name" from "Siblings Dropdown"
And I verify Audits exist
  |Audit Type          |Query Message |User                               |Time                 |
  |Signature Succeeded |              |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss |
  |User entered        |'testA'       |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss |
And I take a screenshot
And I choose "Data Point - Result" from "Siblings Dropdown"
And I verify Audits exist
 |Audit Type          |Query Message |User                               |Time                 |
 |Signature Succeeded |              |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss |
 |User entered        |'2.1'         |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss |
And I take a screenshot
And I select link "ECGMixedLandscape" in "Header"
And I click audit on Field "Actual date" log line "3"
And I choose "Data Point - Actual date" from "Siblings Dropdown"
Then I verify Audits exist
 |Audit Type          |Query Message |User                               |Time                 |
 |Signature Broken    |              |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss |
 |DataPoint           |Inactivated.  |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss | 
 |Signature Succeeded |              |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss |
 |User entered        |'03 Mar 2011' |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss |
And I take a screenshot
And I choose "Data Point - Actual time" from "Siblings Dropdown"
And I verify Audits exist
 |Audit Type          |Query Message |User                               |Time                 |
 |Signature Broken    |              |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss |
 |DataPoint           |Inactivated.  |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss | 
 |Signature Succeeded |              |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss |
 |User entered        |'12:12'       |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss |
And I take a screenshot
And I choose "Data Point - Test name" from "Siblings Dropdown"
And I verify Audits exist
 |Audit Type          |Query Message |User                               |Time                 |
 |Signature Broken    |              |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss |
 |DataPoint           |Inactivated.  |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss | 
 |Signature Succeeded |              |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss |
 |User entered        |'testC'       |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss |
And I take a screenshot
And I choose "Data Point - Result" from "Siblings Dropdown"
And I verify Audits exist
 |Audit Type          |Query Message |User                               |Time                 |
 |Signature Broken    |              |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss |
 |DataPoint           |Inactivated.  |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss | 
 |Signature Succeeded |              |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss |
 |User entered        |'2.3'         |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss |
And I take a screenshot
And I select link "ECGMixedLandscape" in "Header"
And I click audit on Field "Actual date" log line "5"
And I choose "Data Point - Actual date" from "Siblings Dropdown"
Then I verify Audits exist
 |Audit Type          |Query Message |User                               |Time                 |
 |Signature Broken    |              |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss |
 |DataPoint           |Inactivated.  |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss | 
 |Signature Succeeded |              |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss |
 |User entered        |'05 Mar 2011' |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss |
And I take a screenshot
And I choose "Data Point - Actual time" from "Siblings Dropdown"
And I verify Audits exist
 |Audit Type          |Query Message |User                               |Time                 |
 |Signature Broken    |              |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss |
 |DataPoint           |Inactivated.  |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss | 
 |Signature Succeeded |              |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss |
 |User entered        |'12:14'       |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss |
And I take a screenshot
And I choose "Data Point - Test name" from "Siblings Dropdown"
And I verify Audits exist
 |Audit Type          |Query Message |User                               |Time                 |
 |Signature Broken    |              |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss |
 |DataPoint           |Inactivated.  |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss | 
 |Signature Succeeded |              |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss |
 |User entered        |'testE'       |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss |
And I take a screenshot
And I choose "Data Point - Result" from "Siblings Dropdown"
And I verify Audits exist
 |Audit Type          |Query Message |User                               |Time                 |
 |Signature Broken    |              |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss |
 |DataPoint           |Inactivated.  |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss | 
 |Signature Succeeded |              |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss |
 |User entered        |'2.5'         |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss |
And I take a screenshot

@Release_2013.2.0
@PB_MCC41854-004
@RR28.MAR.2013
@Draft
Scenario: MCC41854-004 Mixed form in Portrait direction - verify signature is not broken incorrectly from log line inactivation and audited correctly on log lines.

#Given I have a mixed form with "Signature Required" in Portrait direction 
#And I submit 5 log lines and sign the form
#When I inactivate log line 5
#Then I should not see signature broken for standard field
#When I inactivate log line 2
#Then I should not see signature broken for log line 1
#And I should see correct audits for standard field and log lines

Given I login to Rave with user "SUPER USER 1"
And I select Study "MCC41854" and Site "Site_A"
And I create a Subject
  | Field            | Data              | Control Type |
  | Subject Initials | SUB               | textbox      |
  | Subject Number   | {RndNum<num1>(3)} | textbox      |
  | Subject ID       | SUB {Var(num1)}   | textbox      |
And I take a screenshot 
And I select Form "ECGMixedPortrait"
And I take a screenshot
And I enter data in CRF and save 
  |Field        |Data         |Control Type  |
  |Number       |2            |textbox       |
  |Actual date  |01 Apr 2011  |datetime      |
  |Actual time  |12 20        |datetime      |
  |Test name    |testF        |textbox       |     	
  |Result       |2.6	      |textbox       | 
And I enter data in CRF on a new log line and save
  |Field        |Data         |Control Type  |
  |Actual date  |02 Apr 2011  |datetime      |
  |Actual time  |12 21        |datetime      |
  |Test name    |testG        |textbox       |     	
  |Result       |2.7	      |textbox       | 
And I enter data in CRF on a new log line and save
  |Field        |Data         |Control Type  |
  |Actual date  |03 Apr 2011  |datetime      |
  |Actual time  |12 22        |datetime      |
  |Test name    |testH        |textbox       |     	
  |Result       |2.8	      |textbox       | 
And I enter data in CRF on a new log line and save
  |Field        |Data         |Control Type  |
  |Actual date  |04 Apr 2011  |datetime      |
  |Actual time  |12 23        |datetime      |
  |Test name    |test11       |textbox       |     	
  |Result       |2.9	      |textbox       | 
And I enter data in CRF on a new log line and save
  |Field        |Data         |Control Type  |
  |Actual date  |05 Apr 2011  |datetime      |
  |Actual time  |12 24        |datetime      |
  |Test name    |test12       |textbox       |     	
  |Result       |2.10	      |textbox       | 
And I verify data on Fields in CRF
  | Field  | Data | Status Icon        |
  | Number | 2    | Requires Signature |
And I verify data on Fields in CRF
  | Field       | Record | Status Icon        |
  | Actual date | 1      | Requires Signature |
  | Actual date | 2      | Requires Signature |
  | Actual date | 3      | Requires Signature |
  | Actual date | 4      | Requires Signature |
  | Actual date | 5      | Requires Signature |
And I take a screenshot
And I click button "Sign and Save"
And I sign the form with username "SUPER USER 1"
And I verify text "Please Sign - Default User  (SUPER USER 1)" with username "SUPER USER 1" exists
And I verify data on Fields in CRF
  | Field  | Data | Status Icon        |
  | Number | 2    | Requires Signature |
And I verify data on Fields in CRF
  | Field       | Record | Status Icon |
  | Actual date | 1      | Complete    |
  | Actual date | 2      | Complete    |
  | Actual date | 3      | Complete    |
  | Actual date | 4      | Complete    |
  | Actual date | 5      | Complete    |
And I take a screenshot  
And I select link "Inactivate"
And I choose "5" from "Inactivate"
When I click button "Inactivate"
Then I verify data on Fields in CRF
  | Field  | Data | Status Icon        |
  | Number | 2    | Requires Signature | 
And I verify data on Fields in CRF
  | Field       | Record | Status Icon |
  | Actual date | 1      | Complete    |
  | Actual date | 2      | Complete    |
  | Actual date | 3      | Complete    |
  | Actual date | 4      | Complete    |
  | Actual date | 5      | Inactive    |
And I can see "Sign and Save" button
And I take a screenshot  
And I select link "Inactivate"
And I choose "2" from "Inactivate"
When I click button "Inactivate"
Then I verify data on Fields in CRF
  | Field  | Data | Status Icon        |
  | Number | 2    | Requires Signature |
And I verify data on Fields in CRF
  | Field       | Record | Status Icon |
  | Actual date | 1      | Complete    |
  | Actual date | 2      | Inactive    |
  | Actual date | 3      | Complete    |
  | Actual date | 4      | Complete    |
  | Actual date | 5      | Inactive    |
And I can see "Sign and Save" button
And I take a screenshot
When I click audit on Field "Number"
Then I verify Audits exist
  |Audit Type           |Query Message|User                               |Time                 |
  |Signature Succeeded  |             |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss |
  |User entered         |'2'          |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss |
And I select link "ECGMixedPortrait" in "Header"
And I click audit on Field "Actual date" log line "1"
And I choose "Data Point - Actual date" from "Siblings Dropdown"
Then I verify Audits exist
  |Audit Type           |Query Message |User                               |Time                 |
  |Signature Succeeded  |              |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss |
  |User entered         |'01 Apr 2011' |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss |
And I take a screenshot
And I choose "Data Point - Actual time" from "Siblings Dropdown"
And I verify Audits exist
  |Audit Type          |Query Message |User                               |Time                 |
  |Signature Succeeded |              |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss |
  |User entered        |'12:20'       |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss |
And I take a screenshot
And I choose "Data Point - Test name" from "Siblings Dropdown"
And I verify Audits exist
  |Audit Type          |Query Message |User                               |Time                 |
  |Signature Succeeded |              |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss |
  |User entered        |'testF'       |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss |
And I take a screenshot
And I choose "Data Point - Result" from "Siblings Dropdown"
And I verify Audits exist
 |Audit Type          |Query Message |User                               |Time                 |
 |Signature Succeeded |              |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss |
 |User entered        |'2.6'         |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss |
And I take a screenshot
And I select link "ECGMixedPortrait" in "Header"
And I click audit on Field "Actual date" log line "2"
And I choose "Data Point - Actual date" from "Siblings Dropdown"
Then I verify Audits exist
 |Audit Type          |Query Message |User                               |Time                 |
 |Signature Broken    |              |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss |
 |DataPoint           |Inactivated.  |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss | 
 |Signature Succeeded |              |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss |
 |User entered        |'02 Apr 2011' |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss |
And I take a screenshot
And I choose "Data Point - Actual time" from "Siblings Dropdown"
And I verify Audits exist
 |Audit Type          |Query Message |User                               |Time                 |
 |Signature Broken    |              |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss |
 |DataPoint           |Inactivated.  |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss | 
 |Signature Succeeded |              |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss |
 |User entered        |'12:21'       |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss |
And I take a screenshot
And I choose "Data Point - Test name" from "Siblings Dropdown"
And I verify Audits exist
 |Audit Type          |Query Message |User                               |Time                 |
 |Signature Broken    |              |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss |
 |DataPoint           |Inactivated.  |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss | 
 |Signature Succeeded |              |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss |
 |User entered        |'testG'       |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss |
And I take a screenshot
And I choose "Data Point - Result" from "Siblings Dropdown"
And I verify Audits exist
 |Audit Type          |Query Message |User                               |Time                 |
 |Signature Broken    |              |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss |
 |DataPoint           |Inactivated.  |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss | 
 |Signature Succeeded |              |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss |
 |User entered        |'2.7'         |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss |
And I take a screenshot
And I select link "ECGMixedPortrait" in "Header"
And I click audit on Field "Actual date" log line "5"
And I choose "Data Point - Actual date" from "Siblings Dropdown"
Then I verify Audits exist
 |Audit Type          |Query Message |User                               |Time                 |
 |Signature Broken    |              |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss |
 |DataPoint           |Inactivated.  |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss | 
 |Signature Succeeded |              |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss |
 |User entered        |'05 Apr 2011' |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss |
And I take a screenshot
And I choose "Data Point - Actual time" from "Siblings Dropdown"
And I verify Audits exist
 |Audit Type          |Query Message |User                               |Time                 |
 |Signature Broken    |              |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss |
 |DataPoint           |Inactivated.  |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss | 
 |Signature Succeeded |              |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss |
 |User entered        |'12:24'       |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss |
And I take a screenshot
And I choose "Data Point - Test name" from "Siblings Dropdown"
And I verify Audits exist
 |Audit Type          |Query Message |User                               |Time                 |
 |Signature Broken    |              |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss |
 |DataPoint           |Inactivated.  |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss | 
 |Signature Succeeded |              |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss |
 |User entered        |'test12'      |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss |
And I take a screenshot
And I choose "Data Point - Result" from "Siblings Dropdown"
And I verify Audits exist
 |Audit Type          |Query Message |User                               |Time                 |
 |Signature Broken    |              |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss |
 |DataPoint           |Inactivated.  |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss | 
 |Signature Succeeded |              |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss |
 |User entered        |'2.10'        |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss |
And I take a screenshot

@Release_2013.2.0
@PB_MCC41854-005
@RR29.MAR.2013
@Draft
Scenario: MCC41854-005 Log form in Landscape direction - verify signature is not broken incorrectly from log line inactivation, reactivation after applying signature.

#Given I have a log form with "Signature Required" in landscape direction 
#And I submit 5 log lines and sign the form
#When I inactivate log line 5
#And I reactivate log line 5
#Then I should not see signature broken for log line 1 and log line 5
#And I should see correct audits for log lines

Given I login to Rave with user "SUPER USER 1"
And I select Study "MCC41854" and Site "Site_A"
And I create a Subject
  | Field            | Data              | Control Type |
  | Subject Initials | SUB               | textbox      |
  | Subject Number   | {RndNum<num1>(3)} | textbox      |
  | Subject ID       | SUB {Var(num1)}   | textbox      |
And I take a screenshot 
And I select Form "ECGLogLandscape"
And I take a screenshot
And I enter data in CRF and save 
  |Field        |Data         |Control Type  |
  |Actual date  |06 Jan 2011  |datetime      |
  |Actual time  |10 15        |datetime      |
  |Test name    |test20       |textbox       |     	
  |Result       |3.1	      |textbox       | 
And I enter data in CRF on a new log line and save
  |Field        |Data         |Control Type  |
  |Actual date  |07 Jan 2011  |datetime      |
  |Actual time  |10 16        |datetime      |
  |Test name    |test21       |textbox       |     	
  |Result       |3.2	      |textbox       | 
And I enter data in CRF on a new log line and save
  |Field        |Data         |Control Type  |
  |Actual date  |08 Jan 2011  |datetime      |
  |Actual time  |10 17        |datetime      |
  |Test name    |test22       |textbox       |     	
  |Result       |3.3	      |textbox       | 
And I enter data in CRF on a new log line and save
  |Field        |Data         |Control Type  |
  |Actual date  |09 Jan 2011  |datetime      |
  |Actual time  |10 18        |datetime      |
  |Test name    |test23       |textbox       |     	
  |Result       |3.4	      |textbox       | 
And I enter data in CRF on a new log line and save
  |Field        |Data         |Control Type  |
  |Actual date  |10 Jan 2011  |datetime      |
  |Actual time  |10 19        |datetime      |
  |Test name    |test24       |textbox       |     	
  |Result       |3.5	      |textbox       |  
And I verify data on Fields in CRF
  | Field       | Record | Status Icon        |
  | Actual date | 1      | Requires Signature |
  | Actual date | 2      | Requires Signature |
  | Actual date | 3      | Requires Signature |
  | Actual date | 4      | Requires Signature |
  | Actual date | 5      | Requires Signature |
And I take a screenshot
And I click button "Sign and Save"
And I sign the form with username "SUPER USER 1"
And I verify text "Please Sign - Default User  (SUPER USER 1)" with username "SUPER USER 1" exists
And I verify data on Fields in CRF
  | Field       | Record | Status Icon |
  | Actual date | 1      | Complete    |
  | Actual date | 2      | Complete    |
  | Actual date | 3      | Complete    |
  | Actual date | 4      | Complete    |
  | Actual date | 5      | Complete    |
And I take a screenshot  
And I select link "Inactivate"
And I choose "5" from "Inactivate"
When I click button "Inactivate"
And I verify data on Fields in CRF
  | Field       | Record | Status Icon |
  | Actual date | 1      | Complete    |
  | Actual date | 2      | Complete    |
  | Actual date | 3      | Complete    |
  | Actual date | 4      | Complete    |
  | Actual date | 5      | Inactive    |
And I can see "Sign and Save" button
And I take a screenshot
And I select link "Reactivate"
And I choose "5" from "Reactivate"
When I click button "Reactivate"
And I verify data on Fields in CRF
  | Field       | Record | Status Icon        |
  | Actual date | 1      | Complete           |
  | Actual date | 2      | Complete           |
  | Actual date | 3      | Complete           |
  | Actual date | 4      | Complete           |
  | Actual date | 5      | Requires Signature |
And I can see "Sign and Save" button
And I take a screenshot
And I click audit on Field "Actual date" log line "5"
And I choose "Data Point - Actual date" from "Siblings Dropdown"
Then I verify Audits exist
 |Audit Type          |Query Message |User                               |Time                 |
 |DataPoint           |Activated.    |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss |  
 |Signature Broken    |              |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss |
 |DataPoint           |Inactivated.  |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss | 
 |Signature Succeeded |              |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss |
 |User entered        |'10 Jan 2011' |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss |
And I take a screenshot

@Release_2013.2.0
@PB_MCC41854-006
@RR29.MAR.2013
@Draft
Scenario: MCC41854-006 Log form in Portrait direction - verify signature is not broken incorrectly from log line inactivation, reactivation after applying signature.
#Given I have a log form with "Signature Required" in Portrait direction 
#And I submit 5 log lines and sign the form
#When I inactivate log line 3
#And I reactivate log line 3
#Then I should not see signature broken for log line 1 and log line 3
#And I should see correct audits for log lines

Given I login to Rave with user "SUPER USER 1"
And I select Study "MCC41854" and Site "Site_A"
And I create a Subject
  | Field            | Data              | Control Type |
  | Subject Initials | SUB               | textbox      |
  | Subject Number   | {RndNum<num1>(3)} | textbox      |
  | Subject ID       | SUB {Var(num1)}   | textbox      |
And I take a screenshot 
And I select Form "ECGLogPortrait"
And I take a screenshot
And I enter data in CRF and save 
  |Field        |Data         |Control Type  |
  |Actual date  |06 Feb 2011  |datetime      |
  |Actual time  |11 15        |datetime      |
  |Test name    |test25       |textbox       |     	
  |Result       |3.6	      |textbox       | 
And I enter data in CRF on a new log line and save
  |Field        |Data         |Control Type  |
  |Actual date  |07 Feb 2011  |datetime      |
  |Actual time  |11 16        |datetime      |
  |Test name    |test26       |textbox       |     	
  |Result       |3.7	      |textbox       | 
And I enter data in CRF on a new log line and save
  |Field        |Data         |Control Type  |
  |Actual date  |08 Feb 2011  |datetime      |
  |Actual time  |11 17        |datetime      |
  |Test name    |test27       |textbox       |     	
  |Result       |3.8	      |textbox       |  
And I enter data in CRF on a new log line and save
  |Field        |Data         |Control Type  |
  |Actual date  |09 Feb 2011  |datetime      |
  |Actual time  |11 18        |datetime      |
  |Test name    |test28       |textbox       |     	
  |Result       |3.9	      |textbox       | 
And I enter data in CRF on a new log line and save
  |Field        |Data         |Control Type  |
  |Actual date  |10 Feb 2011  |datetime      |
  |Actual time  |11 19        |datetime      |
  |Test name    |test29       |textbox       |     	
  |Result       |3.10	      |textbox       |  
And I verify data on Fields in CRF
  | Field       | Record | Status Icon        |
  | Actual date | 1      | Requires Signature |
  | Actual date | 2      | Requires Signature |
  | Actual date | 3      | Requires Signature |
  | Actual date | 4      | Requires Signature |
  | Actual date | 5      | Requires Signature |
And I take a screenshot
And I click button "Sign and Save"
And I sign the form with username "SUPER USER 1"
And I verify text "Please Sign - Default User  (SUPER USER 1)" with username "SUPER USER 1" exists
And I verify data on Fields in CRF
  | Field       | Record | Status Icon |
  | Actual date | 1      | Complete    |
  | Actual date | 2      | Complete    |
  | Actual date | 3      | Complete    |
  | Actual date | 4      | Complete    |
  | Actual date | 5      | Complete    |
And I take a screenshot  
And I select link "Inactivate"
And I choose "3" from "Inactivate"
When I click button "Inactivate"
And I verify data on Fields in CRF
  | Field       | Record | Status Icon |
  | Actual date | 1      | Complete    |
  | Actual date | 2      | Complete    |
  | Actual date | 3      | Inactive    |
  | Actual date | 4      | Complete    |
  | Actual date | 5      | Complete    |
And I can see "Sign and Save" button
And I take a screenshot
And I select link "Reactivate"
And I choose "3" from "Reactivate"
When I click button "Reactivate"
And I verify data on Fields in CRF
  | Field       | Record | Status Icon        |
  | Actual date | 1      | Complete           |
  | Actual date | 2      | Complete           |
  | Actual date | 3      | Requires Signature |
  | Actual date | 4      | Complete           |
  | Actual date | 5      | Complete           |
And I can see "Sign and Save" button
And I take a screenshot
And I click audit on Field "Actual date" log line "3"
And I choose "Data Point - Actual time" from "Siblings Dropdown"
Then I verify Audits exist
 |Audit Type          |Query Message |User                               |Time                 |
 |DataPoint           |Activated.    |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss |  
 |Signature Broken    |              |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss |
 |DataPoint           |Inactivated.  |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss | 
 |Signature Succeeded |              |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss |
 |User entered        |'11:17'       |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss |
And I take a screenshot

@Release_2013.2.0
@PB_MCC41854-007
@RR29.MAR.2013
@Draft
Scenario: MCC41854-007 Mixed form in Landscape direction - verify signature is not broken incorrectly from log line inactivation, reactivation after applying signature.
#Given I have a mixed form with "Signature Required" in landscape direction 
#And I submit 5 log lines and sign the form
#When I inactivate log line 5
#Then I should not see signature broken for standard field
#When I inactivate log line 4
#And I reactivate log line 5 and log line 4
#Then I should not see signature broken for log line 1
#And I should not see signature broken for log line 5 and log line 4
#And I should see correct audits for log lines

Given I login to Rave with user "SUPER USER 1"
And I select Study "MCC41854" and Site "Site_A"
And I create a Subject
  | Field            | Data              | Control Type |
  | Subject Initials | SUB               | textbox      |
  | Subject Number   | {RndNum<num1>(3)} | textbox      |
  | Subject ID       | SUB {Var(num1)}   | textbox      |
And I take a screenshot 
And I select Form "ECGMixedLandscape"
And I take a screenshot
And I enter data in CRF and save 
  |Field        |Data         |Control Type  |
  |Number       |3            |textbox       |
  |Actual date  |06 Mar 2011  |datetime      |
  |Actual time  |12 15        |datetime      |
  |Test name    |test30       |textbox       |     	
  |Result       |4.1	      |textbox       | 
And I enter data in CRF on a new log line and save
  |Field        |Data         |Control Type  |
  |Actual date  |07 Mar 2011  |datetime      |
  |Actual time  |12 16        |datetime      |
  |Test name    |test31       |textbox       |     	
  |Result       |4.2	      |textbox       | 
And I enter data in CRF on a new log line and save
  |Field        |Data         |Control Type  |
  |Actual date  |08 Mar 2011  |datetime      |
  |Actual time  |12 17        |datetime      |
  |Test name    |test32       |textbox       |     	
  |Result       |4.3	      |textbox       | 
And I enter data in CRF on a new log line and save
  |Field        |Data         |Control Type  |
  |Actual date  |09 Mar 2011  |datetime      |
  |Actual time  |12 18        |datetime      |
  |Test name    |test33       |textbox       |     	
  |Result       |4.4	      |textbox       | 
And I enter data in CRF on a new log line and save
  |Field        |Data         |Control Type  |
  |Actual date  |10 Mar 2011  |datetime      |
  |Actual time  |12 19        |datetime      |
  |Test name    |test34       |textbox       |     	
  |Result       |4.5	      |textbox       | 
And I verify data on Fields in CRF
  | Field  | Data | Status Icon        |
  | Number | 3    | Requires Signature |
And I verify data on Fields in CRF
  | Field       | Record | Status Icon        |
  | Actual date | 1      | Requires Signature |
  | Actual date | 2      | Requires Signature |
  | Actual date | 3      | Requires Signature |
  | Actual date | 4      | Requires Signature |
  | Actual date | 5      | Requires Signature |
And I take a screenshot
And I click button "Sign and Save"
And I sign the form with username "SUPER USER 1"
And I verify text "Please Sign - Default User  (SUPER USER 1)" with username "SUPER USER 1" exists
And I verify data on Fields in CRF
  | Field  | Data | Status Icon        |
  | Number | 3    | Requires Signature |
And I verify data on Fields in CRF
  | Field       | Record | Status Icon |
  | Actual date | 1      | Complete    |
  | Actual date | 2      | Complete    |
  | Actual date | 3      | Complete    |
  | Actual date | 4      | Complete    |
  | Actual date | 5      | Complete    |
And I take a screenshot  
And I select link "Inactivate"
And I choose "5" from "Inactivate"
When I click button "Inactivate"
Then I verify data on Fields in CRF
  | Field  | Data | Status Icon        |
  | Number | 3    | Requires Signature |
And I verify data on Fields in CRF
  | Field       | Record | Status Icon |
  | Actual date | 1      | Complete    |
  | Actual date | 2      | Complete    |
  | Actual date | 3      | Complete    |
  | Actual date | 4      | Complete    |
  | Actual date | 5      | Inactive    |
And I can see "Sign and Save" button
And I take a screenshot  
And I select link "Inactivate"
And I choose "4" from "Inactivate"
When I click button "Inactivate"
Then I verify data on Fields in CRF
  | Field  | Data | Status Icon        |
  | Number | 3    | Requires Signature |
And I verify data on Fields in CRF
  | Field       | Record | Status Icon |
  | Actual date | 1      | Complete    |
  | Actual date | 2      | Complete    |
  | Actual date | 3      | Complete    |
  | Actual date | 4      | Inactive    |
  | Actual date | 5      | Inactive    |
And I can see "Sign and Save" button
And I take a screenshot
And I select link "Reactivate"
And I choose "4" from "Reactivate"
When I click button "Reactivate"
And I select link "Reactivate"
And I choose "5" from "Reactivate"
When I click button "Reactivate"
Then I verify data on Fields in CRF
  | Field  | Data | Status Icon        |
  | Number | 3    | Requires Signature |
And I verify data on Fields in CRF
  | Field       | Record | Status Icon        |
  | Actual date | 1      | Complete           |
  | Actual date | 2      | Complete           |
  | Actual date | 3      | Complete           |
  | Actual date | 4      | Requires Signature |
  | Actual date | 5      | Requires Signature |
And I can see "Sign and Save" button
And I take a screenshot
And I click audit on Field "Actual date" log line "4"
And I choose "Data Point - Test name" from "Siblings Dropdown"
Then I verify Audits exist
 |Audit Type          |Query Message |User                               |Time                 |
 |DataPoint           |Activated.    |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss |  
 |Signature Broken    |              |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss |
 |DataPoint           |Inactivated.  |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss | 
 |Signature Succeeded |              |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss |
 |User entered        |'test33'      |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss |
And I take a screenshot

@Release_2013.2.0
@PB_MCC41854-008
@RR29.MAR.2013
@Draft
Scenario: MCC41854-008 Mixed form in Portrait direction - verify signature is not broken incorrectly from log line inactivation, reactivation after applying signature.

#Given I have a mixed form with "Signature Required" in Portrait direction 
#And I submit 5 log lines and sign the form
#When I inactivate log line 5
#Then I should not see signature broken for standard field
#When I inactivate log line 2
#And I reactivate log line 5 and log line 2
#Then I should not see signature broken for log line 1
#And I should not see signature broken for log line 5 and log line 2
#And I should see correct audits for log lines

Given I login to Rave with user "SUPER USER 1"
And I select Study "MCC41854" and Site "Site_A"
And I create a Subject
  | Field            | Data              | Control Type |
  | Subject Initials | SUB               | textbox      |
  | Subject Number   | {RndNum<num1>(3)} | textbox      |
  | Subject ID       | SUB {Var(num1)}   | textbox      |
And I take a screenshot 
And I select Form "ECGMixedPortrait"
And I take a screenshot
And I enter data in CRF and save 
  |Field        |Data         |Control Type  |
  |Number       |4            |textbox       |
  |Actual date  |06 Apr 2011  |datetime      |
  |Actual time  |12 30        |datetime      |
  |Test name    |test1A       |textbox       |     	
  |Result       |4.6	      |textbox       | 
And I enter data in CRF on a new log line and save
  |Field        |Data         |Control Type  |
  |Actual date  |07 Apr 2011  |datetime      |
  |Actual time  |12 31        |datetime      |
  |Test name    |test1B       |textbox       |     	
  |Result       |4.7	      |textbox       | 
And I enter data in CRF on a new log line and save
  |Field        |Data         |Control Type  |
  |Actual date  |08 Apr 2011  |datetime      |
  |Actual time  |12 32        |datetime      |
  |Test name    |test1C       |textbox       |     	
  |Result       |4.8	      |textbox       | 
And I enter data in CRF on a new log line and save
  |Field        |Data         |Control Type  |
  |Actual date  |09 Apr 2011  |datetime      |
  |Actual time  |12 33        |datetime      |
  |Test name    |test1D       |textbox       |     	
  |Result       |4.9	      |textbox       | 
And I enter data in CRF on a new log line and save
  |Field        |Data         |Control Type  |
  |Actual date  |10 Apr 2011  |datetime      |
  |Actual time  |12 34        |datetime      |
  |Test name    |test1E       |textbox       |     	
  |Result       |4.10	      |textbox       | 
And I verify data on Fields in CRF
  | Field  | Data | Status Icon        |
  | Number | 4    | Requires Signature |
And I verify data on Fields in CRF
  | Field       | Record | Status Icon        |
  | Actual date | 1      | Requires Signature |
  | Actual date | 2      | Requires Signature |
  | Actual date | 3      | Requires Signature |
  | Actual date | 4      | Requires Signature |
  | Actual date | 5      | Requires Signature |
And I take a screenshot
And I click button "Sign and Save"
And I sign the form with username "SUPER USER 1"
And I verify text "Please Sign - Default User  (SUPER USER 1)" with username "SUPER USER 1" exists
And I verify data on Fields in CRF
  | Field  | Data | Status Icon        |
  | Number | 4    | Requires Signature |
And I verify data on Fields in CRF
  | Field       | Record | Status Icon |
  | Actual date | 1      | Complete    |
  | Actual date | 2      | Complete    |
  | Actual date | 3      | Complete    |
  | Actual date | 4      | Complete    |
  | Actual date | 5      | Complete    |
And I take a screenshot  
And I select link "Inactivate"
And I choose "5" from "Inactivate"
When I click button "Inactivate"
Then I verify data on Fields in CRF
  | Field  | Data | Status Icon        |
  | Number | 4    | Requires Signature |
And I verify data on Fields in CRF
  | Field       | Record | Status Icon |
  | Actual date | 1      | Complete    |
  | Actual date | 2      | Complete    |
  | Actual date | 3      | Complete    |
  | Actual date | 4      | Complete    |
  | Actual date | 5      | Inactive    |
And I can see "Sign and Save" button
And I take a screenshot  
And I select link "Inactivate"
And I choose "2" from "Inactivate"
When I click button "Inactivate"
Then I verify data on Fields in CRF
  | Field  | Data | Status Icon        |
  | Number | 4    | Requires Signature |
And I verify data on Fields in CRF
  | Field       | Record | Status Icon |
  | Actual date | 1      | Complete    |
  | Actual date | 2      | Inactive    |
  | Actual date | 3      | Complete    |
  | Actual date | 4      | Complete    |
  | Actual date | 5      | Inactive    |
And I can see "Sign and Save" button
And I take a screenshot
And I select link "Reactivate"
And I choose "2" from "Reactivate"
When I click button "Reactivate"
And I select link "Reactivate"
And I choose "5" from "Reactivate"
When I click button "Reactivate"
Then I verify data on Fields in CRF
  | Field  | Data | Status Icon        |
  | Number | 4    | Requires Signature |
And I verify data on Fields in CRF
  | Field       | Record | Status Icon        |
  | Actual date | 1      | Complete           |
  | Actual date | 2      | Requires Signature |
  | Actual date | 3      | Complete           |
  | Actual date | 4      | Complete           |
  | Actual date | 5      | Requires Signature |
And I can see "Sign and Save" button
And I take a screenshot
And I click audit on Field "Actual date" log line "2"
And I choose "Data Point - Result" from "Siblings Dropdown"
Then I verify Audits exist
 |Audit Type          |Query Message |User                               |Time                 |
 |DataPoint           |Activated.    |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss |  
 |Signature Broken    |              |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss |
 |DataPoint           |Inactivated.  |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss | 
 |Signature Succeeded |              |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss |
 |User entered        |'4.7'         |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss |
And I take a screenshot

@Release_2013.2.0
@PB_MCC41854-009
@RR29.MAR.2013
@Draft
Scenario: MCC41854-009 Log form in Landscape direction - verify signature is not broken incorrectly from log line inactivation, signing and reactivation.

#Note: Refer MCC-57931 for the commented line (Signature Succeeded) in the scenario. After fixing the story MCC-57931, the line can be uncommented and executable.

#Given I have a log form with "Signature Required" in landscape direction 
#And I submit 5 log lines
#And I inactivate log line 5
#And I sign the form
#When I reactivate log line 5
#Then I should not see signature broken for log line 5
#And I should see correct audits for log lines

Given I login to Rave with user "SUPER USER 1"
And I select Study "MCC41854" and Site "Site_A"
And I create a Subject
  | Field            | Data              | Control Type |
  | Subject Initials | SUB               | textbox      |
  | Subject Number   | {RndNum<num1>(3)} | textbox      |
  | Subject ID       | SUB {Var(num1)}   | textbox      |
And I take a screenshot 
And I select Form "ECGLogLandscape"
And I take a screenshot
And I enter data in CRF and save 
  |Field        |Data         |Control Type  |
  |Actual date  |11 Jan 2011  |datetime      |
  |Actual time  |10 01        |datetime      |
  |Test name    |t1           |textbox       |     	
  |Result       |5.1	      |textbox       | 
And I enter data in CRF on a new log line and save
  |Field        |Data         |Control Type  |
  |Actual date  |12 Jan 2011  |datetime      |
  |Actual time  |10 02        |datetime      |
  |Test name    |t2           |textbox       |     	
  |Result       |5.2	      |textbox       | 
And I enter data in CRF on a new log line and save
  |Field        |Data         |Control Type  |
  |Actual date  |13 Jan 2011  |datetime      |
  |Actual time  |10 03        |datetime      |
  |Test name    |t3           |textbox       |     	
  |Result       |5.3	      |textbox       | 
And I enter data in CRF on a new log line and save
  |Field        |Data         |Control Type  |
  |Actual date  |14 Jan 2011  |datetime      |
  |Actual time  |10 04        |datetime      |
  |Test name    |t4           |textbox       |     	
  |Result       |5.4	      |textbox       | 
And I enter data in CRF on a new log line and save
  |Field        |Data         |Control Type  |
  |Actual date  |15 Jan 2011  |datetime      |
  |Actual time  |10 05        |datetime      |
  |Test name    |t5           |textbox       |     	
  |Result       |5.5	      |textbox       |  
And I verify data on Fields in CRF
  | Field       | Record | Status Icon        |
  | Actual date | 1      | Requires Signature |
  | Actual date | 2      | Requires Signature |
  | Actual date | 3      | Requires Signature |
  | Actual date | 4      | Requires Signature |
  | Actual date | 5      | Requires Signature |
And I take a screenshot
And I select link "Inactivate"
And I choose "5" from "Inactivate"
When I click button "Inactivate"
And I verify data on Fields in CRF
  | Field       | Record | Status Icon        |
  | Actual date | 1      | Requires Signature |
  | Actual date | 2      | Requires Signature |
  | Actual date | 3      | Requires Signature |
  | Actual date | 4      | Requires Signature |
  | Actual date | 5      | Inactive           |
And I can see "Sign and Save" button
And I click button "Sign and Save"
And I sign the form with username "SUPER USER 1"
And I verify text "Please Sign - Default User  (SUPER USER 1)" with username "SUPER USER 1" exists
And I verify data on Fields in CRF
  | Field       | Record | Status Icon |
  | Actual date | 1      | Complete    |
  | Actual date | 2      | Complete    |
  | Actual date | 3      | Complete    |
  | Actual date | 4      | Complete    |
  | Actual date | 5      | Inactive    |
And I take a screenshot  
And I select link "Reactivate"
And I choose "5" from "Reactivate"
When I click button "Reactivate"
And I verify data on Fields in CRF
  | Field       | Record | Status Icon        |
  | Actual date | 1      | Complete           |
  | Actual date | 2      | Complete           |
  | Actual date | 3      | Complete           |
  | Actual date | 4      | Complete           |
  | Actual date | 5      | Requires Signature |
And I can see "Sign and Save" button
And I take a screenshot
And I click audit on Field "Actual date" log line "5"
And I choose "Data Point - Actual date" from "Siblings Dropdown"
Then I verify Audits exist
  |Audit Type          |Query Message |User                               |Time                 |
  |Signature Broken    |              |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss |
  |DataPoint           |Activated.    |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss |  
  |Signature Succeeded |              |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss |
  |DataPoint           |Inactivated.  |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss | 
  |User entered        |'15 Jan 2011' |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss |
And I take a screenshot

@Release_2013.2.0
@PB_MCC41854-010
@RR29.MAR.2013
@Draft
Scenario: MCC41854-010 Log form in Portrait direction - verify signature is not broken incorrectly from log line inactivation, signing and reactivation.

#Note: Refer MCC-57931 for the commented line (Signature Succeeded) in the scenario. After fixing the story MCC-57931, the line can be uncommented and executable.

#Given I have a log form with "Signature Required" in landscape direction 
#And I submit 5 log lines
#And I inactivate log line 4
#And I sign the form
#When I reactivate log line 4
#Then I should not see signature broken for log line 4
#And I should see correct audits for log lines

Given I login to Rave with user "SUPER USER 1"
And I select Study "MCC41854" and Site "Site_A"
And I create a Subject
  | Field            | Data              | Control Type |
  | Subject Initials | SUB               | textbox      |
  | Subject Number   | {RndNum<num1>(3)} | textbox      |
  | Subject ID       | SUB {Var(num1)}   | textbox      |
And I take a screenshot 
And I select Form "ECGLogPortrait"
And I take a screenshot
And I enter data in CRF and save 
  |Field        |Data         |Control Type  |
  |Actual date  |16 Jan 2011  |datetime      |
  |Actual time  |10 06        |datetime      |
  |Test name    |t6           |textbox       |     	
  |Result       |5.6	      |textbox       | 
And I enter data in CRF on a new log line and save
  |Field        |Data         |Control Type  |
  |Actual date  |17 Jan 2011  |datetime      |
  |Actual time  |10 07        |datetime      |
  |Test name    |t7           |textbox       |     	
  |Result       |5.7	      |textbox       | 
And I enter data in CRF on a new log line and save
  |Field        |Data         |Control Type  |
  |Actual date  |18 Jan 2011  |datetime      |
  |Actual time  |10 08        |datetime      |
  |Test name    |t8           |textbox       |     	
  |Result       |5.8	      |textbox       | 
And I enter data in CRF on a new log line and save
  |Field        |Data         |Control Type  |
  |Actual date  |19 Jan 2011  |datetime      |
  |Actual time  |10 09        |datetime      |
  |Test name    |t9           |textbox       |     	
  |Result       |5.9	      |textbox       | 
And I enter data in CRF on a new log line and save
  |Field        |Data         |Control Type  |
  |Actual date  |20 Jan 2011  |datetime      |
  |Actual time  |10 30        |datetime      |
  |Test name    |t10          |textbox       |     	
  |Result       |5.10	      |textbox       |  
And I verify data on Fields in CRF
  | Field       | Record | Status Icon        |
  | Actual date | 1      | Requires Signature |
  | Actual date | 2      | Requires Signature |
  | Actual date | 3      | Requires Signature |
  | Actual date | 4      | Requires Signature |
  | Actual date | 5      | Requires Signature |
And I take a screenshot
And I select link "Inactivate"
And I choose "4" from "Inactivate"
When I click button "Inactivate"
And I verify data on Fields in CRF
  | Field       | Record | Status Icon        |
  | Actual date | 1      | Requires Signature |
  | Actual date | 2      | Requires Signature |
  | Actual date | 3      | Requires Signature |
  | Actual date | 4      | Inactive           |
  | Actual date | 5      | Requires Signature |
And I can see "Sign and Save" button
And I click button "Sign and Save"
And I sign the form with username "SUPER USER 1"
And I verify text "Please Sign - Default User  (SUPER USER 1)" with username "SUPER USER 1" exists
And I verify data on Fields in CRF
  | Field       | Record | Status Icon |
  | Actual date | 1      | Complete    |
  | Actual date | 2      | Complete    |
  | Actual date | 3      | Complete    |
  | Actual date | 4      | Inactive    |
  | Actual date | 5      | Complete    |
And I take a screenshot  
And I select link "Reactivate"
And I choose "4" from "Reactivate"
When I click button "Reactivate"
And I verify data on Fields in CRF
  | Field       | Record | Status Icon        |
  | Actual date | 1      | Complete           |
  | Actual date | 2      | Complete           |
  | Actual date | 3      | Complete           |
  | Actual date | 4      | Requires Signature |
  | Actual date | 5      | Complete           |
And I can see "Sign and Save" button
And I take a screenshot
And I click audit on Field "Actual date" log line "4"
And I choose "Data Point - Actual time" from "Siblings Dropdown"
Then I verify Audits exist
 |Audit Type          |Query Message |User                               |Time                 |
 |Signature Broken    |              |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss |
 |DataPoint           |Activated.    |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss |  
 |Signature Succeeded |              |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss |
 |DataPoint           |Inactivated.  |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss | 
 |User entered        |'10:09'       |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss |
And I take a screenshot

@Release_2013.2.0
@PB_MCC41854-011
@RR29.MAR.2013
@Draft
Scenario: MCC41854-011 Mixed form in Landscape direction - verify signature is not broken incorrectly from log line inactivation, signing and reactivation.

#Note: Refer MCC-57931 for the commented line (Signature Succeeded) in the scenario. After fixing the story MCC-57931, the line can be uncommented and executable.

#Given I have a mixed form with "Signature Required" in landscape direction 
#And I submit 5 log lines
#And I inactivate log line 5 and log line 4
#And I sign the form
#When I reactivate log line 5 and log line 4
#Then I should not see signature broken for log line 5 and log line 4
#And I should see correct audits for log lines

Given I login to Rave with user "SUPER USER 1"
And I select Study "MCC41854" and Site "Site_A"
And I create a Subject
  | Field            | Data              | Control Type |
  | Subject Initials | SUB               | textbox      |
  | Subject Number   | {RndNum<num1>(3)} | textbox      |
  | Subject ID       | SUB {Var(num1)}   | textbox      |
And I take a screenshot 
And I select Form "ECGMixedLandscape"
And I take a screenshot
And I enter data in CRF and save 
  |Field        |Data         |Control Type  |
  |Number       |5            |textbox       |
  |Actual date  |11 Mar 2011  |datetime      |
  |Actual time  |12 01        |datetime      |
  |Test name    |t11          |textbox       |     	
  |Result       |4.6	      |textbox       | 
And I enter data in CRF on a new log line and save
  |Field        |Data         |Control Type  |
  |Actual date  |12 Mar 2011  |datetime      |
  |Actual time  |12 02        |datetime      |
  |Test name    |t12          |textbox       |     	
  |Result       |4.7	      |textbox       | 
And I enter data in CRF on a new log line and save
  |Field        |Data         |Control Type  |
  |Actual date  |13 Mar 2011  |datetime      |
  |Actual time  |12 03        |datetime      |
  |Test name    |t13          |textbox       |     	
  |Result       |4.8	      |textbox       | 
And I enter data in CRF on a new log line and save
  |Field        |Data         |Control Type  |
  |Actual date  |14 Mar 2011  |datetime      |
  |Actual time  |12 04        |datetime      |
  |Test name    |t14          |textbox       |     	
  |Result       |4.9	      |textbox       | 
And I enter data in CRF on a new log line and save
  |Field        |Data         |Control Type  |
  |Actual date  |15 Mar 2011  |datetime      |
  |Actual time  |12 05        |datetime      |
  |Test name    |t15          |textbox       |     	
  |Result       |4.10	      |textbox       | 
And I verify data on Fields in CRF
  | Field  | Data | Status Icon        |
  | Number | 5    | Requires Signature |
And I verify data on Fields in CRF
  | Field       | Record | Status Icon        |
  | Actual date | 1      | Requires Signature |
  | Actual date | 2      | Requires Signature |
  | Actual date | 3      | Requires Signature |
  | Actual date | 4      | Requires Signature |
  | Actual date | 5      | Requires Signature |
And I take a screenshot
And I select link "Inactivate"
And I choose "5" from "Inactivate"
And I click button "Inactivate"
And I select link "Inactivate"
And I choose "4" from "Inactivate"
When I click button "Inactivate"
And I verify data on Fields in CRF
  | Field       | Record | Status Icon        |
  | Actual date | 1      | Requires Signature |
  | Actual date | 2      | Requires Signature |
  | Actual date | 3      | Requires Signature |
  | Actual date | 4      | Inactive           |
  | Actual date | 5      | Inactive           |
And I can see "Sign and Save" button
And I click button "Sign and Save"
And I sign the form with username "SUPER USER 1"
And I verify text "Please Sign - Default User  (SUPER USER 1)" with username "SUPER USER 1" exists
And I select link "Reactivate"
And I choose "5" from "Reactivate"
When I click button "Reactivate"
And I select link "Reactivate"
And I choose "4" from "Reactivate"
When I click button "Reactivate"
And I verify data on Fields in CRF
  | Field       | Record | Status Icon        |
  | Actual date | 1      | Complete           |
  | Actual date | 2      | Complete           |
  | Actual date | 3      | Complete           |
  | Actual date | 4      | Requires Signature |
  | Actual date | 5      | Requires Signature |
And I can see "Sign and Save" button
And I take a screenshot
And I click audit on Field "Actual date" log line "4"
And I choose "Data Point - Test name" from "Siblings Dropdown"
Then I verify Audits exist
 |Audit Type          |Query Message |User                               |Time                 |
 |Signature Broken    |              |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss |
 |DataPoint           |Activated.    |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss |  
 |Signature Succeeded |              |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss |
 |DataPoint           |Inactivated.  |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss | 
 |User entered        |'t14'         |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss |
And I take a screenshot

@Release_2013.2.0
@PB_MCC41854-012
@RR29.MAR.2013
@Draft
Scenario: MCC41854-012 Mixed form in Portrait direction - verify signature is not broken incorrectly from log line inactivation, signing and reactivation.

#Note: Refer MCC-57931 for the commented line (Signature Succeeded) in the scenario. After fixing the story MCC-57931, the line can be uncommented and executable.

#Given I have a mixed form with "Signature Required" in Portrait direction 
#And I submit 5 log lines
#And I inactivate log line 5 and log line 2
#And I sign the form
#When I reactivate log line 5 and log line 2
#Then I should not see signature broken for log line 5 and log line 2
#And I should see correct audits for log lines

Given I login to Rave with user "SUPER USER 1"
And I select Study "MCC41854" and Site "Site_A"
And I create a Subject
  | Field            | Data              | Control Type |
  | Subject Initials | SUB               | textbox      |
  | Subject Number   | {RndNum<num1>(3)} | textbox      |
  | Subject ID       | SUB {Var(num1)}   | textbox      |
And I take a screenshot 
And I select Form "ECGMixedPortrait"
And I take a screenshot
And I enter data in CRF and save
  |Field        |Data         |Control Type  |
  |Number       |6            |textbox       |
  |Actual date  |20 Mar 2011  |datetime      |
  |Actual time  |12 06        |datetime      |
  |Test name    |t20          |textbox       |     	
  |Result       |5.1	      |textbox       | 
And I enter data in CRF on a new log line and save
  |Field        |Data         |Control Type  |
  |Actual date  |21 Mar 2011  |datetime      |
  |Actual time  |12 07        |datetime      |
  |Test name    |t21          |textbox       |     	
  |Result       |5.2	      |textbox       | 
And I enter data in CRF on a new log line and save
  |Field        |Data         |Control Type  |
  |Actual date  |22 Mar 2011  |datetime      |
  |Actual time  |12 08        |datetime      |
  |Test name    |t22          |textbox       |     	
  |Result       |5.3	      |textbox       | 
And I enter data in CRF on a new log line and save
  |Field        |Data         |Control Type  |
  |Actual date  |23 Mar 2011  |datetime      |
  |Actual time  |12 09        |datetime      |
  |Test name    |t23          |textbox       |     	
  |Result       |5.4	      |textbox       | 
And I enter data in CRF on a new log line and save
  |Field        |Data         |Control Type  |
  |Actual date  |24 Mar 2011  |datetime      |
  |Actual time  |12 10        |datetime      |
  |Test name    |t24          |textbox       |     	
  |Result       |5.5	      |textbox       | 
And I verify data on Fields in CRF
  | Field  | Data | Status Icon        |
  | Number | 6    | Requires Signature |
And I verify data on Fields in CRF
  | Field       | Record | Status Icon        |
  | Actual date | 1      | Requires Signature |
  | Actual date | 2      | Requires Signature |
  | Actual date | 3      | Requires Signature |
  | Actual date | 4      | Requires Signature |
  | Actual date | 5      | Requires Signature |
And I take a screenshot
And I select link "Inactivate"
And I choose "5" from "Inactivate"
And I click button "Inactivate"
And I select link "Inactivate"
And I choose "2" from "Inactivate"
When I click button "Inactivate"
And I verify data on Fields in CRF
  | Field       | Record | Status Icon        |
  | Actual date | 1      | Requires Signature |
  | Actual date | 2      | Inactive           |
  | Actual date | 3      | Requires Signature |
  | Actual date | 4      | Requires Signature |
  | Actual date | 5      | Inactive           |
And I can see "Sign and Save" button
And I click button "Sign and Save"
And I sign the form with username "SUPER USER 1"
And I verify text "Please Sign - Default User  (SUPER USER 1)" with username "SUPER USER 1" exists
And I select link "Reactivate"
And I choose "5" from "Reactivate"
When I click button "Reactivate"
And I select link "Reactivate"
And I choose "2" from "Reactivate"
When I click button "Reactivate"
And I verify data on Fields in CRF
  | Field       | Record | Status Icon        |
  | Actual date | 1      | Complete           |
  | Actual date | 2      | Requires Signature |
  | Actual date | 3      | Complete           |
  | Actual date | 4      | Complete           |
  | Actual date | 5      | Requires Signature |
And I can see "Sign and Save" button
And I take a screenshot
And I click audit on Field "Actual date" log line "2"
And I choose "Data Point - Result" from "Siblings Dropdown"
Then I verify Audits exist
 |Audit Type          |Query Message |User                               |Time                 |
 |Signature Broken    |              |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss |
 |DataPoint           |Activated.    |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss |  
 |Signature Succeeded |              |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss |
 |DataPoint           |Inactivated.  |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss | 
 |User entered        |'5.2'         |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss |
And I take a screenshot

@Release_2013.2.0
@PB_MCC41854-013
@RR28.MAR.2013
@Draft
Scenario: MCC41854-013 Log form in Portrait direction - verify signature is broken after inactivating all log lines.

#Given I have a log form with "Signature Required" in Portrait direction 
#And I submit 5 log lines and sign the form
#When I inactivate all log lines
#Then I should see signature broken for form
#And I should see correct audits for log lines

Given I login to Rave with user "SUPER USER 1"
And I select Study "MCC41854" and Site "Site_A"
And I create a Subject
  | Field            | Data              | Control Type |
  | Subject Initials | SUB               | textbox      |
  | Subject Number   | {RndNum<num1>(3)} | textbox      |
  | Subject ID       | SUB {Var(num1)}   | textbox      |
And I take a screenshot 
And I select Form "ECGLogPortrait"
And I take a screenshot
And I enter data in CRF and save 
  |Field        |Data         |Control Type  |
  |Actual date  |20 Feb 2011  |datetime      |
  |Actual time  |11 20        |datetime      |
  |Test name    |test44       |textbox       |     	
  |Result       |8.1	      |textbox       | 
And I enter data in CRF on a new log line and save
  |Field        |Data         |Control Type  |
  |Actual date  |21 Feb 2011  |datetime      |
  |Actual time  |11 21        |datetime      |
  |Test name    |test45       |textbox       |     	
  |Result       |8.2	      |textbox       | 
And I enter data in CRF on a new log line and save
  |Field        |Data         |Control Type  |
  |Actual date  |22 Feb 2011  |datetime      |
  |Actual time  |11 22        |datetime      |
  |Test name    |test46       |textbox       |     	
  |Result       |8.3	      |textbox       |  
And I enter data in CRF on a new log line and save
  |Field        |Data         |Control Type  |
  |Actual date  |23 Feb 2011  |datetime      |
  |Actual time  |11 23        |datetime      |
  |Test name    |test47       |textbox       |     	
  |Result       |8.4	      |textbox       | 
And I enter data in CRF on a new log line and save
  |Field        |Data         |Control Type  |
  |Actual date  |24 Feb 2011  |datetime      |
  |Actual time  |11 24        |datetime      |
  |Test name    |test48       |textbox       |     	
  |Result       |8.5	      |textbox       |  
And I verify data on Fields in CRF
  | Field       | Record | Status Icon        |
  | Actual date | 1      | Requires Signature |
  | Actual date | 2      | Requires Signature |
  | Actual date | 3      | Requires Signature |
  | Actual date | 4      | Requires Signature |
  | Actual date | 5      | Requires Signature |
And I take a screenshot
And I click button "Sign and Save"
And I sign the form with username "SUPER USER 1"
And I verify text "Please Sign - Default User  (SUPER USER 1)" with username "SUPER USER 1" exists
And I verify data on Fields in CRF
  | Field       | Record | Status Icon |
  | Actual date | 1      | Complete    |
  | Actual date | 2      | Complete    |
  | Actual date | 3      | Complete    |
  | Actual date | 4      | Complete    |
  | Actual date | 5      | Complete    |
And I take a screenshot  
And I select link "Inactivate"
And I choose "5" from "Inactivate"
When I click button "Inactivate"
And I select link "Inactivate"
And I choose "4" from "Inactivate"
When I click button "Inactivate"
And I select link "Inactivate"
And I choose "3" from "Inactivate"
When I click button "Inactivate"
And I select link "Inactivate"
And I choose "2" from "Inactivate"
When I click button "Inactivate"
And I select link "Inactivate"
And I choose "1" from "Inactivate"
When I click button "Inactivate"
And I verify data on Fields in CRF
  | Field       | Record | Status Icon |
  | Actual date | 1      | Inactive    |
  | Actual date | 2      | Inactive    |
  | Actual date | 3      | Inactive    |
  | Actual date | 4      | Inactive    |
  | Actual date | 5      | Inactive    |
And I can see "Sign and Save" button
And I take a screenshot
And I click audit on Field "Actual date" log line "1"
And I choose "Data Point - Actual date" from "Siblings Dropdown"
Then I verify Audits exist
  |Audit Type           |Query Message |User                               |Time                 |
  |Signature Broken     |              |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss |
  |DataPoint            |Inactivated.  |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss |  
  |Signature Succeeded  |              |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss |
  |User entered         |'20 Feb 2011' |Default User ([id] - SUPER USER 1) |dd MMM yyyy HH:mm:ss |
And I take a screenshot