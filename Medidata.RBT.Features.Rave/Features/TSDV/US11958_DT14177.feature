Feature: US11958_DT14177
	Change randomization algorithm to randomize initial set of subjects to the tiers in a block rather than sequentially assigning them.
Background:
	Given I am logged in to Rave with username "defuser" and password "password"
	#Given there is a project Mediflex
	#Given there is an environment Prod for project Mediflex
	#And there are four sites assigned to study Mediflex (Prod):
		# | Site Name  | Site Number       |
		# | Site 1     | 3001              |
		# | Site 2     | 3002              |
		# | Site 3     | 3003              |
		# | Site 4     | 3004              |
	#And site Site 1 is assigned to site group Asia
	#And site Site 2 is assigned to site group Europ
	#And site Site 3 is assigned to site group World
	#And site Site 4 is assigned to site group North America
 #And TSDV Study Plan has been setup for Study "Mediflex"
	# And TSDV Study Plan has block with tier(s)
	# | Block Name | Subject Count | IsRepeated | Tier Name         | Subject Count | Folder | Form                         | Field |
	# | Architect  | 20            | Yes        |                   |               |        |                              |       |
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
 #And TSDV Site Group Plan has been setup for Site Group "World"
	# And TSDV Site Group Plan has block with tier(s)
	# | Block Name | Subject Count | IsRepeated | Tier Name         | Subject Count | Folder | Form                         | Field |
	# | Architect  | 20            | Yes        |                   |               |        |                              |       |
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
 #And TSDV Site Plan has been setup for Site "Site 1"
	# And TSDV Site Plan has block with tier(s)
	# | Block Name | Subject Count | IsRepeated | Tier Name         | Subject Count | Folder | Form                         | Field |
	# | Architect  | 20            | Yes        |                   |               |        |                              |       |
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
 #And TSDV Site Plan has been setup for Site "Site 3"
	# And TSDV Site Plan has block with tier(s)
	# | Block Name | Subject Count | IsRepeated | Tier Name         | Subject Count | Folder | Form                         | Field |
	# | Architect  | 20            | Yes        |                   |               |        |                              |       |
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
 #And TSDV Site Plan has been setup for Site "Site 4"
	# And TSDV Site Plan has block with tier(s)
	# | Block Name | Subject Count | IsRepeated | Tier Name         | Subject Count | Folder | Form                         | Field |
	# | Architect  | 20            | Yes        |                   |               |        |                              |       |
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

	
#----------------------------------------------------------------------------------------------------------------------------------------	 

@PB-US11958-01
Scenario: Enroll 10 subjects in a study to verify that TSDV has randomized the subjects in non sequential order when the subjects are included in TSDV using the Targeted SDV Subject Include report.
	#When I create 10 random Subjects with name "TSDV" in Study "Mediflex" in Site "Site 1"
	#And TSDV Site Plan has been activated for Site "Site 1"
	And I navigate to "Reporter"
	And I select Report "Targeted SDV Subject Management"
	And I set report parameter "Study" with table
		| Name               | Environment |
		| Mediflex			 | Prod        |
	And I click button "Submit Report"
	And I switch to "Targeted SDV Subject Include" window
	And I choose "Site 1: 3001" from "Select Site"
	And I click button "Search"
	And I include all subjects in TSDV
	And I navigate to "Reporter"
	And I select Report "Targeted SDV Subject Management"
	And I set report parameter "Study" with table
		| Name               | Environment |
		| Mediflex			 | Prod        |
	And I click button "Submit Report"
	And I switch to "Targeted SDV Subject Override" window
	And I choose "Site 1: 3001" from "Select Site"
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

#----------------------------------------------------------------------------------------------------------------------------------------	 

@PB-US11958-02
Scenario: Enroll 10 subjects in a study to verify that TSDV has randomized the subjects in non sequential order for the Study Plan.
	#When TSDV Study Plan has been activated for Study "Mediflex"
	#And I create 10 random Subjects with name "TSDV" in Study "Mediflex" in Site "Site 2"
	And I navigate to "Reporter"
	And I select Report "Targeted SDV Subject Management"
	And I set report parameter "Study" with table
		| Name               | Environment |
		| Mediflex			 | Prod        |
	And I click button "Submit Report"
	And I switch to "Targeted SDV Subject Override" window
	And I choose "Site 2: 3002" from "Select Site"
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

#----------------------------------------------------------------------------------------------------------------------------------------	 

@PB-US11958-03
Scenario: Enroll 10 subjects in a study to verify that TSDV has randomized the subjects in non sequential order for the Site Group Plan.
	#When TSDV Site Group Plan has been activated for Site Group "World"
	#And I create 10 random Subjects with name "TSDV" in Study "Mediflex" in Site "Site 3"
	And I navigate to "Reporter"
	And I select Report "Targeted SDV Subject Management"
	And I set report parameter "Study" with table
		| Name               | Environment |
		| Mediflex			 | Prod        |
	And I click button "Submit Report"
	And I switch to "Targeted SDV Subject Override" window
	And I choose "Site 3: 3003" from "Select Site"
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

#----------------------------------------------------------------------------------------------------------------------------------------	 

@PB-US11958-04
Scenario: Enroll 10 subjects in a study to verify that TSDV has randomized the subjects in non sequential order for the Site Plan.
	#When TSDV Site Plan has been activated for Site "Site 4"
	#And I create 10 random Subjects with name "TSDV" in Study "Mediflex" in Site "Site 4"
	And I navigate to "Reporter"
	And I select Report "Targeted SDV Subject Management"
	And I set report parameter "Study" with table
		| Name               | Environment |
		| Mediflex			 | Prod        |
	And I click button "Submit Report"
	And I switch to "Targeted SDV Subject Override" window
	And I choose "Site 4: 3004" from "Select Site"
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