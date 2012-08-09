********Role and CRF Version in the table need to be confirmed************
# When a PDF form is generated special character such as "<" ">" "<=" ">=" should be displayed properly 

Feature: When an EDC form contains special characters such as "<" ">" "<=" ">=" the PDF file should display the special characters appropriately. 
	Rave architect allows for characters that the PDF generator does support. The PDF generator should convert the special characters so that they are displayed appropriately as follows:
	|Rave Architect	 		|PDF Interpretation |Symbol in PDF                 |
	|&lt 					|&lt;               |<                             |
	|&gt					|&gt;               |>                             |
	|&ge					|<u>&gt;</u>        |>(underlined)                 |
	|&ge;					|<u>&gt;</u>        |>(underlined)                 |
	|&le					|<u>&lt;</u>        |<(underlined)                 |
	|&le;					|<u>&lt;</u>        |<(underlined)                 |
	|bullet points <li>		|<br/> •            |(Line Break/carriage return) •|
	|(user hitting "enter")	|<br/>              |(Line Break/carriage return)  |
	
	NOTE: An underlined ">" will display instead of ">=" which is represented by ">(underlined)" in this feature file as text editors do not allow underlines.
	      An underlined "<" will display instead of "<=" which is represented by "<(underlined)" in this feature file as text editors do not allow underlines.
	NOTE: user hitting "enter" was previously interpreted as " " but should be interpreted as a new line. In certain Japanese fonts it had been
		interpreted as "="
	This rendering should be implemented for fonts 
	|Font                       |
	|Helvetica                  |
	|Times Roman                |
	|Times New Roman Embedded   |
	
	|Asian Font               |
	|Heisei Kaku Gothic W5    |
	|Meiryo                   |
	
	This rendering should be implemented for blank PDFs, annotated PDFs, data populated PDFs, Rave Monitor Trip Report PDFs. 
	This rendering should be implemented for:
		translations
		field pretext
		data dictionaries on the CRF but NOT in the audit trail
		unit dictionaries on the CRF but NOT in the audit trail
		coding dictionaries on the CRF but NOT in the audit trail
		lab units on the CRF but NOT in the audit trail (does not apply to Rave Monitor Trip Report PDFs)
		lab ranges on the CRF but NOT in the audit trail (does not apply to Rave Monitor Trip Report PDFs)
	This rendering will NOT be implented for:
		bookmarks
		lab names
		Form names
		
		
