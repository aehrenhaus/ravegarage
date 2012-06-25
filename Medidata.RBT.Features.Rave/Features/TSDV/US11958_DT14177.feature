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
	When I create 1 random Subjects with name "TSDV" in Study "Edit Check Study 3" in Site "Edit Check Site 3"
	And I navigate to "Reporter"
	And I run Report "Targeted SDV Subject Management" on Study "Mediflex"
	And I choose "Site 1" from "Select Site"
	Then verify that Tiers in subject override table are not in the following order
		| Tier Name         |
		| All Forms         |
		| No Forms          |
		| Architect Defined |
		| Custom Tier 1     |
		| Custom Tier 2     |
		| Custom Tier 3     |
		| Custom Tier 4     |
		| Custom Tier 5     |
		| Custom Tier 6     |
		| Custom Tier 7     |