Feature: US11958_DT14177
	Change randomization algorithm to randomize initial set of subjects to the tiers in a block rather than sequentially assigning them.
Background:
	Given I am logged in to Rave with username "defuser" and password "password"
	#Given there is a project Edit Check Study 3
	#Given there is an environment Prod for project Edit Check Study 3
	#And there are four sites assigned to study Edit Check Study 3 (Prod):
		# | Site Name  | Site Number       |
		# | Edit Check Site 1     | 10001              |Site 
		# | Edit Check Site 2     | 20001              |
		# | Edit Check Site 3     | 30001              |
		# | Edit Check Site 4     | 40001              |
	#And site Edit Check Site 1 is assigned to site group Asia
	#And site Edit Check Site 2 is assigned to site group Europe
	#And site Edit Check Site 3 is assigned to site group World
	#And site Edit Check Site 4 is assigned to site group North America
 #And TSDV Study Plan has been setup for Study "Edit Check Study 3"
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
 #And TSDV Site Plan has been setup for Site "Edit Check Site 1"
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
 #And TSDV Site Plan has been setup for Site "Edit Check Site 3"
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
 #And TSDV Site Plan has been setup for Site "Edit Check Site 4"
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
	
	#When I create 10 random Subjects with name "TSDV" in Study "Edit Check Study 3" in Site "Edit Check Site 1"
	When  I navigate to "Reporter"
	And I select Report "Targeted SDV Configuration"
	And I set report parameter "Study" with table
		| Name               | Environment |
		| Edit Check Study 3 | Prod        |
	And I click button "Submit Report"
	And I switch to "Targeted SDV Study Plan" window
	And I select "Asia"
	And I select "Edit Check Site 1"
	And I select "Activate"
	And I accept alert window
#	And I activate TSDV Site Plan has been activated for Site "Edit Check Site 1"
	And I switch to "Reports" window
	And I select "My Reports"
	And I select Report "Targeted SDV Subject Management"
	And I set report parameter "Study" with table
		| Name               | Environment |
		| Edit Check Study 3			 | Prod        |
	And I click button "Submit Report"
	And I switch to "Targeted SDV Subject Include" window
	And I choose "Edit Check Site 1: 10001" from "Select Site"
	And I select "Search"
	And I include all subjects in TSDV
	And I select "Subject Override"
	And I choose "Edit Check Site 1: 10001" from "Select Site"
	And I select "Search"
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
	#When TSDV Study Plan has been activated for Study "Edit Check Study 3"
	When I navigate to "Reporter"
	And I select Report "Targeted SDV Configuration"
	And I set report parameter "Study" with table
		| Name               | Environment |
		| Edit Check Study 3			 | Prod        |
	And I click button "Submit Report"
	And I switch to "Targeted SDV Study Plan" window
	And I create 10 random Subjects with name "TSDV" in Study "Edit Check Study 3" in Site "Edit Check Site 2"
	And I navigate to "Reporter"
	And I select Report "Targeted SDV Subject Management"
	And I set report parameter "Study" with table
		| Name               | Environment |
		| Edit Check Study 3			 | Prod        |
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

#----------------------------------------------------------------------------------------------------------------------------------------	 

@PB-US11958-03
Scenario: Enroll 10 subjects in a study to verify that TSDV has randomized the subjects in non sequential order for the Site Group Plan.
	#When TSDV Site Group Plan has been activated for Site Group "World"
	And I create 10 random Subjects with name "TSDV" in Study "Edit Check Study 3" in Site "Edit Check Site 3"
	And I navigate to "Reporter"
	And I select Report "Targeted SDV Subject Management"
	And I set report parameter "Study" with table
		| Name               | Environment |
		| Edit Check Study 3			 | Prod        |
	And I click button "Submit Report"
	And I switch to "Targeted SDV Subject Override" window
	And I choose "Edit Check Site 3: 30001" from "Select Site"
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
	#When TSDV Site Plan has been activated for Site "Edit Check Site 4"
	#And I create 10 random Subjects with name "TSDV" in Study "Edit Check Study 3" in Site "Edit Check Site 4"
	And I navigate to "Reporter"
	And I select Report "Targeted SDV Subject Management"
	And I set report parameter "Study" with table
		| Name               | Environment |
		| Edit Check Study 3			 | Prod        |
	And I click button "Submit Report"
	And I switch to "Targeted SDV Subject Override" window
	And I choose "Edit Check Site 4: 40001" from "Select Site"
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