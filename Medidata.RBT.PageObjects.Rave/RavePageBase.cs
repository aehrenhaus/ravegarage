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

            if (name == "PDF Generator")
            {
                if(TestContext.CurrentPage.URL != "Modules/PDF/FileRequest.aspx")
                    Browser.FindElementByXPath("//a[@href='LaunchModule.aspx?M=~/Modules/PDF/FileRequests.aspx&I=12']").Click();
                return new FileRequestPage();
            }

			throw new Exception("Don't know how to navigate to "+name);
		}


		public override IWebElement GetElementByName(string identifier, string areaIdentifier = null, string listItem = null)
		{
			if (identifier == "Header")
				return Browser.Table("_ctl0_PgHeader_TabTable");
			return base.GetElementByName(identifier,areaIdentifier,listItem);
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
        public virtual IEDCFieldControl FindLandscapeLogField(string fieldName, int rowIndex, ControlType controlType = ControlType.Default)
        {
            switch (controlType)
            {
                case ControlType.Default:
                    return new LandscapeLogField(this, fieldName, rowIndex);
                //case ControlType.Text:
                //case ControlType.LongText:
                //case ControlType.Datetime:
                //case ControlType.RadioButton:
                //case ControlType.RadioButtonVertical:
                //case ControlType.DropDownList:
                case ControlType.DynamicSearchList:
                    return new LandscapeLogField(this, fieldName, rowIndex, controlType);
                default:
                    throw new Exception("Not supported control type:" + controlType);
            }
        }
	}
}
