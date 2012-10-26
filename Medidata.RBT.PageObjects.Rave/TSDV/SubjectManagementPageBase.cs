using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium.Support.PageObjects;
using OpenQA.Selenium;
using OpenQA.Selenium.Remote;
using Medidata.RBT.SeleniumExtension;
using TechTalk.SpecFlow;
using Medidata.RBT.PageObjects.Rave.SharedRaveObjects;

namespace Medidata.RBT.PageObjects.Rave
{
    public abstract class SubjectManagementPageBase : RavePageBase
	{


        public IPage FilterBySite(string sitename)
        {
            Site site = TestContext.GetExistingFeatureObjectOrMakeNew(sitename, () => new Site(sitename));
            ChooseFromDropdown("Select Site", site.UniqueName + ": " + site.Number);
            var search = GetElementByName("Search");
            search.Click();
            return this;
        }

       
	}
}
