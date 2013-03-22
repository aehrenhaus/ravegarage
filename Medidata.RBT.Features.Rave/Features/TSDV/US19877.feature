# TSDV will regenerate a new randomization permutation when a TSDV plan using Permuted Block randomization is updated
@EnableSeeding=true
@FT_US19877
Feature: US19877 TSDV will regenerate a new randomization permutation when a TSDV plan using Permuted Block randomization is updated
	When subjects are allocated to tiers using the Permuted Block Randomization Type
	And the TSDV plan is updated to include a new custom tier
	Then a new randomization permutation is generated
	And subject assignment satisfies the new specified allocation ratio
	And is random for all blocks
	And each randomization permutation has an equal probability of being selected
	
Background:
	Given TSDV is enabled
	Given I perform cache flush of "Medidata.Core.Objects.Configuration"
	Given xml draft "US19877.xml" is Uploaded with Environment name "Dev"

	Given Site "Site 1" with Site Group "World" exists
	Given study "US19877" is assigned to Site "Site 1" with study environment "Aux: Dev"
	Given I publish and push eCRF "US19877.xml" to "Version 1" with study environment "Dev"
	Given following Project assignments exist
	| User         | Project | Environment | Role         | Site   | SecurityRole          | 
	| SUPER USER 1 | US19877 | Aux: Dev    | SUPER ROLE 1 | Site 1 | Project Admin Default | 
	Given following Report assignments exist
	| User         | Report                                                           |
	| SUPER USER 1 | Targeted SDV Configuration - Targeted SDV Configuration          |
	| SUPER USER 1 | Targeted SDV Subject Management - Targeted SDV Subject Managemen |
	
	# Note: The setup used for the testing of this Feature File is not the only setup that will work with the Permuted Block randomization algorithm. The randomization algorithm will work for all Block and Tier combinations, or a block of n of n.

	# below should be commented out.
	#Given there is a project US19877
	#Given there is an environment Prod for project US19877
	#And there are four sites assigned to study US19877(Dev):
		# | Site Name  | Site Number      |
		# | Site 1     | 1001             |
		# | Site 2     | 2001             |
		# | Site 3     | 3001             |
		# | Site 4     | 4001             |
	#And site Site 1 is assigned to site group World
	#And TSDV Study Plan has been setup for Study "US19877"
	# And TSDV Study Plan has block with tier(s)
	# | Block Name | Subject Count | IsRepeated | Tier Name         | Subject Count | Folder | Form                         | Field |
	# | Architect  | 6             | Yes        |                   |               |        |                              |       |
	# |            |               |            | All Forms         | 1             |        |                              |       |
	# |            |               |            | No Forms          | 2             |        |                              |       |
	# |            |               |            | Architect Defined | 3             |        |                              |       |
	
	# And modify TSDV Study Plan has block with tier(s)
	# | Block Name | Subject Count | IsRepeated | Tier Name         | Subject Count | Folder | Form                         | Field |
	# | Architect  | 6             | Yes        |                   |               |        |                              |       |
	# |            |               |            | All Forms         | 1             |        |                              |       |
	# |            |               |            | No Forms          | 2             |        |                              |       |
	# |            |               |            | Architect Defined | 3             |        |                              |       |
	# |            |               |            | Custom Tier 1     | 1             |        |                              |       |

@release_2012.1.0 
@PB_US19877_01
@Validation
Scenario: PB_US19877_01 As a Rave user, when I select Permuted Block Randomization and I Enroll 50 subjects in study then subject assignment satisfies the specified ratio and is random for all blocks in study level.
	Given I login to Rave with user "SUPER USER 1"
	And I navigate to "Home"
	And I navigate to "Reporter"
	And I select Report "Targeted SDV Configuration"
	And I set report parameter "Study" with table
		| Name    | Environment |
		| US19877 | Dev         |
	And I click button "Submit Report"
	And I switch to "Targeted SDV Study Plan" window
	And I create a new block plan named "US19877 (Dev) Block Plan" with Data entry Role "SUPER ROLE 1"
	And I verify text "Dynamic Allocation" exists
	And I take a screenshot
	And I click button "edit block plan"
	And I choose "Permuted Block" from "Randomization Type"
	And I click button "save block plan"
	And I take a screenshot
	And I delete the tier "Architect Defined" from plan
	And I edit Blocks 
	| Name              | Subject Count |
	| Architect Defined | 6             |            
	And I select the tier "Architect Defined" and Subject Count "1"
	And I select the tier "All Forms" and Subject Count "2"
	And I select the tier "No Forms" and Subject Count "3"
	And I activate the plan
	And I take a screenshot
	And I switch to "Reports" window
	And I navigate to "Home"
	And I create 30 random Subjects with name "BBB" in Study "US19877" in Site "Site 1"
	And I take a screenshot
	And I navigate to "Home"
	And I navigate to "Reporter"
	And I select Report "Targeted SDV Subject Management"
	And I set report parameter "Study" with table
		| Name    | Environment |
		| US19877 | Dev         |
	And I click button "Submit Report"
	And I switch to "Targeted SDV Subject Override" window
	And I take a screenshot
	Then I verify that one of the following Permutations has been used every 6 subjects
	| Randomization Permutations                                            |
	| All Forms, All Forms, Architect Defined, No Forms, No Forms, No Forms |
	| All Forms, All Forms, No Forms, Architect Defined, No Forms, No Forms |
	| All Forms, All Forms, No Forms, No Forms, Architect Defined, No Forms |
	| All Forms, All Forms, No Forms, No Forms, No Forms, Architect Defined |
	| All Forms, Architect Defined, All Forms, No Forms, No Forms, No Forms |
	| All Forms, No Forms, All Forms, Architect Defined, No Forms, No Forms |
	| All Forms, No Forms, All Forms, No Forms, Architect Defined, No Forms |
	| All Forms, No Forms, All Forms, No Forms, No Forms, Architect Defined |
	| All Forms, Architect Defined, No Forms, All Forms, No Forms, No Forms |
	| All Forms, No Forms, Architect Defined, All Forms, No Forms, No Forms |
	| All Forms, No Forms, No Forms, All Forms, Architect Defined, No Forms |
	| All Forms, No Forms, No Forms, All Forms, No Forms, Architect Defined |
	| All Forms, Architect Defined, No Forms, No Forms, All Forms, No Forms |
	| All Forms, No Forms, Architect Defined, No Forms, All Forms, No Forms |
	| All Forms, No Forms, No Forms, Architect Defined, All Forms, No Forms |
	| All Forms, No Forms, No Forms, No Forms, All Forms, Architect Defined |
	| All Forms, Architect Defined, No Forms, No Forms, No Forms, All Forms |
	| All Forms, No Forms, Architect Defined, No Forms, No Forms, All Forms |
	| All Forms, No Forms, No Forms, Architect Defined, No Forms, All Forms |
	| All Forms, No Forms, No Forms, No Forms, Architect Defined, All Forms |
	| Architect Defined, All Forms, All Forms, No Forms, No Forms, No Forms |
	| No Forms, All Forms, All Forms, Architect Defined, No Forms, No Forms |
	| No Forms, All Forms, All Forms, No Forms, Architect Defined, No Forms |
	| No Forms, All Forms, All Forms, No Forms, No Forms, Architect Defined |
	| Architect Defined, All Forms, No Forms, All Forms, No Forms, No Forms |
	| No Forms, All Forms, Architect Defined, All Forms, No Forms, No Forms |
	| No Forms, All Forms, No Forms, All Forms, Architect Defined, No Forms |
	| No Forms, All Forms, No Forms, All Forms, No Forms, Architect Defined |
	| Architect Defined, All Forms, No Forms, No Forms, All Forms, No Forms |
	| No Forms, All Forms, Architect Defined, No Forms, All Forms, No Forms |
	| No Forms, All Forms, No Forms, Architect Defined, All Forms, No Forms |
	| No Forms, All Forms, No Forms, No Forms, All Forms, Architect Defined |
	| Architect Defined, All Forms, No Forms, No Forms, No Forms, All Forms |
	| No Forms, All Forms, Architect Defined, No Forms, No Forms, All Forms |
	| No Forms, All Forms, No Forms, Architect Defined, No Forms, All Forms |
	| No Forms, All Forms, No Forms, No Forms, Architect Defined, All Forms |
	| Architect Defined, No Forms, All Forms, All Forms, No Forms, No Forms |
	| No Forms, Architect Defined, All Forms, All Forms, No Forms, No Forms |
	| No Forms, No Forms, All Forms, All Forms, Architect Defined, No Forms |
	| No Forms, No Forms, All Forms, All Forms, No Forms, Architect Defined |
	| Architect Defined, No Forms, All Forms, No Forms, All Forms, No Forms |
	| No Forms, Architect Defined, All Forms, No Forms, All Forms, No Forms |
	| No Forms, No Forms, All Forms, Architect Defined, All Forms, No Forms |
	| No Forms, No Forms, All Forms, No Forms, All Forms, Architect Defined |
	| Architect Defined, No Forms, All Forms, No Forms, No Forms, All Forms |
	| No Forms, Architect Defined, All Forms, No Forms, No Forms, All Forms |
	| No Forms, No Forms, All Forms, Architect Defined, No Forms, All Forms |
	| No Forms, No Forms, All Forms, No Forms, Architect Defined, All Forms |
	| Architect Defined, No Forms, No Forms, All Forms, All Forms, No Forms |
	| No Forms, Architect Defined, No Forms, All Forms, All Forms, No Forms |
	| No Forms, No Forms, Architect Defined, All Forms, All Forms, No Forms |
	| No Forms, No Forms, No Forms, All Forms, All Forms, Architect Defined |
	| Architect Defined, No Forms, No Forms, All Forms, No Forms, All Forms |
	| No Forms, Architect Defined, No Forms, All Forms, No Forms, All Forms |
	| No Forms, No Forms, Architect Defined, All Forms, No Forms, All Forms |
	| No Forms, No Forms, No Forms, All Forms, Architect Defined, All Forms |
	| Architect Defined, No Forms, No Forms, No Forms, All Forms, All Forms |
	| No Forms, Architect Defined, No Forms, No Forms, All Forms, All Forms |
	| No Forms, No Forms, Architect Defined, No Forms, All Forms, All Forms |
	| No Forms, No Forms, No Forms, Architect Defined, All Forms, All Forms |
