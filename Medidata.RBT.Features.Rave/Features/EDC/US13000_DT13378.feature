# Upon further investigation, there is a known lab cascade change performance issue that is occurring on clients who utilize labs a great deal and make many changes to both the local and global (alert) labs.
# What happens in these cases is that changes cascade for the same analyte and the same lab in one form, however, in a different form for the same subject, the alerts do not cascade properly and therefore cause a discrepancy. In one form you have a different alert status than another for the same subject, same analyte and same lab.
# The impact and severity of this issue is high, as many prompts for clinical significance may be destroyed in the cascading of changes causing sites to have to re-enter CS data. Also, the integrity of labs is potentially compromised as the alert ranges are discrepant in various forms for the same analyte.
# In order to resolve this issue, the affected subjects need to either be inserted back into the labupdatequeue for processing, or splabcascadechangetosubject needs to be called in a cursor or while loop on the affected subjects. The latter takes more time to execute and may cause performance issues on the server, as it uses a lot of memory in execution and does the cascade changes at the time of processing. The former solution will do them at a deferred rate, and will generally take more time, however, it will not cause performance issues on the SQL server.
@ignore
@EnableSeeding=False
@SuppressSeeding=Site,SiteGroup,Role,User,SecurityRole

Feature: US13000_DT13378 Lab Cascade changes do not occur completely if there is a massive amount of changes to be done (performance)
	As a Rave user
	Given I enter lab values that are out of range
	And I provide clinical significance information
	When I change the lab ranges for multiple labs
	And the lab values are still out of range
	Then I should still see the clinical significance information

Background:
      Given I login to Rave with user "defuser" and password "password"
#	And following Project assignments exist
#	|User	 |Project	     |Environment	|Role |Site	  |Site Number	|
#	|defuser |US13000_DT13378|Prod			|cdm1 |Site 1 |S100			|
#    And Role "cdm1" has Action "Query"
#	And Role "cdm1" has Missing Code "ND"
#	And Project "US13000_DT13378" has Draft "<Draft1>"
#	And I publish and push CRF Version "CRF Version<RANDOMNUMBER>" of Draft "<Draft1>" to site "Site 1" in Project "DT13977 SJ " for Enviroment"Prod"
#	And the Local Lab "US13000_DT13378_LocalLab" exists
#	And the Alert Lab "US13000_DT13378_AlertLab" exists
#	And the following Lab assignment exists
#	|Project	     |Environment	|Site	|Lab				     |
#	|US13000_DT13378 |Prod			|Site 1	|US13000_DT13378_LocalLab|
#	|US13000_DT13378 |Prod			|Site 1	|US13000_DT13378_AlertLab|
#	And Lab analyte fields should have "Prompt for Clinical Significance" checked in Architect
# Lab analyte fields should have "Prompt for Clinical Significance" checked in Architect

@release_2012.1.0		
@PB_US13000_DT13378_01
@Validation
Scenario: PB_US13000_DT13378_01 As an EDC user, when I clinical significance information and make changes to the local lab and Alert lab ranges such that the lab value is still above range, then I should still see the clinical significance information.
	
	When I select Study "IMCLCP11-0805" and Site "135 - Denis"
	And I create a Subject
	| Field        | Data                 | Control Type	|
	| Site Number: | 135                  | textbox			|
	| Subject ID:  | LAB{RndNum<num1>(4)} | textbox			|
	And I select link "Pre-Treatment"
	And I select link "Informed Consent"
	And I enter data in CRF and save
	| Field													| Data        | Control Type |
	| Patient signed informed consent form on (dd MMM yyyy)	| 01 Jan 2012 | datetime     |
	And I click button "Save"
	And I select link "Demographics"
	And I enter data in CRF and save
	| Field                       | Data        | Control Type |
	| Date of Birth (dd MMM yyyy) | 01 Apr 1982 | datetime     |
	| Sex:                        | Male        | radiobutton  |
	And I click button "Save"
	And I select link "Serum Chemistry"
	And I choose "laboratoire beauverger" from "Lab"
	And I enter data in CRF and save
	| Field                       | Data | Unit   |
	| Sodium                      | ND   | mEq/L  |
	| Potassium                   | 8    | mEq/L  |
	| Chloride                    | ND   | mEq/L  |
	| Creatinine                  | ND   | µmol/L |
	| BUN                         | ND   | mmol/L |
	| Glucose                     | ND   | mmol/L |
	| Calcium                     | ND   | mmol/L |
	| Phosphorus                  | ND   | mmol/L |
	| Magnesium                   | ND   | mmol/L |
	| Total Protein               | ND   | g/L    |
	| Albumin                     | ND   | g/L    |
	| Uric Acid                   | ND   | µmol/L |
	| Total Bilirubin             | ND   | µmol/L |
	| ALT                         | ND   | U/L    |
	| AST                         | ND   | U/L    |
	| Alkaline Phosphatase        | ND   | U/L    |
	| Lactate Dehydrogenase (LDH) | ND   | U/L    |
	#And I enter data in CRF and save
	#| Field						| Data			| Control Type	|
	#| Sample Date (dd MMM yyyy) | 01 Jan 2012	| datetime		|
	And I click button "Save"
	And I choose "Clinically Significant" from "Clinical Significance"
	And I click button "Save"
	And I verify lab ranges
	| Field		| Data | Range Status | Range		| Unit	| Status Icon			|
	| Potassium	| 8    | ++           | 3.8 - 4.8	| mEq/L	| Requires Verification	|
	And I select link "Demographics"
	And I enter data in CRF and save
	| Field							| Data			| Control Type |
	| Sex:							| Female		| radiobutton  |
	And I click button "Save"
	And I wait for 1 minute
	And I select link "Serum Chemistry"
	Then I should see Clinical Significance "Clinically Significant" on Field "Potassium"
	And I verify lab ranges
	| Field		| Data | Range Status | Range		| Unit	| Status Icon			|
	| Potassium	| 8    | ++           | 3.8 - 4.8	| mEq/L	| Requires Verification	|

