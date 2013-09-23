# Subject Date is being used in searching Lab variable mapping value. If subject date is not set from any datapoint value, then it defaults to the timestamp the subjects was first created.
# If the study is not built perfectly, system may not find Lab variable mapping value because of subject date.
# For example, Age is a lab variable (Closest to InputDate) and exists in each visit.
# Subject is created on 2010-01-05 and there is not any datapoint can set subject date, so subject data is 2010-01-05 too.
# Screen (2010-01-01, Age=40) -> Visit 1 (Missing, Age is empty) -> Visit2 (2010-01-20, Age=40)
# Also, these is a lab form with sample date = 2010-01-04
# Now, when system do Lab range searching, system will try to use the Age in Visit 1 which is the closest mapped variable because of subject date.
# To fix: we need to remove subject date from order by so that subject date will not affect search order. Also we need to keep all lab variable datapoints in search targets, it is to say when record date, datapage date and instance date is null for an Age datapoint, but if it is the only one in subject, it will be fetched.
@FT_US12994_DT10991
Feature: US12994_DT10991 Remove Subject Date from order by statement in searching Lab Variable Mapping Value
	Remove Subject Date from order by statement in searching Lab Variable Mapping Value
	As a Rave user
	When I skip a visit
	And enter lab data after that visit
	Then I expect to see lab ranges for the lab data
	So that I can use the Rave lab features of out of range flagging, clinical significance prompts, and lab clinical view

Background:
    And study "US12994_DT10991" is assigned to Site "EDS1"
    And study "US12994_DT10991" is assigned to Site "LDS1"
    And study "US12994_DT10991" is assigned to Site "CTLDS1"
    And study "US12994_DT10991" is assigned to Site "CTPLDV1"
	And I navigate to "Lab Administration"
	And xml Lab Configuration "All_US12994.xml" is uploaded
	And xml draft "US12994_DT10991_Earliest_Date_Draft.xml" is Uploaded with Environment name "Prod"
	And xml draft "US12994_DT10991_Latest_Date_Draft.xml" is Uploaded with Environment name "Prod"
	And xml draft "US12994_DT10991_Closest_in_Time_to_Lab_Date_Draft.xml" is Uploaded with Environment name "Prod"
    And xml draft "US12994_DT10991_Closest_in_Time_Prior_to_Lab_Date_Draft.xml" is Uploaded with Environment name "Prod"
	And I publish and push eCRF "US12994_DT10991_Earliest_Date_Draft.xml" to "CRF Earliest Date Site" with study environment "Prod" for site "EDS1"
	And I publish and push eCRF "US12994_DT10991_Latest_Date_Draft.xml" to "CRF Latest Date Site" with study environment "Prod" for site "LDS1"
	And I publish and push eCRF "US12994_DT10991_Closest_in_Time_Prior_to_Lab_Date_Draft.xml" to "CRF Closest in Time Prior to Lab Date Site" with study environment "Prod" for site "CTPLDV1"
	And I publish and push eCRF "US12994_DT10991_Closest_in_Time_to_Lab_Date_Draft.xml" to "CRF Closest in Time to Lab Date Site" with study environment "Prod" for site "CTLDS1"
	And study "US12994_DT10991" is assigned to Site "EDS1" with study environment "Live: Prod"
    And study "US12994_DT10991" is assigned to Site "LDS1" with study environment "Live: Prod"
	And study "US12994_DT10991" is assigned to Site "CTLDS1" with study environment "Live: Prod"
    And study "US12994_DT10991" is assigned to Site "CTPLDV1" with study environment "Live: Prod"
	And following Project assignments exist
		| User			| Project			| Environment	| Role			|  Site     |SecurityRole			|
		| SUPER USER 1	| US12994_DT10991	| Live: Prod    | SUPER ROLE 1	| EDS1      |Project Admin Default	|
		| SUPER USER 1	| US12994_DT10991	| Live: Prod    | SUPER ROLE 1	| LDS1      |Project Admin Default	|
		| SUPER USER 1	| US12994_DT10991	| Live: Prod    | SUPER ROLE 1	| CTLDS1    |Project Admin Default	|
		| SUPER USER 1	| US12994_DT10991	| Live: Prod    | SUPER ROLE 1	| CTPLDV1	|Project Admin Default	|
	And I login to Rave with user "SUPER USER 1"

