#Note: This DT5899/14019 can be tested only through manual verification
# When a blank PDF form is generated based on a log form populated with default values, the PDF file should not include page breaks between each of the 
# default values.
@ignore
@FT_DT5899_DT14019
Feature: US15841_US17279_US17414_DT5899_DT14019 Blank PDF files that are generated for log forms with default values should not include page breaks between records
	#As a Rave User with access to PDF generator and a study with a log form with default values
	#I want to generate a blank PDF for the log form with default value that is a continuous list of all records instead of multiple pages
	#so that I can minimize the number of pages generated in the PDF
	
#Background:
	#Given user "defuser"  has study "PDF Default Study"
	#And study "PDF Default Study" has draft "Draft 1"
	#And draft "Draft 1" has form "Medical History"
	#And draft "Draft 1" has form "Demographics"
	#And form "Demographics" has log direction "Portrait"
	#And form "Demographics" has varOID "<VarOID>" has format "<Format>" has data dictionary "<Dictionary>" has Unit dictionary "<Unit Dictionary>" has field name "<Field Name>" has field OID "<Field OID>" has status "<Active>" has visible status "<Is Visible Field>" has log data entry "<Log Data Entry>" has field label "<Field Label>" has control type "<Control Type>" has value "<Default Value>" has field help text "<Field Help Text>"
	    #|VarOID		  |Format	   |Dictionary      |Unit Dictionary	|Field Name		    |Field OID		   |Active		|Is Visible Field 	|Log Data Entry	|Field Label                       |Control Type    |Default Value                      |Field Help Text	|
		#|BIRTHDT 	      |dd MMM yyyy |                |					|BIRTHDT		    |BIRTHDT		   |true		|true				|               |Date of Birth:                    |DateTime    	|				                    |					|
		#|GENDER1	      |$1          |Gender          | 				    |GENDER1		    |GENDER1		   |true		|true				|               |Gender                            |RadioButton	    |		                            |                   |
		#|WHITEBLOODCELLS |3		   |                | 				    |WHITEBLOODCELLS	|WHITEBLOODCELLS   |true		|true				|true			|WhiteBloodCells                   |Text			|                                   |                   |
		#|REDBLOODCELLS	  |3           |                | 				    |REDBLOODCELLS	    |REDBLOODCELLS	   |true		|true				|true			|RedBloodCells                     |Text			|							        |                   |
		#|BLOODWORK	      |1 		   |Normal Abnormal | 				    |BLOODWORK	        |BLOODWORK	       |true		|true				|true			|BloodWork                         |Dropdown    	|                                   |					|	
		#|CHLDBEAR	      |1 		   |Normal Abnormal | 				    |CHLDBEAR	        |CHLDBEAR	       |true		|true				|true			|Child bearing potential           |Dropdown    	|                                   |					|	
		#|RACE	          |$1		   |Race            | 				    |RACE	            |RACE	           |true		|true				|true			|Ethnicity                         |Dropdown    	|                                   |					|	
		#|BODYSYS_INDIC	  |$1 		   |Body System     | 				    |BODYSYS_INDIC	    |BODYSYS_INDIC	   |true		|true				|true			|Body System Indication            |Dropdown    	|H|C|R|G|T|S|E|P|M|L|N|I|U|D|B|O|   |					|	
		#|SPECIFY	      |$200 	   |                | 				    |SPECIFY	        |SPECIFY	       |true		|true				|true			|Specify race                      |LongText		|                                   |					|		
	#And form "Medical History" has log direction "Landscape"
	#And form "Medical History" has varOID "<VarOID>" has format "<Format>" has data dictionary "<Dictionary>" has Unit dictionary "<Unit Dictionary>" has field name "<Field Name>" has field OID "<Field OID>" has status "<Active>" has visible status "<Is Visible Field>" has log data entry "<Log Data Entry>" has field label "<Field Label>" has control type "<Control Type>" has value "<Default Value>" has field help text "<Field Help Text>"
	    #|VarOID		|Format		   |Dictionary	    |Unit Dictionary	|Field Name		|Field OID		|Active		|Is Visible Field 	|Log Data Entry	|Field Label        |Control Type           |Default Value                       |Field Help Text	|
		#|VISITDT	    |dd MMM yyyy   |                |					|VISITDT		|VISITDT		|true		|true				|			    |Visit Date:       	|DateTime    			|				                     |					|
		#|GENDER	    |$1            |Gender          | 				    |GENDER		    |GENDER		    |true		|true				|			    |Gender             |RadioButton			|							         |                  |
		#|BODYSYS	    |$1		       |Body System     | 				    |BODYSYS		|BODYSYS		|true		|true				|true			|Body System:       |Dropdown    			|H|C|R|G|T|S|E|P|M|L|N|I|U|D|B|O|    |					|
		#|NORMALABNORMAL|$1            |Normal Abnormal | 				    |NORMALABNORMAL	|NORMALABNORMAL	|true		|true				|true			|Result:            |Dropdown    			|							         |                  |
		#|DESC	        |$200 		   |                | 				    |DESC           |DESC	        |true		|true				|true			|Description:       |LongText			    |                                    |					|	
	#And data dictionary "Body System" has entries
		#|User Data String	    |Specify	|Coded Data	|
		#|HEENT			        |			|H		    |
		#|Cardiovascular		|			|C		    |	
		#|Respiratory			|			|R		    |
		#|Gastrointestinal 		|			|G		    |
		#|Genitourinary		    |			|T		    |
		#|Skin			        |			|S		    |
		#|Endocrine/Metabolic   |			|E		    |
		#|Hepatic			    |			|P		    |
		#|Musculoskeletal		|			|M		    |
		#|SpecialSenses 		|			|L			|
		#|Renal		            |			|N			|
		#|Hemotologic		    |			|I			|
		#|Neurologic	        |    		|U			|
		#|Dermatologic		    |			|D		    |
		#|Immunologic			|			|B		    |
		#|Other (please specify) |true		|O		    |	
	#And data dictionary "Gender" has entries
	    #|User Data String	|Specify	|Coded Data	|
		#|Male				|			|M			|
		#|Female			|			|F			|		
   #And data dictionary " Normal Abnormal" has entries
	    #|User Data String	|Specify	|Coded Data	|
		#|Normal			|			|1			|
		#|Abnormal			|			|2			|		
   #And data dictionary "Race" has entries
		#|User Data String	|Specify	|Coded Data	|
		#|White			    |			|W		    |
		#|Black			    |			|B		    |	
		#|Asian			    |			|A		    |
		#|Hispanic 		    |			|H		    |
		#|Other		        |true		|O		    |		
   #And PDF Configuration Profile "PDF A1" has default settings   
   #And PDF Configuration Profile "PDF A2" has settings
        #|Annotations_Pre-Filled Values|
        #|True                         |	
	#And form "Demographics" has log direction "Portrait"
	#And I take a screenshot
	#And form "Medical History" has log direction "Landscape"
	#And I take a screenshot	
	#And PDF Configuration Profile "PDF A1" has default settings
	#And I take a screenshot
	#And PDF Configuration Profile "PDF A2" has Pre-Filled Values Annotations settings
	#And I take a screenshot
	#Given I am logged in to Rave with username "defuser" and password "password"
	#And study "PDF Default Study" has role "Role 1"
	#And I publish "CRF Version<RANDOMNUMBER>" to site "Site A1"
	#And I note "CRF Version"
	#And I take a screenshot
	#And I navigate to "Home"
	#When I navigate to "PDF Generator" module
	#And I take a screenshot

	#Note: Both forms "Demographics" with log direction "Portrait" and "Medical History" with log direction "Landscape" are tested in the below scenarios on the generated PDF's. 
    #Note: Three user stories are linked with this feature file US15841, US17279 and US17414
	
