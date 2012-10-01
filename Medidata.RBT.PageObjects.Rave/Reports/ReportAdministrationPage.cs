using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium.Support.PageObjects;
using OpenQA.Selenium;
using OpenQA.Selenium.Remote;
using System.Collections.Specialized;
using Medidata.RBT.SeleniumExtension;

namespace Medidata.RBT.PageObjects.Rave
{
    public class ReportAdministrationPage : RavePageBase
    {
        public override string URL
        {
            get
            {
                return "Modules/ReportAdmin/ReportManager.aspx";
            }
        }

        public override IPage NavigateTo(string name)
        {
            //d.v. add reference.  
            NameValueCollection poClassMapping = new NameValueCollection();

            poClassMapping["Report Assignment"] = "ReportAssignmentPage";



            //TODO: other mappings

            var leftNavContainer = Browser.FindElementById("TblOuter");
            var link = leftNavContainer.TryFindElementBy(By.LinkText(name));

            if (link == null)
                return base.NavigateTo(name);

            link.Click();
            string className = poClassMapping[name];
            return TestContext.POFactory.GetPage(className);
        }
    }
}