Background:
#Create 4 forms: lab form, log form, standard form, mixed form. Each form should contain every possible control type. Each form should contain all of 
#the special characters as outlined above in at least one field pre-text, the data dictionaries, unit dictionaries, lab units, lab ranges

	#Given user "User 1"  has study "PDF Font Study" has site "PDF Font Site 1" has Site Group "World" has lab "Local Lab" and has subject "Sub{Var(num1)}" in database "<EDC> Database"
	#And study "PDF Font Study" has draft "Draft 1"
	#And draft "Draft 1" has "Signature Prompt" with message "Please Sign&lt&gt&ge&ge;&le&le;bullet points&lt;li&gt;&lt;br/&gt;break"
	#And form "PDF Standard Form" has varOID "<VarOID>" has format "<Format>" has data dictionary "<Dictionary>" has Unit dictionary "<Unit Dictionary>" has field name "<Field Name>" has field OID "<Field OID>" has status "<Active>" has visible status "<Is Visible Field>" has log data entry "<Log Data Entry>" has field label "<Field Label>" has control type "<Control Type>" has value "<Default Value>" has field help text "<Field Help Text>"
	#	|VarOID		              |Format		  |Dictionary	  |Unit Dictionary	|Field Name		          |Field OID		        |Active		|Is Visible Field 	|Log Data Entry	|Field Label                                        |Control Type          |Default Value 	|Field Help Text	|
	#	|DATEFIELD1	              |mm- dd- yyyy	  |               |					|DATEFIELD1		          |DATEFIELD1		        |true		|true				|			    |&ltDateField 	                                    |DateTime 	           |		    	|					|
	#	|DROPDOWNFIELD1A	      |$20            |DDictionary1   | 				|DROPDOWNFIELD1A	      |DROPDOWNFIELD1A	        |true		|true				|			    |&gtDropDownField1                                  |DropDownList	       |      			|                   |
	#	|DROPDOWNFIELD2A	      |$20            |DDictionary1   | 				|DROPDOWNFIELD2A	      |DROPDOWNFIELD2A	        |true		|true				|			    |&gtDropDownField2                                  |DropDownList	       |      			|                   |
	#	|DROPDOWNFIELD3A	      |$20            |DDictionary1   | 				|DROPDOWNFIELD3A	      |DROPDOWNFIELD3A	        |true		|true				|			    |&gtDropDownField3                                  |DropDownList	       |      			|                   |
	#	|DROPDOWNFIELD4A	      |$20            |DDictionary1   | 				|DROPDOWNFIELD4A	      |DROPDOWNFIELD4A	        |true		|true				|			    |&gtDropDownField4                                  |DropDownList	       |      			|                   |
	#	|DROPDOWNFIELD5A	      |$20            |DDictionary1   | 				|DROPDOWNFIELD5A	      |DROPDOWNFIELD5A	        |true		|true				|			    |&gtDropDownField5                                  |DropDownList	       |      			|                   |
	#	|DROPDOWNFIELD6A	      |$20            |DDictionary1   | 				|DROPDOWNFIELD6A	      |DROPDOWNFIELD6A	        |true		|true				|			    |&gtDropDownField6                                  |DropDownList	       |      			|                   |
	#	|DROPDOWNFIELD7A	      |$20            |DDictionary1   | 				|DROPDOWNFIELD7A	      |DROPDOWNFIELD7A	        |true		|true				|			    |&gtDropDownField7                                  |DropDownList	       |      			|                   |
	#	|DROPDOWNFIELD8A	      |$20            |DDictionary1   | 				|DROPDOWNFIELD8A	      |DROPDOWNFIELD8A	        |true		|true				|			    |&gtDropDownField8                                  |DropDownList	       |      			|                   |
	#	|TEXTFIELD1	              |$10	          |               |					|TEXTFIELD1	              |TEXTFIELD1	            |true		|true				|			    |Text Field&ge 	                                    |Text     	           |		    	|					|
	#	|LONGTEXTFIELD1	          |$100	          |               |					|LONGTEXTFIELD1	          |LONGTEXTFIELD1	        |true		|true				|			    |Long Text&ge; Field                                |LongText     	       |		    	|					|
	#	|TEXTFIELD1A	          |4.1            |               |UDictionary1  	|TEXTFIELD1A	          |TEXTFIELD1A	            |true		|true				|			    |&leTextField1                                      |Text    	           |      			|                   |
	#	|TEXTFIELD2A	          |4.1            |               |UDictionary1  	|TEXTFIELD2A	          |TEXTFIELD2A	            |true		|true				|			    |&leTextField2                                      |Text    	           |      			|                   |
	#	|TEXTFIELD3A	          |4.1            |               |UDictionary1  	|TEXTFIELD3A	          |TEXTFIELD3A	            |true		|true				|			    |&leTextField3                                      |Text    	           |      			|                   |
	#	|TEXTFIELD4A	          |4.1            |               |UDictionary1  	|TEXTFIELD4A	          |TEXTFIELD4A	            |true		|true				|			    |&leTextField4                                      |Text    	           |      			|                   |
	#	|TEXTFIELD5A	          |4.1            |               |UDictionary1  	|TEXTFIELD5A	          |TEXTFIELD5A	            |true		|true				|			    |&leTextField5                                      |Text    	           |      			|                   |
	#	|TEXTFIELD6A	          |4.1            |               |UDictionary1  	|TEXTFIELD6A	          |TEXTFIELD6A	            |true		|true				|			    |&leTextField6                                      |Text    	           |      			|                   |
	#	|TEXTFIELD7A	          |4.1            |               |UDictionary1  	|TEXTFIELD7A	          |TEXTFIELD7A	            |true		|true				|			    |&leTextField7                                      |Text    	           |      			|                   |
	#	|TEXTFIELD8A	          |4.1            |               |UDictionary1  	|TEXTFIELD8A	          |TEXTFIELD8A	            |true		|true				|			    |&leTextField8                                      |Text    	           |      			|                   |
	#	|DSLFIELD1	              |$60	          |               |					|DSLFIELD1	              |DSLFIELD1	            |true		|true				|			    |&le;DSL Field                                      |Dynamic SearchList    |		    	|					|
	#	|FILEUPLOADFIELD1         |$200	          |               |					|FILEUPLOADFIELD1         |FILEUPLOADFIELD1         |true		|true				|			    |&leFile Upload Field                               |File Upload           |		    	|					|
	#	|RADIOBUTTONFIELD1        |$20	          |DDictionary1   |					|RADIOBUTTONFIELD1        |RADIOBUTTONFIELD1        |true		|true				|			    |bullet points <li>Radio Button Field               |RadioButton           |		    	|					|
	#	|RADIOBUTTONVERTICALFIELD1|$20	          |DDictionary1   |					|RADIOBUTTONVERTICALFIELD1|RADIOBUTTONVERTICALFIELD1|true		|true				|			    |(user hitting "enter")Radio Button Vertical Field  |RadioButton (Vertical)|		    	|					|
	#	|SEARCHFIELD1	          |$20	          |DDictionary1   |					|SEARCHFIELD1	          |SEARCHFIELD1	            |true		|true				|			    |Search Field&lt                                    |SearchList            |		    	|					|
	#	|CHECKBOXFIELD1	          |1              |               |              	|CHECKBOXFIELD1	          |CHECKBOXFIELD1	        |true		|true				|			    |&leCheckBoxField1                                  |CheckBox	           |      			|                   |
	#	|SIGNATUREFIELD1	      |eSigPage	      |               |					|SIGNATUREFIELD1	      |SIGNATUREFIELD1	        |true		|true				|			    |&ge;Signature Field                                |Signature             |		    	|					|
	#	
    #And form "PDF Log Form" has varOID "<VarOID>" has format "<Format>" has data dictionary "<Dictionary>" has Unit dictionary "<Unit Dictionary>" has field name "<Field Name>" has field OID "<Field OID>" has status "<Active>" has visible status "<Is Visible Field>" has log data entry "<Log Data Entry>" has field label "<Field Label>" has control type "<Control Type>" has value "<Default Value>" has field help text "<Field Help Text>"
	#	|VarOID		              |Format		  |Dictionary	  |Unit Dictionary	|Field Name		          |Field OID		        |Active		|Is Visible Field 	|Log Data Entry	|Field Label                                        |Control Type          |Default Value 	|Field Help Text	|
	#	|DATEFIELD2	              |mm- dd- yyyy	  |               |					|DATEFIELD2	              |DATEFIELD2	            |true		|true				|true    	    |&ltDateField 	                                    |DateTime 	           |		    	|					|
	#	|DROPDOWNFIELD1B	      |$20            |DDictionary1   | 				|DROPDOWNFIELD1B	      |DROPDOWNFIELD1B	        |true		|true				|true    	    |&gtDropDownField1                                  |DropDownList	       |      			|                   |
	#	|DROPDOWNFIELD2B	      |$20            |DDictionary1   | 				|DROPDOWNFIELD2B	      |DROPDOWNFIELD2B	        |true		|true				|true    	    |&gtDropDownField2                                  |DropDownList	       |      			|                   |
	#	|DROPDOWNFIELD3B	      |$20            |DDictionary1   | 				|DROPDOWNFIELD3B	      |DROPDOWNFIELD3B	        |true		|true				|true    	    |&gtDropDownField3                                  |DropDownList	       |      			|                   |
	#	|DROPDOWNFIELD4B	      |$20            |DDictionary1   | 				|DROPDOWNFIELD4B	      |DROPDOWNFIELD4B	        |true		|true				|true    	    |&gtDropDownField4                                  |DropDownList	       |      			|                   |
	#	|DROPDOWNFIELD5B	      |$20            |DDictionary1   | 				|DROPDOWNFIELD5B	      |DROPDOWNFIELD5B	        |true		|true				|true    	    |&gtDropDownField5                                  |DropDownList	       |      			|                   |
	#	|DROPDOWNFIELD6B	      |$20            |DDictionary1   | 				|DROPDOWNFIELD6B	      |DROPDOWNFIELD6B	        |true		|true				|true    	    |&gtDropDownField6                                  |DropDownList	       |      			|                   |
	#	|DROPDOWNFIELD7B	      |$20            |DDictionary1   | 				|DROPDOWNFIELD7B	      |DROPDOWNFIELD7B	        |true		|true				|true    	    |&gtDropDownField7                                  |DropDownList	       |      			|                   |
	#	|DROPDOWNFIELD8B	      |$20            |DDictionary1   | 				|DROPDOWNFIELD8B	      |DROPDOWNFIELD8B	        |true		|true				|true    	    |&gtDropDownField8                                  |DropDownList	       |      			|                   |
	#	|TEXTFIELD2	              |$10	          |               |					|TEXTFIELD2	              |TEXTFIELD2	            |true		|true				|true    	    |Text Field&ge 	                                    |Text     	           |		    	|					|
	#	|LONGTEXTFIELD2	          |$100	          |               |					|LONGTEXTFIELD2	          |LONGTEXTFIELD2	        |true		|true				|true    	    |Long Text&ge; Field                                |LongText     	       |		    	|					|
	#	|TEXTFIELD1B	          |4.1            |               |UDictionary1  	|TEXTFIELD1B	          |TEXTFIELD1B	            |true		|true				|true    	    |&leTextField1                                      |Text    	           |      			|                   |
	#	|TEXTFIELD2B	          |4.1            |               |UDictionary1  	|TEXTFIELD2B	          |TEXTFIELD2B	            |true		|true				|true    	    |&leTextField2                                      |Text    	           |      			|                   |
	#	|TEXTFIELD3B	          |4.1            |               |UDictionary1  	|TEXTFIELD3B	          |TEXTFIELD3B	            |true		|true				|true    	    |&leTextField3                                      |Text    	           |      			|                   |
	#	|TEXTFIELD4B	          |4.1            |               |UDictionary1  	|TEXTFIELD4B	          |TEXTFIELD4B	            |true		|true				|true    	    |&leTextField4                                      |Text    	           |      			|                   |
	#	|TEXTFIELD5B	          |4.1            |               |UDictionary1  	|TEXTFIELD5B	          |TEXTFIELD5B	            |true		|true				|true    	    |&leTextField5                                      |Text    	           |      			|                   |
	#	|TEXTFIELD6B	          |4.1            |               |UDictionary1  	|TEXTFIELD6B	          |TEXTFIELD6B	            |true		|true				|true    	    |&leTextField6                                      |Text    	           |      			|                   |
	#	|TEXTFIELD7B	          |4.1            |               |UDictionary1  	|TEXTFIELD7B	          |TEXTFIELD7B	            |true		|true				|true    	    |&leTextField7                                      |Text    	           |      			|                   |
	#	|TEXTFIELD8B	          |4.1            |               |UDictionary1  	|TEXTFIELD8B	          |TEXTFIELD8B	            |true		|true				|true    	    |&leTextField8                                      |Text    	           |      			|                   |
	#	|DSLFIELD2	              |$60	          |			      |					|DSLFIELD2	              |DSLFIELD2	            |true		|true				|true    	    |&le;DSL Field                                      |Dynamic SearchList    |		    	|					|
	#	|FILEUPLOADFIELD2         |$200	          |               |					|FILEUPLOADFIELD2         |FILEUPLOADFIELD2         |true		|true				|true    	    |&leFile Upload Field                               |File Upload           |		    	|					|
	#	|RADIOBUTTONFIELD2        |$20	          |DDictionary1   |					|RADIOBUTTONFIELD2        |RADIOBUTTONFIELD2        |true		|true				|true    	    |bullet points <li>Radio Button Field               |RadioButton           |		    	|					|
	#	|RADIOBUTTONVERTICALFIELD2|$20	          |DDictionary1   |					|RADIOBUTTONVERTICALFIELD2|RADIOBUTTONVERTICALFIELD2|true		|true				|true    	    |(user hitting "enter")Radio Button Vertical Field  |RadioButton (Vertical)|		    	|					|
	#	|SEARCHFIELD2	          |$20	          |DDictionary1   |					|SEARCHFIELD2	          |SEARCHFIELD2	            |true		|true				|true    	    |Search Field&lt                                    |SearchList            |		    	|					|
	#	|CHECKBOXFIELD2	          |1              |               |              	|CHECKBOXFIELD2	          |CHECKBOXFIELD2	        |true		|true				|true    	    |&leCheckBoxField1                                  |CheckBox	           |      			|                   |
	#	|SIGNATUREFIELD2	      |eSigPage	      |               |					|SIGNATUREFIELD2	      |SIGNATUREFIELD2	        |true		|true				|        	    |&ge;Signature Field                                |Signature             |		    	|					|
	#	
    #And form "PDF Mixed Form" has varOID "<VarOID>" has format "<Format>" has data dictionary "<Dictionary>" has Unit dictionary "<Unit Dictionary>" has field name "<Field Name>" has field OID "<Field OID>" has status "<Active>" has visible status "<Is Visible Field>" has log data entry "<Log Data Entry>" has field label "<Field Label>" has control type "<Control Type>" has value "<Default Value>" has field help text "<Field Help Text>"
	#	|VarOID		              |Format		  |Dictionary	  |Unit Dictionary	|Field Name		          |Field OID		        |Active		|Is Visible Field 	|Log Data Entry	|Field Label                                        |Control Type          |Default Value 	|Field Help Text	|
	#	|DATEFIELD3	              |mm- dd- yyyy	  |               |					|DATEFIELD3	              |DATEFIELD3	            |true		|true				|        	    |&ltDateField 	                                    |DateTime 	           |		    	|					|
	#	|TEXTFIELD3	              |$10	          |               |					|TEXTFIELD3	              |TEXTFIELD3	            |true		|true				|        	    |Text Field&ge 	                                    |Text     	           |		    	|					|
	#	|FILEUPLOADFIELD3         |$200	          |               |					|FILEUPLOADFIELD3         |FILEUPLOADFIELD3         |true		|true				|        	    |&leFile Upload Field                               |File Upload           |		    	|					|		
	#	|DROPDOWNFIELD1C	      |$20            |DDictionary1   | 				|DROPDOWNFIELD1C	      |DROPDOWNFIELD1C	        |true		|true				|true   	    |&gtDropDownField1                                  |DropDownList	       |      			|                   |
	#	|DROPDOWNFIELD2C	      |$20            |DDictionary1   | 				|DROPDOWNFIELD2C	      |DROPDOWNFIELD2C	        |true		|true				|true   	    |&gtDropDownField2                                  |DropDownList	       |      			|                   |
	#	|DROPDOWNFIELD3C	      |$20            |DDictionary1   | 				|DROPDOWNFIELD3C	      |DROPDOWNFIELD3C	        |true		|true				|true   	    |&gtDropDownField3                                  |DropDownList	       |      			|                   |
	#	|DROPDOWNFIELD4C	      |$20            |DDictionary1   | 				|DROPDOWNFIELD4C	      |DROPDOWNFIELD4C	        |true		|true				|true   	    |&gtDropDownField4                                  |DropDownList	       |      			|                   |
	#	|DROPDOWNFIELD5C	      |$20            |DDictionary1   | 				|DROPDOWNFIELD5C	      |DROPDOWNFIELD5C	        |true		|true				|true   	    |&gtDropDownField5                                  |DropDownList	       |      			|                   |
	#	|DROPDOWNFIELD6C	      |$20            |DDictionary1   | 				|DROPDOWNFIELD6C	      |DROPDOWNFIELD6C	        |true		|true				|true   	    |&gtDropDownField6                                  |DropDownList	       |      			|                   |
	#	|DROPDOWNFIELD7C	      |$20            |DDictionary1   | 				|DROPDOWNFIELD7C	      |DROPDOWNFIELD7C	        |true		|true				|true   	    |&gtDropDownField7                                  |DropDownList	       |      			|                   |
	#	|DROPDOWNFIELD8C	      |$20            |DDictionary1   | 				|DROPDOWNFIELD8C	      |DROPDOWNFIELD8C	        |true		|true				|true   	    |&gtDropDownField8                                  |DropDownList	       |      			|                   |
	#	|LONGTEXTFIELD3	          |$100	          |               |					|LONGTEXTFIELD3	          |LONGTEXTFIELD3	        |true		|true				|true   	    |Long Text&ge; Field                                |LongText     	       |		    	|					|
	#	|TEXTFIELD1C	          |4.1            |               |UDictionary1  	|TEXTFIELD1C	          |TEXTFIELD1C	            |true		|true				|true   	    |&leTextField1                                      |Text    	           |      			|                   |
	#	|TEXTFIELD2C	          |4.1            |               |UDictionary1  	|TEXTFIELD2C	          |TEXTFIELD2C	            |true		|true				|true   	    |&leTextField2                                      |Text    	           |      			|                   |
	#	|TEXTFIELD3C	          |4.1            |               |UDictionary1  	|TEXTFIELD3C	          |TEXTFIELD3C	            |true		|true				|true   	    |&leTextField3                                      |Text    	           |      			|                   |
	#	|TEXTFIELD4C	          |4.1            |               |UDictionary1  	|TEXTFIELD4C	          |TEXTFIELD4C	            |true		|true				|true   	    |&leTextField4                                      |Text    	           |      			|                   |
	#	|TEXTFIELD5C	          |4.1            |               |UDictionary1  	|TEXTFIELD5C	          |TEXTFIELD5C	            |true		|true				|true   	    |&leTextField5                                      |Text    	           |      			|                   |
	#	|TEXTFIELD6C	          |4.1            |               |UDictionary1  	|TEXTFIELD6C	          |TEXTFIELD6C	            |true		|true				|true   	    |&leTextField6                                      |Text    	           |      			|                   |
	#	|TEXTFIELD7C	          |4.1            |               |UDictionary1  	|TEXTFIELD7C	          |TEXTFIELD7C	            |true		|true				|true   	    |&leTextField7                                      |Text    	           |      			|                   |
	#	|TEXTFIELD8C	          |4.1            |               |UDictionary1  	|TEXTFIELD8C	          |TEXTFIELD8C	            |true		|true				|true   	    |&leTextField8                                      |Text    	           |      			|                   |
	#	|DSLFIELD3	              |$60	          |               |					|DSLFIELD3	              |DSLFIELD3	            |true		|true				|true   	    |&le;DSL Field                                      |Dynamic SearchList    |		    	|					|
	#	|RADIOBUTTONFIELD3        |$20	          |DDictionary1   |					|RADIOBUTTONFIELD3        |RADIOBUTTONFIELD3        |true		|true				|true   	    |bullet points <li>Radio Button Field               |RadioButton           |		    	|					|
	#	|RADIOBUTTONVERTICALFIELD3|$20	          |DDictionary1   |					|RADIOBUTTONVERTICALFIELD3|RADIOBUTTONVERTICALFIELD3|true		|true				|true   	    |(user hitting "enter")Radio Button Vertical Field  |RadioButton (Vertical)|		    	|					|
	#	|SEARCHFIELD3	          |$20	          |DDictionary1   |					|SEARCHFIELD3	          |SEARCHFIELD3	            |true		|true				|true   	    |Search Field&lt                                    |SearchList            |		    	|					|
	#	|CHECKBOXFIELD3	          |1              |               |              	|CHECKBOXFIELD3	          |CHECKBOXFIELD3	        |true		|true				|true   	    |&leCheckBoxField1                                  |CheckBox	           |      			|                   |
	#	|SIGNATUREFIELD3	      |eSigPage	      |               |					|SIGNATUREFIELD3	      |SIGNATUREFIELD3	        |true		|true				|       	    |&ge;Signature Field                                |Signature             |		    	|					|

