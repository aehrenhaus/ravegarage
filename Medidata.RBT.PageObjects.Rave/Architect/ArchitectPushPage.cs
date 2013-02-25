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
            Browser.DropdownById("StudyDDL").SelectByText(env);
            Browser.WaitForPageToBeReady();
            ChooseFromRadiobuttons(null, "_ctl0_Content_SelectSitesRB");
            IWebElement listbox = Browser.TryFindElementById("_ctl0_Content_DestinationLB");
            listbox.FindElement(By.XPath("//option[contains(text(),'" + site + "')]")).Click();
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
