# When an analyte range is manually created, the audit information should be captured in the database.

Feature: US17701_DT13437
	Audit information for manually create analyte ranges is captured in the database.
	As a Rave user
	When I manually create an analyte range
	Then the audit information for the analyte I created is captured in the database

Background:
	Given I am logged in to Rave with username "defuser" and password "password"
	#And the following Project assignments exist
	#	| User    | Project    | Environment | Role | Site         | Site Number | Lab Type  | Lab Name      | Description   | Range Type |
	#	| defuser | Jennicilin | Prod        | cdm1 | ABC Hospital | 12333       | Local Lab | ABC Local Lab | ABC Local Lab | Standard   |
	#And Role "cdm1" has Action "Entry"
	#And User "defuser" has Module "Site Administration, Lab Administrator"
	#And Project "Jennicilin" has Draft "Draft 1"
	#And I publish and push CRF Version "CRF Version<RANDOMNUMBER>" of Draft "Draft 1" to site "ABC Hospital" in Project "Jennicilin" for Enviroment "Prod"

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
	#	| Local Lab     | ABC Local Lab     | ABC Local Lab     | Standard   |
	#	| Central Lab   | ABC Central Lab   | ABC Central Lab   | Standard   |
	#	| Alert Lab     | ABC Alert Lab     | ABC Alert Lab     | Standard   |
	#	| Reference Lab | ABC Reference Lab | ABC Reference Lab | Standard   |

	#And the following Lab Settings Exists 
		#| Standard Units	| Reference Labs	| Alert Labs    |
		#| US				| ReferenceLab_1	|AlertLab_1		|

	#And the following Analyte Ranges Exsits
		#| Analyte     | From Date   | To Date     | Low Value | High Value | Units  | Dictionary | Comments |
		#| Neutrophils | 01 Jan 2000 | 01 Jan 2020 | 10        | 20         | 10^9/L | ...        |          |
		#| WBC         | 01 Jan 2000 | 01 Jan 2020 | 10        | 20         | 10^9/L | ...        |          |

#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_2012.1.0
@PB_US17701_01
@Draft
Scenario: PB_US17701_01 As a Lab Administrator, when manually create an analyte range for an Local Lab, then the audit information for the analyte I created is captured in the database.

	And I navigate to "Site Administration" module
	And I search for site "Site 10991"
	And I select Site Details for Site "Site 10991"
	And I select "Lab Maintenance" for Study "Mediflex" in Environment "Prod"
	And I select Ranges for "ABC Local Lab" for "Local Lab" lab
	And I select "Add New Range"
	And I create range
		| Analyte       | From Date   | To Date     | From Age          | To Age            | Sex            | Low Value | High Value | Units              | Dictionary | Comments | Edit | New Version |
		| WBCREG_ECPV11 | 01 Jan 2000 | 01 Jan 2020 | 15 YearREG_ECPV11 | 99 YearREG_ECPV11 | maleREG_ECPV11 | 2         | 4          | *10E6/ulREG_ECPV11 |            |          |      |             |
	And I take a screenshot
	And I verify analyterange audits exist
		| Lab           | Analyte       | AuditName | ObjectName   |
		| ABC Local Lab | WBCREG_ECPV11 | Created   | AnalyteRange |
	
#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_2012.1.0
@PB_US17701_02
@Draft
Scenario: PB_US17701_02 As a Lab Administrator, when manually create an analyte range for an Central Lab, then the audit information for the analyte I created is captured in the database.

	And I navigate to "Lab Administration" module
	And I navigate to "Central Labs" module
	And I select Ranges for "ABC Central Lab" for "Central Lab" lab
	And I select "Add New Range"
	And I create range
		| Analyte       | From Date   | To Date     | From Age          | To Age            | Sex            | Low Value | High Value | Units              | Dictionary | Comments | Edit | New Version |
		| WBCREG_ECPV11 | 01 Jan 2000 | 01 Jan 2020 | 15 YearREG_ECPV11 | 99 YearREG_ECPV11 | maleREG_ECPV11 | 2         | 4          | *10E6/ulREG_ECPV11 |            |          |      |             |
	And I take a screenshot
	And I take a screenshot
	And I verify analyterange audits exist
		| Lab             | Analyte       | AuditName | ObjectName   |
		| ABC Central Lab | WBCREG_ECPV11 | Created   | AnalyteRange |

#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_2012.1.0
@PB_US17701_03
@Draft
Scenario: PB_US17701_03 As a Lab Administrator, when manually create an analyte range for an Alert Lab, then the audit information for the analyte I created is captured in the database.

	And I navigate to "Lab Administration" module
	And I navigate to "Global Labs" module
	And I select Ranges for "ABC Alert Lab" for "Alert Lab" lab
	And I select "Add New Range"
	And I create range
		| Analyte       | From Date   | To Date     | From Age          | To Age            | Sex            | Low Value | High Value | Units              | Dictionary | Comments | Edit | New Version |
		| WBCREG_ECPV11 | 01 Jan 2000 | 01 Jan 2020 | 15 YearREG_ECPV11 | 99 YearREG_ECPV11 | maleREG_ECPV11 | 2         | 4          | *10E6/ulREG_ECPV11 |            |          |      |             |
	And I take a screenshot
	And I verify analyterange audits exist
		| Lab           | Analyte       | AuditName | ObjectName   |
		| ABC Alert Lab | WBCREG_ECPV11 | Created   | AnalyteRange |

