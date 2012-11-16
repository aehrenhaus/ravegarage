using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium.Support.PageObjects;
using OpenQA.Selenium;
using OpenQA.Selenium.Remote;
using System.Collections.Specialized;
using OpenQA.Selenium.Support.UI;
using Medidata.RBT.SeleniumExtension;
using Medidata.RBT.PageObjects.Rave.SharedRaveObjects;
using Medidata.RBT.PageObjects.Rave.UserAdministrator;
namespace Medidata.RBT.PageObjects.Rave
{
    public class UserActivationPage : RavePageBase
    {
        /// <summary>
        /// Get the activation code on the UserActivationPage
        /// </summary>
        /// <returns>The activation code IWebElement</returns>
        public IWebElement GetActivationCode()
        {
			return Browser.TryFindElementByPartialID("_ctl0_Content_ActCodeValueLabel");
        }

        public override string URL
        {
            get { return "Modules/UserAdmin/UserActivation.aspx"; }
        }
    }
}