Lab form
And form "PDF Lab Form" has varOID "<VarOID>" has format "<Format>" has field name "<Field Name>" has field OID "<Field OID>" has status "<Active>" has visible status "<Is Visible Field>" has field label "<Field Label>" has control type "<Control Type>" has lab analyte "<Lab Analyte>" has prompt for clinical significance "<Prompt for Clinical Significance>"
		|VarOID		          |Format |Field Name	|Field OID	  |Active	|Is Visible Field 	|Field Label                                                            |Control Type |Lab Analyte 	|Prompt for Clinical Significance	|
		|WBC	              |4.2	  |WBC  	    |WBC	      |true		|true				|WBC&lt&gt&ge&ge;&le&le;bullet points&lt;li&gt;&lt;br/&gt;break         |Text    	  |WBC  		|true				                |
		|NEUTROPHILS	      |4.2	  |NEUTROPHILS  |NEUTROPHILS  |true		|true				|&lt&gt&ge&ge;&le&le;bullet points&lt;li&gt;&lt;br/&gt;breakNEUTROPHILS |Text    	  |NEUTROPHILS  |false				                |
	
   And the following Lab Units exists
	| Lab Unit |
	| %        |
	
   And the following Lab Unit Dictionary exists
	| Name        | Units  |
	| WBC         | %      |
	| Neutrophils | %      |
	
	And the following Analytes exists
	| Analytes    | Lab Unit Dictionary |
	| WBC         | WBC                 |
	| NEUTROPHILS | NEUTROPHILS         |
	
	And the following Range Types exists
	| Range Type    | 
	| US12175 Range |
		
	And lab "US12175 Lab" with Range Type "US12175 Range" has analyte "Analyte" has from date "From Date" has to date "To Date" has low value "Low Value" has high value "High Value" has units "Units" 
	|Analyte     |From Date   |To Date     |Low Value  |High Value  |Units |
	|WBC         |01 Jan 2005 |01 Jan 2015 |15         |25          |%     |
	|NEUTROPHILS |01 Jan 2005 |01 Jan 2015 |40         |50          |%     |

                                                                                                                          
	#And data dictionary "DDictionary1"	has entries
	#	|User Data String       |Coded Data             |
	#	|&lt		            |&lt		            |
	#	|&gt		            |&gt		            |
	#	|&ge		            |&ge		            |
	#	|&ge;		            |&ge;		            |
	#	|&le		            |&le		            |
	#	|&le;		            |&le;		            |
	#	|<li> bullet points     |<li> bullet points     |
	#	|<br/>break             |<br/>break             |	
	#
    #And unit dictionary "UDictionary1"	has entries	
	#	|User Data String       |Standard  |Coded Unit             |
	#	|&lt		            |true      |&lt		               |
	#	|&gt		            |false     |&gt		               |
	#	|&ge		            |false     |&ge		               |
	#	|&ge;		            |false     |&ge;		           |
	#	|&le		            |false     |&le		               |
	#	|&le;		            |false     |&le;		           |
	#	|<li> bullet points     |false     |<li> bullet points     |
	#	|<br/>break             |false     |<br/>break             |
	#
	#And Field "DSLFIELD" on Form "PDF Standard Form" has Edit Check "DSL Check" using Custom Function "DSL CF"
	
	# DSL CF:
	#Medidata.Utilities.KeyValueCollection KVC=new Medidata.Utilities.KeyValueCollection();
	#Medidata.Utilities.KeyValue KV0=new Medidata.Utilities.KeyValue("key0", "&lt&gt&ge&ge;&le&le;bullet points<li><br/>break0");
	#Medidata.Utilities.KeyValue KV1=new Medidata.Utilities.KeyValue("key1", "&lt&gt&ge&ge;&le&le;bullet points<li><br/>break1");
	#KVC.Add(KV0);
	#KVC.Add(KV1);
	#
	#return KVC;

	#|DSL Check1|True|False
	#
	#||StandardValue|DSLFIELD1||PDFSTANDARDFORM|DSLFIELD1|||||
	#IsNotEmpty|||||||||||
	#
	#|PDFSTANDARDFORM|DSLFIELD1|DSLFIELD1||||SetDynamicSearchList||DSL CF|

	#|DSL Check2|True|False
	#
	#||StandardValue|DSLFIELD2||PDFLOGFORM|DSLFIELD2|1||||
	#IsNotEmpty|||||||||||
	#
	#|PDFLOGFORM|DSLFIELD2|DSLFIELD2|1|||SetDynamicSearchList||DSL CF|

	#|DSL Check3|True|False
	#
	#||StandardValue|DSLFIELD3||PDFMIXEDFORM|DSLFIELD3|1||||
	#IsNotEmpty|||||||||||
	#
	#|PDFMIXEDFORM|DSLFIELD3|DSLFIELD3|1|||SetDynamicSearchList||DSL CF|

	#And PDF Configuration Profile "PDF 1" has settings
	#|Formatting Properties_Font |Annotations_Field Label|Annotations_Units|Annotations_Values|Annotations_Pre-Filled Values|
	#|Helvetica                  |True                   |True             |True              |True                         |
	#
	#And PDF Configuration Profile "PDF 2" has settings
	#|Font                       |Annotations_Field Label|Annotations_Units|Annotations_Values|Annotations_Pre-Filled Values|
	#|Times Roman                |True                   |True             |True              |True                         |
	#
	#And PDF Configuration Profile "PDF 3" has settings
	#|Font                       |Annotations_Field Label|Annotations_Units|Annotations_Values|Annotations_Pre-Filled Values|
	#|Times New Roman Embedded   |True                   |True             |True              |True                         |
	#
	#And PDF Configuration Profile "PDF 4" has settings
	#|Asian Font               |Use Asian font selected to ensure both single and double byte characters render|Annotations_Field Label|Annotations_Units|Annotations_Values|Annotations_Pre-Filled Values|
	#|Heisei Kaku Gothic W5    |True                                                                           |True                   |True             |True              |True                         |
	#
	#And PDF Configuration Profile "PDF 5" has settings
	#|Asian Font               |Use Asian font selected to ensure both single and double byte characters render|Annotations_Field Label|Annotations_Units|Annotations_Values|Annotations_Pre-Filled Values|
	#|Meiryo                   |True                                                                           |True                   |True             |True              |True                         |
	#
	#
	Given I am logged in to Rave with username "defuser" and password "password"
	#And study "PDF Font Study" has role "Role 1"
	#And I publish and push "CRF Version<RANDOMNUMBER>" to site "PDF Font Site 1"
	#And I note "CRF Version"
	#And I navigate to "study {PDF Font Study}, site {PDF Font Site 1}, subject Sub{Var(num1)}"
	
	#And I select Form "PDF Standard Form"
	#And I enter data in CRF and save
	#|Field                                              |Data                                                           |
	#|<DateField 	                                     |01 25 1995 	                                                 |
	#|>DropDownField1                                    |&lt                           	                             |
	#|>DropDownField2                                    |&gt                           	                             |
	#|>DropDownField3                                    |&ge			               	                                 |
	#|>DropDownField4                                    |&ge;		                 	                                 |
	#|>DropDownField5                                    |&le				        	                                 |
	#|>DropDownField6                                    |&le;		                	                                 |
	#|>DropDownField7                                    |bullet points <li>						                     |
	#|>DropDownField8                                    |<br/>break					  	                             |
	#|Text Field>(underlined) 	                         |data1     	                                                 |
	#|Long Text>(underlined) Field                       |&lt&gt&ge&ge;&le&le;bullet points<li><br/>breakaaaaaaaaaa123	 |	
	#|<(underlined)TextField1                            |1.1&lt                             	                         |
	#|<(underlined)TextField2                            |2.2&gt                                                         |                                                                                 
	#|<(underlined)TextField3                            |3.3&ge                 									     |
	#|<(underlined)TextField4                            |4.4&ge;			                 	                         |
	#|<(underlined)TextField5                            |5.5&le			                							 |
	#|<(underlined)TextField6                            |6.6&le;						       	                         |
	#|<(underlined)TextField7                            |7.7bullet points <li>								             |                                                              
	#|<(underlined)TextField8                            |8.8<br/>break					  					             |                                                              
	#|<(underlined)DSL Field                             |&lt&gt&ge&ge;&le&le;bullet points<li><br/>break0               |
	#|<(underlined)File Upload Field                     |do not upload					                                 |
	#|bullet points <li>Radio Button Field               |&lt                                                            |
	#|(user hitting "enter")Radio Button Vertical Field  |&gt                                                            |
	#|Search Field<                                      |&ge                                                            |
	#|<(underlined)CheckBoxField1                        |true   	                                                     |
	#|>(underlined)Signature Field                       |defuser password							                     |
	#
	#And I select Form "PDF Log Form"
	#And I enter data in CRF and save
	#|Field                                              |Data                                                          |                                                                     
	#|<DateField 	                                     |02 25 1995 	                                                |                                                                     
	#|>DropDownField1                                    |&lt                           								|																		
	#|>DropDownField2                                    |&gt                           								|																		
	#|>DropDownField3                                    |&ge			               									|																	  
	#|>DropDownField4                                    |&ge;		                 									|																	  
	#|>DropDownField5                                    |&le				        									|																	  
	#|>DropDownField6                                    |&le;		                									|																	  
	#|>DropDownField7                                    |bullet points <li>											|																		
	#|>DropDownField8                                    |<br/>break					  								|																		
	#|Text Field>(underlined) 	                         |data2     													|																		
	#|Long Text>(underlined) Field                       |&lt&gt&ge&ge;&le&le;bullet points<li><br/>breakbbbbbbbbbb456	|																			  
	#|<(underlined)TextField1                            |1.1&lt                             							|																	  
	#|<(underlined)TextField2                            |2.2&gt                           								|																	  
	#|<(underlined)TextField3                            |3.3&ge                 										|																	  
	#|<(underlined)TextField4                            |4.4&ge;			                 							|																	  
	#|<(underlined)TextField5                            |5.5&le			                							|																		
	#|<(underlined)TextField6                            |6.6&le;						       							|																	  
	#|<(underlined)TextField7                            |7.7bullet points <li>											|																	  
	#|<(underlined)TextField8                            |8.8<br/>break					  								|																	  
	#|<(underlined)DSL Field                             |&lt&gt&ge&ge;&le&le;bullet points<li><br/>break0				|																	  
	#|<(underlined)File Upload Field                     |do not upload													|																	  
	#|bullet points <li>Radio Button Field               |&lt															|																	  
	#|(user hitting "enter")Radio Button Vertical Field  |&gt															|																	  
	#|Search Field<                                      |&ge															|																	  
	#|<(underlined)CheckBoxField1                        |true   														|																	  
	#|>(underlined)Signature Field                       |defuser password												|																	  
	#	
	#And I select Form "PDF Mixed Form"
	#And I enter data in CRF and save
	#|Field                                              |Data                                                           |                                                                     
	#|<DateField	                                     |03 25 1995  	                                                 |                                                                  
	#|Text Field>(underlined) 	                         |data3     	                                                 |                                                                  
	#|<(underlined)File Upload Field                     |do not upload				                                     |                                                              
	#|>DropDownField1                                    |&lt															 |								                                
	#|>DropDownField2                                    |&gt															 |								                                
	#|>DropDownField3                                    |&ge															 |								                                
	#|>DropDownField4                                    |&ge;															 |								                                
	#|>DropDownField5                                    |&le															 |								                                
	#|>DropDownField6                                    |&le;															 |								                                
	#|>DropDownField7                                    |bullet points <li>											 |									                            
	#|>DropDownField8                                    |<br/>break													 |									                            
	#|Long Text>(underlined) Field                       |&lt&gt&ge&ge;&le&le;bullet points<li><br/>breakcccccccccc789	 |																
	#|<(underlined)TextField1                            |1.1&lt                 										 |																
	#|<(underlined)TextField2                            |2.2&gt                 										 |																
	#|<(underlined)TextField3                            |3.3&ge                 										 |																
	#|<(underlined)TextField4                            |4.4&ge;			    										 |																
	#|<(underlined)TextField5                            |5.5&le			        									 |																
	#|<(underlined)TextField6                            |6.6&le;														 |																
	#|<(underlined)TextField7                            |7.7bullet points <li>											 |																
	#|<(underlined)TextField8                            |8.8<br/>break													 |																
	#|<(underlined)DSL Field                             |&lt&gt&ge&ge;&le&le;bullet points<li><br/>break0               |                                                              
	#|bullet points <li>Radio Button Field               |&lt                                                            |                                                                  
	#|(user hitting "enter")Radio Button Vertical Field  |&gt                                                            |                                                                  
	#|Search Field<                                      |&ge                                                            |                                                                  
	#|<(underlined)CheckBoxField1                        |true  	                                                     |                                                                  
	#|>(underlined)Signature Field                       |defuser password                                               | 

	#And I select Form "PDF Lab Form"
	#And I select Lab "US12175 Lab"
	#And I enter data in CRF and save
	#|Field                                                                                                     |Data  |                                                                   
	#|WBC<>>(underlined)>(underlined)<(underlined)<(underlined)bullet points <li>(user hitting "enter")	        |20    |
	#|<>>(underlined)>(underlined)<(underlined)<(underlined)bullet points <li>(user hitting "enter")NEUTROPHILS	|45    | 	

	#And I navigate to "Home"
	When I navigate to "PDF Generator" module
