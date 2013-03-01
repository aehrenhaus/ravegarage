# As a user, I can choose between two randomization types and change randomization types for non-Production plans
@EnableSeeding=true
@FT_US19017
Feature: US19017 As a user, I can choose between two randomization types and change randomization types for non-Production plans
	When user selects Targeted SDV Configuration report
	And environment is equal to Production
	And user selects a Randomization Type 
	Then subject assignment satisfies a specified allocation ratio
	And subject assignment is random for all blocks
	
Background:

	Given xml draft "US19017.xml" is Uploaded with Environments
		| Name |
		| Dev  |
		| Prod |

	Given Site "Site 1" with Site Group "Asia" exists
	Given Site "Site 2" with Site Group "Europe" exists
	Given study "US19017" is assigned to Site "Site 1" with study environment "Aux: Dev"
	Given study "US19017" is assigned to Site "Site 1" with study environment "Live: Prod"
	Given study "US19017" is assigned to Site "Site 2" with study environment "Aux: Dev"
	Given study "US19017" is assigned to Site "Site 2" with study environment "Live: Prod"

	Given I publish and push eCRF "US19017.xml" to "Version 1" with study environment "Prod"
	Given I publish and push eCRF "US19017.xml" to "Version 1" with study environment "Dev"

	And I set lines per page to 100 for User "SUPER USER 1"
	And following Project assignments exist
	| User         | Project | Environment | Role         | Site   | SecurityRole          | 
	| SUPER USER 1 | US19017 | Live: Prod  | SUPER ROLE 1 | Site 1 | Project Admin Default | 
	| SUPER USER 1 | US19017 | Aux: Dev    | SUPER ROLE 1 | Site 1 | Project Admin Default | 
	| SUPER USER 1 | US19017 | Live: Prod  | SUPER ROLE 1 | Site 2 | Project Admin Default | 
	| SUPER USER 1 | US19017 | Aux: Dev    | SUPER ROLE 1 | Site 2 | Project Admin Default | 
	
	And Role "SUPER ROLE 1" has Action "Entry"
	Given following Report assignments exist
	| User         | Report                                                            |
	| SUPER USER 1 | Targeted SDV Configuration - Targeted SDV Configuration           |
	| SUPER USER 1 | Targeted SDV Subject Management - Targeted SDV Subject Managemen |
	


	#| Block Name        | Subject Count | IsRepeated | Tier Name                        | Subject Count | Folder | Form | Field |
	#| Architect Defined | 7             | Yes        |                                  |               |        |      |       |
	#|                   |               |            | Architect Defined (Default Tier) | 1             |        |      |       |
	#|                   |               |            | All Forms (Default Tier)         | 2             |        |      |       |
	#|                   |               |            | No Forms (Default Tier)          | 3             |        |      |       |
	
	
	#And Targeted SDV Configuration has settings
	#| Block Plan Name       | Contains Subjects | Data Entry Role | Activated | Average Subject Per Site | Estimated Coverage | Using Matrix | Date of Estimation | Randomization Type |
	#| US19017 Block Plan |                   | SUPER ROLE 1    | Checked   |                          |                    |              |                    |                    |
	#And the following Randomization Types exist
	#| Randomization Type |
	#| Dynamic Allocation |
	#| Permuted Block     |



@release_2012.1.0 
@PB_US19017_01
@Validation

