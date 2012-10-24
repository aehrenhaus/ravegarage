# Subject Date is being used in searching Lab variable mapping value. If subject date is not set from any datapoint value, then it defaults to the timestamp the subjects was first created.

# If the study is not built perfectly, system may not find Lab variable mapping value because of subject date.
# For example, Age is a lab variable (Closest to InputDate) and exists in each visit.
# Subject is created on 2010-01-05 and there is not any datapoint can set subject date, so subject data is 2010-01-05 too.
# Screen (2010-01-01, Age=40) -> Visit 1 (Missing, Age is empty) -> Visit2 (2010-01-20, Age=40)
# Also, these is a lab form with sample date = 2010-01-04

# Now, when system do Lab range searching, system will try to use the Age in Visit 1 which is the closest mapped variable because of subject date.

# To fix: we need to remove subject date from order by so that subject date will not affect search order. Also we need to keep all lab variable datapoints in search targets, it is to say when record date, datapage date and instance date is null for an Age datapoint, but if it is the only one in subject, it will be fetched.
@ignore
Feature: DT 10991 Remove Subject Date from order by statement in searching Lab Variable Mapping Value
	As a Rave user
	When I skip a visit
	And enter lab data after that visit
	Then I expect to see lab ranges for the lab data
	So that I can use the Rave lab features of out of range flagging, clinical significance prompts, and lab clinical view

Background:
    Given I am logged in to Rave with username "defuser" and password "password"
	And following Project assignments exist
	|User	|Project	|Environment	|Role |Site	  |Site Number	|
	|User 1 |Mediflex	|Prod			|cdm1 |Site 1 |S100			|
    And Role "cdm1" has Action "Query"
	And Project "Mediflex" has Draft "<Draft1>"
	And the following Lab Settings and Lab Variable Mappings exists
	|Range Type	|Variable	|Folder	|Form 	|Field	|Location     						|
	|Standard	|Age	 	|      	|Visit	|Age  	|Earliest date						|
	And I publish and push CRF Version "CRF Version<RANDOMNUMBER>" of Draft "<Draft1>" to site "Site 1" in Project "Mediflex" for Enviroment "Prod"
	And the Central Lab "Mediflex Central Lab" exists
	And the following Lab assignment exists
	|Project	|Environment	|Site	|Lab					|
	|Mediflex	|Prod			|Site 1	|Mediflex Central Lab	|

# Visit Date and Lab Date should have "Observation Date of Form" checked in Architect
		
@PB-DT10991-01
Scenario: As an EDC user, when I enter a missing date in the first Visit Date, a valid date in the second Visit Date, and a Lab Date after the second Visit Date and the lab Age variable is mapped to the Earliest date, then I should see lab ranges.
	When I create a Subject
	| Field				|Value	|
	| Subject Number	|101	|
	| Subject Initials	|SUBJ	|	
	And I am on CRF page "Visit Date" in Folder "Visit 1" in Subject "101SUBJ" in Site "Site 1" in Study "Mediflex"
	And I enter data in CRF
	|Field		|Value	|
	|Visit Date	|		|
	|Age		|		|
	And I save the CRF
	And I am on CRF page "Visit Date" in Folder "Visit 2" in Subject "101SUBJ" in Site "Site 1" in Study "Mediflex"
	And I enter data in CRF
	|Field		|Value		|
	|Visit Date	|01 FEB 2011|
	|Age		|20			|
	And I save the CRF
	And I am on CRF page "Hematology" on subject level in Subject "101SUBJ" in Site "Site 1" in Study "Mediflex"
	And I select Lab "Mediflex Central Lab"
	And I enter data in CRF
	|Field		|Value		|
	|Sample Date|02 FEB 2011|
	And I save the CRF
	Then I should see lab ranges for field "WBC"

