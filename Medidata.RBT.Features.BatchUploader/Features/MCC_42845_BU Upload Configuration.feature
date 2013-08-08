Feature: Batch Upload - Upload Configuration

Background:

	 Given I am an Rave user "<Rave User>" with username "<Rave User Name>", password "<Rave Password>" and email "<Rave Email>"
		|Rave User		|Rave User Name		|Rave Password		|Rave Email		|
		|{Rave User 1}	|{Rave User Name 1}	|{Rave Password 1}	|{Rave Email 1}	|.
	    
	And there exists Rave study "<Rave Study>" 
		|{Study A}	|
   
    And there exists site "<Site>" in study "<Study>", with environment "<Environment>"	and CRF version "<CRF>" in iMedidata and with Study-Site number "<StudySiteNo>"	
		|Study		|Site		|Environment	|StudySiteNo	|CRF			|
		|{Study A}	|{Site A1}	|{Env 1}		|{StudySiteNo1}	|{Crf Ver 1}	|
		|{Study A}	|{Site A1}	|{Env 1}		|{StudySiteNo1}	|{Crf Ver 2}	|

    And there exists a BU configuration file "<BU Configuration File>" to be uploaded in study "<Study>" on the BUUI with the worksheet "Advanced" entries "Ignore Keys for Record Reference"  for "Priority"
		|BU Configuration File	|Study		|Ignore Keys for Record Reference	|Priority	|
		|{BU Config 1}			|{Study A}	|"true"								|0			|
		|{BU Config 2}			|{Study A}	|"false"							|0			|
		|{BU Config 3}			|{Study A}	|"true"								|1			|
		|{BU Config 4}			|{Study A}	|"false"							|1			|
		|{BU Config 5}			|{Study A}	|"true"								|2			|
		|{BU Config 6}			|{Study A}	|"false"							|2			|

#--------------------------------------------------------------------------------------------------------------------------------------

@Scenario MCC42845-01
@Validation
Scenario outline: When a configuration for a BU project is uploaded and the worksheet "Advanced" has entry "true" or "false" for "Ignore Keys for Record Reference" and a numerical entry  for "Priority", the user will see in the BUUI that the parameters for Advanced will be "Ignore Keys for Record Reference" and Priority are correct

Given I am a Rave user "<Rave User 1>" with Rave Email "<Rave Email 1>"

And I am logged in to the Batch Upload UI
And I select project "<Study A>"
And I select link "Upload Configuration"
And I select button "Browse"
And I select "<BU Configuration File>"
	|BU Configuration File	|
	|{BU Config 1}			|
	|{BU Config 2}			|
	|{BU Config 3}			|
	|{BU Config 4}			|
	|{BU Config 5}			|
	|{BU Config 6}			|
And I select button "Upload"

And I select link "<BU Configuration>"
	|BU Configuration		|
	|{BU Config 1}			|
	|{BU Config 2}			|
	|{BU Config 3}			|
	|{BU Config 4}			|
	|{BU Config 5}			|
	|{BU Config 6}			|


And I select link "<Advanced>"
And verify entry "<Ignore Keys for Record Reference>" and entry "<Priority>" for configuration "<Configuration>
|Configuration 			|Ignore Keys for Record Reference	|Priority	|
|{BU Config 1}			|checked							|0			|
|{BU Config 2}			|unchecked							|0			|
|{BU Config 3}			|checked							|1			|
|{BU Config 4}			|unchecked							|1			|
|{BU Config 5}			|checked							|2			|
|{BU Config 6}			|unchecked							|2			|

And I take a screenshot
