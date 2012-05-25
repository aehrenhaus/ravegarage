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


Page objects pattern
Operating web pages by automation is trick especially when the page is not well constructed.
Some times you have to use some tricky and crispy filter to find out a control on the page. 

For example, using the xpath "\\div[@class='articles']\p[position()=2]" to find out the 2nd p in the first div in DOM that has class='articles'

This kind of filter is easy to break, but often the time you don't have a better way the locate the p control.
We don't want this kind of code scattered in step definitions, so we need an other layer called Page Objects.
Each page object class should represent a page, the methods should describe page level operations, and encapsulate the tricky work inside.

Now step definitions can focus on what to do on the page instead of how to do on the page. Once the tricky filter breaks inside a page object class we will only fix the page object. It's much more controllable than without this layer.