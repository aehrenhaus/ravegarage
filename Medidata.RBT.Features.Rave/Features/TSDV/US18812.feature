# When a user selects  Dynamic Allocation Randomization Block algorithm , subject assignment satisfies a specified allocation and ratio is random for all blocks.
@EnableSeeding=true
@FT_US18812
#SecurityRole
Feature: US18812 When a user selects  Dynamic Allocation Randomization Block algorithm , subject assignment satisfies a specified allocation and ratio is random for all blocks.
	When user selects Dynamic Allocation Randomization Block algorithm
	Then subject assignment satisfies a specified allocation ratio
	And subject assignment is random for all blocks

Background:
	Given TSDV is enabled
	Given I perform cache flush of "Medidata.Core.Objects.Configuration"

	Given xml draft "US18812.xml" is Uploaded with Environment name "Dev"
	Given Site "Site 1" with Site Group "Asia" exists
	Given Site "Site 2" with Site Group "Europe" exists
	Given Site "Site 3" with Site Group "North America" exists

	Given study "US18812" is assigned to Site "Site 1" with study environment "Aux: Dev"
	Given study "US18812" is assigned to Site "Site 2" with study environment "Aux: Dev"
	Given study "US18812" is assigned to Site "Site 3" with study environment "Aux: Dev"

	Given I publish and push eCRF "US18812.xml" to "Version 1" with study environment "Dev"
	#Given following Project assignments exist
	#| User         | Project | Environment | Role         | Site   | SecurityRole          | Lines Per Page |
	#| SUPER USER 1 | US18812 | Aux: Dev    | SUPER ROLE 1 | Site 1 | Project Admin Default | 100            |
	#Given following Project assignments exist
	#| User         | Project | Environment | Role         | Site   | SecurityRole          | Lines Per Page |
	#| SUPER USER 1 | US18812 | Aux: Dev    | SUPER ROLE 1 | Site 1 | Project Admin Default | 100            |
	#| SUPER USER 1 | US18812 | Aux: Dev    | SUPER ROLE 1 | Site 2 | Project Admin Default | 100            |
	#| SUPER USER 1 | US18812 | Aux: Dev    | SUPER ROLE 1 | Site 3 | Project Admin Default | 100            |
	#| SUPER USER 1 | US18812 | Aux: Dev    | SUPER ROLE 1 | Site 4 | Project Admin Default | 100            |
	Given following Project assignments exist
	| User         | Project | Environment | Role         | Site   | SecurityRole          | Lines Per Page |
	| SUPER USER 1 | US18812 | Aux: Dev    | SUPER ROLE 1 | Site 1 | Project Admin Default | 100            |
	| SUPER USER 1 | US18812 | Aux: Dev    | SUPER ROLE 1 | Site 2 | Project Admin Default | 100            |
	| SUPER USER 1 | US18812 | Aux: Dev    | SUPER ROLE 1 | Site 3 | Project Admin Default | 100            |
	Given following Report assignments exist
	| User         | Report                                                           |
	| SUPER USER 1 | Targeted SDV Configuration - Targeted SDV Configuration          |
	| SUPER USER 1 | Targeted SDV Subject Management - Targeted SDV Subject Managemen |




	# below should be commented out.
	#Given there is a project US18812
	#Given there is an environment Prod for project US18812
	#And there are four sites assigned to study US18812(Dev):
		# | Site Name  | Site Number      |
		# | Site 1     | 1001             |
		# | Site 2     | 2001             |
		# | Site 3     | 3001             |
		# | Site 4     | 4001             |
	#And site Site 1 is assigned to site group Asia
	#And site Site 2 is assigned to site group Europe
	#And site Site 3 is assigned to site group World
	#And site Site 4 is assigned to site group North America
	#And TSDV Study Plan has been setup for Study "US18812"
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
 	#And TSDV Site Group Plan has been setup for Site Group "World"
	# And TSDV Site Group Plan has block with tier(s)
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
 #And TSDV Site Plan has been setup for Site "Site 1"
	# And TSDV Site Plan has block with tier(s)
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
 #And TSDV Site Plan has been setup for Site "Site 3"
	# And TSDV Site Plan has block with tier(s)
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
 #And TSDV Site Plan has been setup for Site "Site 4"
	# And TSDV Site Plan has block with tier(s)
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

	
	 

