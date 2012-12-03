# When an analyte range is manually created, the audit information should be captured in the database.
@ignore
Feature: US17701_DT13437 When an analyte range is manually created, the audit information should be captured in the database.
	Audit information for manually create analyte ranges is captured in the database.
	As a Rave user
	When I manually create an analyte range
	Then the audit information for the analyte I created is captured in the database
 
Background:
	Given I login to Rave with user "defuser" and password "password"
	#And the following Project assignments exist
	#	| User    | Project  | Environment | Role | Site			| Site Number | Lab Type  | Lab Name		| Description   | Range Type |
	#	| defuser | Mediflex | Prod        | cdm1 |  Site 10991		| 10991       | Local Lab |  Local Lab		|  Local Lab	| Standard   |
	#And Role "cdm1" has Action "Entry"
	#And User "defuser" has Module "Site Administration, Lab Administrator"
	#And Project "Mediflex" has Draft "Draft 1"
	#And I publish and push CRF Version "CRF Version<RANDOMNUMBER>" of Draft "Draft 1" to site " Hospital" in Project "Mediflex" for Enviroment "Prod"

	# And the following Lab Unit Dictionary exists
	#	 | Name        | Units    |
	#	 | WBC         | *10E6/ul |
	#	 | WBC         | Fraction |
	#	 | Neutrophils | *10E6/ul |
	#	 | Neutrophils | Fraction |

	# And the following Analytes exists
		# | Analytes    | Lab Unit Dictionary	|
		# | WBC         | WBC					|
		# | Neutrophils | Neutrophils			|

	# And the following Standard Group Exists with Entries and their related Analytes and Units
		# | Standard Group	| Analyte           | Units				|
		# | US				| Neutrophils		| Fraction			|
		# | US				| WBC				| *10E6/ul			|

	#And the following Range Types Exists
		#| Range Type   |
		#| Standard		|

	#And the following labs exists
	#	| Lab Type      | Lab Name          | Description       | Range Type |
	#	| Local Lab     |  Local Lab		|  Local Lab		| Standard   |
	#	| Central Lab   |  Central Lab		|  Central Lab		| Standard   |
	#	| Alert Lab     |  Alert Lab		|  Alert Lab		| Standard   |
	#	| Reference Lab |  Reference Lab	|  Reference Lab	| Standard   |

	#And the following Lab Settings Exists 
		#| Standard Units	| Reference Labs	| Alert Labs    |
		#| US				| ReferenceLab_1	|AlertLab_1		|

	#And the following Analyte Ranges Exsits
		#| Analyte     | From Date   | To Date     | Low Value | High Value | Units  | Dictionary | Comments |
		#| Neutrophils | 01 Jan 2000 | 01 Jan 2020 | 10        | 20         | 10^9/L | ...        |          |
		#| WBC         | 01 Jan 2000 | 01 Jan 2020 | 10        | 20         | 10^9/L | ...        |          |

#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_2012.1.0
@PB_US17701_DT13437_01
@Validation
Scenario: PB_US17701_01 As a Lab Administrator, when manually create an analyte range for an Local Lab, then the audit information for the analyte I created is captured in the database.

	And I navigate to "Site Administration" module
	And I search for site "Site 10991"
	And I select Site Details for Site "Site 10991"
	And I select "Lab Maintenance" for Study "Mediflex" in Environment "Prod"
	And I create lab
		| Type      | Name                        | Range Type          |
		| Local Lab | Local Lab {RndNum<num1>(5)} | StandardREG_US17701 |
	And I select Ranges for "Local Lab {Var(num1)}" for "Local Lab" lab
	And I select "Add New Range"
	And I create range
		| Analyte        | From Date   | To Date     | From Age           | To Age             | Sex             | Low Value | High Value | Units               | Dictionary | Comments | Edit | New Version |
		| WBCREG_US17701 | 01 Jan 2000 | 01 Jan 2020 | 15 YearREG_US17701 | 99 YearREG_US17701 | maleREG_US17701 | 2         | 4          | *10E6/ulREG_US17701 |            |          |      |             |
	And I take a screenshot
	And I verify analyterange audits exist
		| Lab                   | Analyte        | AuditName | ObjectName   |
		| Local Lab {Var(num1)} | WBCREG_US17701 | Created   | AnalyteRange |
	
