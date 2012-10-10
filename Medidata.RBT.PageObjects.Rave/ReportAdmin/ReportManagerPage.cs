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
	public class ReportManagerPage : RavePageBase
    {
        public override string URL
        {
            get
            {
                return "Modules/ReportAdmin/ReportManager.aspx";
            }
        }

     
    }
}
