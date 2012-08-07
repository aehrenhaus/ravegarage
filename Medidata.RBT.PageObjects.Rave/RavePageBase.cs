using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Medidata.RBT.PageObjects;
using OpenQA.Selenium.Support.PageObjects;
using OpenQA.Selenium;

using System.Collections.Specialized;
using TechTalk.SpecFlow;
using Medidata.RBT.SeleniumExtension;


namespace Medidata.RBT.PageObjects.Rave
{
	public  class RavePageBase : PageBase
	{
		public override IPage NavigateTo(string name)
		{
			if (name == "Home")
			{
				Browser.FindElementById("_ctl0_PgHeader_TabHyperlink0").Click();
				return new HomePage();
			}


			throw new Exception("Don't know how to navigate to "+name);
		}


		public override IWebElement GetElementByName(string name)
		{
			if (name == "Header")
				return Browser.Table("_ctl0_PgHeader_TabTable");
			return base.GetElementByName(name);
		}

        public override IPage ClickLink(string linkText)
        {
            IPage page = null;
            try 
            {
                page = base.ClickLink(linkText);
                
            }
            catch(Exception e)
            {
                page = this.ClickSpanLink(linkText);
            }
            return page;
        }


        public override string BaseURL
        {
            get 
            {
                return RaveConfiguration.Default.RaveURL;
            }
        }

        public IWebElement GetElementByControlTypeAndValue(ControlType controlType, string value)
        {
            if (controlType == ControlType.Button)
            {
                return TestContext.Browser.TryFindElementBy(By.XPath("//input[contains(@value, '" + value + "')]"));
            }
            else if (controlType == ControlType.Link)
            {
                return TestContext.Browser.TryFindElementBy(By.XPath("//a[text() = '" + value + "']"));
            }
            else
                return null;
        }

		public IPage GoBack()
		{
			throw new NotImplementedException();
		}
	}
}
