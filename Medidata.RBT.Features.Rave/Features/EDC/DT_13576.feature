# Edit check 'sets subject to require signature' behaves inconsistently if the value for the field it is assigned to got changed to the value it should not fire. 
# 1. The edit check fired and set the subject to requires signature based on entered value for the field it is assigned to. 
# 2. Subject was signed
# 3. The value for the field got changed to the value the edit check should not set the subject to requires signature.
# You will not see the signature prompt anywhere, but the subject will requires signature in its summary.
# And the report will display the subject as requires signature.

Feature: DT 13576 Edit Check 'sets subject to require signature' unexpectedly sets subject to req. signature in its summary on the value change, but there are no forms that are required signature.
	As a Rave user
	Given I enter data
	And there is an edit check that sets the data to requires signature
	And I should see the requires signature for the data

Background:
Create 2 forms: Demograhics form set up with edit check less than 18.
Medical History form set up with (Yes/No) data dictionary associated to an edit check for "Y" value. 

    #Given user "defuser"  has study "13576 Study" has site "Site 1"
	#And study "13576 Study" has draft "Draft 1"
	#And form "Enrollment" has varOID "<VarOID>" has format "<Format>" has data dictionary "<Dictionary>" has Unit dictionary "<Unit Dictionary>" has field name "<Field Name>" has field OID "<Field OID>" has status "<Active>" has visible status "<Is Visible Field>" has log data entry "<Log Data Entry>" has field label "<Field Label>" has control type "<Control Type>" has value "<Edit Checks>"
	#	|VarOID		              |Format		  |Dictionary	  |Unit Dictionary	|Field Name		          |Field OID		        |Active		|Is Visible Field 	|Log Data Entry	|Field Label                                        |Control Type          |Edit Checks 	|
	#	|SUBJ_INIT	              |$3	          |               |					|SUBJ_INIT		          |SUBJ_INIT		        |true		|true				|			    |Subject Initials 	                                |Text 	               |		    	|
	#	|SUBJ_NUM	              |$5	          |               |					|SUBJ_NUM		          |SUBJ_NUM		            |true		|true				|			    |Subject Number 	                                |Text 	               |		    	|
	#	|SUBJ_ID	              |$8	          |               |					|SUBJ_ID		          |SUBJ_ID		            |true		|true				|			    |Subject ID 	                                    |Text 	               |		    	|

	#And form "Demographics" has varOID "<VarOID>" has format "<Format>" has data dictionary "<Dictionary>" has Unit dictionary "<Unit Dictionary>" has field name "<Field Name>" has field OID "<Field OID>" has status "<Active>" has visible status "<Is Visible Field>" has log data entry "<Log Data Entry>" has field label "<Field Label>" has control type "<Control Type>" has value "<Edit Checks>"
	#	|VarOID		              |Format		  |Dictionary	  |Unit Dictionary	|Field Name		          |Field OID		        |Active		|Is Visible Field 	|Log Data Entry	|Field Label                                        |Control Type          |Edit Checks 	|
	#	|AGE1	                  |2	          |               |					|AGE1		              |AGE1    		            |true		|true				|			    |Age	                                            |Text     	           |EC1		    	|
	#	|VISITDATE	              |dd MMM yyyy    |               | 				|VISITDATE	              |VISITDATE	            |true		|true				|			    |Visit Date                                         |DateTime    	       |EC1      		|

	#And form "Medical History" has varOID "<VarOID>" has format "<Format>" has data dictionary "<Dictionary>" has Unit dictionary "<Unit Dictionary>" has field name "<Field Name>" has field OID "<Field OID>" has status "<Active>" has visible status "<Is Visible Field>" has log data entry "<Log Data Entry>" has field label "<Field Label>" has control type "<Control Type>" has value "<Edit Checks>"
	#	|VarOID		              |Format		  |Dictionary	  |Unit Dictionary	|Field Name		          |Field OID		        |Active		|Is Visible Field 	|Log Data Entry	|Field Label                                                                   |Control Type           |Edit Checks 	|
	#	|FIELD1	                  |$3	          |Yes/No         |					|FIELD1		              |FIELD1		            |true		|true				|			    |Does the subject have a known history of an abnormality, disease or surgery?  |DropDownList 	       |EC2		    	|
		
	#And data dictionary "Yes/No" has entries
	#	|User Data String       |Coded Data         |
	#	|Yes		            |Y		            |
	#	|No 		            |N		            |
	
	#And Matrices "Baseline" has Folder Forms
	#	|Forms            |Subject   |
	#	|Enrollment	      |True		 |
	#	|Demographics     |True      |
	#	|Medical History  |True      |
	
	#And has "EC1" and "EC2" Edit Checks

    #|EC1|True|False
    #
    #||StandardValue|AGE1||FRM1|AGE1|||||
    #|18|2|||||||||
    #IsLessThan|||||||||||
    #
    #|FRM1|AGE1|AGE1||||SetSubjectRequiresSignature|Age must be greater than or equal to 18 and less than or equal to 65. Please verify.||
    #|FRM1|VISITDATE|VISITDATE||||SetSubjectRequiresSignature|||

    #|EC2|True|False
    #
    #||StandardValue|FIELD1||FRM2|FIELD1|0||||
    #|Y|$3|||||||||
    #IsEqualTo|||||||||||
    #
    #|FRM2|FIELD1|FIELD1|0|||SetSubjectRequiresSignature|||
	
	Given I am logged in to Rave with username "defuser" and password "password"
	#And study "13576 Study" has role "Role1"
    #And Role "Role1" has Actions "Entry" and "Sign"
	#And I publish and push "CRF Version<RANDOMNUMBER>" to site "13576 Study"
	#And I note "CRF Version"
					