Scenario: PB_US19017_01 When I enroll 20 subjects in a Production environment, and my Randomization Type is Dynamic Allocation, TSDV will randomize subjects in non-sequential order and I am not able to change the Randomization Type after a subject is enrolled. 
	When I login to Rave with user "SUPER USER 1"
	And I navigate to "Reporter"
	And I select Report "Targeted SDV Configuration"
	And I set report parameter "Study" with table
	| Name    | Environment |
	| US19017 | Prod        |
	And I click button "Submit Report"
	And I switch to "Targeted SDV Study Plan" window
	And I create a new block plan named "US19017 (Prod) Block Plan" with Data entry Role "SUPER ROLE 1"
	And I verify text "Dynamic Allocation" exists
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
	And I create 30 random Subjects with name "ABB" in Study "US19017" (Prod) in Site "Site 1"
	And I take a screenshot
	And I navigate to "Home"
	And I navigate to "Reporter"
	And I select Report "Targeted SDV Subject Management"
	And I set report parameter "Study" with table
	| Name    | Environment |
	| US19017 | Prod        |
	And I click button "Submit Report"
	And I switch to "Targeted SDV Subject Override" window 
	And I take a screenshot
	Then I verify that Tiers in subject override table are not in the following order
		| Tier Name         | Row  |
		| All Forms         | 1    |
		| No Forms          | 2    |
		| Architect Defined | 3    |
		| All Forms         | 4    |
		| No Forms          | 5    |
		| Architect Defined | 6    |
		| All Forms         | 7    |
		| No Forms          | 8    |
		| Architect Defined | 9    |
		| All Forms         | 10   |
		| No Forms          | 11   |
		| Architect Defined | 12   |
		| All Forms         | 13   |
		| No Forms          | 14   |
		| Architect Defined | 15   |
		| All Forms         | 16   |
		| No Forms          | 17   |
		| Architect Defined | 18   |
		| All Forms         | 19   |
		| No Forms          | 20   |
		| Architect Defined | 21   |
		| All Forms         | 22   |
		| No Forms          | 23   |
		| Architect Defined | 24   |
		| All Forms         | 25   |
		| No Forms          | 26   |
		| Architect Defined | 27   |
		| All Forms         | 28   |
		| No Forms          | 29   |
		| Architect Defined | 30   |
	And I verify every 3 rows of subjects in 30 rows do not have tiers pattern
	And I switch to "Reports" window
	And I navigate to "Home"
	And I navigate to "Reporter"
	And I select Report "Targeted SDV Configuration"
	And I set report parameter "Study" with table
	| Name    | Environment |
	| US19017 | Prod        |
	And I click button "Submit Report"
	And I switch to "Targeted SDV Study Plan" window
	And I verify text "Dynamic Allocation" exists
	And I click button "edit block plan"
	Then I verify "Randomization Type" is disabled
	And I take a screenshot
	And I switch to "Reports" window
	And I navigate to "Home"
	And I navigate to "Reporter"
	And I select Report "Targeted SDV Configuration"
	And I set report parameter "Study" with table
	| Name    | Environment |
	| US19017 | Dev	        |
	And I click button "Submit Report"
	And I switch to "Targeted SDV Study Plan" window
	And I create a new block plan named "US19017 (Dev) Block Plan" with Data entry Role "SUPER ROLE 1"
	And I verify text "Dynamic Allocation" exists
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
	And I create 30 random Subjects with name "ABB" in Study "US19017" (Dev) in Site "Site 1"
	And I take a screenshot
	And I navigate to "Home"
	And I navigate to "Reporter"
	And I select Report "Targeted SDV Subject Management"
	And I set report parameter "Study" with table
	| Name    | Environment |
	| US19017 | Dev	        |
	And I click button "Submit Report"
	And I switch to "Targeted SDV Subject Override" window 
	And I take a screenshot
	Then I verify that Tiers in subject override table are not in the following order
		| Tier Name         | Row  |
		| All Forms         | 1    |
		| No Forms          | 2    |
		| Architect Defined | 3    |
		| All Forms         | 4    |
		| No Forms          | 5    |
		| Architect Defined | 6    |
		| All Forms         | 7    |
		| No Forms          | 8    |
		| Architect Defined | 9    |
		| All Forms         | 10   |
		| No Forms          | 11   |
		| Architect Defined | 12   |
		| All Forms         | 13   |
		| No Forms          | 14   |
		| Architect Defined | 15   |
		| All Forms         | 16   |
		| No Forms          | 17   |
		| Architect Defined | 18   |
		| All Forms         | 19   |
		| No Forms          | 20   |
		| Architect Defined | 21   |
		| All Forms         | 22   |
		| No Forms          | 23   |
		| Architect Defined | 24   |
		| All Forms         | 25   |
		| No Forms          | 26   |
		| Architect Defined | 27   |
		| All Forms         | 28   |
		| No Forms          | 29   |
		| Architect Defined | 30   |
	And I verify every 3 rows of subjects in 30 rows do not have tiers pattern
	And I switch to "Reports" window
	And I navigate to "Home"
	And I navigate to "Reporter"
	And I select Report "Targeted SDV Configuration"
	And I set report parameter "Study" with table
	| Name    | Environment |
	| US19017 | Dev	        |
	And I click button "Submit Report"
	And I switch to "Targeted SDV Study Plan" window
	And I verify text "Dynamic Allocation" exists
	And I take a screenshot
	And I click button "edit block plan"
	And I choose "Permuted Block" from "Randomization Type"
	And I click button "save block plan"
	Then I verify text "Permuted Block" exists
	And I take a screenshot
	And I switch to "Reports" window
	And I navigate to "Home"
	And I navigate to "Reporter"
	And I select Report "Targeted SDV Configuration"
	And I set report parameter "Study" with table
	| Name    | Environment |
	| US19017 | Prod        |
	And I click button "Submit Report"
	And I switch to "Targeted SDV Study Plan" window
	And I select Site Group link "World"
	And I select Site link "Site 2"
	And I create a new block plan named "Site 2 Block Plan" with Data entry Role "SUPER ROLE 1"
	And I verify text "Dynamic Allocation" exists
	And I take a screenshot
	And I click button "edit block plan"
	And I choose "Permuted Block" from "Randomization Type"
	And I click button "save block plan"
	And I verify text "Permuted Block" exists
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
	And I create 30 random Subjects with name "ABB" in Study "US19017" (Prod) in Site "Site 2"
	And I take a screenshot
	And I navigate to "Home"
	And I navigate to "Reporter"
	And I select Report "Targeted SDV Subject Management"
	And I set report parameter "Study" with table
	| Name    | Environment |
	| US19017 | Prod        |
	And I click button "Submit Report"
	And I switch to "Targeted SDV Subject Override" window 
	And I choose Site "Site 2" from "Sites"
	And I select link "Search"
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
	| US19017 | Prod        |
	And I click button "Submit Report"
	And I switch to "Targeted SDV Study Plan" window
	And I select Site Group link "World"
	And I select Site link "Site 2"
	And I click button "edit block plan"
	And I verify text "Permuted Block" exists
	Then I verify "Randomization Type" is disabled
	And I take a screenshot
	And I switch to "Reports" window
	And I navigate to "Home"
	And I navigate to "Reporter"
	And I select Report "Targeted SDV Configuration"
	And I set report parameter "Study" with table
	| Name    | Environment |
	| US19017 | Dev	        |
	And I click button "Submit Report"
	And I switch to "Targeted SDV Study Plan" window
	And I select Site Group link "World"
	And I select Site link "Site 2"
	And I create a new block plan named "Site 2 Block Plan" with Data entry Role "SUPER ROLE 1"
	And I verify text "Dynamic Allocation" exists
	And I take a screenshot
	And I click button "edit block plan"
	And I choose "Permuted Block" from "Randomization Type"
	And I click button "save block plan"
	And I take a screenshot
	And I verify text "Permuted Block" exists
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
	And I create 30 random Subjects with name "ABB" in Study "US19017" (Dev) in Site "Site 2"
	And I take a screenshot
	And I navigate to "Home"
	And I navigate to "Reporter"
	And I select Report "Targeted SDV Subject Management"
	And I set report parameter "Study" with table
	| Name    | Environment |
	| US19017 | Dev	        |
	And I click button "Submit Report"
	And I switch to "Targeted SDV Subject Override" window 
	And I choose Site "Site 2" from "Sites"
	And I select link "Search"
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
	| US19017 | Dev         |
	And I click button "Submit Report"
	And I switch to "Targeted SDV Study Plan" window
	And I select Site Group link "World"
	And I select Site link "Site 2"
	And I click button "edit block plan"
	And I inactivate the plan
	And I verify text "Permuted Block" exists
	And I take a screenshot
	And I click button "edit block plan"
	And I choose "Dynamic Allocation" from "Randomization Type"
	And I click button "save block plan"
	Then I verify text "Dynamic Allocation" exists
	And I take a screenshot
	And I switch to the second window
	
	