using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium.Support.PageObjects;
using OpenQA.Selenium;
using OpenQA.Selenium.Remote;
using Medidata.RBT.SeleniumExtension;
using TechTalk.SpecFlow;

namespace Medidata.RBT.PageObjects.Rave
{
    public abstract class SubjectManagementPageBase : RavePageBase
	{


        public IPage FilterBySite(string sitename)
        {
            ChooseFromDropdown("Select Site", sitename);
            var search = GetElementByName("Search");
            search.Click();
            return this;
        }

       
	}
}