@release_2012.1.0
@PB_US15841_US17279_US17414_DT5899_DT14019A
@ignore
@manual
@Validation 
#Scenario: PB_US15841_US17279_US17414_DT5899_DT14019A A blank PDF that is generated should not product multiple pages for the default log lines
	
	#When I view the blank PDF that is generated
	#I should see a continuous page or set of pages for the default log lines
	#I should not see a new page produced for every default log line
	#I should not see a blank page in PDF
	#
	#When I create Blank PDF
	#	| Name						   | Profile | Study				    |Role   |Locale  |CRFVersion                 |
	#	| Blank PDF 1A{RndNum<num>(3)} | PDF A1  | PDF Default Study (Prod) |Role 1 |English |CRF Version<RANDOMNUMBER>  |
	#And I take a screenshot
	#And I generate Blank PDF "Blank PDF 1A{Var(num)}"
	#And I wait for PDF "Blank PDF 1A{Var(num)}" to complete
	#And I take a screenshot
	#When I view blank PDF "BASE.pdf"
	#Then I should not see a blank page in PDF
    #And I take a screenshot
	#When I click on link "Medical History" on the PDF in the left side
	#Then I should see a continuous page or set of pages for the default log lines on the "Medical History" form
	#And I should not see a new page produced for every default log line on the "Medical History" form
	#And I take a screenshot
	#When I click on link "Demographics" on the PDF in the left side
	#Then I should see a continuous page or set of pages for the default log lines on the "Demographics" form
	#And I should not see a new page produced for every default log line on the "Demographics" form
    #And I take a screenshot

@release_2012.1.0
@PB_US15841_US17279_US17414_DT5899_DT14019B
@ignore
@manual  
@Validation
#Scenario: PB_US15841_US17279_US17414_DT5899_DT14019B As a user when I navigate to "PDF Generator" and select "Create Blank Request" 
#using "Annotated PDF profile" where the "Pre-Filled Values" checkbox has been checked 
#from the "Annotations" category, then I should see all the prefilled values in one page.
#I should not see a blank page in PDF

	#When I create Blank PDF
	#	| Name						   | Profile | Study				    |Role   |Locale  |CRFVersion                 |
	#	| Blank PDF 2A{RndNum<num>(3)} | PDF A2  | PDF Default Study (Prod) |Role 1 |English |CRF Version<RANDOMNUMBER>  |
	#And I take a screenshot
	#And I generate Blank PDF "Blank PDF 2A{Var(num)}"
	#And I wait for PDF "Blank PDF 2A{Var(num)}" to complete
	#And I take a screenshot
	#When I view blank PDF "BASE.pdf"
	#Then I should not see a blank page in PDF
	#Then I should see all the prefilled values in one page on "Medical History" form
	#And I take a screenshot
	#Then I should see all the prefilled values in one page on "Demographics" form
	#And I take a screenshot
	#When I click on link "Medical History" on the PDF in the left side
	#Then I should see the "Medical History" form on the right side of the PDF with Annonations
	#And I take a screenshot	
    #When I click on the Annotations on the "Medical History" form on the PDF
    #Then I should take to the Annotations page of "Medical History" form
	#And I take a screenshot	
    #When I click on link "Demographics" on the PDF in the left side
	#Then I should see the "Demographics" form on the right side of the PDF with Annonations
	#And I take a screenshot	
    #When I click on the Annotations on the "Demographics" form on the PDF
    #Then I should take to the Annotations page of "Demographics" form
	#And I take a screenshot