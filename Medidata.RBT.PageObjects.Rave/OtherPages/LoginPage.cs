using System;
using OpenQA.Selenium.Support.PageObjects;
using OpenQA.Selenium;
using Medidata.RBT.SeleniumExtension;

namespace Medidata.RBT.PageObjects.Rave
{
	public class LoginPage : RavePageBase
	{
		public LoginPage()
		{
			//PageFactory.InitElements(Browser, this);
		}

		public override IWebElement GetElementByName(string identifier, string areaIdentifier = null, string listItem = null)
		{
			return Browser.FindElementById("_ctl0_Content_chkReqResponse");
		}


		[FindsBy(How = How.Id, Using = "LoginButton")] IWebElement LoginButton { get; set; }

		/// <summary>
		/// Login the default user from any page.
		/// </summary>
		public static void LoginToHomePageIfNotAlready(WebTestContext context, string userName = null, string password = null)
		{
			//user default if not assigned
			userName = userName ?? RaveConfiguration.Default.DefaultUser;
			password = password ?? RaveConfiguration.Default.DefaultUserPassword;

			//if not the user
			if (context.CurrentUser != userName)
			{
				var loginPage = new LoginPage();
				loginPage.NavigateToSelf();
				var homePage = loginPage.Login(userName, password);
				context.CurrentPage = homePage;
			}

			if (!(context.CurrentPage is HomePage))
			{
				context.CurrentPage = new HomePage().NavigateToSelf();
			}

		}

		/// <summary>
		/// Login using the provided username and password
		/// </summary>
		/// <param name="userName">The username to login with</param>
		/// <param name="password">The username to password with</param>
		/// <returns>The home page after logging in</returns>
		public HomePage Login(string userName, string password)
		{
			IWebElement UsernameBox = Browser.TryFindElementById("UserLoginBox");
			IWebElement PasswordBox = Browser.TryFindElementById("UserPasswordBox");
			UsernameBox.EnhanceAs<Textbox>().SetText(userName);
			PasswordBox.EnhanceAs<Textbox>().SetText(password);
			LoginButton.Click();

			Context.CurrentUser = userName;
			Context.CurrentUserPassword = password;
			return (HomePage)base.GetPageByCurrentUrlIfNoAlert();
		}


		public override string URL
		{
			get { return "login.aspx"; }
		}
	}


}

