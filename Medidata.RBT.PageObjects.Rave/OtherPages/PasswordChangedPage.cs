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
	public class PasswordChangedPage : RavePageBase
	{
        public PasswordChangedPage()
		{
			PageFactory.InitElements(Browser, this);
		}

        public override string URL { get { return "PasswordChanged.aspx"; } }
	}
}