#*******************************************************************************************************	
@release_2012.1.0
@US11043A
@Draft  
Scenario: @US11043A A blank PDF that is generated should properly display special characters.
An annotated Blank PDF that is generated should properly display special characters. 
This should be tested for each possible font combination (english & Japanese fonts)
This should be tested with all 4 forms

	When I create Blank PDF
		| Name						  | Profile				| Study					| Role         | Locale  | CRFVersion    |
		| Blank PDF A{RndNum<num>(3)} | PDF 1               | PDF Font Study (Prod) | CDM1B144V1   | English | 6 (284)	     |
	And I generate Blank PDF "Blank PDF A{Var(num)}"
	And I wait for PDF "Blank PDF A{Var(num)}" to complete
	When I View Blank PDF "Blank PDF A{Var(num)}"
	Then the text should not contain "<Symbol>"
        |Symbol         |
        |&gt            |
        |&ge            |
        |&ge;           |
        |&lt            |
        |&le            |
		|&le;           |
        |&lt;li&gt;     |
        |&lt;br&gt;     |

@release_2012.1.0
@US11043B
@Draft  
Scenario: @US11043B A blank PDF that is generated should properly display special characters.
An annotated Blank PDF that is generated should properly display special characters.
This should be tested for each possible font combination (english & Japanese fonts)
This should be tested with all 4 forms

	When I create Blank PDF
		| Name						  | Profile				| Study					| Role         | Locale  | CRFVersion    |
		| Blank PDF B{RndNum<num>(3)} | PDF 2               | PDF Font Study (Prod) | CDM1B144V1   | English | 6 (284)	     |
	And I generate Blank PDF "Blank PDF B{Var(num)}"
	And I wait for PDF "Blank PDF B{Var(num)}" to complete
	When I View Blank PDF "Blank PDF B{Var(num)}"
	Then the text should not contain "<Symbol>"
        |Symbol         |
        |&gt            |
        |&ge            |
        |&ge;           |
        |&lt            |
        |&le            |
		|&le;           |
        |&lt;li&gt;     |
        |&lt;br&gt;     |
	
