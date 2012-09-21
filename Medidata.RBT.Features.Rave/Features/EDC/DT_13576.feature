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

Given I login to Rave with user "defuser"
Given xml draft "13576_Study_A.xml" is Uploaded
Given xml draft "13576 Study B.xml" is Uploaded
Given Site "Site_A" exists
Given Site "Site_B" exists
Given study "13576 Study A" is assigned to Site "Site_A"
Given study "13576 Study B" is assigned to Site "Site_B"
Given role "SUPER ROLE 1" exists
Given I publish and push eCRF "13576 Study A.xml" to "Version 1"
Given I publish and push eCRF "13576 Study B.xml" to "Version 2"
Given following Project assignments exist
|User         |Project        | Environment | Role         | Site   |SecurityRole          |
|SUPER USER 1 |13576 Study A  | Live: Prod  | SUPER ROLE 1 | Site_A |Project Admin Default |
|SUPER USER 1 |13576 Study B  | Live: Prod  | SUPER ROLE 1 | Site_B |Project Admin Default |
Given I login to Rave with user "SUPER USER 1"

#Note: Study "13576 Study A" is set up with an edit check "If Age field in Demographics form IsLessThan 18 then set Subject to Requires Signature on Age and Visit Date fields on the Demographics form"
#Note: Study "13576 Study A" is set up with an edit check "If Does the subject have a known history of an abnormality, disease or surgery? field in Medical History with record position 0 IsEqualTo Yes then set Subject to Requires Signature" 
#Note: Study "13576 Study B" is set up with an edit check "If Enrollment Date field in Enrollment form IsNotEmpty Or Stop Date field in AE form IsNotEmpty then set Subject to Requires Signature"

@Release_2012.1.0
@WIP
@PB-DT13576-01
Scenario: As an EDC user, when I have an edit check that sets a subject to require signature, and I sign, and I change data such that the subject no longer requires signature, then I should not see a task that requires signature for the subject in the task summary.

  And I navigate to study "13576 Study A", site "Site_A"
  And I create a Subject
    |Field               |Data              |Control Type |
    |Subject Initials    |SUB               |textbox      |
    |Subject Number      |{RndNum<num1>(3)} |textbox      |
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
  And I select link "Site_A"
  And I expand "Requiring Signature" in Task Summary
  And I verify the task summary
	|Task Summary: Site     |Pages |
	|Requiring Signature    |0     |
  And I take a screenshot	

@Release_2012.1.0
@WIP
@PB-DT13576-02
Scenario: As an EDC user, when I have an edit check associated to data dictionary that sets a subject to require signature, and I sign, and I change data such that the subject no longer requires signature, then I should not see a task that requires signature for the subject in the task summary. 

  And I create a Subject
    |Field               |Data              |Control Type |
    |Subject Initials    |SUB               |textbox      |
    |Subject Number      |{RndNum<num1>(3)} |textbox      |
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
  And I select link "Site_B"
  And I expand "Requiring Signature" in Task Summary
  And I verify the task summary
	|Task Summary: Site     |Pages |
	|Requiring Signature    |0     |
  And I take a screenshot 
  
@Release_2012.1.0
@WIP
@PB-DT13576-03
Scenario: As an EDC user, when I have an edit check that sets a subject to require signature on two forms and I change data such that the subject no longer requires signature on first form, then I should see a task that requires signature on both forms for the subject in the task summary.

And I navigate to study "13576 Study B", site "Site_B"
  And I create a Subject
    |Field               |Data              |Control Type |
    |Subject Initials    |SUB               |textbox      |
    |Subject Number      |{RndNum<num1>(3)} |textbox      |
    |Subject ID 	     |SUB {Var(num1)}   |textbox      |
  And I select link "Enrollment"
  And I enter data in CRF and save
    |Field                  |Data           |Control Type |
    |Enrollment Date        |01 Jan 2012    |datetime     |
  And I verify data in CRF
	|Field                  |Value          |Requires Signature |
	|Enrollment Date        |01 Jan 2012    |False              |
  And I can not see "Sign and Save" button
  And I take a screenshot
  And I select link "SUB {Var(num1)}"
  And I select link "AE"
  And I enter data in CRF and save
    |Field                  |Data             |Control Type    |
    |Was there any AE's?    |Yes              |dropdownlist    |
    |Start Date             |05 Jan 2012      |datetime        |
	|Stop Date              |25 Jan 2012      |datetime        |
  And I verify data in CRF
	|Field                  |Value         |Requires Signature |
    |Was there any AE's?    |Yes           |True               |
	|Start Date             |05 Jan 2012   |True               |
	|Stop Date              |25 Jan 2012   |True               |
  And I can see "Sign and Save" button
  And I take a screenshot
  And I select link "SUB {Var(num1)}"
  And I can see "Sign and Save" button
  And I expand "Requiring Signature" in Task Summary
  And I verify the task summary
	|Task Summary: Subject  |Pages |
	|Requiring Signature    |3     |
  And I take a screenshot
  And I select link "Enrollment"
  And I enter data in CRF and save
    |Field                  |Data           |Control Type    |
    |Enrollment Date        |               |datetime        |
  And I verify data in CRF
	|Field                  |Value          |Requires Signature |
	|Enrollment Date        |               |True               |
  And I can see "Sign and Save" button
  And I take a screenshot
  And I select link "SUB {Var(num1)}"
  And I can see "Sign and Save" button
  And I expand "Requiring Signature" in Task Summary
  And I verify the task summary
	|Task Summary: Subject  |Pages |
	|Requiring Signature    |3     |
  And I take a screenshot
  And I select link "AE"
  And I enter data in CRF and save
    |Field                  |Data             |Control Type    |
	|Stop Date              |                 |datetime        |
  And I verify data in CRF
	|Field                  |Value         |Requires Signature |
    |Was there any AE's?    |Yes           |False              |
	|Start Date             |05 Jan 2012   |False              |
    |Stop Date              |              |False              |
  And I can not see "Sign and Save" button
  And I take a screenshot
  And I select link "SUB {Var(num1)}"
  And I can not see "Sign and Save" button
  And I expand "Requiring Signature" in Task Summary
  And I verify the task summary
	|Task Summary: Subject  |Pages |
	|Requiring Signature    |0     |
  And I take a screenshot 
  And I select link "Enrollment"
  And I enter data in CRF and save
    |Field                  |Data           |Control Type |
    |Enrollment Date        |02 Jan 2012    |datetime     |
  And I verify data in CRF
	|Field                  |Value          |Requires Signature |
	|Enrollment Date        |02 Jan 2012    |True               |
  And I can see "Sign and Save" button
  And I take a screenshot
  And I select link "AE"
  And I verify data in CRF
	|Field                  |Value         |Requires Signature |
    |Was there any AE's?    |Yes           |True               |
	|Start Date             |05 Jan 2012   |True               |
    |Stop Date              |              |True               |
  And I can see "Sign and Save" button
  And I take a screenshot
  And I select link "SUB {Var(num1)}"
  And I can see "Sign and Save" button
  And I expand "Requiring Signature" in Task Summary
  And I verify the task summary
	|Task Summary: Subject  |Pages |
	|Requiring Signature    |3     |
 And I take a screenshot