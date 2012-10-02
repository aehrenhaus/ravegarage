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
    public class CentralLabsPage : LabPageBase
    {

        public override string URL
        {
            get
            {
                return "Modules/LabAdmin/CentralLabsPage.aspx";
            }
        }


    }
}