@release_2012.1.0
@US11043C
@Draft  
Scenario: @US11043C A blank PDF that is generated should properly display special characters.
An annotated Blank PDF that is generated should properly display special characters. 
This should be tested for each possible font combination (english & Japanese fonts)
This should be tested with all 4 forms

	When I create Blank PDF
		| Name						  | Profile				| Study					| Role         | Locale  | CRFVersion    |
		| Blank PDF C{RndNum<num>(3)} | PDF 3               | PDF Font Study (Prod) | CDM1B144V1   | English | 6 (284)	     |
	And I generate Blank PDF "Blank PDF C{Var(num)}"
	And I wait for PDF "Blank PDF C{Var(num)}" to complete
	When I View Blank PDF "Blank PDF C{Var(num)}"
	Then the text should not contain "<Symbol>"
        |Symbol         |
        |&gt            |
        |&ge            |
        |&ge;           |
        |&lt            |
        |&le            |
		|&le;           |
        |&lt;li&gt;     |
        |&lt;br&gt;     |

@release_2012.1.0
@US11043D
@Draft  
Scenario: @US11043D A blank PDF that is generated should properly display special characters.
An annotated Blank PDF that is generated should properly display special characters. 
This should be tested for each possible font combination (english & Japanese fonts)
This should be tested with all 4 forms

	When I create Blank PDF
		| Name						  | Profile				| Study					| Role         | Locale   | CRFVersion    |
		| Blank PDF D{RndNum<num>(3)} | PDF 4               | PDF Font Study (Prod) | CDM1B144V1   | Japanese | 6 (284)	      |
	And I generate Blank PDF "Blank PDF D{Var(num)}"
	And I wait for PDF "Blank PDF D{Var(num)}" to complete
	When I View Blank PDF "Blank PDF D{Var(num)}"
	Then the text should not contain "<Symbol>"
        |Symbol         |
        |&gt            |
        |&ge            |
        |&ge;           |
        |&lt            |
        |&le            |
		|&le;           |
        |&lt;li&gt;     |
        |&lt;br&gt;     |

