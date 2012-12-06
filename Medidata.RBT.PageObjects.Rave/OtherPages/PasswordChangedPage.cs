using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium.Support.PageObjects;
using OpenQA.Selenium;
using OpenQA.Selenium.Remote;
using Medidata.RBT.SeleniumExtension;
using System.Collections.Specialized;
namespace Medidata.RBT.PageObjects.Rave
{
	public class PasswordChangedPage : RavePageBase
	{
        public PasswordChangedPage()
		{
			PageFactory.InitElements(Browser, this);
		}

        public override IPage ClickLink(string linkText, string objectType = null, string areaIdentifier = null, bool partial = false)
        {
            try
            {
                base.ClickLink(linkText);
            }
            catch (Exception ex)
            {
                base.ClickLink("L" + linkText); //Adding localization support
            }
            if (linkText == "Click here to continue..." || linkText == "LClick here to continue...") //Adding localization test support
                TestContext.CurrentPage = new HomePage();
            return TestContext.CurrentPage;
        }

        public override string URL { get { return "PasswordChanged.aspx"; } }
	}
}
