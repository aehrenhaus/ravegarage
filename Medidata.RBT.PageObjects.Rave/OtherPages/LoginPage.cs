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
			PageFactory.InitElements(Browser, this);
		}

		public override IWebElement GetElementByName(string identifier, string areaIdentifier = null, string listItem = null)
		{
			return Browser.FindElementById("_ctl0_Content_chkReqResponse");
		}


		[FindsBy(How = How.Id, Using = "LoginButton")] private IWebElement LoginButton;

		/// <summary>
		/// Login the default user from any page.
		/// </summary>
		public static void LoginToHomePageIfNotAlready(string userName = null, string password = null)
		{
			//user default if not assigned
			userName = userName ?? RaveConfiguration.Default.DefaultUser;
			password = password ?? RaveConfiguration.Default.DefaultUserPassword;

			//if not the user
			if (TestContext.CurrentUser != userName)
			{
				var loginPage = new LoginPage();
				loginPage.NavigateToSelf();
				var homePage = loginPage.Login(userName, password);
				TestContext.CurrentPage = homePage;
			}

			if (!(TestContext.CurrentPage is HomePage))
			{
				TestContext.CurrentPage = new HomePage().NavigateToSelf();
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

			TestContext.CurrentUser = userName;
			TestContext.CurrentUserPassword = password;

			TestContext.CurrentPage = new HomePage();
			return (HomePage) TestContext.CurrentPage;
		}


		public override string URL
		{
			get { return "login.aspx"; }
		}
	}

	public class LoginSession : IDisposable
	{
		string previousUser = TestContext.CurrentUser;
		string previousPassword = TestContext.CurrentUserPassword;

		public LoginSession(string username = null, string passowrd = null)
		{
			LoginPage.LoginToHomePageIfNotAlready(username,passowrd);
		}

		public void Dispose()
		{
			if(previousUser!=null)
				LoginPage.LoginToHomePageIfNotAlready(previousUser, previousPassword);
		}
	}
}