#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_2012.1.0
@PB_US17701_DT13437_02
@Validation
Scenario: PB_US17701_DT13437_02 As a Lab Administrator, when manually create an analyte range for an Central Lab, then the audit information for the analyte I created is captured in the database.

	And I navigate to "Lab Administration" module
	And I navigate to "Central Labs" module
	And I select Ranges for "Central Lab" for "Central Lab" lab
	And I select "Add New Range"
	And I create range
		| Analyte        | From Date   | To Date     | From Age           | To Age             | Sex             | Low Value | High Value | Units               | Dictionary | Comments | Edit | New Version |
		| WBCREG_US17701 | 01 Jan 2000 | 01 Jan 2020 | 15 YearREG_US17701 | 99 YearREG_US17701 | maleREG_US17701 | 2         | 9          | *10E6/ulREG_US17701 |            |          |      |             |
	And I take a screenshot
	And I verify analyterange audits exist
		| Lab         | Analyte        | AuditName | ObjectName   |
		| Central Lab | WBCREG_US17701 | Created   | AnalyteRange |

#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_2012.1.0
@PB_US17701_DT13437_03
@Validation
Scenario: PB_US17701_DT13437_03 As a Lab Administrator, when manually create an analyte range for an Alert Lab, then the audit information for the analyte I created is captured in the database.

	And I navigate to "Lab Administration" module
	And I navigate to "Global Labs" module
	And I create lab
		| Type      | Name                        | Range Type          |
		| Alert Lab | Alert Lab {RndNum<num1>(5)} | StandardREG_US17701 |
	And I select Ranges for "Alert Lab {Var(num1)}" for "Alert Lab" lab
	And I select "Add New Range"
	And I create range
		| Analyte        | From Date   | To Date     | From Age           | To Age             | Sex             | Low Value | High Value | Units               | Dictionary | Comments | Edit | New Version |
		| WBCREG_US17701 | 01 Jan 2000 | 01 Jan 2020 | 15 YearREG_US17701 | 99 YearREG_US17701 | maleREG_US17701 | 2         | 4          | *10E6/ulREG_US17701 |            |          |      |             |
	And I take a screenshot
	And I verify analyterange audits exist
		| Lab                   | Analyte        | AuditName | ObjectName   |
		| Alert Lab {Var(num1)} | WBCREG_US17701 | Created   | AnalyteRange |

#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_2012.1.0
@PB_US17701_DT13437_04
@Validation
Scenario: PB_US17701_DT13437_04 As a Lab Administrator, when manually create an analyte range for an Reference Lab, then the audit information for the analyte I created is captured in the database.

	And I navigate to "Lab Administration" module
	And I navigate to "Global Labs" module
	And I create lab
		| Type          | Name                            | Range Type          |
		| Reference Lab | Reference Lab {RndNum<num1>(5)} | StandardREG_US17701 |
	And I select Ranges for "Reference Lab {Var(num1)}" for "Reference Lab" lab
	And I select "Add New Range"
	And I create range
		| Analyte        | From Date   | To Date     | From Age           | To Age             | Sex             | Low Value | High Value | Units               | Dictionary | Comments | Edit | New Version |
		| WBCREG_US17701 | 01 Jan 2000 | 01 Jan 2020 | 15 YearREG_US17701 | 99 YearREG_US17701 | maleREG_US17701 | 2         | 4          | *10E6/ulREG_US17701 |            |          |      |             |
	And I take a screenshot
	And I verify analyterange audits exist
		| Lab                       | Analyte        | AuditName | ObjectName   |
		| Reference Lab {Var(num1)} | WBCREG_US17701 | Created   | AnalyteRange |


#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_2012.1.0
@PB_US17701_DT13437_05
@Validation
Scenario: PB_US17701_DT13437_05 As a Lab Administrator, when manually create an analyte range for a Local Lab in EDC, then the audit information for the analyte I created is captured in the database.
		
	And I select Study "Mediflex" and Site "Site 10991"
	And I select link "Labs"
	And I create lab
		| Type      | Name                        | Range Type          |
		| Local Lab | Local Lab {RndNum<num1>(5)} | StandardREG_US17701 |
	And I select Ranges for "Local Lab {Var(num1)}" for "Local Lab" lab
	And I select "Add New Range"
	And I create range
		| Analyte        | From Date   | To Date     | From Age           | To Age             | Sex             | Low Value | High Value | Units               | Dictionary | Comments | Edit | New Version |
		| WBCREG_US17701 | 01 Jan 2000 | 01 Jan 2020 | 15 YearREG_US17701 | 99 YearREG_US17701 | maleREG_US17701 | 2         | 4          | *10E6/ulREG_US17701 |            |          |      |             |
	And I take a screenshot
	And I verify analyterange audits exist
		| Lab                   | Analyte        | AuditName | ObjectName   |
		| Local Lab {Var(num1)} | WBCREG_US17701 | Created   | AnalyteRange |

