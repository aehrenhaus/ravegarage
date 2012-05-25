Please see the latest decription of this project at:
	https://sites.google.com/a/mdsol.com/knowledgebase/home/departments/engineering/specflow/medidata-uat-kick-start

	
Solution layout:
	
	Medidata.UAT 
	This project is the basic project that contains utilities and base classes shared by other projects

	Medidata.UAT.Features.Rave 
	It contains feature files and step definitions for Rave
	There will be other projects for other products. Separating features for different products into different projects can reduce conflict of lingo.
	For example, 'I login as "User1" ' shall map to different actions in browser between Rave and iMedidata. If there are step definitions methods for both Rave and iMedidata matching the lingo, specflow will see it as conflict.

	Medidata.UAT.WebDrivers
	This project contains all the page objects. See the blow section for page objects.

	
Run test
	Specflow will convert feature files into a normal test method.( MsTest or nUnit according to configuration)
	So any test tools can that support these 2 kinds of test can run the compiled dll. (eg. see the above Gallio GUI test runner)
	In our case, it is configured to generate MSTest methods. So visual studio can recognize the test methods.

	
	
Step definitions
	Step definitions are just C# methods with Given When Then attribute(see the figure below)


	 [When(@"I login to Rave with username ""([^""]*)"" and password ""([^""]*)""")]
	 [Then(@"I login to Rave with username ""([^""]*)"" and password ""([^""]*)""")]
	 public void ILoginToRaveWithUsername____AndPassword____(string username, string passowrd)
	 {
	 ......
	 }

	When the test is run , the test method will ask specflow engine for a matched step definition method and execute.
	If no method matches, the test method will fail. If more the one match, test will also fail with a message saying multiple definitions found.

	At run time ,specflow will scan all the methods marked with Given When Then attribute. There is no restriction but should be conventions where you put your step definitions. I recommend to put step definition method related to EDC pages into CommonDECStep.cs . And those methods general enough for all rave pages into CommonRaveSteps. If some step is very specific in one feature file, you can of course put the step definition to a .cs file that has same name of the feature file.
	 
	Note that in cucumber, given when then are treated equally, you can use them interchangeably in your features and step definitions.  This is NOT true in specflow.
	Specflow treat Given When Then as different matches. So often you will have to repeat the match attribute in order for feature files to use them interchangeably.


Page objects pattern
	Operating web pages by automation is trick especially when the page is not well constructed.
	Some times you have to use some tricky and crispy filter to find out a control on the page. 

	For example, using the xpath "\\div[@class='articles']\p[position()=2]" to find out the 2nd p in the first div in DOM that has class='articles'

	This kind of filter is easy to break, but often the time you don't have a better way the locate the p control.
	We don't want this kind of code scattered in step definitions, so we need an other layer called Page Objects.
	Each page object class should represent a page, the methods should describe page level operations, and encapsulate the tricky work inside.

	Now step definitions can focus on what to do on the page instead of how to do on the page. Once the tricky filter breaks inside a page object class we will only fix the page object. It's much more controllable than without this layer.