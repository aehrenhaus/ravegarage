using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Medidata.RBT.SeleniumExtension;
using OpenQA.Selenium;

namespace Medidata.RBT
{
    public class GeneralPage : PageBase
    {
		public GeneralPage(WebTestContext context)
			: base(context)
		{
		}

        public override string URL
        {
            get { throw new NotImplementedException(); }
        }

        public override IWebElement GetElementByName(string identifier, string areaIdentifier = null, string listItem = null)
        {
            if (identifier == "Source")
                return base.Browser.TryFindElementByName("_ctl0:Content:VSWO1:Prev_Run_0:_ctl4");
            else if (identifier == "Destination")
                return base.Browser.TryFindElementByName("_ctl0:Content:VSWO1:Prev_Run_0:NonDParams:_ctl3");
            else if (identifier == "Live Update")
                return base.Browser.FindElementById("LiveStatusUpdate"); 

            return base.GetElementByName(identifier, areaIdentifier, listItem);
        }

    }
}
