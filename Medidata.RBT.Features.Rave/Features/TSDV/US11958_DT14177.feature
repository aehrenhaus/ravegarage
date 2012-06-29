Feature: US11958_DT14177
	Change randomization algorithm to randomize initial set of subjects to the tiers in a block rather than sequentially assigning them.
Background:
	Given I am logged in to Rave with username "defuser" and password "password"
	#Given there is a project Mediflex
	#Given there is an environment Prod for project Mediflex
	#And there are three sites assigned to study Mediflex (Prod):
		# | Site Name  | Site Number       |
		# | Site 1     | 3001              |
		# | Site 2     | 3002              |
		# | Site 3     | 3003              |
 #And TSDV Plan has been setup for Study "Mediflex"
	# And TSDV Plan has block with tier(s)
	# | Block Name | Subject Count | IsRepeated | Tier Name         | Subject Count | Folder | Form                         | Field |
	# | Architect  | 10            | Yes        |                   |               |        |                              |       |
	# |            |               |            | All Forms         | 2             |        |                              |       |
	# |            |               |            | No Forms          | 2             |        |                              |       |
	# |            |               |            | Architect Defined | 2             |        |                              |       |
	# |            |               |            | Custom Tier 1     | 2             | [All]  | Assessment Date Log2         | [All] |
	# |            |               |            | Custom Tier 2     | 2             | [All]  | Informed Consent Date Form 1 | [All] |
	# |            |               |            | Custom Tier 3     | 2             | [All]  | Assessment Date Log2         | [All] |
	# |            |               |            | Custom Tier 4     | 2             | [All]  | Informed Consent Date Form 1 | [All] |
	# |            |               |            | Custom Tier 5     | 2             | [All]  | Assessment Date Log2         | [All] |
	# |            |               |            | Custom Tier 6     | 2             | [All]  | Informed Consent Date Form 1 | [All] |
	# |            |               |            | Custom Tier 7     | 2             | [All]  | Assessment Date Log2         | [All] |

	# And TSDV Plan has been activated for Study "Mediflex"


#----------------------------------------------------------------------------------------------------------------------------------------	 

@PB-US11958-01
Scenario: Enroll two subjects in each of three sites to verify at least one site has randomized the subjects in non sequential order.
	#When I create 10 random Subjects with name "TSDV" in Study "Edit Check Study 3" in Site "Edit Check Site 2"
	And I navigate to "Reporter"
	And I select Report "Targeted SDV Subject Management"
	And I set report parameter "Study" with table
		| Name               | Environment |
		| Edit Check Study 3 | Prod        |
	And I click button "Submit Report"
	And I switch to "Targeted SDV Subject Override" window
	And I choose "Edit Check Site 2: 20001" from "Select Site"
	And I click button "Search"
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