@PB-DT10991-02
Scenario: As an EDC user, when I enter a missing date in the first Visit Date, a valid date in the second Visit Date, and a Lab Date after the second Visit Date and the lab Age variable is mapped to the Latest date, then I should see lab ranges.
	And I change Lab Settings and Lab Variable Mappings in the background as follows
	|Range Type	|Variable	|Folder	|Form 	|Field	|Location     						|
	|Standard	|Age	 	|		|Visit	|Age	|Latest date						|
	When I create a Subject
	| Field				|Value	|
	| Subject Number	|101	|
	| Subject Initials	|SUBJ	|	
	And I am on CRF page "Visit Date" in Folder "Visit 1" in Subject "101SUBJ" in Site "Site 1" in Study "Mediflex"
	And I enter data in CRF
	|Field		|Value	|
	|Visit Date	|		|
	|Age		|		|
	And I save the CRF
	And I am on CRF page "Visit Date" in Folder "Visit 2" in Subject "101SUBJ" in Site "Site 1" in Study "Mediflex"
	And I enter data in CRF
	|Field		|Value		|
	|Visit Date	|01 FEB 2011|
	|Age		|20			|
	And I save the CRF
	And I am on CRF page "Hematology" on subject level in Subject "101SUBJ" in Site "Site 1" in Study "Mediflex"
	And I select Lab "Mediflex Central Lab"
	And I enter data in CRF
	|Field		|Value		|
	|Sample Date|02 FEB 2011|
	And I save the CRF
	Then I should see lab ranges for field "WBC"

@PB-DT10991-03
Scenario: As an EDC user, when I enter a missing date in the first Visit Date, a valid date in the second Visit Date, and a Lab Date after the second Visit Date and the lab Age variable is mapped to the Closest in time to the lab date, then I should see lab ranges.
	And I change Lab Settings and Lab Variable Mappings in the background as follows
	|Range Type	|Variable	|Folder	|Form 	|Field	|Location     						|
	|Standard	|Age		|		|Visit	|Age	|Closest in time to lab date		|
	When I create a Subject
	| Field				|Value	|
	| Subject Number	|101	|
	| Subject Initials	|SUBJ	|	
	And I am on CRF page "Visit Date" in Folder "Visit 1" in Subject "101SUBJ" in Site "Site 1" in Study "Mediflex"
	And I enter data in CRF
	|Field		|Value	|
	|Visit Date	|		|
	|Age		|		|
	And I save the CRF
	And I am on CRF page "Visit Date" in Folder "Visit 2" in Subject "101SUBJ" in Site "Site 1" in Study "Mediflex"
	And I enter data in CRF
	|Field		|Value		|
	|Visit Date	|01 FEB 2011|
	|Age		|20			|
	And I save the CRF
	And I am on CRF page "Hematology" on subject level in Subject "101SUBJ" in Site "Site 1" in Study "Mediflex"
	And I select Lab "Mediflex Central Lab"
	And I enter data in CRF
	|Field		|Value		|
	|Sample Date|02 FEB 2011|
	And I save the CRF
	Then I should see lab ranges for field "WBC"

@PB-DT10991-04
Scenario: As an EDC user, when I enter a missing date in the first Visit Date, a valid date in the second Visit Date, and a Lab Date after the second Visit Date and the lab Age variable is mapped to the Closest in time prior to lab date, then I should see lab ranges.
	And I change Lab Settings and Lab Variable Mappings in the background as follows
	|Range Type	|Variable	|Folder	|Form 	|Field	|Location     						|
	|Standard	|Age		|		|Visit	|Age	|Closest in time prior to lab date	|
	When I create a Subject
	| Field				|Value	|
	| Subject Number	|101	|
	| Subject Initials	|SUBJ	|	
	And I am on CRF page "Visit Date" in Folder "Visit 1" in Subject "101SUBJ" in Site "Site 1" in Study "Mediflex"
	And I enter data in CRF
	|Field		|Value	|
	|Visit Date	|		|
	|Age		|		|
	And I save the CRF
	And I am on CRF page "Visit Date" in Folder "Visit 2" in Subject "101SUBJ" in Site "Site 1" in Study "Mediflex"
	And I enter data in CRF
	|Field		|Value		|
	|Visit Date	|01 FEB 2011|
	|Age		|20			|
	And I save the CRF
	And I am on CRF page "Hematology" on subject level in Subject "101SUBJ" in Site "Site 1" in Study "Mediflex"
	And I select Lab "Mediflex Central Lab"
	And I enter data in CRF
	|Field		|Value		|
	|Sample Date|02 FEB 2011|
	And I save the CRF
	Then I should see lab ranges for field "WBC"
