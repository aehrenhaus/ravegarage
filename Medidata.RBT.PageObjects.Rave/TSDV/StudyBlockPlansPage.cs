using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium.Support.PageObjects;
using OpenQA.Selenium;
using OpenQA.Selenium.Remote;
using Medidata.RBT.SeleniumExtension;
using TechTalk.SpecFlow;
using OpenQA.Selenium.Support.UI;

namespace Medidata.RBT.PageObjects.Rave
{
    public class StudyBlockPlansPage : BlockPlansPageBase
    {
        public override string URL
        {
            get
            {
                return "Modules/Reporting/TSDV/EnvironmenttBlockPlans.aspx";
            }
        }


    }
}