@PB-DT13576-01
Scenario: @PB-DT13576-01 As an EDC user, when I have an edit check that sets a subject to require signature, and I sign, and I change data such that the subject no longer requires signature, then I should not see a task that requires signature for the subject in the task summary.
Demograhics form set up with edit check less than 18.
  
  And I navigate to study "13576 Study", site "Site 1"
  And I create a Subject
    |Field               |Data              |Control Type |
    |Subject Initials    |SUB               |textbox      |
    |Subject Number      |{RndNum<num1>(5)} |textbox      |
    |Subject ID 	     |SUB {Var(num1)}   |textbox      |
  And I select link "Demograhics"
  And I enter data in CRF and save
    |Field      |Data           |Control Type |
    |Age        |20             |textbox      |
    |Visit Date |01 Jan 2012    |datetime     |
  And I verify data in CRF
	|Field      |Value        |Requires Signature |
	|Age        |20           |False              |
	|Visit Date |01 Jan 2012  |False              |
  And I can not see "Sign and Save" button
  And I take a screenshot
  And I select link "SUB {Var(num1)}"
  And I can not see "Sign and Save" button
  And I expand "Requiring Signature" in Task Summary
  And I verify the task summary
	|Task Summary: Subject  |Pages |
	|Requiring Signature    |0     |
  And I take a screenshot	
  And I select link "Demograhics" 
  And I enter data in CRF and save
    |Field      |Data           |Control Type |
    |Age        |17             |textbox      |
  And I verify data in CRF
	|Field      |Value        |Requires Signature |
	|Age        |17           |True               |
	|Visit Date |01 Jan 2012  |True               |
  And I can see "Sign and Save" button	
  And I take a screenshot	
  And I select link "SUB {Var(num1)}"	
  And I can see "Sign and Save" button		
  And I expand "Requiring Signature" in Task Summary	
  And I verify the task summary
	|Task Summary: Subject  |Pages |
	|Requiring Signature    |2     |
  And I take a screenshot
  And I sign the subject with username "defuser" and password "password"
  And I verify message is displayed "Signature attempt was successful"
  And I expand "Requiring Signature" in Task Summary	
  And I verify the task summary
	|Task Summary: Subject  |Pages |
	|Requiring Signature    |0     |
  And I take a screenshot 
  And I select link "Demograhics" 
  And I enter data in CRF and save
    |Field      |Data           |Control Type |
    |Age        |21             |textbox      |	
  And I verify data in CRF
	|Field      |Value        |Requires Signature |
	|Age        |21           |False              |
	|Visit Date |01 Jan 2012  |False              |
  And I can not see "Sign and Save" button	
  And I take a screenshot
  And I select link "SUB {Var(num1)}"
  And I can not see "Sign and Save" button
  And I expand "Requiring Signature" in Task Summary
  And I verify the task summary
	|Task Summary: Subject  |Pages |
	|Requiring Signature    |0     |
  And I take a screenshot	
  And I select link "Site 1"
  And I expand "Requiring Signature" in Task Summary
  And I verify the task summary
	|Task Summary: Site     |Pages |
	|Requiring Signature    |0     |
  And I take a screenshot	

