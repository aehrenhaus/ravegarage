using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium.Support.PageObjects;
using OpenQA.Selenium;
using OpenQA.Selenium.Remote;
using System.Collections.Specialized;
using OpenQA.Selenium.Support.UI;

namespace Medidata.RBT.PageObjects.Rave
{
	public  class DDEPage : PageBase
	{
		public DDEPage()
		{
		}

        //[FindsBy(How = How.Id, Using = "UserLoginBox")]
        //public IWebElement UsernameBox;

        //[FindsBy(How = How.Id, Using = "UserPasswordBox")]
        //public IWebElement PasswordBox;


        //[FindsBy(How = How.Id, Using = "LoginButton")]
        //IWebElement LoginButton;

        protected override IWebElement GetElementByName(string name)
        {
      
            NameValueCollection mapping = new NameValueCollection();
            mapping["Study"] = "_ctl0_Content_DPL1_SLHolderStdy";
            mapping["Environment"] = "_ctl0_Content_DPL1_SLHolderEnv";
            mapping["Site"] = "_ctl0_Content_DPL1_SLHolderSite";
            mapping["Subject"] = "_ctl0_Content_DPL1_SLHolderSubj";
            mapping["Folder"] = "_ctl0_Content_DPL1_SLHolderFldr";
            mapping["Form"] = "_ctl0_Content_DPL1_SLHolderFrm";

            mapping["Folder Repeat"] = "_ctl0_Content_DPL1_SLHolderFldrRpt";
            mapping["Form Repeat"] = "_ctl0_Content_DPL1_SLHolderFrmRpt";
			mapping["Locate"] = "_ctl0_Content_DPL1_BtnLocateLbl";

            IWebElement ele = Browser.TryFindElementById(mapping[name]);
            if (ele==null)
            {
                throw new Exception("Can't find element: "+name);
            }

            return ele;
        }

        public override IPage Type(string name, string text)
        {
            text = SpecialStringHelper.Replace(text);

            IWebElement field = GetElementByName(name);
            IWebElement input = field.TryFindElementBy(By.XPath("./span/input[position()=1]"));
            input.SetText(text);
            return this;
        }

        public override IPage Choose(string name, string text)
        {
            IWebElement field = GetElementByName(name);

            IWebElement dropdownButton = field.TryFindElementBy(By.XPath("./span/input[position()=2]"));
    


            dropdownButton.Click();

			var option = WaitForElement(
				driver => field.FindElements(By.XPath("./div[position()=2]/div")).FirstOrDefault(x => x.Text == text),
				name + " not found: " + text
				);
		
			option.Click();
            return this;
        }

		public DDEPage FillDataPoint(string label, string val)
		{
			RavePagesHelper.FillDataPoint(label, val);
			return this;
		}

		public DDEPage SaveForm()
		{
			IWebElement btn = Browser.TryFindElementById("_ctl0_Content_dde1_header_SaveLink1");
			if (btn == null)
				throw new Exception("Can not find the Save button");
			btn.Click();
			return this;
		}
	}
}
