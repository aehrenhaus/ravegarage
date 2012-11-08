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
    public class TiersPage : BlockPlansPageBase
    {

        public override string URL
        {
            get
            {
				return "Modules/Reporting/TSDV/Tiers.aspx";
            }
        }

	    public void RemoveTiers()
	    {
		    while (true)
		    {
				var ele = Browser.TryFindElementByPartialID("CustomTierDeleteLabel");
			    if (ele == null) 
					break;
			    ele.Click();

			    Browser.SwitchTo().Alert().Accept();
		    }
	    }
    }
}