#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_2012.1.0
@PB_US12994_DT10991_01
@Validation		
Scenario: PB_US12994_DT10991_01 As an EDC user, when I enter a missing date in the first Visit Date, a valid date in the second Visit Date, and a Lab Date after the second Visit Date and the lab Age variable is mapped to the Earliest date, then I should see lab ranges.
	When I select Site link "EDS1"
	And I create a Subject
		| Field      | Data                  | Control Type |
		| Subject ID | SUB {RndNum<num1>(5)} | textbox      |
	And I select Form "Visit Date" in Folder "Visit 1"
	And I save the CRF page
	And I take a screenshot
	And I select link "SUB {Var(num1)}"
	And I select Form "Visit Date" in Folder "Visit 2"
	And I enter data in CRF and save
		| Field      | Data        | Control Type |
		| Visit Date | 01 Feb 2099 | datetime     |
		| Age        | 20          | textbox      |
	And I take a screenshot
	And I select link "SUB {Var(num1)}"
	And I select Form "Hematology"
	And I select Lab "Local Lab 1"
	And I enter data in CRF and save
	  | Field | Data |
	  | WBC   |      |
	Then I verify lab ranges
		| Field | Data | Range Status | Range	| Unit					| Status Icon |
		| WBC   |      |              | 10 - 20 | *10E6/ulREG_US12994	| Complete    |
	And I take a screenshot

#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_2012.1.0
@PB_US12994_DT10991_02
@Validation
Scenario: PB_US12994_DT10991_02 As an EDC user, when I enter a missing date in the first Visit Date, a valid date in the second Visit Date, and a Lab Date after the second Visit Date and the lab Age variable is mapped to the Latest date, then I should see lab ranges.
    When I select Site link "LDS1"
	And I create a Subject
		| Field      | Data                  | Control Type |
		| Subject ID | SUB {RndNum<num1>(5)} | textbox      |
	And I select link "SUB {Var(num1)}"
	And I select Form "Visit Date" in Folder "Visit 1"
	And I save the CRF page
	And I take a screenshot
	And I select Form "Visit Date" in Folder "Visit 2"
	And I enter data in CRF and save
		| Field      | Data        | Control Type |
		| Visit Date | 01 Feb 2011 | datetime     |
		| Age        | 20          | textbox      |
	And I take a screenshot
	And I select link "SUB {Var(num1)}"
	And I select Form "Hematology"
	And I select Lab "Local Lab 1"
	And I enter data in CRF and save
	  | Field | Data |
	  | WBC   |      |
	Then I verify lab ranges
		| Field | Data | Range Status | Range	| Unit					| Status Icon |
		| WBC   |      |              | 10 - 20 | *10E6/ulREG_US12994	| Complete    |
	And I take a screenshot

#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_2012.1.0
@PB_US12994_DT10991_03
@Validation
Scenario: PB_US12994_DT10991_03 As an EDC user, when I enter a missing date in the first Visit Date, a valid date in the second Visit Date, and a Lab Date after the second Visit Date and the lab Age variable is mapped to the Closest in time to the lab date, then I should see lab ranges.
    When I select Site link "CTLDS1"
	And I create a Subject
		| Field      | Data                  | Control Type |
		| Subject ID | SUB {RndNum<num1>(5)} | textbox      |
	And I select link "SUB {Var(num1)}"
	And I select Form "Visit Date" in Folder "Visit 1"
	And I save the CRF page
	And I take a screenshot
	And I select Form "Visit Date" in Folder "Visit 2"
	And I enter data in CRF and save
		| Field      | Data        | Control Type |
		| Visit Date | 01 Feb 2011 | datetime     |
		| Age        | 20          | textbox      |
	And I take a screenshot
	And I select link "SUB {Var(num1)}"
	And I select Form "Hematology"
	And I select Lab "Local Lab 1"
	And I enter data in CRF and save
	  | Field | Data |
	  | WBC   |      |
	Then I verify lab ranges
		| Field | Data | Range Status | Range	| Unit					| Status Icon |
		| WBC   |      |              | 10 - 20 | *10E6/ulREG_US12994	| Complete    |
	And I take a screenshot

#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_2012.1.0
@PB_US12994_DT10991_04
@Validation
Scenario: PB_US12994_DT10991_04 As an EDC user, when I enter a missing date in the first Visit Date, a valid date in the second Visit Date, and a Lab Date after the second Visit Date and the lab Age variable is mapped to the Closest in time prior to lab date, then I should see lab ranges.
    When I select Site link "CTPLDV1"
	And I create a Subject
		| Field      | Data                  | Control Type |
		| Subject ID | SUB {RndNum<num1>(5)} | textbox      |
	And I select link "SUB {Var(num1)}"
	And I select Form "Visit Date" in Folder "Visit 1"
	And I save the CRF page
	And I take a screenshot
	And I select Form "Visit Date" in Folder "Visit 2"
	And I enter data in CRF and save
		| Field      | Data        | Control Type |
		| Visit Date | 01 Feb 2011 | datetime     |
		| Age        | 20          | textbox      |
	And I take a screenshot
	And I select link "SUB {Var(num1)}"
	And I select Form "Hematology"
	And I select Lab "Local Lab 1"
	And I enter data in CRF and save
	  | Field | Data |
	  | WBC   |      |
	Then I verify lab ranges
		| Field | Data | Range Status | Range	| Unit					| Status Icon |
		| WBC   |      |              | 10 - 20 | *10E6/ulREG_US12994	| Complete    |
	And I take a screenshot
