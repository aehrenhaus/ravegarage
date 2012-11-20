# When a user selects Permuted Block Randomization, subject assignment satisfies a specified allocation and ratio is random for all blocks.
@EnableSeeding=true
@SuppressSeeding=SiteGroup,Site,Role,SecurityRole
@ignore
Feature: US18689
	When user selects Permuted Block Randomization
	Then subject assignment satisfies a specified allocation ratio
	And subject assignment is random for all blocks
	And each randomization permutation has an equal probability of being selected

Background:
	#Given I am logged in to Rave with username "defuser" and password "password"
	Given xml draft "US18689.xml" is Uploaded with Environment name "Dev"

	Given Site "Site 1" with Site Group "Asia" exists
	Given Site "Site 2" with Site Group "Europe" exists
	Given Site "Site 3" with Site Group "World" exists
	Given Site "Site 4" with Site Group "North America" exists
	Given study "US18689" is assigned to Site "Site 1" with study environment "Aux: Dev"
	Given study "US18689" is assigned to Site "Site 2" with study environment "Aux: Dev"
	Given study "US18689" is assigned to Site "Site 3" with study environment "Aux: Dev"
	Given study "US18689" is assigned to Site "Site 4" with study environment "Aux: Dev"
	Given I publish and push eCRF "US18689.xml" to "Version 1" with study environment "Dev"
	Given following Project assignments exist
	| User         | Project    | Environment | Role         | Site   | SecurityRole          | 
	| SUPER USER 1 | US18689 | Aux: Dev    | SUPER ROLE 1 | Site 1 | Project Admin Default | 
	| SUPER USER 1 | US18689 | Aux: Dev    | SUPER ROLE 1 | Site 2 | Project Admin Default | 
	| SUPER USER 1 | US18689 | Aux: Dev    | SUPER ROLE 1 | Site 3 | Project Admin Default | 
	| SUPER USER 1 | US18689 | Aux: Dev    | SUPER ROLE 1 | Site 4 | Project Admin Default | 
	Given following Report assignments exist
	| User         | Report                                                           |
	| SUPER USER 1 | Targeted SDV Configuration - Targeted SDV Configuration          |
	| SUPER USER 1 | Targeted SDV Subject Management - Targeted SDV Subject Managemen |
	
	# Note: The setup used for the testing of this Feature File is not the only setup that will work with the Permuted Block randomization algorithm. The randomization algorithm will work for all Block and Tier combinations, or a block of n of n.

	# below should be commented out.
	#Given there is a project US18689
	#Given there is an environment Prod for project US18689
	#And there are four sites assigned to study US18689(Dev):
		# | Site Name  | Site Number      |
		# | Site 1     | 1001             |
		# | Site 2     | 2001             |
		# | Site 3     | 3001             |
		# | Site 4     | 4001             |
	#And site Site 1 is assigned to site group Asia
	#And site Site 2 is assigned to site group Europe
	#And site Site 3 is assigned to site group World
	#And site Site 4 is assigned to site group North America
	#And TSDV Study Plan has been setup for Study "US18689"
	# And TSDV Study Plan has block with tier(s)
	# | Block Name | Subject Count | IsRepeated | Tier Name         | Subject Count | Folder | Form                         | Field |
	# | Architect  | 6             | Yes        |                   |               |        |                              |       |
	# |            |               |            | All Forms         | 1             |        |                              |       |
	# |            |               |            | No Forms          | 2             |        |                              |       |
	# |            |               |            | Architect Defined | 3             |        |                              |       |
	#And TSDV Site Group Plan has been setup for Site Group "World"
	# And TSDV Site Group Plan has block with tier(s)
	# | Block Name | Subject Count | IsRepeated | Tier Name         | Subject Count | Folder | Form                         | Field |
	# | Architect  | 6             | Yes        |                   |               |        |                              |       |
	# |            |               |            | All Forms         | 1             |        |                              |       |
	# |            |               |            | No Forms          | 2             |        |                              |       |
	# |            |               |            | Architect Defined | 3             |        |                              |       |
	#And TSDV Site Plan has been setup for Site "Site 3"
	# And TSDV Site Plan has block with tier(s)
	# | Block Name | Subject Count | IsRepeated | Tier Name         | Subject Count | Folder | Form                         | Field |
	# | Architect  | 6             | Yes        |                   |               |        |                              |       |
	# |            |               |            | All Forms         | 1             |        |                              |       |
	# |            |               |            | No Forms          | 2             |        |                              |       |
	# |            |               |            | Architect Defined | 3             |        |                              |       |
	#And TSDV Site Plan has been setup for Site "Site 4"
	# And TSDV Site Plan has block with tier(s)
	# | Block Name | Subject Count | IsRepeated | Tier Name         | Subject Count | Folder | Form                         | Field |
	# | Architect  | 4             | Yes        |                   |               |        |                              |       |
	# |            |               |            | All Forms         | 1             |        |                              |       |
	# |            |               |            | No Forms          | 1             |        |                              |       |
	# |            |               |            | Architect Defined | 2             |        |                              |       |





