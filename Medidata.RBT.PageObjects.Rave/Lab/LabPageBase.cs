using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium.Support.PageObjects;
using OpenQA.Selenium;
using OpenQA.Selenium.Remote;
using TechTalk.SpecFlow;
using Medidata.RBT.SeleniumExtension;
using System.Collections.Specialized;
namespace Medidata.RBT.PageObjects.Rave
{
    public class LabPageBase : RavePageBase
    {

        public override IPage NavigateTo(string name)
        {
            //d.v. add reference.  
            NameValueCollection poClassMapping = new NameValueCollection();

            poClassMapping["Unit Conversions"] = "UnitConversionsPage";



            //TODO: other mappings

            var leftNavContainer = Browser.FindElementById("TblOuter");
            var link = leftNavContainer.TryFindElementBy(By.LinkText(" " + name));

            if (link == null)
                return base.NavigateTo(name);

            link.Click();
            string className = poClassMapping[name];
            return TestContext.POFactory.GetPage(className);
        }

    }
}
