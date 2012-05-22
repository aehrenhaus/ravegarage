using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium.Support.PageObjects;
using OpenQA.Selenium;

namespace Medidata.UAT.WebDrivers.Rave
{
	public  class LoginPage : PageBase
	{
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