#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_2012.1.0
@PB_US17701_DT13437_06
@Validation
Scenario: PB_US17701_DT13437_06 As a Lab Administrator, when manually copy analyte range for an Alert Lab, then the audit information for the analyte I copied is captured in the database.

	And I navigate to "Lab Administration" module
	And I navigate to "Global Labs" module
	And I create lab
		| Type      | Name                        | Range Type          |
		| Alert Lab | Alert Lab {RndNum<num1>(5)} | StandardREG_US17701 |
	And I select Ranges for "Alert Lab {Var(num1)}" for "Alert Lab" lab
	And I select "Copy Ranges" form "Alert Lab"
	And I take a screenshot
	And I verify analyterange audits exist
		| Lab                   | Analyte        | AuditName | ObjectName   |
		| Alert Lab {Var(num1)} | WBCREG_US17701 | Review    | AnalyteRange |

#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_2012.1.0
@PB_US17701_DT13437_07
@Validation
Scenario: PB_US17701_DT13437_07 As a Lab Administrator, when manually create an analyte range from New Version for an Alert Lab, then the audit information for the analyte I created is captured in the database.

	And I navigate to "Lab Administration" module
	And I navigate to "Global Labs" module
	And I create lab
		| Type      | Name                        | Range Type          |
		| Alert Lab | Alert Lab {RndNum<num1>(5)} | StandardREG_US17701 |
	And I select Ranges for "Alert Lab {Var(num1)}" for "Alert Lab" lab
	And I select "Add New Range"
	And I create range
		| Analyte        | From Date   | To Date     | From Age           | To Age             | Sex             | Low Value | High Value | Units               | Dictionary | Comments | Edit | New Version |
		| WBCREG_US17701 | 01 Jan 2000 | 01 Jan 2020 | 15 YearREG_US17701 | 50 YearREG_US17701 | maleREG_US17701 | 2         | 4          | *10E6/ulREG_US17701 |            |          |      |             |
	And I take a screenshot
	And I verify analyterange audits exist
		| Lab                   | Analyte        | AuditName | ObjectName   |
		| Alert Lab {Var(num1)} | WBCREG_US17701 | Created   | AnalyteRange |
	And I select "New Version" for "WBCREG_US17701" lab
	And I create range
		| Analyte        | From Date   | To Date     | From Age           | To Age             | Sex             | Low Value | High Value | Units               | Dictionary | Comments | Edit | New Version |
		| WBCREG_US17701 | 01 Jan 2040 | 01 Jan 2060 | 25 YearREG_US17701 | 75 YearREG_US17701 | maleREG_US17701 | 3         | 8          | *10E6/ulREG_US17701 |            |          |      |             |
	And I take a screenshot
	And I verify analyterange audits exist
		| Lab                   | Analyte        | AuditName | ObjectName   |
		| Alert Lab {Var(num1)} | WBCREG_US17701 | Created   | AnalyteRange |

#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_2012.1.0
@PB_US17701_DT13437_08
@Validation
Scenario: PB_US17701_DT13437_08 As a Lab Administrator, when manually create an analyte range from New Version for an Reference Lab, then the audit information for the analyte I created is captured in the database.

	And I navigate to "Lab Administration" module
	And I navigate to "Global Labs" module
	And I create lab
		| Type          | Name                            | Range Type          |
		| Reference Lab | Reference Lab {RndNum<num1>(5)} | StandardREG_US17701 |
	And I select Ranges for "Reference Lab {Var(num1)}" for "Reference Lab" lab
	And I select "Add New Range"
	And I create range
		| Analyte        | From Date   | To Date     | From Age           | To Age             | Sex             | Low Value | High Value | Units               | Dictionary | Comments | Edit | New Version |
		| WBCREG_US17701 | 01 Jan 2000 | 01 Jan 2020 | 15 YearREG_US17701 | 50 YearREG_US17701 | maleREG_US17701 | 2         | 4          | *10E6/ulREG_US17701 |            |          |      |             |
	And I take a screenshot
	And I verify analyterange audits exist
		| Lab                       | Analyte        | AuditName | ObjectName   |
		| Reference Lab {Var(num1)} | WBCREG_US17701 | Created   | AnalyteRange |
	And I select "New Version" for "WBCREG_US17701" lab
	And I create range
		| Analyte        | From Date   | To Date     | From Age           | To Age             | Sex             | Low Value | High Value | Units               | Dictionary | Comments | Edit | New Version |
		| WBCREG_US17701 | 01 Jan 2040 | 01 Jan 2060 | 25 YearREG_US17701 | 75 YearREG_US17701 | maleREG_US17701 | 3         | 8          | *10E6/ulREG_US17701 |            |          |      |             |
	And I take a screenshot
	And I verify analyterange audits exist
		| Lab                       | Analyte        | AuditName | ObjectName   |
		| Reference Lab {Var(num1)} | WBCREG_US17701 | Created   | AnalyteRange |