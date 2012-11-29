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
            ChooseFromDropdown("Select Site", site.UniqueName);
           
           
            var search = GetElementByName("Search");
            search.Click();
            return this;
        }

		public override IWebElement GetElementByName(string identifier, string areaIdentifier = null, string listItem = null)
		{
			if (identifier == "Search")
				return Browser.FindElementById("_ctl0_Content_HeaderControl_SearchLabel");
			return base.GetElementByName(identifier, areaIdentifier, listItem);
		}


		public override IPage ChooseFromDropdown(string identifier, string text, string objectType = null, string areaIdentifier = null)
		{
			if (identifier == "Select Site")
			{
				var container = Browser.TryFindElementById("_ctl0_Content_HeaderControl_slSite").Parent();
				CompositeDropdown d = new CompositeDropdown(this, "DSL", container);
				d.TypeAndSelect(text);
				return this;
			}

			else if (identifier == "Select Site Group")
			{
				var container = Browser.TryFindElementById("_ctl0_Content_HeaderControl_slSiteGroup").Parent();
				CompositeDropdown d = new CompositeDropdown(this, "DSL", container);
				d.TypeAndSelect(text);
				return this;
			}
		

			return base.ChooseFromDropdown(identifier, text);
		}

        public IPage FilterBySiteGroup(string siteGroupName)
        {
            if (!(siteGroupName.ToLower().Equals("world") || siteGroupName.ToLower().Equals("all site groups")))
                siteGroupName = TestContext.GetExistingFeatureObjectOrMakeNew(siteGroupName, () => new SiteGroup(siteGroupName)).UniqueName;

            ChooseFromDropdown("Select Site Group", siteGroupName);
          
            var search = GetElementByName("Search");
            search.Click();
            return this;
        }

       
	}
}
