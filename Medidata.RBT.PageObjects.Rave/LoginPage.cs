using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium.Support.PageObjects;
using OpenQA.Selenium;
using OpenQA.Selenium.Remote;
using Medidata.RBT.SeleniumExtension;
namespace Medidata.RBT.PageObjects.Rave
{
	public class LoginPage : RavePageBase
	{
		public LoginPage(string url)
		{
		

			//After restroing snapshot, Rave will throw a TCP closed exception when trying to visit database for the first time,
			//so go to cacheflush.aspx to trigger this exception first,  then goto Login page
			//TODO: Get rid of the line that goes to cacheflush.aspx when there is a solution to the problem above
			//InitializeWithNewUrl(url+"cacheflush.aspx");
			Browser.Navigate().GoToUrl(url+"login.aspx");
			PageFactory.InitElements(Browser, this);

		}

		protected override IWebElement GetElementByName(string name)
		{
			return Browser.FindElementById("_ctl0_Content_chkReqResponse");
		}

		[FindsBy(How = How.Id, Using = "UserLoginBox")]
		public IWebElement UsernameBox;

		[FindsBy(How = How.Id, Using = "UserPasswordBox")]
		public IWebElement PasswordBox;


		[FindsBy(How = How.Id, Using = "LoginButton")]
		IWebElement LoginButton;

		public HomePage Login(string userName, string password)
		{
			UsernameBox.EnhanceAs<Textbox>().SetText(userName);
			PasswordBox.EnhanceAs<Textbox>().SetText(password);
			LoginButton.Click();

			return new HomePage();
		}

	
	}
}
