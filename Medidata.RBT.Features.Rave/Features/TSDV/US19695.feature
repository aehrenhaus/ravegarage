# When using Subject Include feature, Subjects are enrolled per selected Randomization. 
@ignore
Feature: US19695
	When user creates subjects 
	And user selects Dynamic Allocation Randomization Block algorithm
	And user selects Permuted Block Randomization Block algorithm
	And user includes subject through Targeted SDV Subject Management report 
	Then subject assignment satisfies a specified allocation ratio
	And subjects are allocated to tiers per the selected Randomization Type
	Then subject assignment satisfies a specified allocation ratio

Background:
	#Given I am logged in to Rave with username "defuser" and password "password"
	Given xml draft "US19695.xml" is Uploaded with Environment name "Dev"
	Given Site "Site 1" with Site Group "Asia" exists
	Given Site "Site 2" with Site Group "Europe" exists
	Given study "US19695" is assigned to Site "Site 1" with study environment "Aux: Dev"
	Given study "US19695" is assigned to Site "Site 2" with study environment "Aux: Dev"
	Given I publish and push eCRF "US19695.xml" to "Version 1" with study environment "Dev"
	Given following Project assignments exist
	| User         | Project | Environment | Role         | Site   | SecurityRole          | Lines Per Page |
	| SUPER USER 1 | US19695 | Aux: Dev    | SUPER ROLE 1 | Site 1 | Project Admin Default | 100            |
	| SUPER USER 1 | US19695 | Aux: Dev    | SUPER ROLE 1 | Site 2 | Project Admin Default | 100            |
	Given following Report assignments exist
	| User         | Report                                                           |
	| SUPER USER 1 | Targeted SDV Configuration - Targeted SDV Configuration          |
	| SUPER USER 1 | Targeted SDV Subject Management - Targeted SDV Subject Managemen |


	# below should be commented out.
	#Given there is a project US19695
	#Given there is an environment Prod for project US19695
	#And there are four sites assigned to study US19695(Dev):
		# | Site Name  | Site Number      |
		# | Site 1     | 1001             |
		# | Site 2     | 2001             |
	#And site Site 1 is assigned to site group Asia
	#And site Site 2 is assigned to site group Europe
	#And TSDV Study Plan has been setup for Study "US19695"
	# And TSDV Study Plan has block with tier(s)
	# | Block Name | Subject Count | IsRepeated | Tier Name         | Subject Count | Folder | Form                         | Field |
	# | Architect  | 10            | Yes        |                   |               |        |                              |       |
	# |            |               |            | All Forms         | 1             |        |                              |       |
	# |            |               |            | No Forms          | 1             |        |                              |       |
	# |            |               |            | Architect Defined | 1             |        |                              |       |
	# |            |               |            | Custom Tier 1     | 1             | [All]  | Demographics  		        | [All] |
	# |            |               |            | Custom Tier 2     | 1             | [All]  | Enrollment					| [All] |
	# |            |               |            | Custom Tier 3     | 1             | [All]  | Field Edit Checks	        | [All] |
	# |            |               |            | Custom Tier 4     | 1             | [All]  | Form 1 				        | [All] |
	# |            |               |            | Custom Tier 5     | 1             | [All]  | Form 2                		| [All] |
	# |            |               |            | Custom Tier 6     | 1             | [All]  | Form 3						| [All] |
	# |            |               |            | Custom Tier 7     | 1             | [All]  | Form 4           			| [All] |
 	#And TSDV Site Plan has been setup for Site "Site 2"
	# And TSDV Site Plan has block with tier(s)
	# | Block Name | Subject Count | IsRepeated | Tier Name         | Subject Count | Folder | Form                         | Field |
	# | Architect  | 4             | Yes        |                   |               |        |                              |       |
	# |            |               |            | All Forms         | 1             |        |                              |       |
	# |            |               |            | No Forms          | 1             |        |                              |       |
	# |            |               |            | Architect Defined | 2             |        |                              |       |

	
	 

@release_2012.1.0 
@PB_US19695_01
@Draft