@release_2012.1.0 
@PB_US18689_01
@Draft
Scenario: @PB_US18689_01 As a Rave user, when I select Permuted Block Randomization and I Enroll 50 subjects in study then subject assignment satisfies the specified ratio and is random for all blocks in study level.
	#When I select Study "US18689" and Site "Site 1"
	Given I login to Rave with user "SUPER USER 1"
	And I select link "Home"
	And I navigate to "Reporter"
	And I select Report "Targeted SDV Configuration"
	And I set report parameter "Study" with table
		| Name    | Environment |
		| US18689 | Dev         |
	And I click button "Submit Report"
	And I switch to "Targeted SDV Study Plan" window
	And I create a new block plan named "US18689 Block Plan" with Data entry Role "SUPER ROLE 1"
	And I verify text "Dynamic Allocation" exists
	And I click button "edit block plan"
	And I choose "Permuted Block" from "Randomization Type"
	And I click button "save block plan"
	And I delete the tier "Architect Defined" from plan
	And I edit Blocks 
	| Name              | Subject Count |
	| Architect Defined | 6             |            
	And I select the tier "Architect Defined" and Subject Count "1"
	And I select the tier "All Forms" and Subject Count "2"
	And I select the tier "No Forms" and Subject Count "3"
	And I activate the plan
	And I switch to "Reports" window
	And I select link "Home"
	And I create 12 random Subjects with name "KKP" in Study "US18689" in Site "Site 1"
	And I select link "Home"
	And I navigate to "Reporter"
	And I select Report "Targeted SDV Subject Management"
	And I set report parameter "Study" with table
		| Name        | Environment |
		| US18689 | Dev         |
	And I click button "Submit Report"
	And I switch to "Targeted SDV Subject Override" window

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
	And I select link "Home"
	And I navigate to "Reporter"
	And I select Report "Targeted SDV Configuration"
	And I set report parameter "Study" with table
		| Name        | Environment |
		| US18689 | Dev         |
	And I click button "Submit Report"
	And I switch to "Targeted SDV Study Plan" window
	And I inactivate the plan
	And I select link "World"
	And I create a new block plan named "World Block Plan" with Data entry Role "SUPER ROLE 1"
	And I verify text "Dynamic Allocation" exists
	And I click button "edit block plan"
	And I choose "Permuted Block" from "Randomization Type"
	And I click button "save block plan"
	And I delete the tier "Architect Defined" from plan
	And I edit Blocks 
	| Name              | Subject Count |
	| Architect Defined | 6            | 
	And I select the tier "Architect Defined" and Subject Count "1"
	And I select the tier "All Forms" and Subject Count "2"
	And I select the tier "No Forms" and Subject Count "3"
	And I activate the plan
	And I switch to "Reports" window
	And I select link "Home"
	And I create 6 random Subjects with name "BBC" in Study "US18689" in Site "Site 2"
	And I select link "Home"
	And I navigate to "Reporter"
	And I select Report "Targeted SDV Subject Management"
	And I set report parameter "Study" with table
		| Name       | Environment |
		| US18689 | Dev         |
	And I click button "Submit Report"
	And I switch to "Targeted SDV Subject Override" window
	And I filter by site group "World"

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
	And I select link "Home"
	And I navigate to "Reporter"
	And I select Report "Targeted SDV Configuration"
	And I set report parameter "Study" with table
		| Name       | Environment |
		| US18689 | Dev         |
	And I click button "Submit Report"
	And I switch to "Targeted SDV Study Plan" window
	And I select link "World"
	And I inactivate the plan
	And I select link "Site 3"
	And I create a new block plan named "Site 3 Block Plan" with Data entry Role "SUPER ROLE 1"
	And I verify text "Dynamic Allocation" exists
	And I click button "edit block plan"
	And I choose "Permuted Block" from "Randomization Type"
	And I click button "save block plan"
	And I delete the tier "Architect Defined" from plan
	And I edit Blocks 
	| Name              | Subject Count |
	| Architect Defined | 6            |
	And I select the tier "Architect Defined" and Subject Count "1"
	And I select the tier "All Forms" and Subject Count "2"
	And I select the tier "No Forms" and Subject Count "3"
	And I activate the plan
	And I switch to "Reports" window
	And I select link "Home"
	And I create 6 random Subjects with name "CCD" in Study "US18689" in Site "Site 3"
	And I select link "Home"
	And I navigate to "Reporter"
	And I select Report "Targeted SDV Subject Management"
	And I set report parameter "Study" with table
		| Name       | Environment |
		| US18689 | Dev         |
	And I click button "Submit Report"
	And I switch to "Targeted SDV Subject Override" window
	And I filter by site "Site 3"
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
	
	And I select link "Home"
	And I navigate to "Reporter"
	And I select Report "Targeted SDV Configuration"
	And I set report parameter "Study" with table
		| Name    | Environment |
		| US18689 | Dev         |
	And I click button "Submit Report"
	And I switch to "Targeted SDV Study Plan" window
	And I select link "World"
	And I select link "Site 3"
	And I inactivate the plan

	And I switch to "Reports" window
	And I select link "Home"
	And I navigate to "Reporter"
	And I select Report "Targeted SDV Configuration"
	And I set report parameter "Study" with table
		| Name    | Environment |
		| US18689 | Dev         |
	And I click button "Submit Report"
	And I switch to "Targeted SDV Study Plan" window
	And I select link "World"
	And I select link "Site 4"
	And I create a new block plan named "Site 4 Block Plan" with Data entry Role "SUPER ROLE 1"
	And I verify text "Dynamic Allocation" exists
	And I click button "edit block plan"
	And I choose "Permuted Block" from "Randomization Type"
	And I click button "save block plan"
	And I delete the tier "Architect Defined" from plan
	And I edit Blocks 
	| Name              | Subject Count |
	| Architect Defined | 4            |
	And I select the tier "Architect Defined" and Subject Count "1"
	And I select the tier "All Forms" and Subject Count "1"
	And I select the tier "No Forms" and Subject Count "2"
	And I activate the plan
	And I switch to "Reports" window
	And I select link "Home"
	And I create 6 random Subjects with name "KKI" in Study "US18689" in Site "Site 4"
	And I select link "Home"
	And I navigate to "Reporter"
	And I select Report "Targeted SDV Subject Management"
	And I set report parameter "Study" with table
		| Name       | Environment |
		| US18689 | Dev         |
	And I click button "Submit Report"
	And I filter by site "Site 4"
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

	And I select link "Home"
	And I navigate to "Reporter"
	And I select Report "Targeted SDV Configuration"
	And I set report parameter "Study" with table
		| Name    | Environment |
		| US18689 | Dev         |
	And I click button "Submit Report"
	And I switch to "Targeted SDV Study Plan" window
	And I select link "World"
	And I select link "Site 4"
	And I inactivate the plan