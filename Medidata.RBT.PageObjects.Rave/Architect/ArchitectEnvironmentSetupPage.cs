using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium.Support.PageObjects;
using OpenQA.Selenium;
using OpenQA.Selenium.Remote;
using Medidata.RBT.SeleniumExtension;

namespace Medidata.RBT.PageObjects.Rave
{
    public class ArchitectEnvironmentSetupPage : ArchitectBasePage
    {

        public override string URL
        {
            get
            {
                return "Modules/Architect/EnviornmentSetup.aspx";
            }
        }
        /// <summary>
        /// This method will add a new user environment if an 
        /// environment with the same name already does not exist
        /// </summary>
        /// <param name="envName"></param>
        /// <returns></returns>
        public IPage AddNewEnvironment(string envName)
        {
            var elems = Browser.FindElementsByPartialId("lblEnvName");
            bool envNameExist = false; 

            if (elems.Count > 0)
            {
                foreach (var elem in elems)
                {
                    if (elem.Text.Equals(envName))
                    {
                        envNameExist = true;
                        break;
                    }
                }
            }

            if (!envNameExist)
            {
                this.ClickLink("Add New");
                var envNameElem = Browser.TryFindElementByPartialID("txtName");
                envNameElem.EnhanceAs<Textbox>().SetText(envName);

                var updateElem = envNameElem.Parent().Parent().TryFindElementByPartialID("imgUpdate");
                updateElem.Click();
            }
            return this;
        }
    }
}