Scenario: @PB_US19695_01 Enroll subjects in studies to verify that TSDV has randomized the subjects based on selected randomization type. 
	#When I select Study "US19695" and Site "Site 1"
	#And I login to Rave with user "SUPER USER 1"

	When I create 50 random Subjects with name "QQR" in Study "US19695 (Dev)" in Site "Site 1"
	And I select link "Home"
	And I navigate to "Reporter"
	And I select Report "Targeted SDV Configuration"
	And I set report parameter "Study" with table
		| Name    | Environment |
		| US19695 | Dev         |
	And I click button "Submit Report"
	And I switch to "Targeted SDV Study Plan" window
	And I create a new block plan named "US19695 (Dev) Block Plan" with Data entry Role "SUPER ROLE 1"
	And I verify text "Dynamic Allocation" exists
	And I delete the tier "Architect Defined" from plan
	And I edit Blocks 
	| Name              | Subject Count |
	| Architect Defined | 10            |            
	And I create a custom tier named "Custom Tier 1" and description "Adverse Events" with table
	| Form           | Selected |
	| Adverse Events | True     |
	And I create a custom tier named "Custom Tier 2" and description "BloodWork" with table
	| Form      | Selected |
	| BloodWork | True     |
	And I create a custom tier named "Custom Tier 3" and description "Cholesterol" with table
	| Form        | Selected |
	| Cholesterol | True     |
	And I create a custom tier named "Custom Tier 4" and description "Concomitant Medications" with table
	| Form                    | Selected |
	| Concomitant Medications | True     |
	And I create a custom tier named "Custom Tier 5" and description "Demographics" with table
	| Form         | Selected |
	| Demographics | True     |
	And I create a custom tier named "Custom Tier 6" and description "Device Form" with table
	| Form        | Selected |
	| Device Form | True     |
	And I create a custom tier named "Custom Tier 7" and description "Drug Administration" with table
	| Form                | Selected |
	| Drug Administration | True     |
	And I select link "Study Block Plan"
	And I select the tier "All Forms" and Subject Count "1"
	And I select the tier "No Forms" and Subject Count "1"
	And I select the tier "Architect Defined" and Subject Count "1"
	And I select the tier "Custom Tier 1" and Subject Count "1"
	And I select the tier "Custom Tier 2" and Subject Count "1"
	And I select the tier "Custom Tier 3" and Subject Count "1"
	And I select the tier "Custom Tier 4" and Subject Count "1"
	And I select the tier "Custom Tier 5" and Subject Count "1"
	And I select the tier "Custom Tier 6" and Subject Count "1"
	And I select the tier "Custom Tier 7" and Subject Count "1"
	And I activate the plan
	And I switch to "Reports" window
	And I select link "Home"
	And I navigate to "Reporter"
	And I select Report "Targeted SDV Subject Management"
	And I set report parameter "Study" with table
		| Name    | Environment |
		| US19695 | Dev         |
	And I click button "Submit Report"
	And I switch to "Targeted SDV Subject Override" window 
	And I select link "Subject Include"
	And I include "50" subjects in TSDV
	And I select link "Subject Override"
	Then I verify that Tiers in subject override table are not in the following order
		| Tier Name         | Row |
		| All Forms         | 1   |
		| No Forms          | 2   |
		| Architect Defined | 3   |
		| Custom Tier 1     | 4   |
		| Custom Tier 2     | 5   |
		| Custom Tier 3     | 6   |
		| Custom Tier 4     | 7   |
		| Custom Tier 5     | 8   |
		| Custom Tier 6     | 9   |
		| Custom Tier 7     | 10  |
		| All Forms         | 11  |
		| No Forms          | 12  |
		| Architect Defined | 13  |
		| Custom Tier 1     | 14  |
		| Custom Tier 2     | 15  |
		| Custom Tier 3     | 16  |
		| Custom Tier 4     | 17  |
		| Custom Tier 5     | 18  |
		| Custom Tier 6     | 19  |
		| Custom Tier 7     | 20  |
		| All Forms         | 21  |
		| No Forms          | 22  |
		| Architect Defined | 23  |
		| Custom Tier 1     | 24  |
		| Custom Tier 2     | 25  |
		| Custom Tier 3     | 26  |
		| Custom Tier 4     | 27  |
		| Custom Tier 5     | 28  |
		| Custom Tier 6     | 29  |
		| Custom Tier 7     | 30  |
		| All Forms         | 31  |
		| No Forms          | 32  |
		| Architect Defined | 33  |
		| Custom Tier 1     | 34  |
		| Custom Tier 2     | 35  |
		| Custom Tier 3     | 36  |
		| Custom Tier 4     | 37  |
		| Custom Tier 5     | 38  |
		| Custom Tier 6     | 39  |
		| Custom Tier 7     | 40  |
		| All Forms         | 41  |
		| No Forms          | 42  |
		| Architect Defined | 43  |
		| Custom Tier 1     | 44  |
		| Custom Tier 2     | 45  |
		| Custom Tier 3     | 46  |
		| Custom Tier 4     | 47  |
		| Custom Tier 5     | 48  |
		| Custom Tier 6     | 49  |
		| Custom Tier 7     | 50  |
	And I verify there is no exact tier match between rows
	And I switch to "Reports" window
	And I select link "Home"
	And I navigate to "Reporter"
	And I select Report "Targeted SDV Configuration"
	And I set report parameter "Study" with table
		| Name    | Environment |
		| US19695 | Dev         |
	And I click button "Submit Report"
	And I switch to "Targeted SDV Study Plan" window
	And I inactivate the plan
	And I switch to "Reports" window
	And I select link "Home"
	And I create 40 random Subjects with name "CCD" in Study "US19695 (Dev)" in Site "Site 2"
	And I select link "Home"
	And I navigate to "Reporter"
	And I select Report "Targeted SDV Configuration"
	And I set report parameter "Study" with table
		| Name    | Environment |
		| US19695 | Dev         |
	And I click button "Submit Report"
	And I switch to "Targeted SDV Study Plan" window
	And I select link "World"
	And I select link "Site 2"
	And I create a new block plan named "Site 2 Block Plan" with Data entry Role "SUPER ROLE 1"
	And I verify text "Dynamic Allocation" exists
	And I click button "edit block plan"
	And I choose "Permuted Block" from "Randomization Type"
	And I click button "save block plan"
	And I verify text "Permuted Block" exists
	And I delete the tier "Architect Defined" from plan
	And I edit Blocks 
	| Name              | Subject Count |
	| Architect Defined | 4             |
	And I select the tier "All Forms" and Subject Count "1"
	And I select the tier "No Forms" and Subject Count "1"
	And I select the tier "Architect Defined" and Subject Count "2"
	And I activate the plan
	And I switch to "Reports" window
	And I select link "Home"
	And I navigate to "Reporter"
	And I select Report "Targeted SDV Subject Management"
	And I set report parameter "Study" with table
		| Name    | Environment |
		| US19695 | Dev         |
	And I click button "Submit Report"
	And I switch to "Targeted SDV Subject Override" window
	And I select link "Subject Include"
	And I include "50" subjects in TSDV
	And I select link "Subject Override"
	And I filter by site "Site 2"
	Then I verify that one of the following Permutations has been used
	|Randomization Permutations                               |
	|All Forms, Architect Defined, Architect Defined, No Forms|
	|All Forms, Architect Defined, No Forms, Architect Defined|
	|All Forms, No Forms, Architect Defined, Architect Defined|
	|Architect Defined, All Forms, Architect Defined, No Forms|
	|Architect Defined, All Forms, No Forms, Architect Defined|
	|No Forms, All Forms, Architect Defined, Architect Defined|
	|Architect Defined, Architect Defined, All Forms, No Forms|
	|Architect Defined, No Forms, All Forms, Architect Defined|
	|No Forms, Architect Defined, All Forms, Architect Defined|
	|Architect Defined, Architect Defined, No Forms, All Forms|
	|Architect Defined, No Forms, Architect Defined, All Forms|
	|No Forms, Architect Defined, Architect Defined, All Forms|
	And I switch to "Reports" window
	And I select link "Home"
	And I navigate to "Reporter"
	And I select Report "Targeted SDV Configuration"
	And I set report parameter "Study" with table
		| Name    | Environment |
		| US19695 | Dev         |
	And I click button "Submit Report"
	And I switch to "Targeted SDV Study Plan" window
	And I select link "World"
	And I select link "Site 2"
	And I inactivate the plan