#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_2012.1.0
@PB_US17701_04
@Draft
Scenario: PB_US17701_04 As a Lab Administrator, when manually create an analyte range for an Reference Lab, then the audit information for the analyte I created is captured in the database.

	And I navigate to "Lab Administration" module
	And I navigate to "Global Labs" module
	And I select Ranges for "ABC Reference Lab" for "Reference Lab" lab
	And I select "Add New Range"
	And I create range
		| Analyte       | From Date   | To Date     | From Age          | To Age            | Sex            | Low Value | High Value | Units              | Dictionary | Comments | Edit | New Version |
		| WBCREG_ECPV11 | 01 Jan 2000 | 01 Jan 2020 | 15 YearREG_ECPV11 | 99 YearREG_ECPV11 | maleREG_ECPV11 | 2         | 4          | *10E6/ulREG_ECPV11 |            |          |      |             |
	And I take a screenshot
	And I verify analyterange audits exist
		| Lab               | Analyte       | AuditName | ObjectName   |
		| ABC Reference Lab | WBCREG_ECPV11 | Created   | AnalyteRange |


#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_2012.1.0
@PB_US17701_05
@Draft
Scenario: PB_US17701_05 As a Lab Administrator, when manually create an analyte range for a Local Lab in EDC, then the audit information for the analyte I created is captured in the database.
		
	And I select Study "Mediflex" and Site "ABC Hospital"
	And I select link "Labs"
	And I select Ranges for "ABC Local Lab" for "Local Lab" lab
	And I select "Add New Range"
	And I create range
		| Analyte       | From Date   | To Date     | From Age          | To Age            | Sex            | Low Value | High Value | Units              | Dictionary | Comments | Edit | New Version |
		| WBCREG_ECPV11 | 01 Jan 2000 | 01 Jan 2020 | 15 YearREG_ECPV11 | 99 YearREG_ECPV11 | maleREG_ECPV11 | 2         | 4          | *10E6/ulREG_ECPV11 |            |          |      |             |
	And I take a screenshot
	And I verify analyterange audits exist
		| Lab           | Analyte       | AuditName | ObjectName   |
		| ABC Local Lab | WBCREG_ECPV11 | Created   | AnalyteRange |

#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_2012.1.0
@PB_US17701_06
@Draft
Scenario: PB_US17701_06 As a Lab Administrator, when manually copy analyte range for an Alert Lab, then the audit information for the analyte I copied is captured in the database.

	And I navigate to "Lab Administration" module
	And I navigate to "Global Labs" module
	And I create lab
		| Type      | Name                            | Range Type     |
		| Alert Lab | ABC Alert Lab {RndNum<num1>(3)} | StandardREGAQT |
	And I select Ranges for "ABC Alert Lab {Var(num1)}" for "Alert Lab" lab
	And I select "Copy Ranges" form "Alert Lab"
	And I take a screenshot
	And I verify analyterange audits exist
		| Lab                       | Analyte   | AuditName | ObjectName   |
		| ABC Alert Lab {Var(num1)} | WBCREGAQT | Review    | AnalyteRange |

#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_2012.1.0
@PB_US17701_07
@Draft
Scenario: PB_US17701_07 As a Lab Administrator, when manually create an analyte range from New Version for an Alert Lab, then the audit information for the analyte I created is captured in the database.

	And I navigate to "Lab Administration" module
	And I navigate to "Global Labs" module
	And I create lab
		| Type      | Name                            | Range Type     |
		| Alert Lab | ABC Alert Lab {RndNum<num1>(3)} | StandardREGAQT |
	And I select Ranges for "ABC Alert Lab {Var(num1)}" for "Alert Lab" lab
	And I select "Add New Range"
	And I create range
		| Analyte       | From Date   | To Date     | From Age      | To Age        | Sex        | Low Value | High Value | Units              | Dictionary | Comments | Edit | New Version |
		| WBCREG_ECPV11 | 01 Jan 2000 | 01 Jan 2020 | 15 YearREGAQT | 50 YearREGAQT | maleREGAQT | 2         | 4          | *10E6/ulREG_ECPV11 |            |          |      |             |
	And I take a screenshot
	And I verify analyterange audits exist
		| Lab               | Analyte       | AuditName | ObjectName   |
		| ABC Reference Lab | WBCREG_ECPV11 | Created   | AnalyteRange |
	And I select "New Version" for "WBCREG_ECPV11" lab
	And I create range
		| Analyte       | From Date   | To Date     | From Age      | To Age        | Sex        | Low Value | High Value | Units              | Dictionary | Comments | Edit | New Version |
		| WBCREG_ECPV11 | 01 Jan 2040 | 01 Jan 2060 | 25 YearREGAQT | 75 YearREGAQT | maleREGAQT | 3         | 8          | *10E6/ulREG_ECPV11 |            |          |      |             |
	And I take a screenshot
	And I verify analyterange audits exist
		| Lab               | Analyte       | AuditName | ObjectName   |
		| ABC Reference Lab | WBCREG_ECPV11 | Created   | AnalyteRange |