@release_2012.1.0
@US11043E
@Draft  
Scenario: @US11043E A blank PDF that is generated should properly display special characters.
An annotated Blank PDF that is generated should properly display special characters. 
This should be tested for each possible font combination (english & Japanese fonts)
This should be tested with all 4 forms

	When I create Blank PDF
		| Name						  | Profile				| Study					| Role         | Locale   | CRFVersion    |
		| Blank PDF E{RndNum<num>(3)} | PDF 5               | PDF Font Study (Prod) | CDM1B144V1   | Japanese | 6 (284)	      |
	And I generate Blank PDF "Blank PDF E{Var(num)}"
	And I wait for PDF "Blank PDF E{Var(num)}" to complete
	When I View Blank PDF "Blank PDF E{Var(num)}"
	Then the text should not contain "<Symbol>"
        |Symbol         |
        |&gt            |
        |&ge            |
        |&ge;           |
        |&lt            |
        |&le            |
		|&le;           |
        |&lt;li&gt;     |
        |&lt;br&gt;     |	
	
@release_2012.1.0
@US11043F
@Draft  
Scenario: @US11043F A data-populated PDF that is generated should properly display special characters
An annotated Data PDF that is generated should properly display special characters.
This should be tested for each possible font combination (english & Japanese fonts)
This should be tested with all 4 forms

	When I create Data PDF
		| Name						  | Profile				| Study					| Role         | Locale  |Site Groups| Sites           |Subjects      |
		| Data PDF A{RndNum<num>(3)}  | PDF 1               | PDF Font Study (Prod) | CDM1B144V1   | English |World      | PDF Font Site 1 |Sub{Var(num1)}|
	And I generate Data PDF "Data PDF A{Var(num)}"
	And I wait for PDF "Data PDF A{Var(num)}" to complete
	When I View Data PDF "Data PDF A{Var(num)}"
	Then the text should not contain "<Symbol>"
        |Symbol         |
        |&gt            |
        |&ge            |
        |&ge;           |
        |&lt            |
        |&le            |
		|&le;           |
        |&lt;li&gt;     |
        |&lt;br&gt;     |	
	