@release_2012.1.0 
@PB_US18812_01
@Validation
Scenario: PB_US18812_01 Enroll 50 subjects in a study to verify that TSDV has randomized the subjects in non sequential order when the subjects are included in TSDV using the Targeted SDV Subject Include report in Study level, Site group level and Site level.
	Given I login to Rave with user "SUPER USER 1"
	And I navigate to "Reporter"
	And I select Report "Targeted SDV Configuration"
	And I set report parameter "Study" with table
		| Name    | Environment |
		| US18812 | Dev         |
	And I click button "Submit Report"
	And I switch to "Targeted SDV Study Plan" window
	And I create a new block plan named "US18812 (Dev) Block Plan" with Data entry Role "SUPER ROLE 1"
	And I verify text "Dynamic Allocation" exists
	And I take a screenshot
	And I delete the tier "Architect Defined" from plan
	And I edit Blocks 
	| Name              | Subject Count |
	| Architect Defined | 10            |
	And I select link "Tiers"
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
	| Form      | Selected |
	| Occlusion | True     |
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
	And I take a screenshot
	And I switch to "Reports" window
	And I navigate to "Home"
	And I create 50 random Subjects with name "ABB" in Study "US18812" in Site "Site 1"
	And I take a screenshot
	And I navigate to "Home"
	And I navigate to "Reporter"
	And I select Report "Targeted SDV Subject Management"
	And I set report parameter "Study" with table
		| Name    | Environment |
		| US18812 | Dev         |
	And I click button "Submit Report"
	And I switch to "Targeted SDV Subject Override" window 
	And I take a screenshot
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
	And I verify every 10 rows of subjects in 50 rows do not have tiers pattern
	And I switch to "Reports" window
	And I navigate to "Home"
	And I navigate to "Reporter"
	And I select Report "Targeted SDV Configuration"
	And I set report parameter "Study" with table
		| Name    | Environment |
		| US18812 | Dev         |
	And I click button "Submit Report"
	And I switch to "Targeted SDV Study Plan" window
	And I inactivate the plan
	And I select link "World"
	And I create a new block plan named "World Block Plan" with Data entry Role "SUPER ROLE 1"
	And I verify text "Dynamic Allocation" exists
	And I take a screenshot
	And I delete the tier "Architect Defined" from plan
	And I edit Blocks 
	| Name              | Subject Count |
	| Architect Defined | 10            | 
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
	And I take a screenshot
	And I switch to "Reports" window
	And I navigate to "Home"
	And I create 50 random Subjects with name "BBC" in Study "US18812" in Site "Site 2"
	And I take a screenshot
	And I navigate to "Home"
	And I navigate to "Reporter"
	And I select Report "Targeted SDV Subject Management"
	And I set report parameter "Study" with table
		| Name    | Environment |
		| US18812 | Dev         |
	And I click button "Submit Report"
	And I switch to "Targeted SDV Subject Override" window
	And I choose Site Group "All Site Groups" from "Site Groups"
	And I select link "Search"
	And I take a screenshot
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
		| All Forms         | 51  |
		| No Forms          | 52  |
		| Architect Defined | 53  |
		| Custom Tier 1     | 54  |
		| Custom Tier 2     | 55  |
		| Custom Tier 3     | 56  |
		| Custom Tier 4     | 57  |
		| Custom Tier 5     | 58  |
		| Custom Tier 6     | 59  |
		| Custom Tier 7     | 60  |
		| All Forms         | 61  |
		| No Forms          | 62  |
		| Architect Defined | 63  |
		| Custom Tier 1     | 64  |
		| Custom Tier 2     | 65  |
		| Custom Tier 3     | 66  |
		| Custom Tier 4     | 67  |
		| Custom Tier 5     | 68  |
		| Custom Tier 6     | 69  |
		| Custom Tier 7     | 70  |
		| All Forms         | 71  |
		| No Forms          | 72  |
		| Architect Defined | 73  |
		| Custom Tier 1     | 74  |
		| Custom Tier 2     | 75  |
		| Custom Tier 3     | 76  |
		| Custom Tier 4     | 77  |
		| Custom Tier 5     | 78  |
		| Custom Tier 6     | 79  |
		| Custom Tier 7     | 80  |
		| All Forms         | 81  |
		| No Forms          | 82  |
		| Architect Defined | 83  |
		| Custom Tier 1     | 84  |
		| Custom Tier 2     | 85  |
		| Custom Tier 3     | 86  |
		| Custom Tier 4     | 87  |
		| Custom Tier 5     | 88  |
		| Custom Tier 6     | 89  |
		| Custom Tier 7     | 90  |
		| All Forms         | 91  |
		| No Forms          | 92  |
		| Architect Defined | 93  |
		| Custom Tier 1     | 94  |
		| Custom Tier 2     | 95  |
		| Custom Tier 3     | 96  |
		| Custom Tier 4     | 97  |
		| Custom Tier 5     | 98  |
		| Custom Tier 6     | 99  |
		| Custom Tier 7     | 100 |
	And I verify every 10 rows of subjects in 100 rows do not have tiers pattern
	And I switch to "Reports" window
	And I navigate to "Home"
	And I navigate to "Reporter"
	And I select Report "Targeted SDV Configuration"
	And I set report parameter "Study" with table
		| Name    | Environment |
		| US18812 | Dev         |
	And I click button "Submit Report"
	And I switch to "Targeted SDV Study Plan" window
	And I select link "World"
	And I inactivate the plan
	And I select link(partial) "Site 3"
	And I create a new block plan named "Site 3 Block Plan" with Data entry Role "SUPER ROLE 1"
	And I verify text "Dynamic Allocation" exists
	And I take a screenshot
	And I delete the tier "Architect Defined" from plan
	And I edit Blocks 
		| Name              | Subject Count |
		| Architect Defined | 10            |
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
	And I take a screenshot
	And I switch to "Reports" window
	And I navigate to "Home"
	And I create 50 random Subjects with name "CCD" in Study "US18812" in Site "Site 3"
	And I take a screenshot
	And I navigate to "Home"
	And I navigate to "Reporter"
	And I select Report "Targeted SDV Subject Management"
	And I set report parameter "Study" with table
		| Name    | Environment |
		| US18812 | Dev         |
	And I click button "Submit Report"
	And I switch to "Targeted SDV Subject Override" window
	And I choose "Site 3" from "Sites"
	And I select link "Search"
	And I take a screenshot
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
	And I verify every 10 rows of subjects in 50 rows do not have tiers pattern
	And I switch to "Reports" window
	And I navigate to "Home"
	And I navigate to "Reporter"
	And I select Report "Targeted SDV Configuration"
	And I set report parameter "Study" with table
		| Name    | Environment |
		| US18812 | Dev         |
	And I click button "Submit Report"
	And I switch to "Targeted SDV Study Plan" window
	And I select link "World"
	And I select link(partial) "Site 3"
	And I inactivate the plan
	And I switch to the second window
	