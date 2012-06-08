﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium.Support.PageObjects;
using OpenQA.Selenium;
using OpenQA.Selenium.Remote;

namespace Medidata.RBT.PageObjects.Rave
{
	public  class LoginPage : PageBase
	{
		public LoginPage(string url)
		{
			InitializeWithNewUrl(url);
		}

		//public override TPage OpenNew<TPage>() 
		//{
		//    InitializeWithNewUrl(RaveConfiguration.Default.RaveURL);
		//    return this.As<TPage>();
		//}

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

			return new HomePage();
		}

	
	}
}