@release_2012.1.0
@US11043G
@Draft  
Scenario: @US11043G A data-populated PDF that is generated should properly display special characters
An annotated Data PDF that is generated should properly display special characters.
This should be tested for each possible font combination (english & Japanese fonts)
This should be tested with all 4 forms

	When I create Data PDF
		| Name						  | Profile				| Study					| Role         | Locale  |Site Groups| Sites           |Subjects      |
		| Data PDF B{RndNum<num>(3)}  | PDF 2               | PDF Font Study (Prod) | CDM1B144V1   | English |World      | PDF Font Site 1 |Sub{Var(num1)}|
	And I generate Data PDF "Data PDF B{Var(num)}"
	And I wait for PDF "Data PDF B{Var(num)}" to complete
	When I View Data PDF "Data PDF B{Var(num)}"
	Then the text should not contain "<Symbol>"
        |Symbol         |
        |&gt            |
        |&ge            |
        |&ge;           |
        |&lt            |
        |&le            |
		|&le;           |
        |&lt;li&gt;     |
        |&lt;br&gt;     |	

@release_2012.1.0
@US11043H
@Draft  
Scenario: @US11043H A data-populated PDF that is generated should properly display special characters
An annotated Data PDF that is generated should properly display special characters.
This should be tested for each possible font combination (english & Japanese fonts)
This should be tested with all 4 forms

	When I create Data PDF
		| Name						  | Profile				| Study					| Role         | Locale  |Site Groups| Sites           |Subjects      |
		| Data PDF C{RndNum<num>(3)}  | PDF 3               | PDF Font Study (Prod) | CDM1B144V1   | English |World      | PDF Font Site 1 |Sub{Var(num1)}|
	And I generate Data PDF "Data PDF C{Var(num)}"
	And I wait for PDF "Data PDF C{Var(num)}" to complete
	When I View Data PDF "Data PDF C{Var(num)}"
	Then the text should not contain "<Symbol>"
        |Symbol         |
        |&gt            |
        |&ge            |
        |&ge;           |
        |&lt            |
        |&le            |
		|&le;           |
        |&lt;li&gt;     |
        |&lt;br&gt;     |

