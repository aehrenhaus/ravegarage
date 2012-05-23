using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium.Support.PageObjects;
using OpenQA.Selenium;
using OpenQA.Selenium.Remote;

namespace Medidata.UAT.WebDrivers.Rave
{
	public  class LoginPage : PageBase
	{
		public static LoginPage New(RemoteWebDriver browser=null)
		{
			browser = browser ?? TestContextSetup.Browser;
			return PageBase.GotoUrl<LoginPage>(browser, UATConfiguration.Default.RaveURL);
		}

		[FindsBy(How = How.Id, Using = "UserLoginBox")]
		public IWebElement UsernameBox;

		[FindsBy(How = How.Id, Using = "UserPasswordBox")]
		public IWebElement PasswordBox;


		[FindsBy(How = How.Id, Using = "LoginButton")]
		IWebElement LoginButton;

		public HomePage Login(string userName, string password)
		{
			UsernameBox.SendKeys(userName);
			PasswordBox.SendKeys(password);
			LoginButton.Click();

			return PageBase.FromCurrentUrl<HomePage>(Browser);
		}
	}
}
