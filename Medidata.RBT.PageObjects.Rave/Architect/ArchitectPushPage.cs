using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium.Support.PageObjects;
using OpenQA.Selenium;
using OpenQA.Selenium.Remote;
using Medidata.RBT.SeleniumExtension;
using TechTalk.SpecFlow;
using System.Threading;
using OpenQA.Selenium.Support.UI;
namespace Medidata.RBT.PageObjects.Rave
{
	public class ArchitectPushPage :  RavePageBase
	{
		public IPage PushToSites(string env, string sites)
        {
            if (sites == "All Sites")
            {
                return PushToAllSites(env);
            }
            else //single site, need a change in incoming parameters if want to include sitegroup here  or passing multiple sites from one step
            {
                return PushToSelectedSite(env, sites);
            }
            throw new NotImplementedException();
        }

		public IPage PushToAllSites(string env)
		{
			Browser.DropdownById("StudyDDL").SelectByText(env);
			Thread.Sleep(1000);
			this.ClickButton("PushBTN");
			Browser.TryFindElementBy(b =>
			{
				var span = Browser.Span("SuccessMessageLBL");
				if (span.Text == "")
					return null;
				return span;
			});
			return this;
		}

        public IPage PushToSelectedSite(string env, string site)
        {
            ChooseFromRadiobuttons(null, "_ctl0_Content_SelectSitesRB");
            Browser.WaitForDocumentLoad();
            Browser.DropdownById("StudyDDL").SelectByText(env);
            Browser.WaitForDocumentLoad();
            Thread.Sleep(1000);
            SelectElement selectElement = null;

            IWebElement optionElem = Browser.TryFindElementBy( b => 
                {
                    IWebElement returnElem = null;

                    var elem = b.FindElement(By.XPath(".//select[@id ='_ctl0_Content_DestinationLB' and not(@disabled)]"));
                    selectElement = new SelectElement(elem);

                    if (selectElement.Options.Count > 0)
                        returnElem = selectElement.Options.FirstOrDefault(oe => oe.Text.Equals(site));

                    return returnElem;
                }, true, 180);

            selectElement.SelectByText(optionElem.Text);
            this.ClickButton("PushBTN");
            Browser.TryFindElementBy(b =>
            {
                var span = Browser.Span("SuccessMessageLBL");
                if (span.Text == "")
                    return null;
                return span;
            });
            return this;
        }

        public override string URL
		{
			get
			{
				return "Modules/Architect/Push.aspx";
			}
		}
	}
}