@release_2012.1.0		
@PB_US13000_DT13378_02
@Validation
Scenario: PB_US13000_DT13378_02 As an EDC user, when I clinical significance information and make changes to the local lab and Alert lab ranges such that the lab value is still below range, then I should still see the clinical significance information.

	When I select Study "IMCLCP11-0805" and Site "135 - Denis"
	And I create a Subject
	| Field        | Data                 | Control Type	|
	| Site Number: | 135                  | textbox			|
	| Subject ID:  | LAB{RndNum<num1>(4)} | textbox			|
	And I select link "Pre-Treatment"
	And I select link "Informed Consent"
	And I enter data in CRF and save
	| Field													| Data        | Control Type |
	| Patient signed informed consent form on (dd MMM yyyy)	| 01 Jan 2012 | datetime     |
	And I click button "Save"
	And I select link "Demographics"
	And I enter data in CRF and save
	| Field                       | Data        | Control Type |
	| Date of Birth (dd MMM yyyy) | 01 Apr 1982 | datetime     |
	| Sex:                        | Male        | radiobutton  |
	And I click button "Save"
	And I select link "Serum Chemistry"
	And I choose "laboratoire beauverger" from "Lab"
	And I enter data in CRF and save
	| Field							| Data	| Unit		|
	| Sodium						| ND    | mEq/L		|
	| Potassium						| 1		| mEq/L		|
	| Chloride						| ND    | mEq/L		|
	| Creatinine					| ND    | µmol/L	|
	| BUN							| ND    | mmol/L	|
	| Glucose						| ND    | mmol/L	|
	| Calcium						| ND    | mmol/L	|
	| Phosphorus					| ND    | mmol/L	|
	| Magnesium						| ND    | mmol/L	|
	| Total Protein					| ND    | g/L		|
	| Albumin						| ND    | g/L		|
	| Uric Acid						| ND    | µmol/L	|
	| Total Bilirubin				| ND    | µmol/L	|
	| ALT							| ND    | U/L		|
	| AST							| ND    | U/L		|
	| Alkaline Phosphatase			| ND    | U/L		|
	| Lactate Dehydrogenase (LDH)	| ND    | U/L		|
	And I click button "Save"
	And I choose "Clinically Significant" from "Clinical Significance"
	And I click button "Save"
	And I verify lab ranges
	| Field		| Data | Range Status | Range		| Unit	| Status Icon			|
	| Potassium	| 1    | --           | 3.8 - 4.8	| mEq/L	| Requires Verification	|
	And I select link "Demographics"
	And I enter data in CRF and save
	| Field							| Data			| Control Type |
	| Sex:							| Female		| radiobutton  |
	And I click button "Save"
	And I wait for 1 minute
	And I select link "Serum Chemistry"
	Then I should see Clinical Significance "Clinically Significant" on Field "Potassium"
	And I verify lab ranges
	| Field		| Data | Range Status | Range		| Unit	| Status Icon			|
	| Potassium	| 1    | --           | 3.8 - 4.8	| mEq/L	| Requires Verification	|