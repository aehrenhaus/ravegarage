using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium.Support.PageObjects;
using OpenQA.Selenium;
using OpenQA.Selenium.Remote;
using Medidata.RBT.SeleniumExtension;
using System.Collections.Specialized;
namespace Medidata.RBT.PageObjects.Rave
{
	public class ActivatePage : RavePageBase
	{
        [FindsBy(How = How.Id, Using = "ActivationCodeBox")]
        public IWebElement ActivationCode;

        [FindsBy(How = How.Id, Using = "PINBox")]
        public IWebElement Pin;
        
        public ActivatePage()
		{
			PageFactory.InitElements(Browser, this);
		}

        public override string URL{ get { return "Activate.aspx"; }}
	}
}