@release_2012.1.0
@US11043I
@Draft  
Scenario: @US11043I A data-populated PDF that is generated should properly display special characters
An annotated Data PDF that is generated should properly display special characters.
This should be tested for each possible font combination (english & Japanese fonts)
This should be tested with all 4 forms

	When I create Data PDF
		| Name						  | Profile				| Study					| Role         | Locale  |Site Groups| Sites           |Subjects      |
		| Data PDF D{RndNum<num>(3)}  | PDF 4               | PDF Font Study (Prod) | CDM1B144V1   | English |World      | PDF Font Site 1 |Sub{Var(num1)}|
	And I generate Data PDF "Data PDF D{Var(num)}"
	And I wait for PDF "Data PDF D{Var(num)}" to complete
	When I View Data PDF "Data PDF D{Var(num)}"
	Then the text should not contain "<Symbol>"
        |Symbol         |
        |&gt            |
        |&ge            |
        |&ge;           |
        |&lt            |
        |&le            |
		|&le;           |
        |&lt;li&gt;     |
        |&lt;br&gt;     |

@release_2012.1.0
@US11043J
@Draft  
Scenario: @US11043J A data-populated PDF that is generated should properly display special characters
An annotated Data PDF that is generated should properly display special characters.
This should be tested for each possible font combination (english & Japanese fonts)
This should be tested with all 4 forms

	When I create Data PDF
		| Name						  | Profile				| Study					| Role         | Locale  |Site Groups| Sites           |Subjects      |
		| Data PDF E{RndNum<num>(3)}  | PDF 5               | PDF Font Study (Prod) | CDM1B144V1   | English |World      | PDF Font Site 1 |Sub{Var(num1)}|
	And I generate Data PDF "Data PDF E{Var(num)}"
	And I wait for PDF "Data PDF E{Var(num)}" to complete
	When I View Data PDF "Data PDF E{Var(num)}"
	Then the text should not contain "<Symbol>"
        |Symbol         |
        |&gt            |
        |&ge            |
        |&ge;           |
        |&lt            |
        |&le            |
		|&le;           |
        |&lt;li&gt;     |
        |&lt;br&gt;     |	