@PB-DT13576-02
Scenario: @PB-DT13576-02 As an EDC user, when I have an edit check associated to data dictionary that sets a subject to require signature, and I sign, and I change data such that the subject no longer requires signature, then I should not see a task that requires signature for the subject in the task summary.
Medical History form set up with (Yes/No) data dictionary associated to an edit check for "Y" value.  
  
  And I create a Subject
    |Field               |Data              |Control Type |
    |Subject Initials    |SUB               |textbox      |
    |Subject Number      |{RndNum<num1>(5)} |textbox      |
    |Subject ID 	     |SUB {Var(num1)}   |textbox      |
  And I select link "Medical History"
  And I enter data in CRF and save
    |Field                                                                           |Data    |Control Type   |
    |Does the subject have a known history of an abnormality, disease or surgery?    |No      |dropdownlist   |
  And I verify data in CRF
	|Field                                                                           |Value   |Requires Signature |
    |Does the subject have a known history of an abnormality, disease or surgery?    |No      |False              |
  And I can not see "Sign and Save" button
  And I take a screenshot
  And I select link "SUB {Var(num1)}"
  And I can not see "Sign and Save" button
  And I expand "Requiring Signature" in Task Summary
  And I verify the task summary
	|Task Summary: Subject  |Pages |
	|Requiring Signature    |0     |
  And I take a screenshot	
  And I select link "Medical History" 
  And I enter data in CRF and save
    |Field                                                                           |Data   |Control Type   |
    |Does the subject have a known history of an abnormality, disease or surgery?    |Yes    |dropdownlist   |
  And I verify data in CRF
	|Field                                                                           |Value  |Requires Signature |
    |Does the subject have a known history of an abnormality, disease or surgery?    |Yes    |True               |
  And I can see "Sign and Save" button	
  And I take a screenshot	
  And I select link "SUB {Var(num1)}"	
  And I can see "Sign and Save" button		
  And I expand "Requiring Signature" in Task Summary	
  And I verify the task summary
	|Task Summary: Subject  |Pages |
	|Requiring Signature    |2     |
  And I take a screenshot
  And I sign the subject with username "defuser" and password "password"
  And I verify message is displayed "Signature attempt was successful"
  And I expand "Requiring Signature" in Task Summary	
  And I verify the task summary
	|Task Summary: Subject  |Pages |
	|Requiring Signature    |0     |
  And I take a screenshot 
  And I select link "Medical History" 
  And I enter data in CRF and save
    |Field                                                                           |Data   |Control Type   |
    |Does the subject have a known history of an abnormality, disease or surgery?    |No     |dropdownlist   |
  And I verify data in CRF
	|Field                                                                           |Value  |Requires Signature |
    |Does the subject have a known history of an abnormality, disease or surgery?    |No     |False              |
  And I can not see "Sign and Save" button	
  And I take a screenshot
  And I select link "SUB {Var(num1)}"
  And I can not see "Sign and Save" button
  And I expand "Requiring Signature" in Task Summary
  And I verify the task summary
	|Task Summary: Subject  |Pages |
	|Requiring Signature    |0     |
  And I take a screenshot	
  And I select link "Site 1"
  And I expand "Requiring Signature" in Task Summary
  And I verify the task summary
	|Task Summary: Site     |Pages |
	|Requiring Signature    |0     |
  And I take a screenshot 