And I switch to "Reports" window
	And I navigate to "Home"
	And I navigate to "Reporter"
	And I select Report "Targeted SDV Configuration"
	And I set report parameter "Study" with table
		| Name    | Environment |
		| US19877 | Dev         |
	And I click button "Submit Report"
	And I switch to "Targeted SDV Study Plan" window
	And I inactivate the plan
	And I edit Blocks 
	| Name              | Subject Count|
	| Architect Defined | 7            | 
	And I create a custom tier named "Custom Tier 1" and description "Adverse Events" with table
	| Form           | Selected |
	| Adverse Events | True     |
	And I select link "Study Block Plan"
	And I select the tier "Custom Tier 1" and Subject Count "1"
	And I activate the plan
	And I take a screenshot
	And I navigate to "Home"
	And I create 21 random Subjects with name "KKP" in Study "US19877" in Site "Site 1"
	And I take a screenshot
	And I navigate to "Home"
	And I navigate to "Reporter"
	And I select Report "Targeted SDV Subject Management"
	And I set report parameter "Study" with table
		| Name    | Environment |
		| US19877 | Dev         |
	And I click button "Submit Report"
	And I switch to "Targeted SDV Subject Override" window
	And I take a screenshot
	Then I verify that one of the following Permutations has been used every 7 subjects with name "KKP"
	| Randomization Permutations                                                           |
	| All Forms, All Forms, Architect Defined, Custom Tier 1, No Forms, No Forms, No Forms |
	| All Forms, All Forms, Architect Defined, No Forms, Custom Tier 1, No Forms, No Forms |
	| All Forms, All Forms, Architect Defined, No Forms, No Forms, Custom Tier 1, No Forms |
	| All Forms, All Forms, Architect Defined, No Forms, No Forms, No Forms, Custom Tier 1 |
	| All Forms, All Forms, Custom Tier 1, Architect Defined, No Forms, No Forms, No Forms |
	| All Forms, All Forms, No Forms, Architect Defined, Custom Tier 1, No Forms, No Forms |
	| All Forms, All Forms, No Forms, Architect Defined, No Forms, Custom Tier 1, No Forms |
	| All Forms, All Forms, No Forms, Architect Defined, No Forms, No Forms, Custom Tier 1 |
	| All Forms, All Forms, Custom Tier 1, No Forms, Architect Defined, No Forms, No Forms |
	| All Forms, All Forms, No Forms, Custom Tier 1, Architect Defined, No Forms, No Forms |
	| All Forms, All Forms, No Forms, No Forms, Architect Defined, Custom Tier 1, No Forms |
	| All Forms, All Forms, No Forms, No Forms, Architect Defined, No Forms, Custom Tier 1 |
	| All Forms, All Forms, Custom Tier 1, No Forms, No Forms, Architect Defined, No Forms |
	| All Forms, All Forms, No Forms, Custom Tier 1, No Forms, Architect Defined, No Forms |
	| All Forms, All Forms, No Forms, No Forms, Custom Tier 1, Architect Defined, No Forms |
	| All Forms, All Forms, No Forms, No Forms, No Forms, Architect Defined, Custom Tier 1 |
	| All Forms, All Forms, Custom Tier 1, No Forms, No Forms, No Forms, Architect Defined |
	| All Forms, All Forms, No Forms, Custom Tier 1, No Forms, No Forms, Architect Defined |
	| All Forms, All Forms, No Forms, No Forms, Custom Tier 1, No Forms, Architect Defined |
	| All Forms, All Forms, No Forms, No Forms, No Forms, Custom Tier 1, Architect Defined |
	| All Forms, Architect Defined, All Forms, Custom Tier 1, No Forms, No Forms, No Forms |
	| All Forms, Architect Defined, All Forms, No Forms, Custom Tier 1, No Forms, No Forms |
	| All Forms, Architect Defined, All Forms, No Forms, No Forms, Custom Tier 1, No Forms |
	| All Forms, Architect Defined, All Forms, No Forms, No Forms, No Forms, Custom Tier 1 |
	| All Forms, Custom Tier 1, All Forms, Architect Defined, No Forms, No Forms, No Forms |
	| All Forms, No Forms, All Forms, Architect Defined, Custom Tier 1, No Forms, No Forms |
	| All Forms, No Forms, All Forms, Architect Defined, No Forms, Custom Tier 1, No Forms |
	| All Forms, No Forms, All Forms, Architect Defined, No Forms, No Forms, Custom Tier 1 |
	| All Forms, Custom Tier 1, All Forms, No Forms, Architect Defined, No Forms, No Forms |
	| All Forms, No Forms, All Forms, Custom Tier 1, Architect Defined, No Forms, No Forms |
	| All Forms, No Forms, All Forms, No Forms, Architect Defined, Custom Tier 1, No Forms |
	| All Forms, No Forms, All Forms, No Forms, Architect Defined, No Forms, Custom Tier 1 |
	| All Forms, Custom Tier 1, All Forms, No Forms, No Forms, Architect Defined, No Forms |
	| All Forms, No Forms, All Forms, Custom Tier 1, No Forms, Architect Defined, No Forms |
	| All Forms, No Forms, All Forms, No Forms, Custom Tier 1, Architect Defined, No Forms |
	| All Forms, No Forms, All Forms, No Forms, No Forms, Architect Defined, Custom Tier 1 |
	| All Forms, Custom Tier 1, All Forms, No Forms, No Forms, No Forms, Architect Defined |
	| All Forms, No Forms, All Forms, Custom Tier 1, No Forms, No Forms, Architect Defined |
	| All Forms, No Forms, All Forms, No Forms, Custom Tier 1, No Forms, Architect Defined |
	| All Forms, No Forms, All Forms, No Forms, No Forms, Custom Tier 1, Architect Defined |
	| All Forms, Architect Defined, Custom Tier 1, All Forms, No Forms, No Forms, No Forms |
	| All Forms, Architect Defined, No Forms, All Forms, Custom Tier 1, No Forms, No Forms |
	| All Forms, Architect Defined, No Forms, All Forms, No Forms, Custom Tier 1, No Forms |
	| All Forms, Architect Defined, No Forms, All Forms, No Forms, No Forms, Custom Tier 1 |
	| All Forms, Custom Tier 1, Architect Defined, All Forms, No Forms, No Forms, No Forms |
	| All Forms, No Forms, Architect Defined, All Forms, Custom Tier 1, No Forms, No Forms |
	| All Forms, No Forms, Architect Defined, All Forms, No Forms, Custom Tier 1, No Forms |
	| All Forms, No Forms, Architect Defined, All Forms, No Forms, No Forms, Custom Tier 1 |
	| All Forms, Custom Tier 1, No Forms, All Forms, Architect Defined, No Forms, No Forms |
	| All Forms, No Forms, Custom Tier 1, All Forms, Architect Defined, No Forms, No Forms |
	| All Forms, No Forms, No Forms, All Forms, Architect Defined, Custom Tier 1, No Forms |
	| All Forms, No Forms, No Forms, All Forms, Architect Defined, No Forms, Custom Tier 1 |
	| All Forms, Custom Tier 1, No Forms, All Forms, No Forms, Architect Defined, No Forms |
	| All Forms, No Forms, Custom Tier 1, All Forms, No Forms, Architect Defined, No Forms |
	| All Forms, No Forms, No Forms, All Forms, Custom Tier 1, Architect Defined, No Forms |
	| All Forms, No Forms, No Forms, All Forms, No Forms, Architect Defined, Custom Tier 1 |
	| All Forms, Custom Tier 1, No Forms, All Forms, No Forms, No Forms, Architect Defined |
	| All Forms, No Forms, Custom Tier 1, All Forms, No Forms, No Forms, Architect Defined |
	| All Forms, No Forms, No Forms, All Forms, Custom Tier 1, No Forms, Architect Defined |
	| All Forms, No Forms, No Forms, All Forms, No Forms, Custom Tier 1, Architect Defined |
	| All Forms, Architect Defined, Custom Tier 1, No Forms, All Forms, No Forms, No Forms |
	| All Forms, Architect Defined, No Forms, Custom Tier 1, All Forms, No Forms, No Forms |
	| All Forms, Architect Defined, No Forms, No Forms, All Forms, Custom Tier 1, No Forms |
	| All Forms, Architect Defined, No Forms, No Forms, All Forms, No Forms, Custom Tier 1 |
	| All Forms, Custom Tier 1, Architect Defined, No Forms, All Forms, No Forms, No Forms |
	| All Forms, No Forms, Architect Defined, Custom Tier 1, All Forms, No Forms, No Forms |
	| All Forms, No Forms, Architect Defined, No Forms, All Forms, Custom Tier 1, No Forms |
	| All Forms, No Forms, Architect Defined, No Forms, All Forms, No Forms, Custom Tier 1 |
	| All Forms, Custom Tier 1, No Forms, Architect Defined, All Forms, No Forms, No Forms |
	| All Forms, No Forms, Custom Tier 1, Architect Defined, All Forms, No Forms, No Forms |
	| All Forms, No Forms, No Forms, Architect Defined, All Forms, Custom Tier 1, No Forms |
	| All Forms, No Forms, No Forms, Architect Defined, All Forms, No Forms, Custom Tier 1 |
	| All Forms, Custom Tier 1, No Forms, No Forms, All Forms, Architect Defined, No Forms |
	| All Forms, No Forms, Custom Tier 1, No Forms, All Forms, Architect Defined, No Forms |
	| All Forms, No Forms, No Forms, Custom Tier 1, All Forms, Architect Defined, No Forms |
	| All Forms, No Forms, No Forms, No Forms, All Forms, Architect Defined, Custom Tier 1 |
	| All Forms, Custom Tier 1, No Forms, No Forms, All Forms, No Forms, Architect Defined |
	| All Forms, No Forms, Custom Tier 1, No Forms, All Forms, No Forms, Architect Defined |
	| All Forms, No Forms, No Forms, Custom Tier 1, All Forms, No Forms, Architect Defined |
	| All Forms, No Forms, No Forms, No Forms, All Forms, Custom Tier 1, Architect Defined |
	| All Forms, Architect Defined, Custom Tier 1, No Forms, No Forms, All Forms, No Forms |
	| All Forms, Architect Defined, No Forms, Custom Tier 1, No Forms, All Forms, No Forms |
	| All Forms, Architect Defined, No Forms, No Forms, Custom Tier 1, All Forms, No Forms |
	| All Forms, Architect Defined, No Forms, No Forms, No Forms, All Forms, Custom Tier 1 |
	| All Forms, Custom Tier 1, Architect Defined, No Forms, No Forms, All Forms, No Forms |
	| All Forms, No Forms, Architect Defined, Custom Tier 1, No Forms, All Forms, No Forms |
	| All Forms, No Forms, Architect Defined, No Forms, Custom Tier 1, All Forms, No Forms |
	| All Forms, No Forms, Architect Defined, No Forms, No Forms, All Forms, Custom Tier 1 |
	| All Forms, Custom Tier 1, No Forms, Architect Defined, No Forms, All Forms, No Forms |
	| All Forms, No Forms, Custom Tier 1, Architect Defined, No Forms, All Forms, No Forms |
	| All Forms, No Forms, No Forms, Architect Defined, Custom Tier 1, All Forms, No Forms |
	| All Forms, No Forms, No Forms, Architect Defined, No Forms, All Forms, Custom Tier 1 |
	| All Forms, Custom Tier 1, No Forms, No Forms, Architect Defined, All Forms, No Forms |
	| All Forms, No Forms, Custom Tier 1, No Forms, Architect Defined, All Forms, No Forms |
	| All Forms, No Forms, No Forms, Custom Tier 1, Architect Defined, All Forms, No Forms |
	| All Forms, No Forms, No Forms, No Forms, Architect Defined, All Forms, Custom Tier 1 |
	| All Forms, Custom Tier 1, No Forms, No Forms, No Forms, All Forms, Architect Defined |
	| All Forms, No Forms, Custom Tier 1, No Forms, No Forms, All Forms, Architect Defined |
	| All Forms, No Forms, No Forms, Custom Tier 1, No Forms, All Forms, Architect Defined |
	| All Forms, No Forms, No Forms, No Forms, Custom Tier 1, All Forms, Architect Defined |
	| All Forms, Architect Defined, Custom Tier 1, No Forms, No Forms, No Forms, All Forms |
	| All Forms, Architect Defined, No Forms, Custom Tier 1, No Forms, No Forms, All Forms |
	| All Forms, Architect Defined, No Forms, No Forms, Custom Tier 1, No Forms, All Forms |
	| All Forms, Architect Defined, No Forms, No Forms, No Forms, Custom Tier 1, All Forms |
	| All Forms, Custom Tier 1, Architect Defined, No Forms, No Forms, No Forms, All Forms |
	| All Forms, No Forms, Architect Defined, Custom Tier 1, No Forms, No Forms, All Forms |
	| All Forms, No Forms, Architect Defined, No Forms, Custom Tier 1, No Forms, All Forms |
	| All Forms, No Forms, Architect Defined, No Forms, No Forms, Custom Tier 1, All Forms |
	| All Forms, Custom Tier 1, No Forms, Architect Defined, No Forms, No Forms, All Forms |
	| All Forms, No Forms, Custom Tier 1, Architect Defined, No Forms, No Forms, All Forms |
	| All Forms, No Forms, No Forms, Architect Defined, Custom Tier 1, No Forms, All Forms |
	| All Forms, No Forms, No Forms, Architect Defined, No Forms, Custom Tier 1, All Forms |
	| All Forms, Custom Tier 1, No Forms, No Forms, Architect Defined, No Forms, All Forms |
	| All Forms, No Forms, Custom Tier 1, No Forms, Architect Defined, No Forms, All Forms |
	| All Forms, No Forms, No Forms, Custom Tier 1, Architect Defined, No Forms, All Forms |
	| All Forms, No Forms, No Forms, No Forms, Architect Defined, Custom Tier 1, All Forms |
	| All Forms, Custom Tier 1, No Forms, No Forms, No Forms, Architect Defined, All Forms |
	| All Forms, No Forms, Custom Tier 1, No Forms, No Forms, Architect Defined, All Forms |
	| All Forms, No Forms, No Forms, Custom Tier 1, No Forms, Architect Defined, All Forms |
	| All Forms, No Forms, No Forms, No Forms, Custom Tier 1, Architect Defined, All Forms |
	| Architect Defined, All Forms, All Forms, Custom Tier 1, No Forms, No Forms, No Forms |
	| Architect Defined, All Forms, All Forms, No Forms, Custom Tier 1, No Forms, No Forms |
	| Architect Defined, All Forms, All Forms, No Forms, No Forms, Custom Tier 1, No Forms |
	| Architect Defined, All Forms, All Forms, No Forms, No Forms, No Forms, Custom Tier 1 |
	| Custom Tier 1, All Forms, All Forms, Architect Defined, No Forms, No Forms, No Forms |
	| No Forms, All Forms, All Forms, Architect Defined, Custom Tier 1, No Forms, No Forms |
	| No Forms, All Forms, All Forms, Architect Defined, No Forms, Custom Tier 1, No Forms |
	| No Forms, All Forms, All Forms, Architect Defined, No Forms, No Forms, Custom Tier 1 |
	| Custom Tier 1, All Forms, All Forms, No Forms, Architect Defined, No Forms, No Forms |
	| No Forms, All Forms, All Forms, Custom Tier 1, Architect Defined, No Forms, No Forms |
	| No Forms, All Forms, All Forms, No Forms, Architect Defined, Custom Tier 1, No Forms |
	| No Forms, All Forms, All Forms, No Forms, Architect Defined, No Forms, Custom Tier 1 |
	| Custom Tier 1, All Forms, All Forms, No Forms, No Forms, Architect Defined, No Forms |
	| No Forms, All Forms, All Forms, Custom Tier 1, No Forms, Architect Defined, No Forms |
	| No Forms, All Forms, All Forms, No Forms, Custom Tier 1, Architect Defined, No Forms |
	| No Forms, All Forms, All Forms, No Forms, No Forms, Architect Defined, Custom Tier 1 |
	| Custom Tier 1, All Forms, All Forms, No Forms, No Forms, No Forms, Architect Defined |
	| No Forms, All Forms, All Forms, Custom Tier 1, No Forms, No Forms, Architect Defined |
	| No Forms, All Forms, All Forms, No Forms, Custom Tier 1, No Forms, Architect Defined |
	| No Forms, All Forms, All Forms, No Forms, No Forms, Custom Tier 1, Architect Defined |
	| Architect Defined, All Forms, Custom Tier 1, All Forms, No Forms, No Forms, No Forms |
	| Architect Defined, All Forms, No Forms, All Forms, Custom Tier 1, No Forms, No Forms |
	| Architect Defined, All Forms, No Forms, All Forms, No Forms, Custom Tier 1, No Forms |
	| Architect Defined, All Forms, No Forms, All Forms, No Forms, No Forms, Custom Tier 1 |
	| Custom Tier 1, All Forms, Architect Defined, All Forms, No Forms, No Forms, No Forms |
	| No Forms, All Forms, Architect Defined, All Forms, Custom Tier 1, No Forms, No Forms |
	| No Forms, All Forms, Architect Defined, All Forms, No Forms, Custom Tier 1, No Forms |
	| No Forms, All Forms, Architect Defined, All Forms, No Forms, No Forms, Custom Tier 1 |
	| Custom Tier 1, All Forms, No Forms, All Forms, Architect Defined, No Forms, No Forms |
	| No Forms, All Forms, Custom Tier 1, All Forms, Architect Defined, No Forms, No Forms |
	| No Forms, All Forms, No Forms, All Forms, Architect Defined, Custom Tier 1, No Forms |
	| No Forms, All Forms, No Forms, All Forms, Architect Defined, No Forms, Custom Tier 1 |
	| Custom Tier 1, All Forms, No Forms, All Forms, No Forms, Architect Defined, No Forms |
	| No Forms, All Forms, Custom Tier 1, All Forms, No Forms, Architect Defined, No Forms |
	| No Forms, All Forms, No Forms, All Forms, Custom Tier 1, Architect Defined, No Forms |
	| No Forms, All Forms, No Forms, All Forms, No Forms, Architect Defined, Custom Tier 1 |
	| Custom Tier 1, All Forms, No Forms, All Forms, No Forms, No Forms, Architect Defined |
	| No Forms, All Forms, Custom Tier 1, All Forms, No Forms, No Forms, Architect Defined |
	| No Forms, All Forms, No Forms, All Forms, Custom Tier 1, No Forms, Architect Defined |
	| No Forms, All Forms, No Forms, All Forms, No Forms, Custom Tier 1, Architect Defined |
	| Architect Defined, All Forms, Custom Tier 1, No Forms, All Forms, No Forms, No Forms |
	| Architect Defined, All Forms, No Forms, Custom Tier 1, All Forms, No Forms, No Forms |
	| Architect Defined, All Forms, No Forms, No Forms, All Forms, Custom Tier 1, No Forms |
	| Architect Defined, All Forms, No Forms, No Forms, All Forms, No Forms, Custom Tier 1 |
	| Custom Tier 1, All Forms, Architect Defined, No Forms, All Forms, No Forms, No Forms |
	| No Forms, All Forms, Architect Defined, Custom Tier 1, All Forms, No Forms, No Forms |
	| No Forms, All Forms, Architect Defined, No Forms, All Forms, Custom Tier 1, No Forms |
	| No Forms, All Forms, Architect Defined, No Forms, All Forms, No Forms, Custom Tier 1 |
	| Custom Tier 1, All Forms, No Forms, Architect Defined, All Forms, No Forms, No Forms |
	| No Forms, All Forms, Custom Tier 1, Architect Defined, All Forms, No Forms, No Forms |
	| No Forms, All Forms, No Forms, Architect Defined, All Forms, Custom Tier 1, No Forms |
	| No Forms, All Forms, No Forms, Architect Defined, All Forms, No Forms, Custom Tier 1 |
	| Custom Tier 1, All Forms, No Forms, No Forms, All Forms, Architect Defined, No Forms |
	| No Forms, All Forms, Custom Tier 1, No Forms, All Forms, Architect Defined, No Forms |
	| No Forms, All Forms, No Forms, Custom Tier 1, All Forms, Architect Defined, No Forms |
	| No Forms, All Forms, No Forms, No Forms, All Forms, Architect Defined, Custom Tier 1 |
	| Custom Tier 1, All Forms, No Forms, No Forms, All Forms, No Forms, Architect Defined |
	| No Forms, All Forms, Custom Tier 1, No Forms, All Forms, No Forms, Architect Defined |
	| No Forms, All Forms, No Forms, Custom Tier 1, All Forms, No Forms, Architect Defined |
	| No Forms, All Forms, No Forms, No Forms, All Forms, Custom Tier 1, Architect Defined |
	| Architect Defined, All Forms, Custom Tier 1, No Forms, No Forms, All Forms, No Forms |
	| Architect Defined, All Forms, No Forms, Custom Tier 1, No Forms, All Forms, No Forms |
	| Architect Defined, All Forms, No Forms, No Forms, Custom Tier 1, All Forms, No Forms |
	| Architect Defined, All Forms, No Forms, No Forms, No Forms, All Forms, Custom Tier 1 |
	| Custom Tier 1, All Forms, Architect Defined, No Forms, No Forms, All Forms, No Forms |
	| No Forms, All Forms, Architect Defined, Custom Tier 1, No Forms, All Forms, No Forms |
	| No Forms, All Forms, Architect Defined, No Forms, Custom Tier 1, All Forms, No Forms |
	| No Forms, All Forms, Architect Defined, No Forms, No Forms, All Forms, Custom Tier 1 |
	| Custom Tier 1, All Forms, No Forms, Architect Defined, No Forms, All Forms, No Forms |
	| No Forms, All Forms, Custom Tier 1, Architect Defined, No Forms, All Forms, No Forms |
	| No Forms, All Forms, No Forms, Architect Defined, Custom Tier 1, All Forms, No Forms |
	| No Forms, All Forms, No Forms, Architect Defined, No Forms, All Forms, Custom Tier 1 |
	| Custom Tier 1, All Forms, No Forms, No Forms, Architect Defined, All Forms, No Forms |
	| No Forms, All Forms, Custom Tier 1, No Forms, Architect Defined, All Forms, No Forms |
	| No Forms, All Forms, No Forms, Custom Tier 1, Architect Defined, All Forms, No Forms |
	| No Forms, All Forms, No Forms, No Forms, Architect Defined, All Forms, Custom Tier 1 |
	| Custom Tier 1, All Forms, No Forms, No Forms, No Forms, All Forms, Architect Defined |
	| No Forms, All Forms, Custom Tier 1, No Forms, No Forms, All Forms, Architect Defined |
	| No Forms, All Forms, No Forms, Custom Tier 1, No Forms, All Forms, Architect Defined |
	| No Forms, All Forms, No Forms, No Forms, Custom Tier 1, All Forms, Architect Defined |
	| Architect Defined, All Forms, Custom Tier 1, No Forms, No Forms, No Forms, All Forms |
	| Architect Defined, All Forms, No Forms, Custom Tier 1, No Forms, No Forms, All Forms |
	| Architect Defined, All Forms, No Forms, No Forms, Custom Tier 1, No Forms, All Forms |
	| Architect Defined, All Forms, No Forms, No Forms, No Forms, Custom Tier 1, All Forms |
	| Custom Tier 1, All Forms, Architect Defined, No Forms, No Forms, No Forms, All Forms |
	| No Forms, All Forms, Architect Defined, Custom Tier 1, No Forms, No Forms, All Forms |
	| No Forms, All Forms, Architect Defined, No Forms, Custom Tier 1, No Forms, All Forms |
	| No Forms, All Forms, Architect Defined, No Forms, No Forms, Custom Tier 1, All Forms |
	| Custom Tier 1, All Forms, No Forms, Architect Defined, No Forms, No Forms, All Forms |
	| No Forms, All Forms, Custom Tier 1, Architect Defined, No Forms, No Forms, All Forms |
	| No Forms, All Forms, No Forms, Architect Defined, Custom Tier 1, No Forms, All Forms |
	| No Forms, All Forms, No Forms, Architect Defined, No Forms, Custom Tier 1, All Forms |
	| Custom Tier 1, All Forms, No Forms, No Forms, Architect Defined, No Forms, All Forms |
	| No Forms, All Forms, Custom Tier 1, No Forms, Architect Defined, No Forms, All Forms |
	| No Forms, All Forms, No Forms, Custom Tier 1, Architect Defined, No Forms, All Forms |
	| No Forms, All Forms, No Forms, No Forms, Architect Defined, Custom Tier 1, All Forms |
	| Custom Tier 1, All Forms, No Forms, No Forms, No Forms, Architect Defined, All Forms |
	| No Forms, All Forms, Custom Tier 1, No Forms, No Forms, Architect Defined, All Forms |
	| No Forms, All Forms, No Forms, Custom Tier 1, No Forms, Architect Defined, All Forms |
	| No Forms, All Forms, No Forms, No Forms, Custom Tier 1, Architect Defined, All Forms |
	| Architect Defined, Custom Tier 1, All Forms, All Forms, No Forms, No Forms, No Forms |
	| Architect Defined, No Forms, All Forms, All Forms, Custom Tier 1, No Forms, No Forms |
	| Architect Defined, No Forms, All Forms, All Forms, No Forms, Custom Tier 1, No Forms |
	| Architect Defined, No Forms, All Forms, All Forms, No Forms, No Forms, Custom Tier 1 |
	| Custom Tier 1, Architect Defined, All Forms, All Forms, No Forms, No Forms, No Forms |
	| No Forms, Architect Defined, All Forms, All Forms, Custom Tier 1, No Forms, No Forms |
	| No Forms, Architect Defined, All Forms, All Forms, No Forms, Custom Tier 1, No Forms |
	| No Forms, Architect Defined, All Forms, All Forms, No Forms, No Forms, Custom Tier 1 |
	| Custom Tier 1, No Forms, All Forms, All Forms, Architect Defined, No Forms, No Forms |
	| No Forms, Custom Tier 1, All Forms, All Forms, Architect Defined, No Forms, No Forms |
	| No Forms, No Forms, All Forms, All Forms, Architect Defined, Custom Tier 1, No Forms |
	| No Forms, No Forms, All Forms, All Forms, Architect Defined, No Forms, Custom Tier 1 |
	| Custom Tier 1, No Forms, All Forms, All Forms, No Forms, Architect Defined, No Forms |
	| No Forms, Custom Tier 1, All Forms, All Forms, No Forms, Architect Defined, No Forms |
	| No Forms, No Forms, All Forms, All Forms, Custom Tier 1, Architect Defined, No Forms |
	| No Forms, No Forms, All Forms, All Forms, No Forms, Architect Defined, Custom Tier 1 |
	| Custom Tier 1, No Forms, All Forms, All Forms, No Forms, No Forms, Architect Defined |
	| No Forms, Custom Tier 1, All Forms, All Forms, No Forms, No Forms, Architect Defined |
	| No Forms, No Forms, All Forms, All Forms, Custom Tier 1, No Forms, Architect Defined |
	| No Forms, No Forms, All Forms, All Forms, No Forms, Custom Tier 1, Architect Defined |
	| Architect Defined, Custom Tier 1, All Forms, No Forms, All Forms, No Forms, No Forms |
	| Architect Defined, No Forms, All Forms, Custom Tier 1, All Forms, No Forms, No Forms |
	| Architect Defined, No Forms, All Forms, No Forms, All Forms, Custom Tier 1, No Forms |
	| Architect Defined, No Forms, All Forms, No Forms, All Forms, No Forms, Custom Tier 1 |
	| Custom Tier 1, Architect Defined, All Forms, No Forms, All Forms, No Forms, No Forms |
	| No Forms, Architect Defined, All Forms, Custom Tier 1, All Forms, No Forms, No Forms |
	| No Forms, Architect Defined, All Forms, No Forms, All Forms, Custom Tier 1, No Forms |
	| No Forms, Architect Defined, All Forms, No Forms, All Forms, No Forms, Custom Tier 1 |
	| Custom Tier 1, No Forms, All Forms, Architect Defined, All Forms, No Forms, No Forms |
	| No Forms, Custom Tier 1, All Forms, Architect Defined, All Forms, No Forms, No Forms |
	| No Forms, No Forms, All Forms, Architect Defined, All Forms, Custom Tier 1, No Forms |
	| No Forms, No Forms, All Forms, Architect Defined, All Forms, No Forms, Custom Tier 1 |
	| Custom Tier 1, No Forms, All Forms, No Forms, All Forms, Architect Defined, No Forms |
	| No Forms, Custom Tier 1, All Forms, No Forms, All Forms, Architect Defined, No Forms |
	| No Forms, No Forms, All Forms, Custom Tier 1, All Forms, Architect Defined, No Forms |
	| No Forms, No Forms, All Forms, No Forms, All Forms, Architect Defined, Custom Tier 1 |
	| Custom Tier 1, No Forms, All Forms, No Forms, All Forms, No Forms, Architect Defined |
	| No Forms, Custom Tier 1, All Forms, No Forms, All Forms, No Forms, Architect Defined |
	| No Forms, No Forms, All Forms, Custom Tier 1, All Forms, No Forms, Architect Defined |
	| No Forms, No Forms, All Forms, No Forms, All Forms, Custom Tier 1, Architect Defined |
	| Architect Defined, Custom Tier 1, All Forms, No Forms, No Forms, All Forms, No Forms |
	| Architect Defined, No Forms, All Forms, Custom Tier 1, No Forms, All Forms, No Forms |
	| Architect Defined, No Forms, All Forms, No Forms, Custom Tier 1, All Forms, No Forms |
	| Architect Defined, No Forms, All Forms, No Forms, No Forms, All Forms, Custom Tier 1 |
	| Custom Tier 1, Architect Defined, All Forms, No Forms, No Forms, All Forms, No Forms |
	| No Forms, Architect Defined, All Forms, Custom Tier 1, No Forms, All Forms, No Forms |
	| No Forms, Architect Defined, All Forms, No Forms, Custom Tier 1, All Forms, No Forms |
	| No Forms, Architect Defined, All Forms, No Forms, No Forms, All Forms, Custom Tier 1 |
	| Custom Tier 1, No Forms, All Forms, Architect Defined, No Forms, All Forms, No Forms |
	| No Forms, Custom Tier 1, All Forms, Architect Defined, No Forms, All Forms, No Forms |
	| No Forms, No Forms, All Forms, Architect Defined, Custom Tier 1, All Forms, No Forms |
	| No Forms, No Forms, All Forms, Architect Defined, No Forms, All Forms, Custom Tier 1 |
	| Custom Tier 1, No Forms, All Forms, No Forms, Architect Defined, All Forms, No Forms |
	| No Forms, Custom Tier 1, All Forms, No Forms, Architect Defined, All Forms, No Forms |
	| No Forms, No Forms, All Forms, Custom Tier 1, Architect Defined, All Forms, No Forms |
	| No Forms, No Forms, All Forms, No Forms, Architect Defined, All Forms, Custom Tier 1 |
	| Custom Tier 1, No Forms, All Forms, No Forms, No Forms, All Forms, Architect Defined |
	| No Forms, Custom Tier 1, All Forms, No Forms, No Forms, All Forms, Architect Defined |
	| No Forms, No Forms, All Forms, Custom Tier 1, No Forms, All Forms, Architect Defined |
	| No Forms, No Forms, All Forms, No Forms, Custom Tier 1, All Forms, Architect Defined |
	| Architect Defined, Custom Tier 1, All Forms, No Forms, No Forms, No Forms, All Forms |
	| Architect Defined, No Forms, All Forms, Custom Tier 1, No Forms, No Forms, All Forms |
	| Architect Defined, No Forms, All Forms, No Forms, Custom Tier 1, No Forms, All Forms |
	| Architect Defined, No Forms, All Forms, No Forms, No Forms, Custom Tier 1, All Forms |
	| Custom Tier 1, Architect Defined, All Forms, No Forms, No Forms, No Forms, All Forms |
	| No Forms, Architect Defined, All Forms, Custom Tier 1, No Forms, No Forms, All Forms |
	| No Forms, Architect Defined, All Forms, No Forms, Custom Tier 1, No Forms, All Forms |
	| No Forms, Architect Defined, All Forms, No Forms, No Forms, Custom Tier 1, All Forms |
	| Custom Tier 1, No Forms, All Forms, Architect Defined, No Forms, No Forms, All Forms |
	| No Forms, Custom Tier 1, All Forms, Architect Defined, No Forms, No Forms, All Forms |
	| No Forms, No Forms, All Forms, Architect Defined, Custom Tier 1, No Forms, All Forms |
	| No Forms, No Forms, All Forms, Architect Defined, No Forms, Custom Tier 1, All Forms |
	| Custom Tier 1, No Forms, All Forms, No Forms, Architect Defined, No Forms, All Forms |
	| No Forms, Custom Tier 1, All Forms, No Forms, Architect Defined, No Forms, All Forms |
	| No Forms, No Forms, All Forms, Custom Tier 1, Architect Defined, No Forms, All Forms |
	| No Forms, No Forms, All Forms, No Forms, Architect Defined, Custom Tier 1, All Forms |
	| Custom Tier 1, No Forms, All Forms, No Forms, No Forms, Architect Defined, All Forms |
	| No Forms, Custom Tier 1, All Forms, No Forms, No Forms, Architect Defined, All Forms |
	| No Forms, No Forms, All Forms, Custom Tier 1, No Forms, Architect Defined, All Forms |
	| No Forms, No Forms, All Forms, No Forms, Custom Tier 1, Architect Defined, All Forms |
	| Architect Defined, Custom Tier 1, No Forms, All Forms, All Forms, No Forms, No Forms |
	| Architect Defined, No Forms, Custom Tier 1, All Forms, All Forms, No Forms, No Forms |
	| Architect Defined, No Forms, No Forms, All Forms, All Forms, Custom Tier 1, No Forms |
	| Architect Defined, No Forms, No Forms, All Forms, All Forms, No Forms, Custom Tier 1 |
	| Custom Tier 1, Architect Defined, No Forms, All Forms, All Forms, No Forms, No Forms |
	| No Forms, Architect Defined, Custom Tier 1, All Forms, All Forms, No Forms, No Forms |
	| No Forms, Architect Defined, No Forms, All Forms, All Forms, Custom Tier 1, No Forms |
	| No Forms, Architect Defined, No Forms, All Forms, All Forms, No Forms, Custom Tier 1 |
	| Custom Tier 1, No Forms, Architect Defined, All Forms, All Forms, No Forms, No Forms |
	| No Forms, Custom Tier 1, Architect Defined, All Forms, All Forms, No Forms, No Forms |
	| No Forms, No Forms, Architect Defined, All Forms, All Forms, Custom Tier 1, No Forms |
	| No Forms, No Forms, Architect Defined, All Forms, All Forms, No Forms, Custom Tier 1 |
	| Custom Tier 1, No Forms, No Forms, All Forms, All Forms, Architect Defined, No Forms |
	| No Forms, Custom Tier 1, No Forms, All Forms, All Forms, Architect Defined, No Forms |
	| No Forms, No Forms, Custom Tier 1, All Forms, All Forms, Architect Defined, No Forms |
	| No Forms, No Forms, No Forms, All Forms, All Forms, Architect Defined, Custom Tier 1 |
	| Custom Tier 1, No Forms, No Forms, All Forms, All Forms, No Forms, Architect Defined |
	| No Forms, Custom Tier 1, No Forms, All Forms, All Forms, No Forms, Architect Defined |
	| No Forms, No Forms, Custom Tier 1, All Forms, All Forms, No Forms, Architect Defined |
	| No Forms, No Forms, No Forms, All Forms, All Forms, Custom Tier 1, Architect Defined |
	| Architect Defined, Custom Tier 1, No Forms, All Forms, No Forms, All Forms, No Forms |
	| Architect Defined, No Forms, Custom Tier 1, All Forms, No Forms, All Forms, No Forms |
	| Architect Defined, No Forms, No Forms, All Forms, Custom Tier 1, All Forms, No Forms |
	| Architect Defined, No Forms, No Forms, All Forms, No Forms, All Forms, Custom Tier 1 |
	| Custom Tier 1, Architect Defined, No Forms, All Forms, No Forms, All Forms, No Forms |
	| No Forms, Architect Defined, Custom Tier 1, All Forms, No Forms, All Forms, No Forms |
	| No Forms, Architect Defined, No Forms, All Forms, Custom Tier 1, All Forms, No Forms |
	| No Forms, Architect Defined, No Forms, All Forms, No Forms, All Forms, Custom Tier 1 |
	| Custom Tier 1, No Forms, Architect Defined, All Forms, No Forms, All Forms, No Forms |
	| No Forms, Custom Tier 1, Architect Defined, All Forms, No Forms, All Forms, No Forms |
	| No Forms, No Forms, Architect Defined, All Forms, Custom Tier 1, All Forms, No Forms |
	| No Forms, No Forms, Architect Defined, All Forms, No Forms, All Forms, Custom Tier 1 |
	| Custom Tier 1, No Forms, No Forms, All Forms, Architect Defined, All Forms, No Forms |
	| No Forms, Custom Tier 1, No Forms, All Forms, Architect Defined, All Forms, No Forms |
	| No Forms, No Forms, Custom Tier 1, All Forms, Architect Defined, All Forms, No Forms |
	| No Forms, No Forms, No Forms, All Forms, Architect Defined, All Forms, Custom Tier 1 |
	| Custom Tier 1, No Forms, No Forms, All Forms, No Forms, All Forms, Architect Defined |
	| No Forms, Custom Tier 1, No Forms, All Forms, No Forms, All Forms, Architect Defined |
	| No Forms, No Forms, Custom Tier 1, All Forms, No Forms, All Forms, Architect Defined |
	| No Forms, No Forms, No Forms, All Forms, Custom Tier 1, All Forms, Architect Defined |
	| Architect Defined, Custom Tier 1, No Forms, All Forms, No Forms, No Forms, All Forms |
	| Architect Defined, No Forms, Custom Tier 1, All Forms, No Forms, No Forms, All Forms |
	| Architect Defined, No Forms, No Forms, All Forms, Custom Tier 1, No Forms, All Forms |
	| Architect Defined, No Forms, No Forms, All Forms, No Forms, Custom Tier 1, All Forms |
	| Custom Tier 1, Architect Defined, No Forms, All Forms, No Forms, No Forms, All Forms |
	| No Forms, Architect Defined, Custom Tier 1, All Forms, No Forms, No Forms, All Forms |
	| No Forms, Architect Defined, No Forms, All Forms, Custom Tier 1, No Forms, All Forms |
	| No Forms, Architect Defined, No Forms, All Forms, No Forms, Custom Tier 1, All Forms |
	| Custom Tier 1, No Forms, Architect Defined, All Forms, No Forms, No Forms, All Forms |
	| No Forms, Custom Tier 1, Architect Defined, All Forms, No Forms, No Forms, All Forms |
	| No Forms, No Forms, Architect Defined, All Forms, Custom Tier 1, No Forms, All Forms |
	| No Forms, No Forms, Architect Defined, All Forms, No Forms, Custom Tier 1, All Forms |
	| Custom Tier 1, No Forms, No Forms, All Forms, Architect Defined, No Forms, All Forms |
	| No Forms, Custom Tier 1, No Forms, All Forms, Architect Defined, No Forms, All Forms |
	| No Forms, No Forms, Custom Tier 1, All Forms, Architect Defined, No Forms, All Forms |
	| No Forms, No Forms, No Forms, All Forms, Architect Defined, Custom Tier 1, All Forms |
	| Custom Tier 1, No Forms, No Forms, All Forms, No Forms, Architect Defined, All Forms |
	| No Forms, Custom Tier 1, No Forms, All Forms, No Forms, Architect Defined, All Forms |
	| No Forms, No Forms, Custom Tier 1, All Forms, No Forms, Architect Defined, All Forms |
	| No Forms, No Forms, No Forms, All Forms, Custom Tier 1, Architect Defined, All Forms |
	| Architect Defined, Custom Tier 1, No Forms, No Forms, All Forms, All Forms, No Forms |
	| Architect Defined, No Forms, Custom Tier 1, No Forms, All Forms, All Forms, No Forms |
	| Architect Defined, No Forms, No Forms, Custom Tier 1, All Forms, All Forms, No Forms |
	| Architect Defined, No Forms, No Forms, No Forms, All Forms, All Forms, Custom Tier 1 |
	| Custom Tier 1, Architect Defined, No Forms, No Forms, All Forms, All Forms, No Forms |
	| No Forms, Architect Defined, Custom Tier 1, No Forms, All Forms, All Forms, No Forms |
	| No Forms, Architect Defined, No Forms, Custom Tier 1, All Forms, All Forms, No Forms |
	| No Forms, Architect Defined, No Forms, No Forms, All Forms, All Forms, Custom Tier 1 |
	| Custom Tier 1, No Forms, Architect Defined, No Forms, All Forms, All Forms, No Forms |
	| No Forms, Custom Tier 1, Architect Defined, No Forms, All Forms, All Forms, No Forms |
	| No Forms, No Forms, Architect Defined, Custom Tier 1, All Forms, All Forms, No Forms |
	| No Forms, No Forms, Architect Defined, No Forms, All Forms, All Forms, Custom Tier 1 |
	| Custom Tier 1, No Forms, No Forms, Architect Defined, All Forms, All Forms, No Forms |
	| No Forms, Custom Tier 1, No Forms, Architect Defined, All Forms, All Forms, No Forms |
	| No Forms, No Forms, Custom Tier 1, Architect Defined, All Forms, All Forms, No Forms |
	| No Forms, No Forms, No Forms, Architect Defined, All Forms, All Forms, Custom Tier 1 |
	| Custom Tier 1, No Forms, No Forms, No Forms, All Forms, All Forms, Architect Defined |
	| No Forms, Custom Tier 1, No Forms, No Forms, All Forms, All Forms, Architect Defined |
	| No Forms, No Forms, Custom Tier 1, No Forms, All Forms, All Forms, Architect Defined |
	| No Forms, No Forms, No Forms, Custom Tier 1, All Forms, All Forms, Architect Defined |
	| Architect Defined, Custom Tier 1, No Forms, No Forms, All Forms, No Forms, All Forms |
	| Architect Defined, No Forms, Custom Tier 1, No Forms, All Forms, No Forms, All Forms |
	| Architect Defined, No Forms, No Forms, Custom Tier 1, All Forms, No Forms, All Forms |
	| Architect Defined, No Forms, No Forms, No Forms, All Forms, Custom Tier 1, All Forms |
	| Custom Tier 1, Architect Defined, No Forms, No Forms, All Forms, No Forms, All Forms |
	| No Forms, Architect Defined, Custom Tier 1, No Forms, All Forms, No Forms, All Forms |
	| No Forms, Architect Defined, No Forms, Custom Tier 1, All Forms, No Forms, All Forms |
	| No Forms, Architect Defined, No Forms, No Forms, All Forms, Custom Tier 1, All Forms |
	| Custom Tier 1, No Forms, Architect Defined, No Forms, All Forms, No Forms, All Forms |
	| No Forms, Custom Tier 1, Architect Defined, No Forms, All Forms, No Forms, All Forms |
	| No Forms, No Forms, Architect Defined, Custom Tier 1, All Forms, No Forms, All Forms |
	| No Forms, No Forms, Architect Defined, No Forms, All Forms, Custom Tier 1, All Forms |
	| Custom Tier 1, No Forms, No Forms, Architect Defined, All Forms, No Forms, All Forms |
	| No Forms, Custom Tier 1, No Forms, Architect Defined, All Forms, No Forms, All Forms |
	| No Forms, No Forms, Custom Tier 1, Architect Defined, All Forms, No Forms, All Forms |
	| No Forms, No Forms, No Forms, Architect Defined, All Forms, Custom Tier 1, All Forms |
	| Custom Tier 1, No Forms, No Forms, No Forms, All Forms, Architect Defined, All Forms |
	| No Forms, Custom Tier 1, No Forms, No Forms, All Forms, Architect Defined, All Forms |
	| No Forms, No Forms, Custom Tier 1, No Forms, All Forms, Architect Defined, All Forms |
	| No Forms, No Forms, No Forms, Custom Tier 1, All Forms, Architect Defined, All Forms |
	| Architect Defined, Custom Tier 1, No Forms, No Forms, No Forms, All Forms, All Forms |
	| Architect Defined, No Forms, Custom Tier 1, No Forms, No Forms, All Forms, All Forms |
	| Architect Defined, No Forms, No Forms, Custom Tier 1, No Forms, All Forms, All Forms |
	| Architect Defined, No Forms, No Forms, No Forms, Custom Tier 1, All Forms, All Forms |
	| Custom Tier 1, Architect Defined, No Forms, No Forms, No Forms, All Forms, All Forms |
	| No Forms, Architect Defined, Custom Tier 1, No Forms, No Forms, All Forms, All Forms |
	| No Forms, Architect Defined, No Forms, Custom Tier 1, No Forms, All Forms, All Forms |
	| No Forms, Architect Defined, No Forms, No Forms, Custom Tier 1, All Forms, All Forms |
	| Custom Tier 1, No Forms, Architect Defined, No Forms, No Forms, All Forms, All Forms |
	| No Forms, Custom Tier 1, Architect Defined, No Forms, No Forms, All Forms, All Forms |
	| No Forms, No Forms, Architect Defined, Custom Tier 1, No Forms, All Forms, All Forms |
	| No Forms, No Forms, Architect Defined, No Forms, Custom Tier 1, All Forms, All Forms |
	| Custom Tier 1, No Forms, No Forms, Architect Defined, No Forms, All Forms, All Forms |
	| No Forms, Custom Tier 1, No Forms, Architect Defined, No Forms, All Forms, All Forms |
	| No Forms, No Forms, Custom Tier 1, Architect Defined, No Forms, All Forms, All Forms |
	| No Forms, No Forms, No Forms, Architect Defined, Custom Tier 1, All Forms, All Forms |
	| Custom Tier 1, No Forms, No Forms, No Forms, Architect Defined, All Forms, All Forms |
	| No Forms, Custom Tier 1, No Forms, No Forms, Architect Defined, All Forms, All Forms |
	| No Forms, No Forms, Custom Tier 1, No Forms, Architect Defined, All Forms, All Forms |
	| No Forms, No Forms, No Forms, Custom Tier 1, Architect Defined, All Forms, All Forms |
	And I switch to the second window