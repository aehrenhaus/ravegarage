using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium.Support.PageObjects;
using OpenQA.Selenium;
using Medidata.RBT.PageObjects.Rave.SeedableObjects;
using Medidata.RBT.SeleniumExtension;
using TechTalk.SpecFlow;


namespace Medidata.RBT.PageObjects.Rave
{
    public class LabsPage : LabPageBase
    {
        public override string URL
        {
            get
            {
                return "Modules/LabAdmin/LabsPage.aspx";
            }
        }


              
    }
}
